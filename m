Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6982EE76C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 22:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbhAGVIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 16:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbhAGVID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:08:03 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF97C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 13:07:23 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id f14so2279391pju.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 13:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AycS9z5H5EArYSxCaTn3F0nB+eORScUBujc0QAwlLzw=;
        b=Jqk7mULK+iMpB4jFuRtzuf1CrwqB6iEZd188K1psKIbbPNJG2x47K7Dz2mYD9AGzNj
         Dm4LwZ/+eG0GLcZuZMj1CqssDHCnsSYgDlF4ShZ5bQ7/eLXF9y06u9s/y8Ty4APMBj1g
         7+bWiu/o02cuUh8emjrYQzeNZjQ6DR+D1vG8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AycS9z5H5EArYSxCaTn3F0nB+eORScUBujc0QAwlLzw=;
        b=unt0Wq+ULNCTUU6Cx7csb0XnnndqMEMVwqo/Dd5qrEqlS9rYXc0iBp8mh26gMwnuV2
         0NxQpe2wt10gojMADEa5ULe9Il5dv12surFmUyblrBmKx74uVPocxkZMlTsjiK105DT+
         9Q2vKv2U066L4RZWLmpfnBTzxVZS5XRMpMYPVE7xtZ4oIrfn7plCJAk35a4hMu+eWrDh
         nsn9u4AXxJjIGDNSk1TY8rFqA+JMZZGqk/TpFEB+OgtMikz8D440fLeStIhSTbRRoiMf
         Fs7dxgueNd7NQ/eOHX++hVWufcv2M3wxvinG3XkSRs0M3gTpjQU5nJLT7w0thejzVMln
         vSyA==
X-Gm-Message-State: AOAM5301/Qlcyw/Him9w0GWalICQJW+gwtYnG6CbcPCVRSNzoiKIrW5G
        tmImivUQZOHe4hApfLSlKZ+D6A==
X-Google-Smtp-Source: ABdhPJx3/TFeN/AstWxBEfrnwhATMveAU7tRlhBMrs2seRKjvwVq1MCf2BbOASd0c2+qyJ1X5kKakQ==
X-Received: by 2002:a17:902:d38b:b029:db:e003:3ff0 with SMTP id e11-20020a170902d38bb02900dbe0033ff0mr635386pld.7.1610053643172;
        Thu, 07 Jan 2021 13:07:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d1sm7103672pgb.13.2021.01.07.13.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:07:22 -0800 (PST)
Date:   Thu, 7 Jan 2021 13:07:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com,
        dvyukov@google.com
Subject: Re: [PATCH] mm/uaccess: Use 'unsigned long' to placate UBSAN
 warnings, again
Message-ID: <202101071306.5A39AAC3A7@keescook>
References: <590998aa9cc50f431343f76cae72b2abf8ac1fdd.1608699683.git.jpoimboe@redhat.com>
 <20210104151317.GR3021@hirez.programming.kicks-ass.net>
 <202101061536.C4A93132@keescook>
 <d5b192b2-b216-57d1-4505-06233ae2b882@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5b192b2-b216-57d1-4505-06233ae2b882@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 04:06:57PM -0800, Randy Dunlap wrote:
> On 1/6/21 3:37 PM, Kees Cook wrote:
> > On Mon, Jan 04, 2021 at 04:13:17PM +0100, Peter Zijlstra wrote:
> >> On Tue, Dec 22, 2020 at 11:04:54PM -0600, Josh Poimboeuf wrote:
> >>> GCC 7 has a known bug where UBSAN ignores '-fwrapv' and generates false
> >>> signed-overflow-UB warnings.  The type mismatch between 'i' and
> >>> 'nr_segs' in copy_compat_iovec_from_user() is causing such a warning,
> >>> which also happens to violate uaccess rules:
> >>>
> >>>   lib/iov_iter.o: warning: objtool: iovec_from_user()+0x22d: call to __ubsan_handle_add_overflow() with UACCESS enabled
> >>>
> >>> Fix it by making the variable types match.
> >>>
> >>> This is similar to a previous commit:
> >>>
> >>>   29da93fea3ea ("mm/uaccess: Use 'unsigned long' to placate UBSAN warnings on older GCC versions")
> >>
> >> Maybe it's time we make UBSAN builds depend on GCC-8+ ?
> > 
> > I would be totally fine with that. The only thing I can think of that
> > might care is syzbot. Dmitry, does syzbot use anything older than gcc 8?
> 
> I use UBSAN successfully with GCC 7.5.0.
> However, I can revert whatever future patch someone adds for this...

Peter, which GCC version specifically are you seeing this on? (i.e. can
I just make in 7.5+ instead of 8+ to make Randy's life easier?)

-- 
Kees Cook
