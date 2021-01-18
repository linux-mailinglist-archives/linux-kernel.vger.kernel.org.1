Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC612F9B86
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 09:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbhARItf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:49:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11553 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387625AbhARItW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:49:22 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DK5506fwFzMLfg;
        Mon, 18 Jan 2021 16:47:16 +0800 (CST)
Received: from [10.174.177.2] (10.174.177.2) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Mon, 18 Jan 2021
 16:48:38 +0800
Subject: Re: [PATCH] hugetlbfs: make BUG_ON(!inode) takes effect in
 hugetlbfs_setattr
To:     Muchun Song <smuchun@gmail.com>
CC:     <mike.kravetz@oracle.com>, <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210116090910.5671-1-linmiaohe@huawei.com>
 <CAPSr9jFQRujOEa_HcqQ6=+hf-jWiGA=+CeWjgwQK+-993gd4Ow@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <88d19bf2-f176-500e-9e73-0d863754466d@huawei.com>
Date:   Mon, 18 Jan 2021 16:48:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAPSr9jFQRujOEa_HcqQ6=+hf-jWiGA=+CeWjgwQK+-993gd4Ow@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.2]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

On 2021/1/18 15:59, Muchun Song wrote:
> On Sat, Jan 16, 2021 at 5:11 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> When we reach here with inode = NULL, we should have crashed as inode has
>> already been dereferenced via hstate_inode. In order to make BUG_ON(!inode)
>> takes effect, we should defer initializing hstate until we really need it.
>> Also do this for hugetlbfs_inode_info as it's only used when ia_valid is
>> verified with ATTR_SIZE.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  fs/hugetlbfs/inode.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index 740693d7f255..9b221b87fbea 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -755,10 +755,8 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>>  static int hugetlbfs_setattr(struct dentry *dentry, struct iattr *attr)
>>  {
>>         struct inode *inode = d_inode(dentry);
>> -       struct hstate *h = hstate_inode(inode);
> 
> If inode == NULL, it will panic here when we access inode->i_sb.
> I have seen many other file system implementations about setattr,
> they all think that d_inode() will return a non-NULL pointer. So
> I prefer to just remove the BUG_ON().
> 

Sounds reasonable. Will do it in v2. Many thanks.

> Thanks.
> 
> 
>>         int error;
>>         unsigned int ia_valid = attr->ia_valid;
>> -       struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
>>
>>         BUG_ON(!inode);
>>
>> @@ -767,6 +765,8 @@ static int hugetlbfs_setattr(struct dentry *dentry, struct iattr *attr)
>>                 return error;
>>
>>         if (ia_valid & ATTR_SIZE) {
>> +               struct hstate *h = hstate_inode(inode);
>> +               struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
>>                 loff_t oldsize = inode->i_size;
>>                 loff_t newsize = attr->ia_size;
>>
>> --
>> 2.19.1
>>
> .
> 
