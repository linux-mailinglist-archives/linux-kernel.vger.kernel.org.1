Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA922AA1F2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 02:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgKGBLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 20:11:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727129AbgKGBLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 20:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604711495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=s03eFWh3bvVnssKugy+SfcexCfSnOxFiFxui5ZZE6JM=;
        b=XfHq78UhDTNUxRIsl5jxQpLA2qCc+EnXFCBG/6d68L60YKNck7n7RnwdkJIiBi3iWJ4VRd
        0iXRK7kOiSx2tO3S4NWh9Z09FGIvvgPdhhXwGih+xgf/sHD/Enb7jWGEPBAReFTliVOBl5
        R6zaJglokwQ8SgW+J4jSAfJ6j9zIiXY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-i3C91GNlPYGQWAgT_8IDJw-1; Fri, 06 Nov 2020 20:11:32 -0500
X-MC-Unique: i3C91GNlPYGQWAgT_8IDJw-1
Received: by mail-qt1-f199.google.com with SMTP id i14so2081643qtq.18
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 17:11:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s03eFWh3bvVnssKugy+SfcexCfSnOxFiFxui5ZZE6JM=;
        b=PkoCm4/XQZMM3yKFdlnfTzU+wFUh02r0vOOfZCxdZB737xNBNR7lldSmUwxum44WCh
         zphB+aKsdxR4VsRFUUJktzJlOThj7PJH/dZfs7FhoqEadxbfS5zx2Km2XodO7jGemVXa
         QC6z0QIQFKcC3kJEwv+cFUbHrZwWw/L/yp7qWDf2SJaAUQn4XyDfI96auy/y+gpolpEg
         zZIU/ENUM2G0tzKnzSL2N/hLDRgsKDOVhoT+cEGdOiM+sgL9XxonOJfwrnk40rvCbf+Z
         oedx8y0Ms0q9r5onk7d8XUsb/Fmog+Yt0JkWRl143FdMfCUiyhK2z6c0vjYfwB91gJAE
         ttSA==
X-Gm-Message-State: AOAM532IqWZ86e4cAkMkFls3dtr4qQIR2JHTvuyp0cpqFJuTurtKUH/K
        w6sHCHEyylQGNocUPx0KBOoulHRpkdXoM6HDanQAL+ivHJjFoCE2FdabUVM8WzEyqOOtflIK6OZ
        iLuxhgfGYI3kL8LnoJvVfN3vQ
X-Received: by 2002:ac8:51cd:: with SMTP id d13mr270203qtn.148.1604711491826;
        Fri, 06 Nov 2020 17:11:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxp4oEucNKi98qPC7sJzn96P9bBblqisJwW0aucCPpUta95o5nBu9m7hEOogL969VFDL1oc3Q==
X-Received: by 2002:ac8:51cd:: with SMTP id d13mr270180qtn.148.1604711491516;
        Fri, 06 Nov 2020 17:11:31 -0800 (PST)
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id q6sm1758584qtq.53.2020.11.06.17.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 17:11:30 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, dustymabe@redhat.com
Subject: [PATCH v2] x86/xen: don't unbind uninitialized lock_kicker_irq
Date:   Fri,  6 Nov 2020 20:11:19 -0500
Message-Id: <20201107011119.631442-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting a hyperthreaded system with the kernel parameter
'mitigations=auto,nosmt', the following warning occurs:

    WARNING: CPU: 0 PID: 1 at drivers/xen/events/events_base.c:1112 unbind_from_irqhandler+0x4e/0x60
    ...
    Hardware name: Xen HVM domU, BIOS 4.2.amazon 08/24/2006
    ...
    Call Trace:
     xen_uninit_lock_cpu+0x28/0x62
     xen_hvm_cpu_die+0x21/0x30
     takedown_cpu+0x9c/0xe0
     ? trace_suspend_resume+0x60/0x60
     cpuhp_invoke_callback+0x9a/0x530
     _cpu_up+0x11a/0x130
     cpu_up+0x7e/0xc0
     bringup_nonboot_cpus+0x48/0x50
     smp_init+0x26/0x79
     kernel_init_freeable+0xea/0x229
     ? rest_init+0xaa/0xaa
     kernel_init+0xa/0x106
     ret_from_fork+0x35/0x40

The secondary CPUs are not activated with the nosmt mitigations and only
the primary thread on each CPU core is used. In this situation,
xen_hvm_smp_prepare_cpus(), and more importantly xen_init_lock_cpu(), is
not called, so the lock_kicker_irq is not initialized for the secondary
CPUs. Let's fix this by exiting early in xen_uninit_lock_cpu() if the
irq is not set to avoid the warning from above for each secondary CPU.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Changes since v1:
- Remove duplicate per_cpu() call and pass in irq variable.
- Changed subject from 'x86/xen: fix warning when running with nosmt
  mitigations'
- Shorten code comment

 arch/x86/xen/spinlock.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 799f4eba0a62..043c73dfd2c9 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -93,10 +93,20 @@ void xen_init_lock_cpu(int cpu)
 
 void xen_uninit_lock_cpu(int cpu)
 {
+	int irq;
+
 	if (!xen_pvspin)
 		return;
 
-	unbind_from_irqhandler(per_cpu(lock_kicker_irq, cpu), NULL);
+	/*
+	 * When booting the kernel with 'mitigations=auto,nosmt', the secondary
+	 * CPUs are not activated, and lock_kicker_irq is not initialized.
+	 */
+	irq = per_cpu(lock_kicker_irq, cpu);
+	if (irq == -1)
+		return;
+
+	unbind_from_irqhandler(irq, NULL);
 	per_cpu(lock_kicker_irq, cpu) = -1;
 	kfree(per_cpu(irq_name, cpu));
 	per_cpu(irq_name, cpu) = NULL;
-- 
2.26.2

