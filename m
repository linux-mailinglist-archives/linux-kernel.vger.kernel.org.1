Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4B52D76AB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 14:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgLKNgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 08:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgLKNf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:35:59 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E197C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 05:35:18 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id 31bD2400Z4C55Sk011bDtf; Fri, 11 Dec 2020 14:35:14 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kniZl-009hkM-Kk; Fri, 11 Dec 2020 14:35:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kniZl-00CSdD-61; Fri, 11 Dec 2020 14:35:13 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] hwmon: (iio_hwmon) Drop bogus __refdata annotation
Date:   Fri, 11 Dec 2020 14:35:12 +0100
Message-Id: <20201211133512.2969952-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the IIO hardware monitoring driver does not have any code or data
located in initmem, there is no need to annotate the iio_hwmon_driver
structure with __refdata.  Drop the annotation, to avoid suppressing
future section warnings.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/hwmon/iio_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index b85a125dd86f46a2..580a7d125b88667b 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -169,7 +169,7 @@ static const struct of_device_id iio_hwmon_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, iio_hwmon_of_match);
 
-static struct platform_driver __refdata iio_hwmon_driver = {
+static struct platform_driver iio_hwmon_driver = {
 	.driver = {
 		.name = "iio_hwmon",
 		.of_match_table = iio_hwmon_of_match,
-- 
2.25.1

