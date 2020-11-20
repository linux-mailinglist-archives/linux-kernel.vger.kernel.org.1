Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7553D2BB198
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 18:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgKTRmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 12:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgKTRmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 12:42:15 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813C0C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:42:14 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id v144so14558829lfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hvM/LSSgC/tnV2UckBGwLgeFxj82XVDHBn5i8yTzPoc=;
        b=WQOOknlZ8F+t2Kqhx+/MokFS4U6JsIVoI24638zYY6iykL7IFtVbg7ZAZBkFF5OEf1
         L08UK6oBAyUmkQjspP1fMdgnkurzkrhPgamkO8jVj+4LoSunIpo6bEefyHNISLDXTmDg
         bn+27eY+exS2MXRYWuydpquaxxcniVPi3YJzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvM/LSSgC/tnV2UckBGwLgeFxj82XVDHBn5i8yTzPoc=;
        b=qbxiNJ0+n/GYNBMB+Y8l2TORTGiCNJgML7rXtDgh9Xl0FmBN0ChoxMCy4mEbDmcCmS
         GqWCThl41PuCX+PmiqYqxcftVU16pQnO2wTQVyvwtrd+SIyJCfM4JXO8ChTirhCF0r9n
         6O0oIiQFCzjaN3xPQcZSmnFv55iyxaaW/dZWCzwIUIO/jyKi9UDrqaoda+mADz80Vt7O
         r/0bWTTtGuc1rQQzqjP7TQz5KI9ectfjOxbCNJjkmt5YHs54UetlE2W9kiEc0M7Pus3M
         sQEevKH2GJQMv9QakY7OKTCebQlU47dcbDckB0QS3vJo4ksbQHYW+U0clANB2QUTxGju
         5DQQ==
X-Gm-Message-State: AOAM530wrAK/Fw3NPJ8hcyvqoHi+erR0NJUiGFKDOVC4+8KwnXoh/OJM
        LMxHED4+pQKuDqVNShy1KipEwSuQSddf0w==
X-Google-Smtp-Source: ABdhPJwX8xO4+L0mAeVDPU8EhH4aZgRXV9f1c2S1u2V3m296qRDIkMByyuTaxPMJE6pLqHVNT1G8Gg==
X-Received: by 2002:ac2:4543:: with SMTP id j3mr7862019lfm.511.1605894131849;
        Fri, 20 Nov 2020 09:42:11 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id h6sm413466lfj.108.2020.11.20.09.42.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 09:42:11 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id e139so14634976lfd.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:42:10 -0800 (PST)
X-Received: by 2002:a19:7f55:: with SMTP id a82mr9487841lfd.603.1605894130308;
 Fri, 20 Nov 2020 09:42:10 -0800 (PST)
MIME-Version: 1.0
References: <20201120143557.6715-1-will@kernel.org> <20201120143557.6715-7-will@kernel.org>
In-Reply-To: <20201120143557.6715-7-will@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Nov 2020 09:41:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjKjnT=yNnRgfPRknOBYF4oJHixbT10wDqXpjQ1qiW7SA@mail.gmail.com>
Message-ID: <CAHk-=wjKjnT=yNnRgfPRknOBYF4oJHixbT10wDqXpjQ1qiW7SA@mail.gmail.com>
Subject: Re: [PATCH 6/6] mm: proc: Avoid fullmm flush for young/dirty bit toggling
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 6:36 AM Will Deacon <will@kernel.org> wrote:
>
> Ensure that TLB invalidation is performed after updating soft-dirty
> entries via clear_refs_write() by using the non-fullmm API to MMU gather.

This code sequence looks bogus to begin with.

It does that

                tlb_gather_mmu(&tlb, mm, 0, -1);
     ..
                tlb_finish_mmu(&tlb, 0, -1);

around the loop (all, your patch series changes those arguments), but
it doesn't actually use "tlb" anywhere inside the loop itself that I
can see.

Yeah., yeah, it sets the flush_pending thing etc, but that still
sounds fundamentally wrong. It should do the proper range adjustments
if/when it actually wals the range. No?

If I read this all right, it will do a full TLB flush even when it
doesn't do anything (eg CLEAR_REFS_SOFT_DIRTY with no softdirty
pages).

So this looks all kinds of bogus. Not your patch, but the code it patches.

               Linus
