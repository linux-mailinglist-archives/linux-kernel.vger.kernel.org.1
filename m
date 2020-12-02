Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800622CBB99
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 12:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbgLBLdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 06:33:44 -0500
Received: from mail-eopbgr00050.outbound.protection.outlook.com ([40.107.0.50]:34735
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725885AbgLBLdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 06:33:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4ciM4Ec/momjXCnh+wo1Xywu9S7XJNfD9XppxWYBpPghWc3wl7f4B3L3S288rekPm1xk+ozNuj3XKzM80Xf4nZdDXby3K8x8yo3Qod+/1+/Vxqr7oF7SxCe6C0wVkxVV7AUNjk+VslcyJE4J9mG28GBXyAiYBC8BDiw6ZvjV0TABNFzDeB/b2w9tbViDQC/2Evo274fa+/200YE22XQz/LjnxHav35JnGl+Cp4egjImCrSGhml0A7blF1YwaPfIjld2IYJ3kAlglUElVYx7Y9+VQzp8g4NPfymEAKkwluYNOZ/u2MA508y6ckPY8lTRzE+zAR96J0PdEgCfY582GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf2aVoIivX6mOp2oFy9JdEFuxg3BjYflEbE1hOh9BzM=;
 b=EJ/WLArTDMBXGsPIIXYODPUNOm9ftMSntwWdLiQsGkvfI5ik/2WGr3cSIcvfg2tqBgnNHI+CVd+n/BXvo0PYSAGMrIFBf4gJHzE/9V2s4ao0l0jV0HzVv3p/cfMs91MWdl5+1gKUxd3oUc9DFiwhVIygVi+tZjbdC4VflrkHTwLwo6k8walRr5kNZ3uK7UYIKY+N70mu4EtEyVmpogCp/2Z3ZbLHi5d3TSJCz31pAo0JvpEufnBAoxKcHuy+DmBGq1S1J+Pu73IdzUjm8nQtyY8R+dJ/437eQgIxBbTQ+tvn6ZRdP03vx8+VDAmUlI7Qg8ZY2xzLIR2BH5cGpd+8eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf2aVoIivX6mOp2oFy9JdEFuxg3BjYflEbE1hOh9BzM=;
 b=JNl1vfSakRz6N6fcSB4pQfcPhnA/tz5BTW8m7tW+US1VHmdMaT7eQbSbiR+AGRk7Q1o1DruSZXN9QeZq9Tle9qxg9qfaBsPiCfiThPBoYUwegjh5crCV1diYISFQsopLDhg+0mcDTwsagt3NbK/9g+yZoB3Tsa4BAeY/RXPy044=
Received: from AM6PR10CA0064.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::41)
 by AM5PR10MB1762.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:1d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 2 Dec
 2020 11:32:50 +0000
Received: from VE1EUR02FT008.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:80:cafe::45) by AM6PR10CA0064.outlook.office365.com
 (2603:10a6:209:80::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Wed, 2 Dec 2020 11:32:49 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT008.mail.protection.outlook.com (10.152.12.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3632.17 via Frontend Transport; Wed, 2 Dec 2020 11:32:49 +0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Dec 2020 12:32:47 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 23378)      id
 D4F263FBE4; Wed,  2 Dec 2020 11:32:47 +0000 (GMT)
Message-ID: <24b2d8b0c3536408369add034221b1141e58bbfc.1606908582.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1606908582.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606908582.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Wed, 2 Dec 2020 11:32:47 +0000
Subject: [PATCH V2 1/1] regulator: da9121: Request IRQ directly and free in
 release function to avoid masking race
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efd88c2c-e664-4494-41de-08d896b5ffe6
X-MS-TrafficTypeDiagnostic: AM5PR10MB1762:
X-Microsoft-Antispam-PRVS: <AM5PR10MB17629059D39369F7B9BD737DCBF30@AM5PR10MB1762.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SSj834F1pTBtFYZI1BSpBYEZNMA7S1+hE8uuL+Kxyge9itAIjWTusQTbaymxNBu75vVX/eFATqqcYT1HjQ013wZI2Kc50esUD3Zr9mcBz1/JU+ixU5JXwQJodqBUf68x8RFM9Mbf9+kgbWfwj1Rb/xO877TtYP7oRBKselrvNv28mQAhSPrkHePOt/nxQgxVy9BqQiHFp/hDQW9mexjVjRQYsGg7yNm337Ox9AGt6/RzCbjK11wtj5wS09A23gpmFPpT/phLD1XRwxcN0kejCnoXkEgicfqBIGJcLV5stWb97aL0JaKbz+SpssDdV+iSSFVxJHmIqNd345utLsA9xgg87LFsdEzbiSX2xiULhafAEU7r6QQi9oelB3PrD8ROyGtUvmp66xvA0th7/1rOfg==
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966005)(42186006)(8676002)(82740400003)(8936002)(5660300002)(110136005)(186003)(86362001)(54906003)(36756003)(83380400001)(316002)(478600001)(81166007)(426003)(70586007)(70206006)(2616005)(26005)(356005)(47076004)(2906002)(6266002)(82310400003)(107886003)(336012)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 11:32:49.6773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efd88c2c-e664-4494-41de-08d896b5ffe6
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT008.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR10MB1762
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index d9a8a4b..3ead6a1 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -945,8 +945,7 @@ static int da9121_config_irq(struct i2c_client *i2c,
 
 		chip->passive_delay = p_delay;
 
-		ret = devm_request_threaded_irq(chip->dev,
-					chip->chip_irq, NULL,
+		ret = request_threaded_irq(chip->chip_irq, NULL,
 					da9121_irq_handler,
 					IRQF_TRIGGER_LOW|IRQF_ONESHOT,
 					"da9121", chip);
@@ -960,7 +959,7 @@ static int da9121_config_irq(struct i2c_client *i2c,
 		if (ret != 0) {
 			dev_err(chip->dev, "Failed to set IRQ masks: %d\n",
 				ret);
-			goto error;
+			goto regmap_error;
 		}
 
 		INIT_DELAYED_WORK(&chip->work, da9121_status_poll_on);
@@ -969,6 +968,9 @@ static int da9121_config_irq(struct i2c_client *i2c,
 	}
 error:
 	return ret;
+regmap_error:
+	free_irq(chip->chip_irq, chip);
+	return ret;
 }
 
 static const struct of_device_id da9121_dt_ids[] = {
@@ -1036,6 +1038,7 @@ static int da9121_i2c_remove(struct i2c_client *i2c)
 	const int mask_all[4] = { 0xFF, 0xFF, 0xFF, 0xFF };
 	int ret = 0;
 
+	free_irq(chip->chip_irq, chip);
 	cancel_delayed_work_sync(&chip->work);
 
 	ret = regmap_bulk_write(chip->regmap, DA9121_REG_SYS_MASK_0, mask_all, 4);
-- 
1.9.1

