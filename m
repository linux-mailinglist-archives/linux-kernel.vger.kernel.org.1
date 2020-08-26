Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A961253785
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 20:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgHZStK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 14:49:10 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:43751 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgHZSs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:48:58 -0400
Received: by mail-il1-f193.google.com with SMTP id e11so2677872ils.10;
        Wed, 26 Aug 2020 11:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xlJZhntJx9sYhVEnGyncNAeUJZzJkWsXffEWR9WDmyk=;
        b=G5u2s6EcTHA3RP1bBGtLQ+3wOFCRBMIYWl7z/Qs82LMCZcT3GtCkyzFaPyqInQzY6o
         y0ejS8nRsPZ5Ud02ZBtcXbNNWnLM5rgA0CpSi6gqvpTApsWnfAlykt6TwTu9HLL6e1ct
         f3VO5bAKUC/nAlR/rJXRj1/SSJT9F4T6HdwLFJKvVOUxUKP3cm9W5pijxN+fdJfQfcK8
         hP8jM0CmKAKECXZNME3ihGznHtKSG2SJBBxdqQxHFPorRsAruLaIauWaPuha76OFdL6j
         AFDVazxzZM6YDut0PiOwM4/HE5UsgEWb5isJNwB8GDTXx3SWvR95Gcda1M/qLiAdpasg
         p+Yg==
X-Gm-Message-State: AOAM532lENznlUuRbEGfpFFlFlSqh8XnOyzCJwBhBKRnSMzNoVIrn9ak
        Z5g9TkUN893ziG78eTPGpfq8cibs0hvV
X-Google-Smtp-Source: ABdhPJyTsipJUvMDB9SXrXoSpMRRUAS0c3IXuXNE6XI7rJPQ/mAKHW1RswyLCGuSV8DiQFjaYzZsTA==
X-Received: by 2002:a92:505:: with SMTP id q5mr13115471ile.15.1598467737533;
        Wed, 26 Aug 2020 11:48:57 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id c2sm1609226iow.6.2020.08.26.11.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 11:48:57 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 3/3] dt-bindings: interrupt-controller: Remove obsolete 'img,meta-intc'
Date:   Wed, 26 Aug 2020 12:48:51 -0600
Message-Id: <20200826184851.3431531-3-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826184851.3431531-1-robh@kernel.org>
References: <20200826184851.3431531-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver and metag arch were removed in 2018.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../interrupt-controller/img,meta-intc.txt    | 82 -------------------
 1 file changed, 82 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/img,meta-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/img,meta-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/img,meta-intc.txt
deleted file mode 100644
index 42431f44697f..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/img,meta-intc.txt
+++ /dev/null
@@ -1,82 +0,0 @@
-* Meta External Trigger Controller Binding
-
-This binding specifies what properties must be available in the device tree
-representation of a Meta external trigger controller.
-
-Required properties:
-
-    - compatible: Specifies the compatibility list for the interrupt controller.
-      The type shall be <string> and the value shall include "img,meta-intc".
-
-    - num-banks: Specifies the number of interrupt banks (each of which can
-      handle 32 interrupt sources).
-
-    - interrupt-controller: The presence of this property identifies the node
-      as an interrupt controller. No property value shall be defined.
-
-    - #interrupt-cells: Specifies the number of cells needed to encode an
-      interrupt source. The type shall be a <u32> and the value shall be 2.
-
-    - #address-cells: Specifies the number of cells needed to encode an
-      address. The type shall be <u32> and the value shall be 0. As such,
-      'interrupt-map' nodes do not have to specify a parent unit address.
-
-Optional properties:
-
-    - no-mask: The controller doesn't have any mask registers.
-
-* Interrupt Specifier Definition
-
-  Interrupt specifiers consists of 2 cells encoded as follows:
-
-    - <1st-cell>: The interrupt-number that identifies the interrupt source.
-
-    - <2nd-cell>: The Linux interrupt flags containing level-sense information,
-                  encoded as follows:
-                    1 = edge triggered
-                    4 = level-sensitive
-
-* Examples
-
-Example 1:
-
-	/*
-	 * Meta external trigger block
-	 */
-	intc: intc {
-		// This is an interrupt controller node.
-		interrupt-controller;
-
-		// No address cells so that 'interrupt-map' nodes which
-		// reference this interrupt controller node do not need a parent
-		// address specifier.
-		#address-cells = <0>;
-
-		// Two cells to encode interrupt sources.
-		#interrupt-cells = <2>;
-
-		// Number of interrupt banks
-		num-banks = <2>;
-
-		// No HWMASKEXT is available (specify on Chorus2 and Comet ES1)
-		no-mask;
-
-		// Compatible with Meta hardware trigger block.
-		compatible = "img,meta-intc";
-	};
-
-Example 2:
-
-	/*
-	 * An interrupt generating device that is wired to a Meta external
-	 * trigger block.
-	 */
-	uart1: uart@02004c00 {
-		// Interrupt source '5' that is level-sensitive.
-		// Note that there are only two cells as specified in the
-		// interrupt parent's '#interrupt-cells' property.
-		interrupts = <5 4 /* level */>;
-
-		// The interrupt controller that this device is wired to.
-		interrupt-parent = <&intc>;
-	};
-- 
2.25.1

