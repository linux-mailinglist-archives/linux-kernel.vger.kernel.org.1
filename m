Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3130274D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 01:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgIVXuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 19:50:35 -0400
Received: from mail-eopbgr70103.outbound.protection.outlook.com ([40.107.7.103]:54855
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726641AbgIVXuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 19:50:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLd4KZqfBVxvSVoRXMCXCfS0XpCvCsM+L1II+U5s9NNubH19fVJjVzHAyEJhco6Qa3CSpNqkLo3vtAUekY5aQCvUHWcpM8ZfrNBkFsa/gCrxy+tPpmjzHQ8E8eDMdFgHrM5eb01KSHCTNhUgcrkkRgq7B6HmkXDVkjVU+UfsL3FGvgmT00K8BvDi5ouwXDXAR5jmD8ESZYCSNazsLYWLBuXG7noXJG/ZE4YPH5wttwB4tgTtKwDjMi4F8Yhkgc8RWTJXlgSiMeOWATcS6N4rCV0Wz2XtbNgYQRRFxO4LEG3R3wSULl39OOS3ImlxeCR9gJrK5Rr8XiSKYbCDTsRUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmEoBkqPm0v9gLQdopwowonWJOLlWD+ICO6s+GwN82g=;
 b=QgMjH5gvxiZTSojVTL4fWa4QzU+5838xE+CJgC9d+8i5I3jQL/lgwzdG/YVhS2stsljFMcTqRsGX/vHfGFDez9JFthzozt2gOtp+t7AApisxoQfz0zeQRGCPZ/tz4RGifuRki9X2DsJ1P8JOeB9+ABIRdlLYZEHLwR7Zc5WsDw9fCsyFNu8E1jU+u8qROWrRjiIRxYi/s7DpcYFPqb2NEuuADHZbGV50SJ8gXrdm+cC4LduNk5wKiOMwwGRpdwHnlupC2F2mJChN0pcCK3MTL6VuYKtcOkI2gZbSJvuTS23EtEtRmWnlYgGQlabt+adtG9rxJ5gorTv6IpVPss6VpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmEoBkqPm0v9gLQdopwowonWJOLlWD+ICO6s+GwN82g=;
 b=SBYd/s89BhqZOJSh7CJJvnD/gJbnrnzG9F84XuonvU/tTb6w/oVNAaHwmlTowHL79xhtDeQWhwchWBL1BycqELapvyYmfSBHSG5xsrGDSjgSSsYst2Gxl1vMeh1C9JEzp646TucibCZzKB4AS5u/s/3B8Er30qZj2PWVewaR+9k=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0491.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:5b::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.19; Tue, 22 Sep 2020 23:50:30 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe%6]) with mapi id 15.20.3391.027; Tue, 22 Sep 2020
 23:50:30 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH] nvmem: core: fix possibly memleak when use nvmem_cell_info_to_nvmem_cell()
Date:   Wed, 23 Sep 2020 02:50:05 +0300
Message-Id: <20200922235005.24371-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: BE0P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::11) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by BE0P281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 22 Sep 2020 23:50:29 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e868a816-cd8f-4861-f540-08d85f52497d
X-MS-TrafficTypeDiagnostic: HE1P190MB0491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB0491450E6121B1D3B54616FF953B0@HE1P190MB0491.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:398;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0cmdaam3sgKlnMXFCgEXIyO9NhYl/yJ5/GBhIi08lzhe6prV+QoZqyAYkoPXcecNaiUvkDz2YDwa6jCwYG9mf8kgs9NNpQAokR3kgLwIbMbag4GyKaJIYiPfeXZUW35wWH3XsY2qFq8cHa1R2eROhKkMCkEb6FaHsCgPB2DS+iHKHWcY8523ACpvukcGHDi5OP0xHtPk5anrQ0grQ1y9qrj1e8s5AEUloezCCT3iOtwMy4vDbXiEtPXu9CGnZGEBLyTDKRFs4sWATZZhrBzAKiaCxnpSMO1PG3mg/7/F5Iff0fKqinhGfXVEv1Qj82OU9Hx8UUpqMypL1RQXJXvcOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(376002)(39830400003)(366004)(136003)(346002)(16526019)(26005)(110136005)(36756003)(107886003)(316002)(8936002)(8676002)(86362001)(66476007)(66556008)(66946007)(5660300002)(4326008)(1076003)(6666004)(6506007)(478600001)(6486002)(186003)(44832011)(2616005)(956004)(6512007)(52116002)(83380400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Am8oYfXVBPZueG3gX4qPGDvHgMo2dWvGmSwF25a+guUF8AsWjDR7DHUfEx9bnSfKcqQW6Hon3WJM/SUL7x+ji9j3Pu4zjcLtlTIWOgkNqodx8uE3nt/vzZjmJEWytsl/6VvgB00FPdOrtxRjM9nqv4pVYo9+KeQ004jd4LJlBGTXo21lis1qCgO0qZV6ZCRBMGT3fee5mUrNOvB71TigHYEr/UzqmoinJmgu+LeTqiEsHf8IOCdpHVWXH8h3Hwcv2dJdc5QmsG6DKDgcv8gVwhGOaCbx2GziEfOJ+1k1wpkepwzp70V5++1tKeWb7j78vHRY//XK/xvLQyYmCTMTTD/vTkfUxxdBI2+DYrI2Fn5UOh1rGw/h7q4mGi4nKJTMBFBNnjUex45KLTmHZ3+ZDD3b0XR1VsZCFd2CeQ5WK6pDf8uaxWIKvq5WR7X3DOHXgVYTyKNj9JyUL2xrUXW+T+i2pG8Hu7H93MGzkvyrAb8rClydqxTBXl0swFNJTOU1JIxhYUFswVDMb0t9YKoTLSeufdTqjKRzm7LmcfarqwXsqddpdKPw/R759HP+TWpEXjY/gvxEtZcigsmKCgeC09c9lSstabE0fl53OxzpTmkLXLVm5bitXyDtbGX7uKGN9wNhPHg5qrHG0U9w+Qq+GQ==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e868a816-cd8f-4861-f540-08d85f52497d
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 23:50:30.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9MK+SYxO1J3GEbJN6jpwdRsI4Xnn2Eygw/xltA/iKYUksql3TeB+bnHbHU8IMYjMIdFyL/EDVNe5c0j9BwotN7+DZtFFJ86iBrv6fjmC2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0491
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix missing kfree_const(cell->name) when call to
nvmem_cell_info_to_nvmem_cell() in several places:

     * after nvmem_cell_info_to_nvmem_cell() failed during nvmem_add_cells()

     * during nvmem_device_cell_{read,write}. This is fixed by simply
       re-using info->name instead of duplicating it (happens in case
       of dynamic module):

           cell->name = info->name

       because cell->name is useless in these cases except for error
       message printing in case of un-aligned access is indicated.
       For this new __nvmem_cell_info_to_nvmem_cell() helper was
       introduced.

Fixes: e2a5402ec7c6 ("nvmem: Add nvmem_device based consumer apis.")
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 drivers/nvmem/core.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 6cd3edb2eaf6..d1f5a639dfca 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -361,16 +361,15 @@ static void nvmem_cell_add(struct nvmem_cell *cell)
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_ADD, cell);
 }
 
-static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
-				   const struct nvmem_cell_info *info,
-				   struct nvmem_cell *cell)
+static int
+__nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
+				const struct nvmem_cell_info *info,
+				struct nvmem_cell *cell)
 {
 	cell->nvmem = nvmem;
 	cell->offset = info->offset;
 	cell->bytes = info->bytes;
-	cell->name = kstrdup_const(info->name, GFP_KERNEL);
-	if (!cell->name)
-		return -ENOMEM;
+	cell->name = info->name;
 
 	cell->bit_offset = info->bit_offset;
 	cell->nbits = info->nbits;
@@ -382,13 +381,30 @@ static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
 	if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
 		dev_err(&nvmem->dev,
 			"cell %s unaligned to nvmem stride %d\n",
-			cell->name, nvmem->stride);
+			cell->name ?: "<unknown>", nvmem->stride);
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
+static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
+				   const struct nvmem_cell_info *info,
+				   struct nvmem_cell *cell)
+{
+	int err;
+
+	err = __nvmem_cell_info_to_nvmem_cell(nvmem, info, cell);
+	if (err)
+		return err;
+
+	cell->name = kstrdup_const(info->name, GFP_KERNEL);
+	if (!cell->name)
+		return -ENOMEM;
+
+	return 0;
+}
+
 /**
  * nvmem_add_cells() - Add cell information to an nvmem device
  *
@@ -418,6 +434,7 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
 
 		rval = nvmem_cell_info_to_nvmem_cell(nvmem, &info[i], cells[i]);
 		if (rval) {
+			kfree_const(cells[i]->name);
 			kfree(cells[i]);
 			goto err;
 		}
@@ -1460,7 +1477,7 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
 	if (!nvmem)
 		return -EINVAL;
 
-	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
+	rc = __nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
 	if (rc)
 		return rc;
 
@@ -1490,7 +1507,7 @@ int nvmem_device_cell_write(struct nvmem_device *nvmem,
 	if (!nvmem)
 		return -EINVAL;
 
-	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
+	rc = __nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
 	if (rc)
 		return rc;
 
-- 
2.17.1

