Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B752B1BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgKMNkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMNkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:40:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDC0C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:40:45 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605274844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p5mwrVsWtueiaiYg1WfJL9uYICXVeES2kWr3szrkRuo=;
        b=XXkG5C8Tq0doWXDccC0iH1CSr+33RcyNo20Bhd9CSFm67wZBCe/ML9jChAR5l6Is7RRWVQ
        zdKewIE63HC8c9mfBATskrvAAYNfp9UXpSMu3S17sqPHfYwxU3OD6ujGuviMGx65w+hzFt
        OYE/8LQUyzk3n5nXzQhC110bekJYTB5aTlE23sc1PcEnPKOmD+0rddSdGO+tiuWMtCS2Vk
        qd+EeQtf5DORcA1mzXceSnEqfSUsO1Skz72zaBQtdJuz9qUz89GH3PXzgPGMxlQoHqM513
        wZnG/G6d7Er52zufhkUwWuQV2Tv6Xs3JS8KdhtA5a5O6x7LcPQbMjOlymxxYpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605274844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p5mwrVsWtueiaiYg1WfJL9uYICXVeES2kWr3szrkRuo=;
        b=4RjPoltS7DtfLm5GdvmjmTQJqibKtcZAjn7r80w3vR4VqWpmGgQySiywgD5+K78Q8jaGT7
        Q+tBFM0Yqdd2eMBQ==
To:     Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] highmem: fix highmem for xtensa
In-Reply-To: <20201113122328.22942-1-jcmvbkbc@gmail.com>
References: <20201113122328.22942-1-jcmvbkbc@gmail.com>
Date:   Fri, 13 Nov 2020 14:40:43 +0100
Message-ID: <87zh3ll6hw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Max,

On Fri, Nov 13 2020 at 04:23, Max Filippov wrote:
> Fixmap on xtensa grows upwards, i.e. bigger fixmap entry index
> corresponds to a higher virtual address. This was lost in highmem
> generalization resulting in the following runtime warnings:

Sorry for not noticing.

> Fix it by adding __ARCH_HAS_POSITIVE_FIXMAP macro and implementing
> vaddr_in_fixmap and fixmap_pte primitives differently depending on
> whether it is defined or not.

What's wrong with just doing the obvious and making the fixmap defines
the other way round?

Thanks,

        tglx
---

diff --git a/arch/xtensa/include/asm/fixmap.h b/arch/xtensa/include/asm/fixmap.h
index 92049b61c351..ee17e46f3b44 100644
--- a/arch/xtensa/include/asm/fixmap.h
+++ b/arch/xtensa/include/asm/fixmap.h
@@ -37,8 +37,8 @@
 enum fixed_addresses {
 #ifdef CONFIG_HIGHMEM
 	/* reserved pte's for temporary kernel mappings */
-	FIX_KMAP_BEGIN,
-	FIX_KMAP_END = FIX_KMAP_BEGIN +
+	FIX_KMAP_END,
+	FIX_KMAP_BEGIN = FIX_KMAP_END +
 		(KM_MAX_IDX * NR_CPUS * DCACHE_N_COLORS) - 1,
 #endif
 	__end_of_fixed_addresses
