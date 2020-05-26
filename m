Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDBD1D1E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 20:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390452AbgEMS4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 14:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390414AbgEMS4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:56:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F19C061A0E;
        Wed, 13 May 2020 11:56:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A2E9B2A2A5E
Received: by jupiter.universe (Postfix, from userid 1000)
        id 9633A480129; Wed, 13 May 2020 20:56:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 17/19] power: supply: sbs-battery: switch to i2c's probe_new
Date:   Wed, 13 May 2020 20:56:13 +0200
Message-Id: <20200513185615.508236-18-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sbs-battery does not use the ID parameter, so switch to i2c's
probe_new API.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/sbs-battery.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 73dfe526c867..f0392be350eb 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -992,8 +992,7 @@ static const struct power_supply_desc sbs_default_desc = {
 	.external_power_changed = sbs_external_power_changed,
 };
 
-static int sbs_probe(struct i2c_client *client,
-	const struct i2c_device_id *id)
+static int sbs_probe(struct i2c_client *client)
 {
 	struct sbs_info *chip;
 	struct power_supply_desc *sbs_desc;
@@ -1172,7 +1171,7 @@ static const struct of_device_id sbs_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, sbs_dt_ids);
 
 static struct i2c_driver sbs_battery_driver = {
-	.probe		= sbs_probe,
+	.probe_new	= sbs_probe,
 	.remove		= sbs_remove,
 	.alert		= sbs_alert,
 	.id_table	= sbs_id,
-- 
2.26.2

