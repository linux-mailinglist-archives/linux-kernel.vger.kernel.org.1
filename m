Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C51726A569
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgIOMnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgIOLm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:42:27 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A830CC06178A;
        Tue, 15 Sep 2020 04:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6oVqFguTY88nx046qRZZUVk5BI6qMTS+nDtw4NJb1Rs=; b=a1DwroSunHWDZGQaucAk5G7svo
        gcgI41+ptEoCPjaGZOSqpTBAAukEXjdV2gXr90nhxmJMiDab5aNoVMW0yxDVjyWepwCsSlvasI5sU
        h5SXIvnppE4SAOBINz1YNMCanOfsOQvdgY1Y06lDL4NkjHZ12PGu4GJyO3eaxTgXdvO8M8ciu/EmL
        R6HGyHryXm2PjxE4ofSENu5W37w09HYBE1HKqHSqoreLAeHNkt0Zg3DnjkriZrTF0Po1FqZ2seI2y
        VvH2JwDqxPjbNR8Di2h3aeJ+Qse0RBwY1dlXZJTtrsw36frP8BEDTojUOaDih/1o6ITMXOrJpq6Co
        cqGw4s0Q==;
Received: from 83-245-197-237.elisa-laajakaista.fi ([83.245.197.237] helo=localhost)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jarkko.sakkinen@linux.intel.com>)
        id 1kI8mA-0005tz-Eb; Tue, 15 Sep 2020 14:05:30 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, linux-sgx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, bp@alien8.de, cedric.xing@intel.com,
        chenalexchen@google.com, conradparker@google.com,
        cyhanish@google.com, dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, tglx@linutronix.de, yaozhangx@google.com
Subject: [PATCH v38 07/24] x86/cpu/intel: Add nosgx kernel parameter
Date:   Tue, 15 Sep 2020 14:05:05 +0300
Message-Id: <20200915110522.893152-8-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200915110522.893152-1-jarkko.sakkinen@linux.intel.com>
References: <20200915110522.893152-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 83.245.197.237
X-SA-Exim-Mail-From: jarkko.sakkinen@linux.intel.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel parameter to disable Intel SGX kernel support.

Tested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 ++
 arch/x86/kernel/cpu/feat_ctl.c                  | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a1068742a6df..e53448716567 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3339,6 +3339,8 @@
 
 	nosep		[BUGS=X86-32] Disables x86 SYSENTER/SYSEXIT support.
 
+	nosgx		[X86-64,SGX] Disables Intel SGX kernel support.
+
 	nosmp		[SMP] Tells an SMP kernel to act as a UP kernel,
 			and disable the IO APIC.  legacy for "maxcpus=0".
 
diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index c3afcd2e4342..1837df39527f 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -101,6 +101,15 @@ static void clear_sgx_caps(void)
 	setup_clear_cpu_cap(X86_FEATURE_SGX2);
 }
 
+static int __init nosgx(char *str)
+{
+	clear_sgx_caps();
+
+	return 0;
+}
+
+early_param("nosgx", nosgx);
+
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 {
 	bool tboot = tboot_enabled();
-- 
2.25.1

