Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C925E300E02
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 21:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbhAVUqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 15:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730925AbhAVUnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:43:33 -0500
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DCAC061788
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:42:52 -0800 (PST)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1l33Gb-00Eha1-SJ
        for linux-kernel@vger.kernel.org; Fri, 22 Jan 2021 21:42:49 +0100
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1l33GJ-00EhXi-Mj; Fri, 22 Jan 2021 21:42:31 +0100
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1l33GI-0028ST-OW; Fri, 22 Jan 2021 21:42:30 +0100
From:   Bert Vermeulen <bert@biot.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 0/2] Realtek RTL838x/RTL839x interrupt controller driver
Date:   Fri, 22 Jan 2021 21:42:22 +0100
Message-Id: <20210122204224.509124-1-bert@biot.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:
- Disable cascaded interrupts before mapping, not after.
- Set chained handlers as interrupt mappings are read, instead of beforehand.
- Removed timer interrupt clear.

v3:
- Fixed syntax and maxItems problems in DT bindings.

v2:
- Addressed all comments by Marc Zyngier.
- Moved interrupt routing symbols to device tree interrupt-map. Parsing
  is done similar to the renesas,rza1-irqc driver.


Bert Vermeulen (2):
  dt-bindings: interrupt-controller: Add Realtek RTL838x/RTL839x support
  irqchip: Add support for Realtek RTL838x/RTL839x interrupt controller

 .../realtek,rtl-intc.yaml                     |  57 ++++++
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-realtek-rtl.c             | 180 ++++++++++++++++++
 3 files changed, 238 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
 create mode 100644 drivers/irqchip/irq-realtek-rtl.c

-- 
2.25.1

