Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2222B1A8659
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391543AbgDNQ4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:56:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407497AbgDNQtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:07 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A70F721582;
        Tue, 14 Apr 2020 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882942;
        bh=eBOZxoYZIMRnDM3jqbg57vKJcreJqVFOz+37SNmuNs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f/wXJl1SXv8hFUd9Me+oFyz3s5kMsFviA8o+ubvlkRZvVhVoMJ7bZdzUmSykTg6nL
         yCoh/0UuTEXAb3cF5Zv3W9cVjuoou+GBrmeK2KYwnTAQu0uYLBaEocjCGJN6UgT79i
         TBuL0ozWjmq6US7ZfYW+/46IVF6L7DxOOBAR9rL0=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk8-0068lp-Tr; Tue, 14 Apr 2020 18:49:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 12/33] docs: amu: supress some Sphinx warnings
Date:   Tue, 14 Apr 2020 18:48:38 +0200
Message-Id: <ab0881638fc41ed790b3307a8e022ec84b7cce7e.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add extra blank lines on some places, in order to avoid those
warnings when building the docs:

    Documentation/arm64/amu.rst:26: WARNING: Unexpected indentation.
    Documentation/arm64/amu.rst:60: WARNING: Unexpected indentation.
    Documentation/arm64/amu.rst:81: WARNING: Unexpected indentation.
    Documentation/arm64/amu.rst:108: WARNING: Unexpected indentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/arm64/amu.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/arm64/amu.rst b/Documentation/arm64/amu.rst
index 5057b11100ed..452ec8b115c2 100644
--- a/Documentation/arm64/amu.rst
+++ b/Documentation/arm64/amu.rst
@@ -23,6 +23,7 @@ optional external memory-mapped interface.
 
 Version 1 of the Activity Monitors architecture implements a counter group
 of four fixed and architecturally defined 64-bit event counters.
+
   - CPU cycle counter: increments at the frequency of the CPU.
   - Constant counter: increments at the fixed frequency of the system
     clock.
@@ -57,6 +58,7 @@ counters, only the presence of the extension.
 
 Firmware (code running at higher exception levels, e.g. arm-tf) support is
 needed to:
+
  - Enable access for lower exception levels (EL2 and EL1) to the AMU
    registers.
  - Enable the counters. If not enabled these will read as 0.
@@ -78,6 +80,7 @@ are not trapped in EL2/EL3.
 
 The fixed counters of AMUv1 are accessible though the following system
 register definitions:
+
  - SYS_AMEVCNTR0_CORE_EL0
  - SYS_AMEVCNTR0_CONST_EL0
  - SYS_AMEVCNTR0_INST_RET_EL0
@@ -93,6 +96,7 @@ Userspace access
 ----------------
 
 Currently, access from userspace to the AMU registers is disabled due to:
+
  - Security reasons: they might expose information about code executed in
    secure mode.
  - Purpose: AMU counters are intended for system management use.
@@ -105,6 +109,7 @@ Virtualization
 
 Currently, access from userspace (EL0) and kernelspace (EL1) on the KVM
 guest side is disabled due to:
+
  - Security reasons: they might expose information about code executed
    by other guests or the host.
 
-- 
2.25.2

