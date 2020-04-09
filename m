Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E85951A3C4F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 00:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgDIWTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 18:19:22 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37907 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgDIWTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 18:19:22 -0400
Received: by mail-qk1-f194.google.com with SMTP id h14so442681qke.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 15:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yF+4ifTZpgac0AbgqyHYOhjvKVGLdZBmX5qyHKVLzpw=;
        b=ayC55L881C6xg8HNUeEsEsdG+JjdxCnjA7UteuNLnWVIETAYJFL0syDwTwbXrwKNQL
         aTbVmOYsLBPrcWQXkiUI0SCP1s+aJ1i08TjGVWGMvHeLKysNIYCnLC7eb32KIrzy/Tiu
         v4nq50XzsOXfMouLuH1upugXdP8A3MXgtAKvbyjlMVcufRn2qSZiqRMbthmhcuouwzuC
         7YsB3TGQSigp5bYimeU9pryCMNu2H2HJzm8+B0E5BHgrFb0VgT2CZTMzWvGtZIALp9g8
         k/jv+Klv0FmpvLvIuFG3AKlNFlBeo3LnegGrWnxxKuEtfuZljPdSScQR/+iEm/RDMkzn
         gCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yF+4ifTZpgac0AbgqyHYOhjvKVGLdZBmX5qyHKVLzpw=;
        b=MKltCR+FBGsUkXJK63ufCUS/szqDa4o2JnjPdf7lWaVqN4aEFVcxvaz4vy2ycXsRH2
         OpKrBsTIb+BBu1u+C1jfgI22EjRQ3QQEwj77EYS10nkb+qUXmG2JVosVSzAyfFCQbRtu
         wh2bab+UuVim/jYddfITPEMV49swr5colVRVIZNbfY/SqiFsxaZUghXdPDUXJlNCei1n
         OxSAFc/Bh90bB7I0iBxzOT93dv8wL55BJtpErjXbu8OSOi2Wgm82lmPrPQ5VeIAUjltw
         JhvTBe+Mgr1HvpImrDjKX+hpvjhMhjxlnZXPlSbkRFcng6Q1hqhMCGT6WO0Za2WTIx5L
         66zQ==
X-Gm-Message-State: AGi0PualgO06LaU7sRzFs+hw4PgfcThRLbR4JlhaSHLaMfJy4IpO3hDN
        e/swDlQCz6ubKavBrNUgHjc=
X-Google-Smtp-Source: APiQypJrKv7Asjch32aD4xEpFDeOyjpzVmOBQiF/yaYfcx+nuoITzrJsRZSj7Udu9wt+ElHx97bWzQ==
X-Received: by 2002:a37:ae04:: with SMTP id x4mr1187661qke.278.1586470762165;
        Thu, 09 Apr 2020 15:19:22 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z3sm180468qtq.7.2020.04.09.15.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 15:19:21 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 9 Apr 2020 18:19:19 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>,
        kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm/init: Stop printing pgt_buf addresses
Message-ID: <20200409221919.GA1460035@rani.riverdale.lan>
References: <20200229231120.1147527-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200229231120.1147527-1-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 06:11:20PM -0500, Arvind Sankar wrote:
> This currently leaks kernel physical addresses into userspace.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/mm/init.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index e7bb483557c9..dc4711f09cdc 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -121,8 +121,6 @@ __ref void *alloc_low_pages(unsigned int num)
>  	} else {
>  		pfn = pgt_buf_end;
>  		pgt_buf_end += num;
> -		printk(KERN_DEBUG "BRK [%#010lx, %#010lx] PGTABLE\n",
> -			pfn << PAGE_SHIFT, (pgt_buf_end << PAGE_SHIFT) - 1);
>  	}
>  
>  	for (i = 0; i < num; i++) {
> -- 
> 2.24.1
> 

This was acked by Kees, is it ok for merge?

Thanks.
