Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8482FCE4A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732894AbhATKUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730313AbhATKLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:11:36 -0500
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D496C061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 02:10:55 -0800 (PST)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1l2ARx-00EMbs-J2
        for linux-kernel@vger.kernel.org; Wed, 20 Jan 2021 11:10:53 +0100
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1l2ARe-00EMZ0-1s; Wed, 20 Jan 2021 11:10:34 +0100
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1l2ARd-000zqh-6w; Wed, 20 Jan 2021 11:10:33 +0100
From:   Bert Vermeulen <bert@biot.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Bert Vermeulen <bert@biot.com>
Subject: [PATCH v3 0/2] Realtek RTL838x/RTL839x interrupt controller driver
Date:   Wed, 20 Jan 2021 11:10:16 +0100
Message-Id: <20210120101018.237693-1-bert@biot.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

