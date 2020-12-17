Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6622DD880
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 19:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgLQSio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 13:38:44 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48730 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728193AbgLQSin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 13:38:43 -0500
Received: from zn.tnic (p200300ec2f10f600357bf2818d4bbee6.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:f600:357b:f281:8d4b:bee6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F03E1EC059F;
        Thu, 17 Dec 2020 19:38:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608230282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=ibIc9832e5EwTEcT10Q3+QC5iRWUQUwoO2pPtOwkBNc=;
        b=H2FoP37+kR+S9RxaYtWQDCLW1RmeiPPfmOU78OH2QW52iQ6dw0y4ntJGDJVm6RWrfSKF9H
        TsD+Hp/Z7397xkU9dyXdTvez+/WGnYlt2CkFIQg03Wb1jwBLnxE3D5fntQI1rrn9uHn9bc
        pCJFK/UWFkRAXmgDNJ9Z1/+vL2o5/4g=
Date:   Thu, 17 Dec 2020 19:37:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documentation/submitting-patches: Document the SoB chain
Message-ID: <20201217183756.GE23634@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

ok, let's start slow and with something that should not need a whole lot
of bikeshedding. We have been repeating that a lot of times in the past
which means that, especially new submitters, do not know it. So here it
goes.

Btw, pls let me know when you start queueing the patches, on which tree
you do that so that I can send you the following ones ontop.

Also, pls have a look here and let me know what else you want moved to
generic docs:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=rc0%2b0-tip-handbook

Otherwise I'll go by my judgement, hoping that no tip-specific stuff
leaks out. :-)

Thx.

---
From: Borislav Petkov <bp@suse.de>
Subject: [PATCH] Documentation/submitting-patches: Document the SoB chain

Document what a chain of Signed-off-by's in a patch commit message
should mean, explicitly.

This has been carved out from a tip subsystem handbook patchset by
Thomas Gleixner:

  https://lkml.kernel.org/r/20181107171010.421878737@linutronix.de

and incorporates follow-on comments.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 Documentation/process/submitting-patches.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index fb8261a4be30..54d761319875 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -411,6 +411,12 @@ Some people also put extra tags at the end.  They'll just be ignored for
 now, but you can do this to mark internal company procedures or just
 point out some special detail about the sign-off.
 
+Any further SoBs (Signed-off-by:'s) following the author's SoB are from
+people handling and transporting the patch, but were not involved in its
+development. SoB chains should reflect the **real** route a patch took
+as it was propagated to the maintainers and ultimately to Linus, with
+the first SoB entry signalling primary authorship of a single author.
+
 
 When to use Acked-by:, Cc:, and Co-developed-by:
 ------------------------------------------------
-- 
2.29.2


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
