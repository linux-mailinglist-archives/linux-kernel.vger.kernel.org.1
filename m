Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A07C278BD2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 17:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgIYPCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 11:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729403AbgIYPCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 11:02:05 -0400
Received: from [192.168.0.108] (unknown [49.65.245.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3144C20715;
        Fri, 25 Sep 2020 15:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601046124;
        bh=9WgaLGTAfx9N0SLsi5CS0bjEUFlWHvpW0Sz8nLg7jis=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=mtT/WbyI46MM40nBYZjXtBkn8QJAxuMV+gtHdAFQQ0mM7mKT658kRZcddoD7/8hOf
         vuMPR0Db20xI8R17kxp5/vMXin1+t8fj4OdYg3sevEbq648BwFVCUgX9UUKlZpg7L7
         qDQsxeoYIuyKGih53wpnxxZamdJoImDGjQF7Sum4=
Subject: Re: [f2fs-dev] KMSAN: uninit-value in f2fs_lookup
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Chao Yu <yuchao0@huawei.com>
References: <000000000000f9f80905b01c7185@google.com>
 <eb03a5c9-eb77-eb91-e17f-8a3273aab7da@huawei.com>
 <20200925105758.GN4282@kadam>
Cc:     syzbot <syzbot+0eac6f0bbd558fd866d7@syzkaller.appspotmail.com>,
        glider@google.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
From:   Chao Yu <chao@kernel.org>
Message-ID: <27500993-7fbd-bbe7-1d6e-83e0e12b4a3e@kernel.org>
Date:   Fri, 25 Sep 2020 23:01:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200925105758.GN4282@kadam>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 2020-9-25 18:57, Dan Carpenter wrote:
> On Fri, Sep 25, 2020 at 05:06:33PM +0800, Chao Yu wrote:
>> Hi,
>>
>> I don't see any problem here, thanks for your report. :)
>>
>
> I bet the uninitialize value is because "max_depth" is zero.

I agree with you, thanks for the hint. :)

Thanks,

>
>
>    352  struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
>    353                                           const struct f2fs_filename *fname,
>    354                                           struct page **res_page)
>                                                                ^^^^^^^^
> The stack trace says this isn't initialized.
>
>    355  {
>    356          unsigned long npages = dir_blocks(dir);
>    357          struct f2fs_dir_entry *de = NULL;
>    358          unsigned int max_depth;
>    359          unsigned int level;
>    360
>    361          if (f2fs_has_inline_dentry(dir)) {
>    362                  *res_page = NULL;
>    363                  de = f2fs_find_in_inline_dir(dir, fname, res_page);
>    364                  goto out;
>    365          }
>    366
>    367          if (npages == 0) {
>    368                  *res_page = NULL;
>    369                  goto out;
>    370          }
>    371
>    372          max_depth = F2FS_I(dir)->i_current_depth;
>    373          if (unlikely(max_depth > MAX_DIR_HASH_DEPTH)) {
>    374                  f2fs_warn(F2FS_I_SB(dir), "Corrupted max_depth of %lu: %u",
>    375                            dir->i_ino, max_depth);
>    376                  max_depth = MAX_DIR_HASH_DEPTH;
>    377                  f2fs_i_depth_write(dir, max_depth);
>    378          }
>    379
>    380          for (level = 0; level < max_depth; level++) {
>                                 ^^^^^^^^^^^^^^^^^
> If "max_depth" is zero, then we never enter this loop.
>
>    381                  *res_page = NULL;
>    382                  de = find_in_level(dir, level, fname, res_page);
>    383                  if (de || IS_ERR(*res_page))
>    384                          break;
>    385          }
>    386  out:
>    387          /* This is to increase the speed of f2fs_create */
>    388          if (!de)
>    389                  F2FS_I(dir)->task = current;
>    390          return de;
>
> Which means that we return a NULL "de" and "*res_page" is uninitialized
> and that matches what syzbot found throug runtime testing.
>
>    391  }
>
> regards,
> dan carpenter
>
