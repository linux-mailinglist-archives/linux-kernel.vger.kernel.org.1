Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AEE2BBB55
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 02:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgKUA62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 19:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgKUA62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 19:58:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63153C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 16:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=/85Vmw+gpTMW9v2I0bLohGt1WwXkc5iB9lprh8ZlXjQ=; b=MBOFltT5rMhYGUyb1hSfUnlUNw
        ooHgK+uEeW6JYvf4PMjnv4x0LkPr8nEdaHO7ogoncxCc0TaiS8YooICRSPuI8ZsTRli5ejPRIRqmH
        y+iM1+x89SjbjRH8eiJSeggsFFCQ88c9ABrNleZpCKos5bx0sb6Aep52YCDEqDRbna8aQMNMYpxHb
        zSdEWhpLfZuKWY0TthfwNwQsV4aNg1/6xoGVavhJhJLeGonOvvPvqiU15vAV+eFUcBerJACkc8kkt
        vZPJR/uchDvS063Pong6aEedSgq308rSSUWUkptTDWiFkPzRxG0hWus2hLCxmbaPrAy/pvujOpddZ
        ILn99Ccg==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kgHEE-0004sC-7O; Sat, 21 Nov 2020 00:58:14 +0000
Subject: Re: [PATCH] fs/stat: set attributes_mask for STATX_ATTR_DAX
To:     XiaoLi Feng <xifeng@redhat.com>, linux-kernel@vger.kernel.org,
        ira.weiny@intel.com, darrick.wong@oracle.com
Cc:     Xiaoli Feng <fengxiaoli0714@gmail.com>
References: <20201121003331.21342-1-xifeng@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <21890103-fce2-bb50-7fc2-6c6d509b982f@infradead.org>
Date:   Fri, 20 Nov 2020 16:58:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201121003331.21342-1-xifeng@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't know this code, but:

On 11/20/20 4:33 PM, XiaoLi Feng wrote:
> From: Xiaoli Feng <fengxiaoli0714@gmail.com>
> 
> keep attributes and attributes_mask are consistent for
> STATX_ATTR_DAX.
> ---
>  fs/stat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index dacecdda2e79..914a61d256b0 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -82,7 +82,7 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
>  
>  	if (IS_DAX(inode))
>  		stat->attributes |= STATX_ATTR_DAX;
> -
> +	stat->attributes_mask |= STATX_ATTR_DAX;

Why shouldn't that be:

	if (IS_DAX(inode))
		stat->attributes_mask |= STATX_ATTR_DAX;

or combine them, like this:

	if (IS_DAX(inode)) {
		stat->attributes |= STATX_ATTR_DAX;
		stat->attributes_mask |= STATX_ATTR_DAX;
	}


and no need to delete that blank line.

>  	if (inode->i_op->getattr)
>  		return inode->i_op->getattr(path, stat, request_mask,
>  					    query_flags);
> 

thanks.
-- 
~Randy

