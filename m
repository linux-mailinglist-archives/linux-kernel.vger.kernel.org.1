Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB06F243D56
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 18:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHMQ1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 12:27:16 -0400
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:32778 "EHLO
        6.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgHMQ1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:27:14 -0400
Received: from player716.ha.ovh.net (unknown [10.110.171.50])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id 9B2CC173E81
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 18:27:12 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player716.ha.ovh.net (Postfix) with ESMTPSA id 41802152A09F7;
        Thu, 13 Aug 2020 16:27:07 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-105G006859e978a-6936-4e1d-aa48-8a114369f44c,
                    E10370F5499BCD549250CF93A1A6372B2A4BB833) smtp.auth=steve@sk2.org
From:   Stephen Kitt <steve@sk2.org>
To:     Steve Glendinning <steve.glendinning@shawell.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] drivers/hwmon/emc2103.c: use simple i2c probe
Date:   Thu, 13 Aug 2020 18:27:04 +0200
Message-Id: <20200813162704.1517951-1-steve@sk2.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7629097772879269159
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrleehgdejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepteegudfgleekieekteeggeetveefueefteeugfduieeitdfhhedtfeefkedvfeefnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejudeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver doesn't use the id information provided by the old i2c
probe function, so it can trivially be converted to the simple
("probe_new") form.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/hwmon/emc2103.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
index 924c02c1631d..e4c95ca9e19f 100644
--- a/drivers/hwmon/emc2103.c
+++ b/drivers/hwmon/emc2103.c
@@ -551,7 +551,7 @@ static const struct attribute_group emc2103_temp4_group = {
 };
 
 static int
-emc2103_probe(struct i2c_client *client, const struct i2c_device_id *id)
+emc2103_probe(struct i2c_client *client)
 {
 	struct emc2103_data *data;
 	struct device *hwmon_dev;
@@ -653,7 +653,7 @@ static struct i2c_driver emc2103_driver = {
 	.driver = {
 		.name	= "emc2103",
 	},
-	.probe		= emc2103_probe,
+	.probe_new	= emc2103_probe,
 	.id_table	= emc2103_ids,
 	.detect		= emc2103_detect,
 	.address_list	= normal_i2c,
-- 
2.25.4

