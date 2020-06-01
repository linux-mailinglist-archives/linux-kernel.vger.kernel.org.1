Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9351E9F9C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 09:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgFAHyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 03:54:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:48860 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728089AbgFAHyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:54:54 -0400
IronPort-SDR: j3CRKgpM3WvcoNWMjL0uNX9fi7T4tNiLgKj/nwhQSRYJVYekXyKEt3zVY2lZM0Iou5Ax5NKYqI
 YRFNoFCEEDyA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 00:54:54 -0700
IronPort-SDR: 4Z+NoaAQhS2Ooz6g4003qw9yMkeXa/o15X0b3JQ4F8TRFsdMk3L3S7Tnr+CBDdFj73N4gDTfpd
 sisgwMOSgo/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,460,1583222400"; 
   d="scan'208";a="311879995"
Received: from yhanin-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.43.17])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Jun 2020 00:54:48 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, sean.j.christopherson@intel.com,
        yaozhangx@google.com
Subject: [PATCH v32 21/21] x86/sgx: Update MAINTAINERS
Date:   Mon,  1 Jun 2020 10:52:18 +0300
Message-Id: <20200601075218.65618-22-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200601075218.65618-1-jarkko.sakkinen@linux.intel.com>
References: <20200601075218.65618-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the maintainer information for the SGX subsystem.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 50659d76976b..2aa6d50afc44 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8840,6 +8840,17 @@ F:	Documentation/x86/intel_txt.rst
 F:	arch/x86/kernel/tboot.c
 F:	include/linux/tboot.h
 
+INTEL SGX
+M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+M:	Sean Christopherson <sean.j.christopherson@intel.com>
+L:	linux-sgx@vger.kernel.org
+S:	Maintained
+Q:	https://patchwork.kernel.org/project/intel-sgx/list/
+T:	git https://github.com/jsakkine-intel/linux-sgx.git
+F:	arch/x86/include/uapi/asm/sgx.h
+F:	arch/x86/kernel/cpu/sgx/*
+K:	\bSGX_
+
 INTERCONNECT API
 M:	Georgi Djakov <georgi.djakov@linaro.org>
 L:	linux-pm@vger.kernel.org
-- 
2.25.1

