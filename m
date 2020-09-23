Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48C627592F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIWNyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:54:05 -0400
Received: from mail-eopbgr150125.outbound.protection.outlook.com ([40.107.15.125]:4270
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgIWNyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:54:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tsg6QJCK3rHfPb+GqmPXbXWF0UmEDowt/DnPLZHmwexDzjAG4qerMVR88Fk8DWxXaPh21o4QMGk6jc4ClY9ZV5N6jDYGP+yT1Sdfpo38sxfz7/Zd3xWYjLv1zV9fZxaPqXIq1H701+x61yaLukrntg6t7JDcfCyW36hU1YonLCLqEDMiauT3YTdWv3qx3pyZ1vUjaj+INO0BNSTCbtv5fpfDo5E2OGd0FTWCDyhiGzkeSYGfAwz71+MrnneMWhdtLR7K8nGweKYj+9gcXwFPm5OUt6/qDrGesr2p+dqlgQCnLZRUGPvWQx4t0VUxVJcnnuc+YnkX3hydHbWtcBBDSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=997+6oSadBEoZ/sjNFIRW4xRm1b2JwAcG+HnTq+ZKAM=;
 b=OsgQV9TjIX0BiR9QesMmRnBKxGCT+R142jZR0QOoD5ro12HPcV3078iW+jdJcFDzwwl10/rh31MgjbX9ww8sJyVCESw6iTbKts8ksPg+khkNxs4HqR2dK3YT4mZNvJ6U3MCRyvcLEbdsKRWc5doMue4VPgcotx0AzkJVMCRr5rQKz5+D4wqmbF5yjkRxpwf13zqtA2rKUazY/RAaV02pMJGuCnu5MmuGxpOh3XhzQ4p9fyPWcsWBGEwvIqLftAkFRQkqcSvR6IczDVp0bPlDfmAWcLNoPvJj2iOsMyNuLzCvZwiezfnTjJOCeft1orvuqMLQ5Rn0surMjMSU56yF8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=997+6oSadBEoZ/sjNFIRW4xRm1b2JwAcG+HnTq+ZKAM=;
 b=GOvxk8aTs7G9nViR1fHAYI+CLX42Fqfs8/Ih0+vkaisu875WC2ZDAxUFTXeqO++yvKY8rNW3AkBlSH3RyD5AmYgIRcP4fA7tFKTM4SSMnI+6SNho8ddNeSweVP8e0NdSFXw1iETcAYxzOljxvUjCO7BNINLENdtzS8RWADEoeY4=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0460.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:58::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13; Wed, 23 Sep 2020 13:54:01 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe%6]) with mapi id 15.20.3391.027; Wed, 23 Sep 2020
 13:54:01 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v2] nvmem: core: fix possibly memleak when use nvmem_cell_info_to_nvmem_cell()
Date:   Wed, 23 Sep 2020 16:53:43 +0300
Message-Id: <20200923135343.16565-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM7PR04CA0004.eurprd04.prod.outlook.com
 (2603:10a6:20b:110::14) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM7PR04CA0004.eurprd04.prod.outlook.com (2603:10a6:20b:110::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend Transport; Wed, 23 Sep 2020 13:54:00 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7628415-df55-472e-6e92-08d85fc8201e
X-MS-TrafficTypeDiagnostic: HE1P190MB0460:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB04607C9557BBB17D19C1F12295380@HE1P190MB0460.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z+nSW/N7OYFy6pl7HP5JWkbXgxndWI5QdDUGxcWrv/CcxfgN3db297s4qT5Z1nqXBQKpXUSlvvq8qvIXScVd1XWzftAT0Yoag7ZsyuQSp3qCR52txZXAyjR7RB5a91RAQJQ68D2ZdxtAEQ2V0s/hIzR36yK2y4z6/A9sq61e0nAeOp8IXAV9BgkfHF9dKU0QzdBBRrcQBwtknDtpq3+CdjtjIKN5gg6UrdpZoSVRb/Q/OXxNqqCAJUj2LOAu6E5ElB6Ugen2SxR/KUBSh+VHAmq9p7T4yXlBgtqn2R38oi8o70Q820MLDI0863XfnRKgzeOJHtHVmT6VICNZeUDG9kHtCJciUw+RC++ffaVkvWFRa+enMheuiR3HiAellBea
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(39830400003)(376002)(396003)(6506007)(110136005)(6486002)(44832011)(956004)(2616005)(16526019)(316002)(86362001)(4326008)(2906002)(107886003)(36756003)(5660300002)(1076003)(52116002)(6666004)(8936002)(186003)(478600001)(6512007)(8676002)(66556008)(26005)(66946007)(83380400001)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 2mH6L2TJDO3GpuutOvQaL30PGONSyc+QtrM6gQlv9i7gwYtT4w3iPWymg9pFd+6AXDeX3RftcbiQeQ1daedRBEjbugHORl/tvbv3Z3ZNykhOr+mOwteBr8lCdE/T+Gczgx3QnrRrPKxLdQ6viEANNGKiWgG8rZPLrby+3NU2W0uEhf4xyHmkFGo24WUhpmsOFzoZ6aox3SAhDQT4ugbcfBTXMmXnXQq/av7hlBB6RrTN/fcaiqrDHuvI5zgFnokFLZEqerU+lYrLggdgtfjhWB0xHGO9+A+OMfhER72hSHL0k5gJIWdabii5kGDiCymmUrZ8B2xq+TRPr+zKdPWOpszjWUbTsH4H61woyHCon2ZZq07QJ3/fNv/2PLKzBZR5LoYkk/HT0RaZNLUBTmQqaLPfYfyCaR2/rwQPX+QYm8bFwGQzGwO8s2Dux02eryPqizMb+fbQYrFVNwD3hXws3ckQ3PSrwEzHQyotqJSsqKRjQQBU8yvpQ2FMD0n9xh48xIe7k/auJUcUd/mfxVE4+BSG6Z1vyPV6EDqpdGezYiGavoiO8HvC6B1fln30Oold8YHCpinLGLVD4JUeqD6Vlx2Wh264RgB+bvUv52aABQ+9F5ItXzZuf19U2tmPgf6m0Rbky3sf3uPhOogNwmKpmg==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f7628415-df55-472e-6e92-08d85fc8201e
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 13:54:01.2197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1oHdZnHyOcY1D3Ql2nuZuIacVA7WVRmrx8TjeYk1RYDvIkUstntbhT6X0UjLTdijeci5ASWdEQx1qbkHSbp4fGY166eDUaB8Y24kCWJlsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0460
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix missing 'kfree_const(cell->name)' when call to
nvmem_cell_info_to_nvmem_cell() in several places:

     * after nvmem_cell_info_to_nvmem_cell() failed during
       nvmem_add_cells()

     * during nvmem_device_cell_{read,write}. This is fixed by simply
       re-using info->name instead of duplicating it:

           cell->name = info->name

Because cell->name is not used except for error message printing in case
of un-aligned access, the new __nvmem_cell_info_to_nvmem_cell() helper
was introduced.

Fixes: e2a5402ec7c6 ("nvmem: Add nvmem_device based consumer apis.")
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
v2:
    * remove not needed 'kfree_const(cell->name)' after nvmem_cell_info_to_nvmem_cell()
      failed.

 drivers/nvmem/core.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 6cd3edb2eaf6..e6d1bc414faf 100644
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
@@ -382,13 +381,31 @@ static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
 	if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
 		dev_err(&nvmem->dev,
 			"cell %s unaligned to nvmem stride %d\n",
-			cell->name, nvmem->stride);
+			cell->name ?: "<unknown>", nvmem->stride);
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
+static int
+nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
+			      const struct nvmem_cell_info *info,
+			      struct nvmem_cell *cell)
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

