Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DB51F64E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 11:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgFKJru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 05:47:50 -0400
Received: from mail-bn8nam11on2126.outbound.protection.outlook.com ([40.107.236.126]:29857
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726684AbgFKJrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:47:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBxcVq6jws/uEiFWI54kzWM9F0aRNX6+fysESWnp24p7KCt+A0a8IiVuchNaKPc8VKZnzdUR2ZuATHLiwjvMwgDd/v6YHYNWWElYXKeWi5yxaX0NjcEXvwiPnPBkh5Jg8BP0g5QQSyz/jsczgl5Dq8rTI59GuctlNU24lyYQExohhkL97VPEeD1+XJQnKK4+nGHIMzu3Gm9NqqwlisuS7S0Plxlpl9rYTE00PryEj8WBg3f79bGnEMO3OfpCXPs1AVKGDaMYm/C0c24N8FhiUM6f99Z9s1n/KzdI3NMFnVzVtIXshcGQ0MUDI7CpjMFZIweYK0DqsYcwT3SWCf2KGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNBQxSCCM+D0W9bOSAiuaGE8mBeFV5Szar2f9nGcjb8=;
 b=gYCM7CC3f6jW7bnxzrDzsX7qq0A+yrkrz6eCzCiyV8M3RNNRLkul4QpmdBs5WjvXHcnlNvob0ZsLczlQl7kOGm0pq9tGjQ0kFRa87TZ+qgt0YIS6VA41z8ksxKvsQGi2SClAjSWnhelMKdi3SB65ZiCsfBNL9RXtVYB2QzOfP6a7PxxHCcNeYfPe00oUcSQ5PIryPS2oXhHT6hoZF2fbUwe/Qg3ew/Emjy11EnBNlJiXNrIYJ2+8DkJyZzn6L4Q7NUZwG/vc+qrtvTXgNhIaqcUaF5uojIA4dt+ob93d5VqsND7dBSs5okKfeHX3FSW0Gpxy0REiciFeIOoZfb9coA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNBQxSCCM+D0W9bOSAiuaGE8mBeFV5Szar2f9nGcjb8=;
 b=NjCyx3ZQOi7TjUxeuAeFe59sb0VzIopPG9u2rP6oOPzoUzZbU1ewixks6SWzlf5O2tCfuLytx/sM7Ll1ecL78nl84RIZGf2eF9Y+GQR2rU9i2wOp7feRbh60DvQz3h5ceqEWlGaH/9J6KQLLUbYCkxqgNLY8JzNroOf2AARb9V0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=maximintegrated.com;
Received: from MWHPR11MB2047.namprd11.prod.outlook.com (2603:10b6:300:2a::12)
 by MW3PR11MB4668.namprd11.prod.outlook.com (2603:10b6:303:54::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Thu, 11 Jun
 2020 09:47:46 +0000
Received: from MWHPR11MB2047.namprd11.prod.outlook.com
 ([fe80::994e:6a48:f660:f363]) by MWHPR11MB2047.namprd11.prod.outlook.com
 ([fe80::994e:6a48:f660:f363%5]) with mapi id 15.20.3088.022; Thu, 11 Jun 2020
 09:47:46 +0000
From:   Steve Lee <steves.lee@maximintegrated.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ckeepax@opensource.cirrus.com,
        geert@linux-m68k.org, rf@opensource.wolfsonmicro.com,
        shumingf@realtek.com, srinivas.kandagatla@linaro.org,
        krzk@kernel.org, dmurphy@ti.com, jack.yu@realtek.com,
        nuno.sa@analog.com, steves.lee@maximintegrated.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com,
        steves.lee.maxim@gmail.com
Subject: [PATCH 1/2] ASoC: max98390: Add Amp init common setting func.
Date:   Thu, 11 Jun 2020 18:47:18 +0900
Message-Id: <20200611094718.18371-1-steves.lee@maximintegrated.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SL2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::34) To MWHPR11MB2047.namprd11.prod.outlook.com
 (2603:10b6:300:2a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2001:2d8:210:3256:d447:7247:839:5c8e) by SL2PR01CA0022.apcprd01.prod.exchangelabs.com (2603:1096:100:41::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.20 via Frontend Transport; Thu, 11 Jun 2020 09:47:40 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [2001:2d8:210:3256:d447:7247:839:5c8e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2c36463e-27ec-4940-a143-08d80dec7e32
X-MS-TrafficTypeDiagnostic: MW3PR11MB4668:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR11MB466873CAED5FA67E39CAE49092800@MW3PR11MB4668.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f2Z6rB6bIvOv/L60eyrwhmhkNcRLfIL607x4Ajn2AE12GPExKLMIex6QORTI/G7is3jCj35BY5tW9kXmgA+8cNnp/FwH21VW8sEXmE+SZ6SnmO3z2Q0MwGPonheeuTjDGoPkQD/OOCb5QgQA1pASRj8TzPvQTB6rSwbciDNEpKt1RZJyCnN2SBUd/WSA6qJewLumCC8l8nC73ZumYtyrHMc5k3Y25eQ+vZ7oL2QpU+eQBfU+N689lsWRYVkgykqdGunp7Yo9AbPy+idTUHalTIzHgbcynSGmGLMLhLAR9KnC1GZZVsS/i04cyjHSFErIg+aps1yQJfT/wzfP7Fr7y+tPl9LHf5vMxQXj0O5jmCsvwL0dW2KeofXWa/pdIi2E3P2kgWfPiGFkZEbsVHAHig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB2047.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(8676002)(2906002)(16526019)(52116002)(478600001)(66476007)(66946007)(1076003)(316002)(186003)(5660300002)(6666004)(6506007)(86362001)(6512007)(83380400001)(66556008)(4326008)(36756003)(69590400007)(2616005)(8936002)(7416002)(6486002)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vWnSY73y5s/wYkaVxvw9a/7U0c+lDOsocwQxXljgZJylxEJHsc1/sg3EnUWCtBL+a3V9xvMtEG2zKMETkxxBlXIUIpUxTxa6gt8BTyaCoA7I0xDNcJwTRTGL0qc6CmJYFLSZZY6XpFmbFpaRzLhXYqDmRdHXFo3BkoqFUogP17aO8sBGq4dwB25pGqoBF4CCyyMWmMk6GXwiMYC8Vw3lugeWNiQZ5/+C3qr00Z7MPlhRjCdKlMVDZ2b5dOQedWIlrGx6eFx8prKCgv72xJdG0FkV8g+7APrvCrvza8KvyvSNt8T1vHg+I+QWe0kD1SAeGpukrwc6VROSBwLkO7U1jct9cqf5i7wC0T4AACOqFIvrkXWxpXsyWeArJEayKFfjlX5GXgajs+qmMNyxltqaZ4n9g5uopbYKlHd/iO2frOm/Vht0E6WujUU9/+Nvy9WraGneqMg8H6SIZ6QQj7X0eRdDbvwY2Jiov9cFcivVmsBzXxF4PeEDrMWfaC0A6yrHpNg17+7vQI4jGq1mvy7ZAZHil9/lkckLfB3ORCsx8Cg=
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c36463e-27ec-4940-a143-08d80dec7e32
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 09:47:46.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmPdqrAsKo9tKqKSZ1+iu89jzU3lVwG4o5/nUHul4Giss3fPKcT0kUEyhXCdoNlJivEaMOEkq/bL2HeobzbJpp1IsbhHuQOHBou+zxZEfL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4668
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Add amp common init function to gather common init setting and finaize.
  - add max98390_init_regs func
  - move amp setting to max98390_init_regs func.
  - removed unneceary setting and finalize common register values.

Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
---
 sound/soc/codecs/max98390.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index 0d63ebfbff2f..57d15dbfcda3 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -842,6 +842,20 @@ static int max98390_dsm_calibrate(struct snd_soc_component *component)
 	return 0;
 }
 
+static void max98390_init_regs(struct snd_soc_component *component)
+{
+	struct max98390_priv *max98390 =
+		snd_soc_component_get_drvdata(component);
+
+	regmap_write(max98390->regmap, MAX98390_CLK_MON, 0x6f);
+	regmap_write(max98390->regmap, MAX98390_DAT_MON, 0x00);
+	regmap_write(max98390->regmap, MAX98390_PWR_GATE_CTL, 0x00);
+	regmap_write(max98390->regmap, MAX98390_PCM_RX_EN_A, 0x03);
+	regmap_write(max98390->regmap, MAX98390_ENV_TRACK_VOUT_HEADROOM, 0x0e);
+	regmap_write(max98390->regmap, MAX98390_BOOST_BYPASS1, 0x46);
+	regmap_write(max98390->regmap, MAX98390_FET_SCALING3, 0x03);
+}
+
 static int max98390_probe(struct snd_soc_component *component)
 {
 	struct max98390_priv *max98390 =
@@ -853,18 +867,10 @@ static int max98390_probe(struct snd_soc_component *component)
 	/* Update dsm bin param */
 	max98390_dsm_init(component);
 
-	/* Amp Setting */
-	regmap_write(max98390->regmap, MAX98390_CLK_MON, 0x6f);
-	regmap_write(max98390->regmap, MAX98390_PCM_RX_EN_A, 0x03);
-	regmap_write(max98390->regmap, MAX98390_PWR_GATE_CTL, 0x2d);
-	regmap_write(max98390->regmap, MAX98390_ENV_TRACK_VOUT_HEADROOM, 0x0e);
-	regmap_write(max98390->regmap, MAX98390_BOOST_BYPASS1, 0x46);
-	regmap_write(max98390->regmap, MAX98390_FET_SCALING3, 0x03);
+	/* Amp init setting */
+	max98390_init_regs(component);
 
 	/* Dsm Setting */
-	regmap_write(max98390->regmap, DSM_VOL_CTRL, 0x94);
-	regmap_write(max98390->regmap, DSMIG_EN, 0x19);
-	regmap_write(max98390->regmap, MAX98390_R203A_AMP_EN, 0x80);
 	if (max98390->ref_rdc_value) {
 		regmap_write(max98390->regmap, DSM_TPROT_RECIP_RDC_ROOM_BYTE0,
 			max98390->ref_rdc_value & 0x000000ff);
-- 
2.17.1

