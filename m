Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBE12002D5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 09:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbgFSHlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 03:41:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58794 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbgFSHlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:41:02 -0400
Received: from zn.tnic (p200300ec2f0bac00fd80253c6a150deb.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ac00:fd80:253c:6a15:deb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 91A071EC0298;
        Fri, 19 Jun 2020 09:41:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592552460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IritHY2wnRSz18h7p7bbLCpGe2Z1I4B1arbap5AVn8U=;
        b=pfKzaMfCiuoUSuFoMXI39QqAHedsWRO5ccukKB+JVpbofnbCm9q3yJ2rMIQEiejKNoIfk4
        68ICEortCSIaTz5Tvoh++8jrauFM9kTb1+iEWFnDGDqhXXg8q4ThaCxlBlAA79FG+NAC/1
        T3AOGMju1KbkkYX0VQwf1xzP9DwK4CY=
Date:   Fri, 19 Jun 2020 09:40:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
Message-ID: <20200619074053.GA32683@zn.tnic>
References: <20200618210215.23602-1-daniel.gutson@eclypsium.com>
 <589c89ae-620e-36f8-2be5-4afc727c2911@intel.com>
 <CAFmMkTHNxSN_uWtm63TdkGxj44NXQQKEOmATXhjA=4DSCS92kQ@mail.gmail.com>
 <20200618220139.GH27951@zn.tnic>
 <CAFmMkTGMAu-huTnP1aeMb_W4NddbTD_b2jhbDVKBDrkwgB97wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFmMkTGMAu-huTnP1aeMb_W4NddbTD_b2jhbDVKBDrkwgB97wg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 07:34:21PM -0300, Daniel Gutson wrote:
> Besides being a CPU capability, it has to be enabled by the BIOS, which is
> what the flag represents.

... yes, and if it is disabled in the BIOS, you clear the CPU cap flag.
Something like this untested diff:

---
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index c25a67a34bd3..59d8342f6a64 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -525,6 +525,7 @@ static void detect_tme(struct cpuinfo_x86 *c)
 	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
 		pr_info_once("x86/tme: not enabled by BIOS\n");
 		mktme_status = MKTME_DISABLED;
+		clear_cpu_cap(c, X86_FEATURE_TME);
 		return;
 	}
 
@@ -553,10 +554,11 @@ static void detect_tme(struct cpuinfo_x86 *c)
 		pr_info_once("x86/mktme: disabled by BIOS\n");
 	}
 
-	if (mktme_status == MKTME_UNINITIALIZED) {
-		/* MKTME is usable */
+	/* MKTME is usable */
+	if (mktme_status == MKTME_UNINITIALIZED)
 		mktme_status = MKTME_ENABLED;
-	}
+	else if (mktme_status == MKTME_DISABLED)
+		clear_cpu_cap(c, X86_FEATURE_TME);
 
 	/*
 	 * KeyID bits effectively lower the number of physical address

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
