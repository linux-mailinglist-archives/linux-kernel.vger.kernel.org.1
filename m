Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF4F24D961
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 18:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHUQGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 12:06:47 -0400
Received: from 12.mo7.mail-out.ovh.net ([178.33.107.167]:50860 "EHLO
        12.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgHUQGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:06:46 -0400
Received: from player799.ha.ovh.net (unknown [10.108.35.158])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id 7C0F4176719
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 18:00:44 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player799.ha.ovh.net (Postfix) with ESMTPSA id ABD0E156BDE9D;
        Fri, 21 Aug 2020 16:00:38 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-103G0059f190c4a-db29-4b17-b616-76cf4b1db7b5,
                    20EB7F6BE0168D07063FB82D5C23839419BBC220) smtp.auth=steve@sk2.org
From:   Stephen Kitt <steve@sk2.org>
To:     Juerg Haefliger <juergh@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] hwmon: (dme1737) use simple i2c probe
Date:   Fri, 21 Aug 2020 18:00:35 +0200
Message-Id: <20200821160035.590142-1-steve@sk2.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17270178671746174236
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudduvddgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the ongoing i2c transition to the simple probe
("probe_new"), this patch uses i2c_match_id to retrieve the
driver_data for the probed device. The id parameter is thus no longer
necessary and the simple probe can be used instead.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/hwmon/dme1737.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index c3472b73fa79..c1e4cfb40c3d 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -2461,8 +2461,9 @@ static int dme1737_i2c_detect(struct i2c_client *client,
 	return 0;
 }
 
-static int dme1737_i2c_probe(struct i2c_client *client,
-			     const struct i2c_device_id *id)
+static const struct i2c_device_id dme1737_id[];
+
+static int dme1737_i2c_probe(struct i2c_client *client)
 {
 	struct dme1737_data *data;
 	struct device *dev = &client->dev;
@@ -2473,7 +2474,7 @@ static int dme1737_i2c_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
-	data->type = id->driver_data;
+	data->type = i2c_match_id(dme1737_id, client)->driver_data;
 	data->client = client;
 	data->name = client->name;
 	mutex_init(&data->update_lock);
@@ -2529,7 +2530,7 @@ static struct i2c_driver dme1737_i2c_driver = {
 	.driver = {
 		.name = "dme1737",
 	},
-	.probe = dme1737_i2c_probe,
+	.probe_new = dme1737_i2c_probe,
 	.remove = dme1737_i2c_remove,
 	.id_table = dme1737_id,
 	.detect = dme1737_i2c_detect,
-- 
2.25.4

