Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9FC2E1959
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 08:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgLWHTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 02:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgLWHTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 02:19:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F30C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 23:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=K3gRouJVTsjpLtwGhImyl3xulbQkaa/U1IM2NyJKtZY=; b=qT99f2Htr47uwnMZdcrOrOdgnX
        GqR8X00rPRlbJ8izs+mlqDzxEUJS67zRmK0cJTpxC3CcTJOe+Gfrg0YFxWjMrX4ww+NvPSu9B1xN1
        arsOBvzU4N1wAoTrR0arMZ3O6jWLXXxEx+gV4MKm2zU47MKHKTl4wOstqP40DvUeKw7LKVukx8i6H
        daI1F5a9Xt5bIA7A7lnATrvwhl+Gawt8V3DfEA2a2mgpiN6XsKjCdFcfCabBxTsDLZ7qgVHIn2LqK
        fMFCrhIu8KAjpYfCgcqc1QZ0SVHYnld77YceMe8Ljq2woWegFEjyom8ty7FBqMJ5u1+wFd8VOT3wm
        dVUvR3RQ==;
Received: from [2601:1c0:6280:3f0::64ea]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kryQG-0002HR-3C; Wed, 23 Dec 2020 07:19:00 +0000
Subject: Re: [PATCH] mm/uaccess: Use 'unsigned long' to placate UBSAN
 warnings, again
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <590998aa9cc50f431343f76cae72b2abf8ac1fdd.1608699683.git.jpoimboe@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6823854f-019f-f9db-7fd8-da8e7a0016d1@infradead.org>
Date:   Tue, 22 Dec 2020 23:18:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <590998aa9cc50f431343f76cae72b2abf8ac1fdd.1608699683.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/20 9:04 PM, Josh Poimboeuf wrote:
> GCC 7 has a known bug where UBSAN ignores '-fwrapv' and generates false
> signed-overflow-UB warnings.  The type mismatch between 'i' and
> 'nr_segs' in copy_compat_iovec_from_user() is causing such a warning,
> which also happens to violate uaccess rules:
> 
>   lib/iov_iter.o: warning: objtool: iovec_from_user()+0x22d: call to __ubsan_handle_add_overflow() with UACCESS enabled
> 
> Fix it by making the variable types match.
> 
> This is similar to a previous commit:
> 
>   29da93fea3ea ("mm/uaccess: Use 'unsigned long' to placate UBSAN warnings on older GCC versions")
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

All good. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


> ---
>  lib/iov_iter.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 1635111c5bd2..2e6a42f5d1df 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1656,7 +1656,8 @@ static int copy_compat_iovec_from_user(struct iovec *iov,
>  {
>  	const struct compat_iovec __user *uiov =
>  		(const struct compat_iovec __user *)uvec;
> -	int ret = -EFAULT, i;
> +	int ret = -EFAULT;
> +	unsigned long i;
>  
>  	if (!user_access_begin(uvec, nr_segs * sizeof(*uvec)))
>  		return -EFAULT;
> 


-- 
~Randy
