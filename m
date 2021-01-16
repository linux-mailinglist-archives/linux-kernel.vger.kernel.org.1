Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8705B2F89D1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 01:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbhAPAOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 19:14:01 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:32845 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbhAPAOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 19:14:00 -0500
Received: by mail-wm1-f51.google.com with SMTP id s24so1831110wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 16:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lEoZ2mLB4jyJp/YEcR/YYhpFBIPctICADecAlH2bFKA=;
        b=MTabrMyI1waxyL34g3m4eHb42dPz9m/pa79bKp6mYL8XbKqKqVrkaOK6jHlQoV80cM
         xQqsjsZz0r9CK69igrkrShFucp/2qthI6g+NS6pRK8T2n/E2u1ZTDyBe2B6/j0fLG0jI
         NZmjP+jRMalqg7N3Bsq30JBsU8IRSJqL3TPRRkd3HThznYoGGy6ioax6H3TY0vTA4I28
         GbT4eWnSyFNTYXWCL4P2ZpRoTDtl83fYDSPX75WvgwtInjXV6rn1p5zecW6Q6TK9y2nl
         EM5MkFMihbXqFfXnnY5x6B2RIXTFR2sw9FhrY4K5beHKltTvYj/stlLTCCx7CRo3KGLt
         Kf6Q==
X-Gm-Message-State: AOAM532oufxw9TVeaZH2q364czpVQBW6if3JD///HOGunuC31z2POtz1
        IagmSeeMJEo03Y9cj4ro1ORIGo+gIEM=
X-Google-Smtp-Source: ABdhPJxUtqDlbgE20zMFy6bhhgFyJACUH0iRegaifx7x5wgt0rjY+xRT/tHbNoNlUETjdcKB1e62zg==
X-Received: by 2002:a7b:ce91:: with SMTP id q17mr9452665wmj.128.1610755998702;
        Fri, 15 Jan 2021 16:13:18 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s1sm17164126wrv.97.2021.01.15.16.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 16:13:18 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux Kernel List <linux-kernel@vger.kernel.org>
Cc:     tyhicks@linux.microsoft.com, Wei Liu <wei.liu@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christian Gromm <christian.gromm@microchip.com>
Subject: [PATCH] fTPM: make sure TEE is initialized before fTPM
Date:   Sat, 16 Jan 2021 00:12:59 +0000
Message-Id: <20210116001301.16861-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For built-in drivers, the order of initialization function invocation is
determined by their link order.

The original code linked TPM drivers before TEE driver when they were
both built in. That caused fTPM's initialization to be deferred to a
worker thread instead of running on PID 1.

That is problematic because IMA's initialization routine, which runs on
PID 1 as a late initcall, needs to have access to the default TPM
instance. If fTPM's initialization is deferred, IMA will not be able to
get hold of a TPM instance in time.

Fix this by modifying Makefile to make sure TEE is initialized before
fTPM when they are both built in.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/Makefile b/drivers/Makefile
index fd11b9ac4cc3..45ea5ec9d0fd 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -180,6 +180,11 @@ obj-$(CONFIG_NVMEM)		+= nvmem/
 obj-$(CONFIG_FPGA)		+= fpga/
 obj-$(CONFIG_FSI)		+= fsi/
 obj-$(CONFIG_TEE)		+= tee/
+
+# TPM drivers must come after TEE, otherwise fTPM initialization will be
+# deferred, which causes IMA to not get a TPM device in time
+obj-$(CONFIG_TCG_TPM)		+= char/tpm/
+
 obj-$(CONFIG_MULTIPLEXER)	+= mux/
 obj-$(CONFIG_UNISYS_VISORBUS)	+= visorbus/
 obj-$(CONFIG_SIOX)		+= siox/
-- 
2.20.1

