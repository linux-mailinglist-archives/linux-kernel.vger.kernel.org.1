Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CBB2E9AE9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 17:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbhADQUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 11:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbhADQUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 11:20:43 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C209C061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 08:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=2MgK+G12+Snon/CujGjskZiZ1FraF4feyNo0CRSFIyI=; b=rHuetudx7+j8WS2lFfm3I122hB
        lr7fLDFL4M66ykWQwVCCyQpS6p+YraWI0Dbcf6XRBAigI7Pjc8HTDSeus8FCJcjAvfypyDwMCeXrD
        QAfEhTnHiPY1Q9ks65/fCg1bqypkkwe0lRQ44J+zVkZaRBWBhJS/6KKMo/WM/V9J8I7Q8u5xjauFG
        mQaqiKSTicimLpuCp7mD8eeCcgUUa4E65Mcz0Dq27uwxySCLKN+Sbd9jK+wWI7SdpUrQZ1OvmJeBm
        T9e22uync4Z/ynTxfNo907RKDAm3EudZCgHEfAtbPj1HBJgxrEVGFiTK+b+Kh68v2TZcSJuuZJu8X
        J0SRb6Ew==;
Received: from [2601:1c0:6280:3f0::2c43]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwSaM-0007Ra-Jk; Mon, 04 Jan 2021 16:19:58 +0000
Subject: Re: [PATCH] x86/compat: Pull huge_encode_dev() outside of UACCESS
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <984353b44a4484d86ba9f73884b7306232e25e30.1608737428.git.jpoimboe@redhat.com>
 <20210104122825.GM3021@hirez.programming.kicks-ass.net>
 <20210104153127.e44uchjhlgg3hq2g@treble>
 <20210104155347.GC3040@hirez.programming.kicks-ass.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c49ae41f-6031-014a-2c43-855e3bbff5e6@infradead.org>
Date:   Mon, 4 Jan 2021 08:19:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210104155347.GC3040@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/21 7:53 AM, Peter Zijlstra wrote:
> On Mon, Jan 04, 2021 at 09:31:27AM -0600, Josh Poimboeuf wrote:
>> Peter, care to submit a proper patch?
> 
> Here goes..
> 
> ---
> Subject: x86/compat: Pull huge_encode_dev() outside of UACCESS
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon, 4 Jan 2021 13:28:25 +0100
> 
> Fixes the following warning:
> 
>   arch/x86/kernel/sys_ia32.o: warning: objtool: cp_stat64()+0xd8: call to new_encode_dev() with UACCESS enabled
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  arch/x86/kernel/sys_ia32.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/kernel/sys_ia32.c
> +++ b/arch/x86/kernel/sys_ia32.c
> @@ -133,18 +133,23 @@ static int cp_stat64(struct stat64 __use
>  {
>  	typeof(ubuf->st_uid) uid = 0;
>  	typeof(ubuf->st_gid) gid = 0;
> +	u64 dev, rdev;
> +
>  	SET_UID(uid, from_kuid_munged(current_user_ns(), stat->uid));
>  	SET_GID(gid, from_kgid_munged(current_user_ns(), stat->gid));
> +	dev = huge_encode_dev(stat->dev);
> +	rdev = huge_encode_dev(stat->rdev);
> +
>  	if (!user_write_access_begin(ubuf, sizeof(struct stat64)))
>  		return -EFAULT;
> -	unsafe_put_user(huge_encode_dev(stat->dev), &ubuf->st_dev, Efault);
> +	unsafe_put_user(dev, &ubuf->st_dev, Efault);
>  	unsafe_put_user(stat->ino, &ubuf->__st_ino, Efault);
>  	unsafe_put_user(stat->ino, &ubuf->st_ino, Efault);
>  	unsafe_put_user(stat->mode, &ubuf->st_mode, Efault);
>  	unsafe_put_user(stat->nlink, &ubuf->st_nlink, Efault);
>  	unsafe_put_user(uid, &ubuf->st_uid, Efault);
>  	unsafe_put_user(gid, &ubuf->st_gid, Efault);
> -	unsafe_put_user(huge_encode_dev(stat->rdev), &ubuf->st_rdev, Efault);
> +	unsafe_put_user(rdev, &ubuf->st_rdev, Efault);
>  	unsafe_put_user(stat->size, &ubuf->st_size, Efault);
>  	unsafe_put_user(stat->atime.tv_sec, &ubuf->st_atime, Efault);
>  	unsafe_put_user(stat->atime.tv_nsec, &ubuf->st_atime_nsec, Efault);
> 


-- 
~Randy
