Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1B321C294
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 08:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgGKGpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jul 2020 02:45:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55300 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727867AbgGKGpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:45:06 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2F1755B6A57830D19173;
        Sat, 11 Jul 2020 14:45:04 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.214) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Sat, 11 Jul 2020
 14:44:53 +0800
Subject: Re: [PATCH] ubifs: Fix a potential space leak problem while linking
 tmpfile
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     Richard Weinberger <richard@nod.at>
CC:     Richard Weinberger <richard.weinberger@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yi zhang <yi.zhang@huawei.com>
References: <20200701112643.726986-1-chengzhihao1@huawei.com>
 <CAFLxGvyO_aXGfgoO0mrNsoGP4Bfh3n6CUQxDx=ecH6o2ZDNYDg@mail.gmail.com>
 <082f18e0-d6f0-6389-43af-3159edb244cb@huawei.com>
 <1463101229.103384.1594123741187.JavaMail.zimbra@nod.at>
 <963fa5c8-414f-783f-871e-47e751b54d87@huawei.com>
 <1480699627.103583.1594126053947.JavaMail.zimbra@nod.at>
 <0c543297-d94f-ad40-7dd0-2198f39336bb@huawei.com>
Message-ID: <a3421498-e3a5-f7dc-50c6-15ef3cdfb51b@huawei.com>
Date:   Sat, 11 Jul 2020 14:44:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0c543297-d94f-ad40-7dd0-2198f39336bb@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.214]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/7/11 14:37, Zhihao Cheng 写道:
> 在 2020/7/7 20:47, Richard Weinberger 写道:
>> ----- Ursprüngliche Mail -----
>>>>> Perhaps I misunderstood what commit 32fe905c17f001 ("ubifs: Fix
>>>>> O_TMPFILE corner case in ubifs_link()") wanted to fix.
>>>>> I think orphan area is used to remind filesystem don't forget to 
>>>>> delete
>>>>> inodes (whose nlink is 0) in next unclean rebooting. Generally, 
>>>>> the file
>>>>> system is not corrupted caused by replaying orphan nodes.
>>>>> Ralph reported a filesystem corruption in combination with overlayfs.
>>>>> Can you tell me the details about that problem? Thanks.
>>>> On my test bed I didn't see a fs corruption, what I saw was a 
>>>> failing orphan
>>>> self test while playing with O_TMPFILE and linkat().
>>> Do we have a reproducer, or can I get the fail testcase? Is it a 
>>> xfstest
>>> case?
>> I think xfstests triggered it, yes.
>> Later today I can check. :)
>>
>> Thanks,
>> //richard
>>
>> .
>
> I think I have found the testcases, overlay/006 and overlay/041.
>
> The 'mv' and 'rm' operations will put lowertestfile into orphan list 
> twice, so we must reseve the orphan deletion operation in 
> ubifs_link(), otherwise the testcase fails and we will see the 
> following msg:
>
>   overlay/006 2s ... - output mismatch (see 
> /root/git/xfstests-dev/results//overlay/006.out.bad)
>     --- tests/overlay/006.out    2020-07-07 21:42:57.737000000 +0800
>     +++ /root/git/xfstests-dev/results//overlay/006.out.bad 2020-07-11 
> 14:31:55.340000000 +0800
>     @@ -1,2 +1,4 @@
>      QA output created by 006
>      Silence is golden
>     +rm: cannot remove 
> '/tmp/scratch/ovl-mnt/uppertestdir/lowertestfile': Invalid argument
>     +lowertestfile
>     ...
>
>   [  382.258210] UBIFS error (ubi0:1 pid 11896): orphan_add [ubifs]: 
> orphaned twice
>   [  382.352535] UBIFS error (ubi0:1 pid 11930): free_orphans [ubifs]: 
> orphan list not empty at unmount
>
>
> So, how about moving ubifs_delete_orphan() after ubifs_jnl_update() in 
> function ubifs_link(). Following modifications applied in linux-5.8 
> has been tested by overlay/041, overlay/006 and  other tmpfile cases 
> (generic/531, generic/530, generic/509, generic/389, generic/004).
>
Results for testcases generic/530, generic/509, generic/389 and 
generic/004 are still "not run".
> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
> index ef85ec167a84..fd4443a5e8c6 100644
> --- a/fs/ubifs/dir.c
> +++ b/fs/ubifs/dir.c
> @@ -722,11 +722,6 @@ static int ubifs_link(struct dentry *old_dentry, 
> struct inode *dir,
>                 goto out_fname;
>
>         lock_2_inodes(dir, inode);
> -
> -       /* Handle O_TMPFILE corner case, it is allowed to link a 
> O_TMPFILE. */
> -       if (inode->i_nlink == 0)
> -               ubifs_delete_orphan(c, inode->i_ino);
> -
> inc_nlink(inode);
> ihold(inode);
>         inode->i_ctime = current_time(inode);
> @@ -736,6 +731,11 @@ static int ubifs_link(struct dentry *old_dentry, 
> struct inode *dir,
>         err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
>         if (err)
>                 goto out_cancel;
> +
> +       /* Handle O_TMPFILE corner case, it is allowed to link a 
> O_TMPFILE. */
> +       if (inode->i_nlink == 1)
> +               ubifs_delete_orphan(c, inode->i_ino);
> +
>         unlock_2_inodes(dir, inode);
>
>         ubifs_release_budget(c, &req);
> @@ -747,8 +747,6 @@ static int ubifs_link(struct dentry *old_dentry, 
> struct inode *dir,
>         dir->i_size -= sz_change;
>         dir_ui->ui_size = dir->i_size;
> drop_nlink(inode);
> -       if (inode->i_nlink == 0)
> -               ubifs_add_orphan(c, inode->i_ino);
>         unlock_2_inodes(dir, inode);
>         ubifs_release_budget(c, &req);
> iput(inode);
> -- 
>


