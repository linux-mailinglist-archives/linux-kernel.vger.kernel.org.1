Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2393302BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 20:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbhAYTsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731893AbhAYT2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:28:32 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FF2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1t/GdNTi2oOTw8D8/h34ezIij3NRN5j7ufZ5EEKo418=; b=hkr0J/fGVEB/dyOiwRHxMp3vdA
        1btyMmB2G8h9CTaU7eoDL9FNz6Mr53fJOK9CL1hyvTRPNYwKe79UxoM4oIyDmua6x+LE5heuj349T
        TUd9fP4idCMAmmCdqfA06x81JLYCdAWd3gNNTi1fCLs01It9h1n8xtTTuRI5omIKs+uc=;
Received: from p200300ccff0a26001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0a:2600:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1l47WV-0007WI-0u; Mon, 25 Jan 2021 20:27:39 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1l47WU-0004ba-P1; Mon, 25 Jan 2021 20:27:38 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] regulator: core: avoid error messages for deferred probing
Date:   Mon, 25 Jan 2021 20:27:36 +0100
Message-Id: <20210125192736.17657-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noise like this happens on boot with regulators which can be bypassed
when the supply is not probed. That looks too alarming and confusing.

[    3.844092] vddpu: bypassed regulator has no supply!
[    3.849105] vddpu: failed to get the current voltage: -EPROBE_DEFER
[    3.855591] vddpu: supplied by DCDC1
[    3.877211] vddsoc: bypassed regulator has no supply!
[    3.882538] vddsoc: failed to get the current voltage: -EPROBE_DEFER
[    3.888975] vddsoc: supplied by DCDC1

Handle such issues silently.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/regulator/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ca03d8e70bd1..238745fc97c2 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1168,6 +1168,9 @@ static int machine_constraints_voltage(struct regulator_dev *rdev,
 			current_uV = regulator_get_voltage_rdev(rdev);
 		}
 
+		if (current_uV == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
 		if (current_uV < 0) {
 			rdev_err(rdev,
 				 "failed to get the current voltage: %pe\n",
@@ -4151,9 +4154,12 @@ int regulator_get_voltage_rdev(struct regulator_dev *rdev)
 		if (bypassed) {
 			/* if bypassed the regulator must have a supply */
 			if (!rdev->supply) {
+				if (rdev->supply_name)
+					return -EPROBE_DEFER;
+
 				rdev_err(rdev,
 					 "bypassed regulator has no supply!\n");
-				return -EPROBE_DEFER;
+				return -EINVAL;
 			}
 
 			return regulator_get_voltage_rdev(rdev->supply->rdev);
-- 
2.29.2

