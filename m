Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033EF271740
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgITS7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:59:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50162 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgITS7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:59:21 -0400
Received: from zn.tnic (p200300ec2f295d00c534af3fd805ebd6.dip0.t-ipconnect.de [IPv6:2003:ec:2f29:5d00:c534:af3f:d805:ebd6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6CF4E1EC0269;
        Sun, 20 Sep 2020 20:59:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600628360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UvXD3Q/TMABI41d+N90w8/mHRLoeW6vMnaSJGKGrbRc=;
        b=VNROPEgrxzET1pj/7t1nW7ippDsTCNLCBbd98ifrzv2xRuAg7RF3OjrmVGa3P8h+c5GXxF
        vYbZGUoYyPi1thJmbS9Hln7QaRF4MeYYWKGXQFDIKd72XJ152zNfKKvSUtV+Du+aziLhsJ
        TA21OZWi3QBfcTw8zDGlwcX3BZg2DGM=
Date:   Sun, 20 Sep 2020 20:59:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] Use feature bit names in clearcpuid=
Message-ID: <20200920185914.GD7473@zn.tnic>
References: <20200920154228.GB7473@zn.tnic>
 <20200920161628.GA3951950@rani.riverdale.lan>
 <20200920172954.GC7473@zn.tnic>
 <20200920183527.GA3970023@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200920183527.GA3970023@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 02:35:27PM -0400, Arvind Sankar wrote:
> Thanks. Maybe also mention in the documentation that names can now be
> used.

Already did it as an incremental ontop. Will merge later:

---
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ffe864390c5a..49988e891d7f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -577,12 +577,17 @@
 			loops can be debugged more effectively on production
 			systems.
 
-	clearcpuid=BITNUM[,BITNUM...] [X86]
+	clearcpuid=X[,X...] [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
-			numbers. Note the Linux specific bits are not necessarily
-			stable over kernel options, but the vendor specific
+			numbers X. Note the Linux-specific bits are not necessarily
+			stable over kernel options, but the vendor-specific
 			ones should be.
+			X can also be a string as appearing in the flags: line
+			in /proc/cpuinfo which does not have the above
+			instability issue. However, not all features have names
+			in /proc/cpuinfo.
+			Note that using this option will taint your kernel.
 			Also note that user programs calling CPUID directly
 			or using the feature without checking anything
 			will still see it. This just prevents it from


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
