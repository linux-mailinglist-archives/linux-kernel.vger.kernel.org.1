Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE952EC6F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 00:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbhAFXig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 18:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbhAFXif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 18:38:35 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3471EC061757
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 15:37:55 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b8so2373982plx.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 15:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jn3oLzAcyA5kfmctaknU4fEVyLu6fbHNrBThhblTzPk=;
        b=kSoCvf4DZs4eC8vITHqKxIReymufHoQvCiey2koVY6RJke4GL3BBEntDpbyuQqJiB3
         ukAmS99DlFP+y2I3bAcu71TUsQgi0R99YVFVIrB0vajGD53IjpyWQzRdFA2pxLCKqdbR
         +94klq7UVKsvnJkh4GIq5/wLD5UlzToroZ/V8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jn3oLzAcyA5kfmctaknU4fEVyLu6fbHNrBThhblTzPk=;
        b=ZJ9e06YyohoDIE6LgFdqYNjL3iFn72BKU+fQWSWjBOwE8L1pu48UYT65FV+QWCSvx4
         xa7HD+AxdgZ7VHraXBkxGz3bNT4grZaYH9ehr55hiPrc9aqg7fwrHfcfbl4kFvrjGHsf
         j66uc5R6b1GuXVW4ez9dvqiIzGZ5we7Au2UdJivkmcrD+n7+e+qIkmPR4TW4x0At6w7U
         CBxzq8Lx4edFspIeZqrFdNHAZtbh840qkGXvV5MELFww1NNTtSimY0ZyvRgqs1ailBDT
         fkI/J4n3hmCfRrJ0j10JhJDE3+6ho+DTNfRtR8KLMQQnAiV5t8CPNKE4DaEjVuXWbfWw
         5rPg==
X-Gm-Message-State: AOAM530Mx+9Z/GEUd3bdjburT2UU97XPMffdC0S48gXYfBeaEptwOkT4
        W3vvmSYPhkdAXYBy6EsxR0acEQ==
X-Google-Smtp-Source: ABdhPJyYpxCvydHbvl0uKvlIlicejk8AkYB8zUkiPnV/v3X/hhhgYM9OaHAOBjgEBVjV5P6MAR1OjQ==
X-Received: by 2002:a17:90b:a47:: with SMTP id gw7mr6492131pjb.1.1609976274832;
        Wed, 06 Jan 2021 15:37:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g30sm3506901pfr.152.2021.01.06.15.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 15:37:54 -0800 (PST)
Date:   Wed, 6 Jan 2021 15:37:53 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        aryabinin@virtuozzo.com, dvyukov@google.com
Subject: Re: [PATCH] mm/uaccess: Use 'unsigned long' to placate UBSAN
 warnings, again
Message-ID: <202101061536.C4A93132@keescook>
References: <590998aa9cc50f431343f76cae72b2abf8ac1fdd.1608699683.git.jpoimboe@redhat.com>
 <20210104151317.GR3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104151317.GR3021@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 04:13:17PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 22, 2020 at 11:04:54PM -0600, Josh Poimboeuf wrote:
> > GCC 7 has a known bug where UBSAN ignores '-fwrapv' and generates false
> > signed-overflow-UB warnings.  The type mismatch between 'i' and
> > 'nr_segs' in copy_compat_iovec_from_user() is causing such a warning,
> > which also happens to violate uaccess rules:
> > 
> >   lib/iov_iter.o: warning: objtool: iovec_from_user()+0x22d: call to __ubsan_handle_add_overflow() with UACCESS enabled
> > 
> > Fix it by making the variable types match.
> > 
> > This is similar to a previous commit:
> > 
> >   29da93fea3ea ("mm/uaccess: Use 'unsigned long' to placate UBSAN warnings on older GCC versions")
> 
> Maybe it's time we make UBSAN builds depend on GCC-8+ ?

I would be totally fine with that. The only thing I can think of that
might care is syzbot. Dmitry, does syzbot use anything older than gcc 8?

-- 
Kees Cook
