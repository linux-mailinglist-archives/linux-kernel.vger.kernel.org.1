Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488212B2313
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgKMR4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:56:11 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:33118 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKMR4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605290170; x=1636826170;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=hi/EXWbkj8b1GwYopAr3TMpnILzgZhmOpGToZR+VA+w=;
  b=I7Ba5mF3TsrTcRZwEBQrWgqM3uuRb2JaCNh4SwvZH7mMxZK5L1qTsjQK
   B+Cf5iwfsssPCKKOZetsBGSOfzu2LLTgk4i4fYnxBaniwXKL4DFcrZZVQ
   ZsGtbPd+/UPzaasoSHRYzZt4Nmq+0vSmB9Cs9HeK265FfMRZqO5YpQzwQ
   2y0NGuzWe1qLuZLCIBLscf9dmSxHtXVNh4NkRB15kcxHLi0wKvQctC5Bt
   o1GWXufKvUdBEYh+M/SbKJYCvd4WfZUn9e+00EkNmneIjk9sEH1st6RpB
   W53ZHYY3JBMc+Zt4xC1wsyjSY8PAFgG2UQqrAsE3mrsNXUL/gammXz7k0
   g==;
IronPort-SDR: ITcZRXMHZRkgZlHPlLtPBUCmGzpAtfF+P/cOQZJWanCy1T92v0PmJrFgjpak3IeeNzqlqDEPgJ
 Vt4mCyR/v4qa6wPT5uN85RRbiE2bBLnh/MwgMGYyKPVTCbAxAgPmbRfGoORfAXBay1MhnYme57
 9AAJBj9aTi4vPwN6rFs5dTGJSqjjTl8a0xKADoc2YvKVSJLXLQLxSncAoBYZgnRoyyPts8LmhK
 U7gauSwqZss8SdR0tf1YP/taK5zHYUdEVNfL9j9z49BZxvqYC1pyfkzaOPGrSV93wdH2xJmSvP
 1t8=
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="93573092"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Nov 2020 10:56:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 13 Nov 2020 10:56:10 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 13 Nov 2020 10:56:07 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 1/1] regulator: core: do not continue if selector match
Date:   Fri, 13 Nov 2020 19:56:04 +0200
Message-ID: <1605290164-11556-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not continue if selector has already been located.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Changes in v4:
- this was part of patch series with title
  "regulator: mcp16502: add support for ramp delay" -> keep only this patch
  in series as the rest were applied
- rebased on top of current regulator/for-next

 drivers/regulator/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f0da0053579c..216b0cbce199 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4035,6 +4035,9 @@ int regulator_set_voltage_time(struct regulator *regulator,
 		if (i < rdev->desc->linear_min_sel)
 			continue;
 
+		if (old_sel >= 0 && new_sel >= 0)
+			break;
+
 		voltage = regulator_list_voltage(regulator, i);
 		if (voltage < 0)
 			return -EINVAL;
-- 
2.7.4

