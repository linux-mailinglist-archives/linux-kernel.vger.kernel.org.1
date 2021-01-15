Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBD72F87B5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 22:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbhAOVd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 16:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbhAOVd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 16:33:58 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8700DC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 13:33:18 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id u25so15288770lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 13:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQxUP24hpiBqEtJYhYwHk6U8ZAm2WakN0TBfaYLNdRc=;
        b=UwkikTy66sWmdnraVWEJ+LlzCNJYBCKbswTcMKOsHurlf1pkecqJjGDUv8bqcK2d1h
         x0Xtu+z3jgU8oB3RtulGryrnGgO1d4IxAVK+rusX5EUub8DSi2y8MoQmAHvHu+ai3IG0
         E6lROXLPXv4yp3z0MlDnv1aLo+5QU1+6Z+sCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQxUP24hpiBqEtJYhYwHk6U8ZAm2WakN0TBfaYLNdRc=;
        b=HggjzwqNGauDsVL5PUamCFyGxK1VV2IFurie8VY9jTyd88TsCGPIOYAKFyQ4byG/bG
         TPUsFFH3caBjuLfwXc4WLMueoKQozvqbs9ZiSYRTyxq64tQe3IbrPfYlQAH9cU5oNb2T
         CS4aewCu7+L+vd9RqGg3l2YF7VDqpq1jJM7alJ6GZ2T5cdP4atAHl3LDr3QbdCNs3Xe7
         ljWTXI8zr8jiH7RDkRmbCA268NVjEWDCojCllstgZ7DwqKFUga5FJ1FK04fdmuYhP+1S
         idOS6lFKzH2fBN7TXJGlZsL847Td4efcnK2rw/j2dXJ5XFx41Sa/BltH7E6E5u+JTEgI
         KDtQ==
X-Gm-Message-State: AOAM532Od+02e19DV2iegiRIni9fNb6n11LTgdAHMV0YzZiaRmNnZfvq
        fFRVWbBtGcp21s+9zyWzr/pvjc6MMs/+Lw==
X-Google-Smtp-Source: ABdhPJwfoPzskVEyPENBNMn+LnLR2QU2hnp7MDf3GJqgFzBDLaDiWEQtXyCMuhYjeTbxmm4nfcBVjg==
X-Received: by 2002:ac2:51ab:: with SMTP id f11mr6907101lfk.510.1610746396206;
        Fri, 15 Jan 2021 13:33:16 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id e6sm1028948lfc.23.2021.01.15.13.33.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 13:33:14 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id o10so15232867lfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 13:33:13 -0800 (PST)
X-Received: by 2002:a05:6512:789:: with SMTP id x9mr6054405lfr.487.1610746393145;
 Fri, 15 Jan 2021 13:33:13 -0800 (PST)
MIME-Version: 1.0
References: <20210114175934.13070-1-will@kernel.org> <20210114175934.13070-5-will@kernel.org>
 <CAHk-=wixsPuT5ingsEqj2a1PKuc+rTS_oeD_VL0p8G_3oRiJhA@mail.gmail.com>
 <20210114190021.GB13135@willie-the-truck> <CAHk-=wjdJmL22+zk3_rWAfEJJCf=oDxiJ530qk-WNk_Ji0qhxw@mail.gmail.com>
 <20210114194129.GA13314@willie-the-truck> <CAHk-=wixswKjAPt0eEVSHqOQB9tBuO5FeqfyKyxFWyBLEG6EcQ@mail.gmail.com>
 <20210115092313.GA13700@willie-the-truck>
In-Reply-To: <20210115092313.GA13700@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Jan 2021 13:32:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjWQFSZci+By4wXAEx6EDH4nss7tf5QimQpF53rnHa7Wg@mail.gmail.com>
Message-ID: <CAHk-=wjWQFSZci+By4wXAEx6EDH4nss7tf5QimQpF53rnHa7Wg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/8] mm: Separate fault info out of 'struct vm_fault'
To:     Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 1:23 AM Will Deacon <will@kernel.org> wrote:
>
> Hmm. The feedback on the clang bug suggests that GCC is the one in the
> wrong here (although the argument is based on C11 and I haven't trawled
> through the standards to see how this has evolved):

Oh well.

That writing is absolutely the _worst_ kind of weaselwording standards
language reading, trying to make excuses for bad behavior by basically
depending on "this language is unclear", and trying to say that the
buggy behavior is required by C11.

What a disappointment.

Absolutely nothing in the quoted C11 language says to me what that bug
entry claims it says.

The argument seems to hinge on

   "The members of an anonymous structure or union are considered to
be members of the containing structure or union"

and then it makes the completely uncalled-for leap that that means
that because it was "int" in the const struct, it must be "int" in the
containing structure too.

Which is complete BS, and doesn't follow logically _or_ grammatically.
It would be a "member of the containing structure" even with the
"const" qualifier, so the argument they make is just inane.

In fact, the _other_ sentence they quote clearly points to this being
just a clang bug:

 "A modifiable lvalue is [...] if it is a structure or union, does not
have any member (including, recursively, any member or element of all
contained aggregates or unions) with a const- qualified type"

and clearly this recursively is an element with a const-qualified
recursive struct.

Whatever. It's one of those "read the documentation squint-eyed to
avoid doing the right thing" arguments.

It's not worth arguing with people like that, and let's just ignore
the clang bug here.

            Linus
