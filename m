Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C462A9E4C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 20:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgKFTw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 14:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgKFTw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 14:52:58 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F755C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 11:52:58 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id r186so1782761pgr.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 11:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kt96Jr0Z4cVutyykEDDLdrrSlVc/2nRg/Ta01oSTLh8=;
        b=fqg1gT6ASXGLrvAEDno6jGnjBo6XmlDpsrqtnKNk6h8pbx4i0342qufWryjXS48Lxv
         Y6k+1uYfb5jvT07lpHKu41v6qopjSiUpW2OXFYP0A1eVXQD1n6oiUzSJAep2LUncmWM6
         m+vBuwtCiRNhJLkFh27qdK3Y2i66w2otgN4q4tCk+qPmMqiUq6wr3FUg0O5m7eL3QOBl
         k/Ughq4nqeOzaxG54BZyvM3mpjThoTl9h00YNUYIyoOFDBx5rDwwQ3EShZSwZujCRz1b
         aD3QzdteOHiAUlJWdqr7G6LZsf6i964OLCLWA8wXb5rzWK6G2l8zWTac6JUe9Leh4Ii6
         bBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kt96Jr0Z4cVutyykEDDLdrrSlVc/2nRg/Ta01oSTLh8=;
        b=lkqpM3S9J5W075saqS5/ui6dGR35FNOdTUnLtdiHL7rPZP5LSHStY2PAL+wrGg7IuD
         ol+pGiuwA4+nfUYc36PmiDwCIBGbnNxupqLP8Zy0+ox+DOOfugQ2XAMda4BZ9aeTh+zH
         lDyKq+eDfm4cb7P+zcBjyoqJblqrWm/4XwYFCRDU6VAtwJH9KURE+vbkr2dH7e2X0svX
         OjTgTBnvUOTF3MtdbKyM9Yrb+L51vrE796rIgef+guxPHTdLuxgOeEcxOHWOLYkf3t4G
         XFFKqOzIr9i9TgxQ5CdfReSESE5r0/JhOrHTvTf4U4CRmQ0nEWEbT+9+Q5D6hB1xdfQb
         fcKg==
X-Gm-Message-State: AOAM531cxcaLlqRhAPM3IgtPeuJ+fxWLmL/TUKmy8ojss4Ck37LZyi/k
        CVwZoOMiAZ/n7q/PfkwfJPxKiKar64LPzuPNcUpjxw==
X-Google-Smtp-Source: ABdhPJxtQ24MSKMaSwDtho+7mrL7igqZ5flwXn9S2ZaacJr5f4SGaulS2LIaXKbD4oQ3c1ck5MjGV/OeeY05vOhNZlo=
X-Received: by 2002:a17:90a:6b04:: with SMTP id v4mr1206965pjj.101.1604692377390;
 Fri, 06 Nov 2020 11:52:57 -0800 (PST)
MIME-Version: 1.0
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-3-adrian.ratiu@collabora.com> <20201106101419.GB3811063@ubuntu-m3-large-x86>
 <87wnyyvh56.fsf@collabora.com>
In-Reply-To: <87wnyyvh56.fsf@collabora.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 6 Nov 2020 11:52:46 -0800
Message-ID: <CAKwvOdkodob0M0r_AK_4nG3atLGMyNENMd6qVAHSPa92Zh7UZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: lib: xor-neon: disable clang vectorization
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 3:50 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> Hi Nathan,
>
> On Fri, 06 Nov 2020, Nathan Chancellor <natechancellor@gmail.com>
> wrote:
> > + Ard, who wrote this code.
> >
> > On Fri, Nov 06, 2020 at 07:14:36AM +0200, Adrian Ratiu wrote:
> >> Due to a Clang bug [1] neon autoloop vectorization does not
> >> happen or happens badly with no gains and considering previous
> >> GCC experiences which generated unoptimized code which was
> >> worse than the default asm implementation, it is safer to
> >> default clang builds to the known good generic implementation.
> >> The kernel currently supports a minimum Clang version of
> >> v10.0.1, see commit 1f7a44f63e6c ("compiler-clang: add build
> >> check for clang 10.0.1").   When the bug gets eventually fixed,
> >> this commit could be reverted or, if the minimum clang version
> >> bump takes a long time, a warning could be added for users to
> >> upgrade their compilers like was done for GCC.   [1]
> >> https://bugs.llvm.org/show_bug.cgi?id=40976  Signed-off-by:
> >> Adrian Ratiu <adrian.ratiu@collabora.com>
> >
> > Thank you for the patch! We are also tracking this here:
> >
> > https://github.com/ClangBuiltLinux/linux/issues/496
> >
> > It was on my TODO to revist getting the warning eliminated,
> > which likely would have involved a patch like this as well.
> >
> > I am curious if it is worth revisting or dusting off Arnd's
> > patch in the LLVM bug tracker first. I have not tried it
> > personally. If that is not a worthwhile option, I am fine with
> > this for now. It would be nice to try and get a fix pinned down
> > on the LLVM side at some point but alas, finite amount of
> > resources and people :(
>
> I tested Arnd's kernel patch from the LLVM bugtracker [1], but
> with the Clang v10.0.1 I still get warnings like the following
> even though the __restrict workaround seems to affect the
> generated instructions:
>
> ./include/asm-generic/xor.h:15:2: remark: the cost-model indicates
> that interleaving is not beneficial [-Rpass-missed=loop-vectorize]
> ./include/asm-generic/xor.h:11:1: remark: List vectorization was
> possible but not beneficial with cost 0 >= 0
> [-Rpass-missed=slp-vectorizer] xor_8regs_2(unsigned long bytes,
> unsigned long *__restrict p1, unsigned long *__restrict p2)

If it's just a matter of overruling the cost model
#pragma clang loop vectorize(enable)

will do the trick.

Indeed,
```
diff --git a/include/asm-generic/xor.h b/include/asm-generic/xor.h
index b62a2a56a4d4..8796955498b7 100644
--- a/include/asm-generic/xor.h
+++ b/include/asm-generic/xor.h
@@ -12,6 +12,7 @@ xor_8regs_2(unsigned long bytes, unsigned long *p1,
unsigned long *p2)
 {
        long lines = bytes / (sizeof (long)) / 8;

+#pragma clang loop vectorize(enable)
        do {
                p1[0] ^= p2[0];
                p1[1] ^= p2[1];
@@ -32,6 +33,7 @@ xor_8regs_3(unsigned long bytes, unsigned long *p1,
unsigned long *p2,
 {
        long lines = bytes / (sizeof (long)) / 8;

+#pragma clang loop vectorize(enable)
        do {
                p1[0] ^= p2[0] ^ p3[0];
                p1[1] ^= p2[1] ^ p3[1];
@@ -53,6 +55,7 @@ xor_8regs_4(unsigned long bytes, unsigned long *p1,
unsigned long *p2,
 {
        long lines = bytes / (sizeof (long)) / 8;

+#pragma clang loop vectorize(enable)
        do {
                p1[0] ^= p2[0] ^ p3[0] ^ p4[0];
                p1[1] ^= p2[1] ^ p3[1] ^ p4[1];
@@ -75,6 +78,7 @@ xor_8regs_5(unsigned long bytes, unsigned long *p1,
unsigned long *p2,
 {
        long lines = bytes / (sizeof (long)) / 8;

+#pragma clang loop vectorize(enable)
        do {
                p1[0] ^= p2[0] ^ p3[0] ^ p4[0] ^ p5[0];
                p1[1] ^= p2[1] ^ p3[1] ^ p4[1] ^ p5[1];
```
seems to generate the vectorized code.

Why don't we find a way to make those pragma's more toolchain
portable, rather than open coding them like I have above rather than
this series?

-- 
Thanks,
~Nick Desaulniers
