Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4E82F9869
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 04:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbhARD6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 22:58:54 -0500
Received: from mail-eopbgr750082.outbound.protection.outlook.com ([40.107.75.82]:60843
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731902AbhARD6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 22:58:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkm0fXXIKdZBF9vi7Ev4FiVKqds78jasiCcp9pwq+E2GvKEXPsT2LSafw4ayHV+NixBeOIG5RsFZzatHc58qCARotc7HRFnml9hJ8IiDIm5PzBYV63TaV9ahTqBoksGL45c5eKNMOz+paK2J2SEFlM1i48yxvOoUVbQUawaE0Qg7GUG5qQm2FvUfA8OX/kDybZfc6sTbazM+biLgOuhF/azfKmcfP68j1/AJLxvjQpSLe4+W7ctmI7MwzhJdJ1gZDlnlLrnQn9GdpGteU52LzyauVTFjtuZ+YfUI36ys66k++broueyJfC177kvlcpXaSlqBrsYf2OevZgsvGC1H/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4TgTzGJH7SIIk92XhmALFI/I16sCzdrdj6dDDzSnEI=;
 b=a5GO0qF4Z3V4iLwz+e3NNa4pBQhxWv83SmJM8aQNOg2LinsDV0b7gPB2TsgIBtNmd1dwUmZ6z3tC624/LgydAF7rzDSGUw67oApn2i0vctkEfcLCh0yRU8W0l8siyy0/k9PKNpSSx2f3RRWIhn4tEGCdyswfNlXEoqoE6+3awp/NK7KQPLCQPNSesm6aTkcqo5XlIPz0NZs4eOGKf5gMIktFIIsgNDER5G6zAPKzdqp/+rXDMGnmVGUshlOO32bgFer3oTNaSP56HJaUcHBzFcoy6GlaLCij1DH0qljddqeVsWjL/S/t5aQfbvDfvqV5bU8WFgRcbXBxEzm+Ujyo0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4TgTzGJH7SIIk92XhmALFI/I16sCzdrdj6dDDzSnEI=;
 b=brDvpufrlehTDUfoxrnEsoSBpoy8trjiJYlC+uUpNwdf20n/k7Ibw3uZS+sdLLJhSYOQ6jKBdns4yCh4WvHjNvO/CNmXvGnzl7bTYkJTSXzs3TM4eC2YeImEg+c92uHhpXSlmiEMbwhpHmaQTvktjA1aFr2gKaAkUW4KmAUR/Ac=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB4878.namprd08.prod.outlook.com (2603:10b6:805:75::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 03:57:40 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0%4]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 03:57:39 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v2 1/6] mfd: iqs62x: Remove superfluous whitespace above fallthroughs
Date:   Sun, 17 Jan 2021 21:57:03 -0600
Message-Id: <1610942228-7275-2-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610942228-7275-1-git-send-email-jeff@labundy.com>
References: <1610942228-7275-1-git-send-email-jeff@labundy.com>
Content-Type: text/plain
X-Originating-IP: [136.49.173.128]
X-ClientProxiedBy: SN4PR0501CA0055.namprd05.prod.outlook.com
 (2603:10b6:803:41::32) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (136.49.173.128) by SN4PR0501CA0055.namprd05.prod.outlook.com (2603:10b6:803:41::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3784.6 via Frontend Transport; Mon, 18 Jan 2021 03:57:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14ecdb55-c4c4-4d55-0b75-08d8bb653331
X-MS-TrafficTypeDiagnostic: SN6PR08MB4878:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR08MB4878499BA6CADE8BC67C859DD3A40@SN6PR08MB4878.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H8NuTp1KLroOt1nw7R1Rn7dTe1hUcFeUFg4sUqtINdorJrz0CNaP5YDw7llTerFOtaqGX43kmYDiVrqHMmKpI4PzUlK5yCg0FcOtGlORhQTFHIkZGXQCoB1ttRf2HKtzO5vTf7w/jxUVNJKZS1vXA2Oo9OGvWBDwCDehlOc7O65bdGIjEaziYZSlruOh9Vwjbe7kI/uuAW0ODiJBSO4ZpcjmftqdmRps6uDnwW/ONF1Nw4/30ppOBEFXMKQwCXvVsueMRceJGZhc3CV1Lz+PvM8pdIp0S7j2urZhvdZxV8iHvMcnKs52vHzbKn4dxxJC9QtBEHNBW0pCXC0C0w9MYLJb0vTTfmL+o6EleuyuBBvN4N4iskI+irIpzZZTjjWcsyp/ZqvRISlPLyGX5MdZRd95PfeUtceG0xw89o/MYkPfnf+zzqb6atDRr0pAL+C4NdiMpvJfLbRdHcY5V/tWtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(346002)(136003)(366004)(376002)(396003)(52116002)(66946007)(107886003)(8936002)(5660300002)(6512007)(69590400011)(16526019)(6666004)(66476007)(478600001)(956004)(316002)(8676002)(6486002)(6506007)(83380400001)(6916009)(2906002)(86362001)(36756003)(4326008)(26005)(186003)(66556008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TwnSCM15N0F0ZJb0IW6QKs4lzPcI1g4gJlJr/pAhm9z61KkXQPHNXVmAANZP?=
 =?us-ascii?Q?4nrTJ5VAjZC7SgOsfCX31QgMysrmvKaks0utzE/0riQ5Dz1j20YkmVaN/3ef?=
 =?us-ascii?Q?SWKmiERxNnywXmsRkgCyrbwUuwn4g9WJIhXcZ6tUtONzWNHRpsXzuWuqis1D?=
 =?us-ascii?Q?4QYJDROInvLOf8YuOdr1DN+ItxqVicFmpT54W249AriuBaNuzgqvqGzLV1Ue?=
 =?us-ascii?Q?EQnNhE+SSOQjR0ACQ4iuiypoF4a1ZCnv3d1xb+xbkVVmDhG/1XQgtjICDQXE?=
 =?us-ascii?Q?cc9ZOFoLsrkYuBzIrxdyL1zm7EVBaI71FaJ+AVSy6Znfi44WpetZPelw2Y1K?=
 =?us-ascii?Q?RId+/P1z5Lk1cIgNQwe7Uol7Gs4Tpds32wC9nVZYL5sC2gnAdtTtcyf75T2y?=
 =?us-ascii?Q?IVdyldkNvYLOyiszinx3WILq3jxXGF7sfWCYgAYjWbk4V/jJ7hrXBkH270Zc?=
 =?us-ascii?Q?7XQAo4Fy7hYokTG2wRAF/Z0APLoBo2fdyXGZE1rvXCZtLZVAQgn0L3A/MiZZ?=
 =?us-ascii?Q?HJVq1Htvx6cuA47Z2AXIxAFMUzml/QPNSXFxWoWKIjH/tUqd4WyesIFJrzgU?=
 =?us-ascii?Q?Be0Kf8D1MELv37Ha4zv5TpW2eRvvBvBUpJQYIkQ5KzFVMSCjrF0t9X14E02V?=
 =?us-ascii?Q?dN7Y3hnOmJrSre+obKhY7GZGhZ7d70mV5Vj4Escg/JKCA4ZVW7R4DAMuEOK/?=
 =?us-ascii?Q?IS7j7b1/pP6mGEnOkieyPZw9ofWSqshkoRfhgDBPP6pH3ztLj/6mnkKKC7bm?=
 =?us-ascii?Q?J512VX9EvG/pQM28x1eAeHkqyq5T8h0GxFky7uBOZWg3wZSmSzrEnWiOd36d?=
 =?us-ascii?Q?uHEY7q9AJ0uZZntdeZ47ZniLH7E5p5rS+CB9G2C7L5991mNL93qIFBGCuNvd?=
 =?us-ascii?Q?G+qBPuJ4z+f5VseaONK90eUVojII/UTEE+pUjpenaTvrL78dCt7tfFS0ySLr?=
 =?us-ascii?Q?nbAR2KDaMVgp6JFTn0F5RUBax2bXkDqk5GgMX/oJXeL+i424b4O3pV3ga7VO?=
 =?us-ascii?Q?IE23?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ecdb55-c4c4-4d55-0b75-08d8bb653331
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 03:57:39.9265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giGae1KdOJoOYA1TbOeDWfo/g0QtY6NB/A9w+V/42bzlfvA1AeOjsaiOpMeyqU7li/V8L9JpeIFJid1l+g3xxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4878
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, all instances of the /* fall through */ comment were
preceded by a newline to improve readability.

Now that /* fall through */ comments have been replaced with the
fallthrough pseudo-keyword, the leftover whitespace looks out of
place and can simply be removed.

Fixes: df561f6688fe ("treewide: Use fallthrough pseudo-keyword")
Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
Changes in v2:
  - Added Acked-for-MFD-by trailer

 drivers/mfd/iqs62x.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mfd/iqs62x.c b/drivers/mfd/iqs62x.c
index 761b4ef..ec4c790 100644
--- a/drivers/mfd/iqs62x.c
+++ b/drivers/mfd/iqs62x.c
@@ -135,7 +135,6 @@ static int iqs62x_dev_init(struct iqs62x_core *iqs62x)

 		if (val & IQS620_PROX_SETTINGS_4_SAR_EN)
 			iqs62x->ui_sel = IQS62X_UI_SAR1;
-
 		fallthrough;

 	case IQS621_PROD_NUM:
@@ -469,7 +468,6 @@ static irqreturn_t iqs62x_irq(int irq, void *context)
 		switch (event_reg) {
 		case IQS62X_EVENT_UI_LO:
 			event_data.ui_data = get_unaligned_le16(&event_map[i]);
-
 			fallthrough;

 		case IQS62X_EVENT_UI_HI:
@@ -490,7 +488,6 @@ static irqreturn_t iqs62x_irq(int irq, void *context)

 		case IQS62X_EVENT_HYST:
 			event_map[i] <<= iqs62x->dev_desc->hyst_shift;
-
 			fallthrough;

 		case IQS62X_EVENT_WHEEL:
--
2.7.4

