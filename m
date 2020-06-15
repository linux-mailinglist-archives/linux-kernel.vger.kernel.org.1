Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E63D1F9286
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 11:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgFOJDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 05:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729286AbgFOJCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:02:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DEAC061A0E;
        Mon, 15 Jun 2020 02:02:42 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b82so5288113wmb.1;
        Mon, 15 Jun 2020 02:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ld57nJnZAP689cxMru8QNpuCGfHmRHQ2rq3i8nGEfuQ=;
        b=E4aEUiPCNp+XDU5iaBC6jRQltGKGR7evgt2RgQKR2QAsCUh+4OS56aWYuDmMYg9OV/
         jOsgDFKCNQOh/iDgpKE/FNP+orbWp2EoUg+keNx1OPoedbFPRcLLCLh/sPoWQC1iEHcP
         8y2iX7WG2mzGuPRBn8r2ZKxjC9PbiQiQgB+m7sGjcKTfnrRle5RAjqrbwR3LBSSBurq+
         xFrzvYZX9JWxcZpof5u/Pa6631bzp6XeJfMEeY94o7D/ONy/Q1D++fqvfPsQvOl6LwoK
         wWcHjYlrfDob7rSQBXzsY8XzisWlKmWnzJoIy30k4oHEEFNKgIGH+WUdwCpNSng3PQu2
         KdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ld57nJnZAP689cxMru8QNpuCGfHmRHQ2rq3i8nGEfuQ=;
        b=Vl8+BVZkvr6qn9BkJZbeg7QtP7mnm7czZDy30/6KOSmzmaGYg600FFvI6N4LRZYqKY
         akbbFmkRK2IVonzlTbLfXU/iKr/76Yw0UDUbQI1f+aecfgj43JVXouma77ebeOSrO982
         kMw5efY9hyGhuNckIZApNSUNQomVnWhsEtcuuadDoUDERm1zfEa5h0r2nS2RIb5Adnu0
         nSEOICJfVQlnd+PoKIeLlQJ24XhEvOP9CaLYSyFVeprQcLrVx/b0OnUxi4BNgMtnSCBu
         xUpf1rUFXf1rFF41yXjiSbYfCAD9davPyceTKLbjvoRNdTjuP7PONRm55arKTUdTcyhp
         3eFg==
X-Gm-Message-State: AOAM533c8tFJ7unQPCXMwhg2IIjPL4MLAWfzSF4xfJaQj4vkGd8nFy11
        w/X4cSzs4+AK1umAYXnqdlg=
X-Google-Smtp-Source: ABdhPJytr5S09yPh9QES843sEaKRMapl23pdGMM5fYzqE8LsqKW3v7pIqGJ6d/IkGL562wILewGwDQ==
X-Received: by 2002:a1c:4143:: with SMTP id o64mr11668285wma.157.1592211760672;
        Mon, 15 Jun 2020 02:02:40 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id o15sm24089516wrv.48.2020.06.15.02.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 02:02:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        julia.lawall@lip6.fr, jonas.gorski@gmail.com, lkp@intel.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 5/8] mips: bmips: add BCM6362 clock definitions
Date:   Mon, 15 Jun 2020 11:02:28 +0200
Message-Id: <20200615090231.2932696-6-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615090231.2932696-1-noltari@gmail.com>
References: <20200615090231.2932696-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add header with BCM6362 definitions in order to be able to include it from
device tree files.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 include/dt-bindings/clock/bcm6362-clock.h | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 include/dt-bindings/clock/bcm6362-clock.h

diff --git a/include/dt-bindings/clock/bcm6362-clock.h b/include/dt-bindings/clock/bcm6362-clock.h
new file mode 100644
index 000000000000..17655cd5bf25
--- /dev/null
+++ b/include/dt-bindings/clock/bcm6362-clock.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __DT_BINDINGS_CLOCK_BCM6362_H
+#define __DT_BINDINGS_CLOCK_BCM6362_H
+
+#define BCM6362_CLK_ADSL_QPROC	1
+#define BCM6362_CLK_ADSL_AFE	2
+#define BCM6362_CLK_ADSL	3
+#define BCM6362_CLK_MIPS	4
+#define BCM6362_CLK_WLAN_OCP	5
+#define BCM6362_CLK_SWPKT_USB	7
+#define BCM6362_CLK_SWPKT_SAR	8
+#define BCM6362_CLK_SAR		9
+#define BCM6362_CLK_ROBOSW	10
+#define BCM6362_CLK_PCM		11
+#define BCM6362_CLK_USBD	12
+#define BCM6362_CLK_USBH	13
+#define BCM6362_CLK_IPSEC	14
+#define BCM6362_CLK_SPI		15
+#define BCM6362_CLK_HSSPI	16
+#define BCM6362_CLK_PCIE	17
+#define BCM6362_CLK_FAP		18
+#define BCM6362_CLK_PHYMIPS	19
+#define BCM6362_CLK_NAND	20
+
+#endif /* __DT_BINDINGS_CLOCK_BCM6362_H */
-- 
2.27.0

