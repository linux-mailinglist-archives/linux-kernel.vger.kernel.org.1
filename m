Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC3B215A25
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 17:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgGFPA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 11:00:28 -0400
Received: from foss.arm.com ([217.140.110.172]:47480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbgGFPA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:00:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F14730E;
        Mon,  6 Jul 2020 08:00:27 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED16B3F71E;
        Mon,  6 Jul 2020 08:00:25 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     vincenzo.frascino@arm.com, Jassi Brar <jassisinghbrar@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH] drivers: soc: Fix mailbox suspend/resume no irq for IMX SCU
Date:   Mon,  6 Jul 2020 16:00:13 +0100
Message-Id: <20200706150013.35326-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

imx_mu_suspend_noirq()/imx_mu_resume_noirq() are currently used only
when CONFIG_PM_SLEEP configuration options is enabled. Having it
disabled triggers the following warning at compile time:

drivers/mailbox/imx-mailbox.c:611:12: warning: ‘imx_mu_resume_noirq’
defined but not used [-Wunused-function]
  static int imx_mu_resume_noirq(struct device *dev)

drivers/mailbox/imx-mailbox.c:601:12: warning: ‘imx_mu_suspend_noirq’
defined but not used [-Wunused-function]
  static int imx_mu_suspend_noirq(struct device *dev)

Make imx_mu_suspend_noirq()/imx_mu_resume_noirq() __maybe_unused to
address the issue.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 drivers/mailbox/imx-mailbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 7205b825c8b5..f54f36948414 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -598,7 +598,7 @@ static const struct of_device_id imx_mu_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, imx_mu_dt_ids);
 
-static int imx_mu_suspend_noirq(struct device *dev)
+static int __maybe_unused imx_mu_suspend_noirq(struct device *dev)
 {
 	struct imx_mu_priv *priv = dev_get_drvdata(dev);
 
@@ -608,7 +608,7 @@ static int imx_mu_suspend_noirq(struct device *dev)
 	return 0;
 }
 
-static int imx_mu_resume_noirq(struct device *dev)
+static int __maybe_unused imx_mu_resume_noirq(struct device *dev)
 {
 	struct imx_mu_priv *priv = dev_get_drvdata(dev);
 
-- 
2.27.0

