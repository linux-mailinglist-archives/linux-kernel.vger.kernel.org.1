Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7282ECE33
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbhAGKwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbhAGKwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:52:17 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5022DC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 02:51:37 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id g24so3930557qtq.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 02:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u7kST0rwmaC4SL82uI8pfLMZP6TWfNFAafaTbu3WzjE=;
        b=uGKsR1B8emOXSo+aPO9pcx49U5WBEKE/nczYXV779uImjtEjNuAtoKtnKU07YaTO5w
         KT6ce6lYEQyKZ+5m9huuw3J/RehlfapatC49H+LG0u1w/N+O3Zv21NOJ+CwUqxFHkSZY
         EpgxD5LH0qAX1iV3THsgt99rH32/R9dHHgq5A0ipQULpo2lvVMiQPJ45p2ovaPTGCSQT
         p/WBGIwqQnuyojdvLBktEzL/MsPOG/M0G2jD4FE78Wl1z+Cv+GEPzjlQwBEt9ueAQ+CU
         ImvjFRcdr5bunHl9Yid1wWW7OkxE98sclXOt1V2GLLvy6hg5NDCOmDqi5hwOc/AypqPj
         DACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u7kST0rwmaC4SL82uI8pfLMZP6TWfNFAafaTbu3WzjE=;
        b=PHrkVsRnKHnSHiLUZ7vT/y82drjb/HueURfcIRPnMR137G+GzdxXZyt2dTf7O6kolH
         UbuPPii4rZw5GmtAwiy2OhlpZzcUiVXIdysb3zjF+5ZNTLIR7I99G70rWo12OhUvqO2R
         8rJiQnz/jA1+yn0TH4vuymBbH13epA08dWyEtfvc6hRO3FuynamYzSa8pu4aaHeJXGxY
         vu48RbeU20iUMubNryfFiY+IOgPHduWJN0E6zNxIYFIibs3sAEOX2G0yx+SI2vYj6PgW
         HqhTMT9dl3GFM/AJP69NBWIAM+cr/WgAuUyIFwRbHj1esM8Jd2o7lVFsg3A1yzFFJiHP
         lT7A==
X-Gm-Message-State: AOAM5333j4rDY6Z6v9FBKVe1rIQHcGyLoiMLRYi9EJS9C/IFdUH33mqO
        Fp+JL4bcLi3EU4yRgvIfkKqhIAFBTztQGsOIfyvBCA==
X-Google-Smtp-Source: ABdhPJyskRFBjvgdll8e75d+zhqGniuxb6C5bhTHGNRCW2yHKxKF8S8QIIRqbL4IyzAoEM2eLPKYSe2dOncagoIiVnU=
X-Received: by 2002:aed:2f06:: with SMTP id l6mr1120851qtd.66.1610016696350;
 Thu, 07 Jan 2021 02:51:36 -0800 (PST)
MIME-Version: 1.0
References: <590998aa9cc50f431343f76cae72b2abf8ac1fdd.1608699683.git.jpoimboe@redhat.com>
 <20210104151317.GR3021@hirez.programming.kicks-ass.net> <202101061536.C4A93132@keescook>
In-Reply-To: <202101061536.C4A93132@keescook>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 7 Jan 2021 11:51:24 +0100
Message-ID: <CACT4Y+bL3sEE6edPmFkW3zbac4D9+9c19jCNRysXohWx+7=Lzw@mail.gmail.com>
Subject: Re: [PATCH] mm/uaccess: Use 'unsigned long' to placate UBSAN
 warnings, again
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 12:37 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jan 04, 2021 at 04:13:17PM +0100, Peter Zijlstra wrote:
> > On Tue, Dec 22, 2020 at 11:04:54PM -0600, Josh Poimboeuf wrote:
> > > GCC 7 has a known bug where UBSAN ignores '-fwrapv' and generates false
> > > signed-overflow-UB warnings.  The type mismatch between 'i' and
> > > 'nr_segs' in copy_compat_iovec_from_user() is causing such a warning,
> > > which also happens to violate uaccess rules:
> > >
> > >   lib/iov_iter.o: warning: objtool: iovec_from_user()+0x22d: call to __ubsan_handle_add_overflow() with UACCESS enabled
> > >
> > > Fix it by making the variable types match.
> > >
> > > This is similar to a previous commit:
> > >
> > >   29da93fea3ea ("mm/uaccess: Use 'unsigned long' to placate UBSAN warnings on older GCC versions")
> >
> > Maybe it's time we make UBSAN builds depend on GCC-8+ ?
>
> I would be totally fine with that. The only thing I can think of that
> might care is syzbot. Dmitry, does syzbot use anything older than gcc 8?

syzbot should use gcc 10 everywhere by now (and if not, we will update).
And in general I think it's a reasonable requirement today.
