Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86391C69DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 09:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgEFHP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 03:15:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33158 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgEFHPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:15:25 -0400
Received: from zn.tnic (p200300EC2F069600BCEB9C28D5742179.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9600:bceb:9c28:d574:2179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AA9E71EC034B;
        Wed,  6 May 2020 09:15:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588749324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mho8C6sS35IZKSMRYCZD7BQKFP6CHln6/0OkmPTwSsw=;
        b=miO0vNqhVF9QZJUg0/3h0QbVSepTdaUav5YLQEM/HVhZiXKI69lnlMK5xWgcJNCm/PUzPz
        y77M8KHz9uO6UxbSyqZfrfGPC/3sfBDN4u8coSi1ahtNmmRqrd4ut9uqDiVYGZeqGAumw8
        dk3By3rTVy1GI2IukZpb1C1hx1oYHAI=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] x86/cpu: Add a X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS() macro
Date:   Wed,  6 May 2020 09:15:15 +0200
Message-Id: <20200506071516.25445-3-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200506071516.25445-1-bp@alien8.de>
References: <20200506071516.25445-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... to match Intel family 6 CPUs with steppings.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/cpu_device_id.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index 10426cd56dca..eb8fcede9e3b 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -160,6 +160,10 @@
 #define X86_MATCH_INTEL_FAM6_MODEL(model, data)				\
 	X86_MATCH_VENDOR_FAM_MODEL(INTEL, 6, INTEL_FAM6_##model, data)
 
+#define X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(model, steppings, data)	\
+	X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
+						     steppings, X86_FEATURE_ANY, data)
+
 /*
  * Match specific microcode revisions.
  *
-- 
2.21.0

