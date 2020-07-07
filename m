Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B70216465
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 05:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgGGDH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 23:07:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:28968 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgGGDH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 23:07:26 -0400
IronPort-SDR: LV6J6qFEb18APpUXiIhLDRm546/n7TMzDi1U/zBZHh+h8himd6dKe2JYQB0mPZ98kJWQB3rT4x
 ez0SMTrdRsPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="145032122"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="145032122"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 20:07:26 -0700
IronPort-SDR: bfrMhqG+etWTqlcu6LE5K1158aGOxMarYj93Lj06bhVJ9w3l97t29cu+/3SGsz8WId2DpxhVXx
 QJjb6w9JYCCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="388369089"
Received: from apiccion-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.45.178])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jul 2020 20:07:16 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, linux-sgx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
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
Subject: [PATCH v34 24/24] x86/sgx: Update MAINTAINERS
Date:   Tue,  7 Jul 2020 06:02:04 +0300
Message-Id: <20200707030204.126021-25-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707030204.126021-1-jarkko.sakkinen@linux.intel.com>
References: <20200707030204.126021-1-jarkko.sakkinen@linux.intel.com>
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
index 1d4aa7f942de..9b5268aa26db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8968,6 +8968,17 @@ F:	Documentation/x86/intel_txt.rst
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

