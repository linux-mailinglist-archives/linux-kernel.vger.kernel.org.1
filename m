Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588802AE5C5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 02:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbgKKBTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 20:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731610AbgKKBTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 20:19:48 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FF7C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 17:19:48 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id b6so753517wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 17:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=F+pUNae2Ork6DSx79r9ToYogqYk1+vYxanQo0ue5F60=;
        b=j4d8d1bwTh7SwUSSB6Qh8Yi2GfiQg9HLpfhrcMwGazALFW3pCTDB1xgirsWSqT2HZR
         G4WKQTtXXz+/2+xKKN8n4oDKV7PXc9Vj92aNucY5x+wdg/xBSSSWYYbtZTfGoP3z1gsr
         D2PYMCwBkxyqZl7FmwTjrZ6+2qq46Emb9T5A7RK2569Bc4hC/eMlttic401BiqQY81Gs
         l+2NoOyCz0ozAA/hq+MUBkNbcOb2onXOovWPVfEBA3t4bYy+AJW71NbYJcgZtRYMhL0S
         cg2fQ4cVhOQdvckLx0J84Swxy+HSlMCAlQbW31aa/tIONQ5+5gqHMtAwTKsFYWjjkd+2
         dtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=F+pUNae2Ork6DSx79r9ToYogqYk1+vYxanQo0ue5F60=;
        b=R2PY0+A+CZKJYtGm1iJeBfSzAPUB2WKyLjWFvxMDZn3BcGHFFzlfTwUeltdpOZeC8V
         /4G5vZziziDFqFZWRdGxxHJl1QtdITyBEPzlRdppxfBsdMpEQUaJ7Cy0SnDA7bNw28aj
         3ZTEoJVOZd0VWRN88ccxHjc7h0uX3bSJD0cqFfGM9CF6C62juShGFnAcJ1ojRZLwM/F1
         4F2c74UFgMqIMEFCbkbvCt2vcL0dZ6XArGHeGMgNHWP1MsEztJ0Qo767LYfFFdHAR7sP
         80RzziMJyiD7FXHDbnq8GRqSjmVmAyK9nEWya3guf6mgsuFboKHDOk7+cNsoPvhvA+Hj
         lVfg==
X-Gm-Message-State: AOAM530snboVL/jC5wFoThzh6ICtxG5CXtjpsPzb1QCL/y0ytzZKwEn6
        wc0tqwMcdMTiNQJRYOVZVyw=
X-Google-Smtp-Source: ABdhPJxFFnxCWeCAyBCZWm++vw5KrxfC8o4qIBCHc+cIerppIWoZCuYYggLE/xxCwDuY6Lkpa9j8bA==
X-Received: by 2002:a05:6000:143:: with SMTP id r3mr15703912wrx.212.1605057587006;
        Tue, 10 Nov 2020 17:19:47 -0800 (PST)
Received: from ansuelxps20 (93-39-149-95.ip76.fastwebnet.it. [93.39.149.95])
        by smtp.gmail.com with ESMTPSA id r8sm486497wrq.14.2020.11.10.17.19.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 17:19:46 -0800 (PST)
From:   <ansuelsmth@gmail.com>
To:     "'Al Viro'" <viro@zeniv.linux.org.uk>
Cc:     "'Will Deacon'" <will@kernel.org>,
        "'Catalin Marinas'" <catalin.marinas@arm.com>,
        "'Andrew Morton'" <akpm@linux-foundation.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Pavel Tatashin'" <pasha.tatashin@soleen.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20201111004440.8783-1-ansuelsmth@gmail.com> <20201111005826.GY3576660@ZenIV.linux.org.uk> <20201111010910.GZ3576660@ZenIV.linux.org.uk>
In-Reply-To: <20201111010910.GZ3576660@ZenIV.linux.org.uk>
Subject: R: [PATCH] arm64: fix missing include in asm uaccess.h
Date:   Wed, 11 Nov 2020 02:19:48 +0100
Message-ID: <000001d6b7c8$bfed23e0$3fc76ba0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMmE+bT5DKvLtqt64q97NbcO3B/eQK8xGH0AfXCMfKm/dRbgA==
Content-Language: it
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Nov 11, 2020 at 12:58:26AM +0000, Al Viro wrote:
> > On Wed, Nov 11, 2020 at 01:44:38AM +0100, Ansuel Smith wrote:
> > > Fix a compilation error as PF_KTHREAD is defined in linux/sched.h and
> > > this is missing.
> > >
> > > Fixes: df325e05a682 ("arm64: Validate tagged addresses in access_ok()
> > > called from kernel threads")
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  arch/arm64/include/asm/uaccess.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/arm64/include/asm/uaccess.h
> b/arch/arm64/include/asm/uaccess.h
> > > index 991dd5f031e4..51a4f63f464a 100644
> > > --- a/arch/arm64/include/asm/uaccess.h
> > > +++ b/arch/arm64/include/asm/uaccess.h
> > > @@ -7,6 +7,8 @@
> > >  #ifndef __ASM_UACCESS_H
> > >  #define __ASM_UACCESS_H
> > >
> > > +#include <linux/sched.h>
> > > +
> > >  #include <asm/alternative.h>
> > >  #include <asm/kernel-pgtable.h>
> > >  #include <asm/sysreg.h>
> >
> > NAK.  The real bug is in arch/arm64/include/asm/asm-prototypes.h -
> > it has no business pulling asm/uaccess.h
> >
> > Just include linux/uaccess.h instead.
> 
> BTW,
> $ grep -n uaccess.h `find -name asm-prototypes.h`
> ./arch/alpha/include/asm/asm-prototypes.h:7:#include <linux/uaccess.h>
> ./arch/arm64/include/asm/asm-prototypes.h:18:#include <asm/uaccess.h>
> ./arch/ia64/include/asm/asm-prototypes.h:12:#include <linux/uaccess.h>
> ./arch/mips/include/asm/asm-prototypes.h:6:#include <linux/uaccess.h>
> ./arch/powerpc/include/asm/asm-prototypes.h:14:#include <linux/uaccess.h>
> ./arch/sparc/include/asm/asm-prototypes.h:9:#include <linux/uaccess.h>
> ./arch/x86/include/asm/asm-prototypes.h:3:#include <linux/uaccess.h>
> 
> Spot the irregularity...
> 
> While we are at it,
> $ git grep -n -w '#.*include.*asm/uaccess.h'
> arch/arm64/include/asm/asm-prototypes.h:18:#include <asm/uaccess.h>
> arch/nds32/math-emu/fpuemu.c:5:#include <asm/uaccess.h>
> arch/powerpc/kvm/book3s_xive_native.c:15:#include <asm/uaccess.h>
> arch/powerpc/mm/book3s64/radix_pgtable.c:30:#include <asm/uaccess.h>
> drivers/s390/net/ctcm_mpc.c:50:#include <linux/uaccess.h>       /* instead
of
> <asm/uaccess.h> ok ? */
> include/linux/uaccess.h:11:#include <asm/uaccess.h>
> 
> The last one is the only such include that should exist; drivers/s390 one
> is obviously a false positive.  And IMO the right thing to do is to
> replace the remaining arch/* instances with includes of linux/uaccess.h.
> 
> All of those are asking for trouble; any change moving e.g. a common
> variant of some primitive into linux/uaccess.h might end up breaking
> those.

Thx for the quick response. I found this error while working on a qcom
driver that
use this include. I can confirm that by using linux/uaccess.h the problem is
solved.

