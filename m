Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4902F29A6FA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895075AbgJ0IwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:52:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895068AbgJ0IwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:52:06 -0400
Received: from localhost.localdomain (88-113-213-94.elisa-laajakaista.fi [88.113.213.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 079F2207DE;
        Tue, 27 Oct 2020 08:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603788724;
        bh=+7hbUMdXTagXxhAYZO04ZOi+TbmgFxXUMEnEjxjCpNU=;
        h=From:To:Cc:Subject:Date:From;
        b=DvFupht9p6CZIJwdADlNSsWi4UVxVfX+jzK7xLZ6xEVEEpOaFAr9pxOC11YGT1YKy
         48TbWynJURCsl8bYjZoY7zXiLzyfQxvtZOuzDYKYE0goxImkGTobFO66RXF7IGabXz
         S9ZgoNWTtwbGX3WFpAke7bR313uyU3AXbvBRGbQM=
From:   balbi@kernel.org
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 0/2] Trivial warning fixes
Date:   Tue, 27 Oct 2020 10:51:55 +0200
Message-Id: <20201027085157.1964906-1-balbi@kernel.org>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felipe Balbi <balbi@kernel.org>

Hi,

here's a couple build warning fixes that I just caught with
allmodconfig on AArch64.

cheers

Felipe Balbi (2):
  hwtracing: coresight: add missing MODULE_LICENSE()
  irqchip: bcm2836: fix section mismatch warning

 drivers/hwtracing/coresight/coresight-core.c | 1 +
 drivers/irqchip/irq-bcm2836.c                | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.29.1

