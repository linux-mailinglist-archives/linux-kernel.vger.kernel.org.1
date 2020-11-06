Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20D22A8B71
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 01:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732802AbgKFAfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 19:35:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732741AbgKFAfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 19:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604622945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8cFssZ0LJiNsdeVizgTqZXbeUskMHHnTsA2koKzQk4Y=;
        b=H+iO+8Sb1EUDYcIuzn8EEAwSLMYh17AXeW/9ymwHcpi4W50TkuPxTltL/3klZ0abMas/7t
        vbV8w3GTRV8VVXltTI6UsTm+AIwYYzUXpOPK1kMV66AMY6wDINkQhICUSeukgNNXSUdbJW
        J8ofPRifSpJhZDU1YDzBB6YuSfpbG0g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-O1-Up9G7MaSRS2rAoUTKyg-1; Thu, 05 Nov 2020 19:35:44 -0500
X-MC-Unique: O1-Up9G7MaSRS2rAoUTKyg-1
Received: by mail-qv1-f69.google.com with SMTP id a1so2081164qvj.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 16:35:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8cFssZ0LJiNsdeVizgTqZXbeUskMHHnTsA2koKzQk4Y=;
        b=B46+1ow4d4BBGEZlSHnkwR726hQaUUNjA/pgDnr8wuCRElZfOPxHBkrvur1xsJxKeH
         VYzyRJmOadOerEVrOBDGZczyKkaargXD1Dvlbi6dz88fmsRrFGQqKr7u6STvC22VZ5Rd
         YgDSyGrlaceXezCgvXL/kZDp5SrSR3pl6QZyyUxbpzQIh6sBHQyYrDu3AJmu822ab6bQ
         P+5Q9QrUa2El7P0ckeXGjV15bgQQqWbgoWrV/0G/mjSiR0baGAdlqjioBXqtSM49NXij
         yKYzIk11R7n/6h2Qvo1JLil1DpoBjozLZ2wajKcz2VxDlAoRW0ZbWGcVdOdbEwaUQZlU
         6E6g==
X-Gm-Message-State: AOAM531RMtFGDcCw7P3SaXcKAUrxJkiz9bwO8RkB2EcXqsgWUPeHI2q1
        JeNZT6ytKO/74F0EH3GMoe3wXd30wRgxAPCYpxXTsO9+L9o8KT5JcT2MmKaJLNJkcAUq201MMiJ
        8gQ8qnkjZGs/Mo/+fdhHjHD0O
X-Received: by 2002:a37:617:: with SMTP id 23mr4692636qkg.256.1604622943548;
        Thu, 05 Nov 2020 16:35:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcXHlYQXweZgP7+K8o61FNzv2e/Th67Tuvn2dyHTEh2Lw53WCzH/qHH2/nUUSBWuJ16IKdJg==
X-Received: by 2002:a37:617:: with SMTP id 23mr4692615qkg.256.1604622943297;
        Thu, 05 Nov 2020 16:35:43 -0800 (PST)
Received: from tp-x1.redhat.com (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id b3sm2002837qte.85.2020.11.05.16.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:35:42 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, dustymabe@redhat.com
Subject: [PATCH] x86/xen: fix warning when running with nosmt mitigations
Date:   Thu,  5 Nov 2020 19:35:29 -0500
Message-Id: <20201106003529.391649-1-bmasney@redhat.com>
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
 arch/x86/xen/spinlock.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 799f4eba0a62..4a052459a08e 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -93,9 +93,24 @@ void xen_init_lock_cpu(int cpu)
 
 void xen_uninit_lock_cpu(int cpu)
 {
+	int irq;
+
 	if (!xen_pvspin)
 		return;
 
+	/*
+	 * When booting the kernel with 'mitigations=auto,nosmt', the secondary
+	 * CPUs are not activated and only the primary thread on each CPU core
+	 * is used. In this situation, xen_hvm_smp_prepare_cpus(), and more
+	 * importantly xen_init_lock_cpu(), is not called, so the
+	 * lock_kicker_irq is not initialized for the secondary CPUs. Let's
+	 * exit early if the irq is not set to avoid a warning in the console
+	 * log.
+	 */
+	irq = per_cpu(lock_kicker_irq, cpu);
+	if (irq == -1)
+		return;
+
 	unbind_from_irqhandler(per_cpu(lock_kicker_irq, cpu), NULL);
 	per_cpu(lock_kicker_irq, cpu) = -1;
 	kfree(per_cpu(irq_name, cpu));
-- 
2.26.2

