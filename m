Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDB32E7278
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 18:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgL2Q6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 11:58:45 -0500
Received: from mail-co1nam11on2070.outbound.protection.outlook.com ([40.107.220.70]:29184
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726214AbgL2Q6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 11:58:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LibqbsDYHkvwJfdBaCmICGvbfQri80Bw4TB3v4SIvGw9F6kxmJt8F9QLtFZ/GSRPwyFLl0NfBXy56Mvpy3/oJD9tJRZt/Npo6tCClChGQ+Py+vzfycchxwYihveV1GQ01zHaf6lDVbyOK01PAQgY+eVm8ynYuLZQHO+r0kEpvsRtyTuN8Wu9Y4WmHjhTVi72NklqBWyUpsfkXSKi1cCWYPfCrb2lUasJMtVKjJdQD4vEM1LYOUo9shD/0YijvGrkgsxPSle2ovpziHSx4/ZPyrvZY14gPnjOg1gsl/rwM3BONB1q7cDz70Tkm/AWaHXDuwpVGtoLsIZW5FX60P6FmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntjwf3kigAGqOWgNrkLxi2ZAmK/8GNK+LZWDgQ2UE+s=;
 b=lP/P+DI2zNQ9AjDiuvcbuKNaxGoKNFTeXCDEysqgMoyykNgLcml0KqBiX0CIj9pFOOH0hF86SQ1LtEPxLcOVMfXzaaKtx89wdM8yL0TEfItWqwLQInjY4Z0HW407QiUiZEd511/qa9alw321GK2/286UpGK4V1kq8h9ct2lc0LYr9v5scnpKK7wxePQJBDKmgxGa9dz5yVJRI6XIy9qmUvgNFkruhzYgRovUr73BjLSuPtiRaXPtjhK0Rx45P1EyH2Jp8+jrsEY3ceaFUCat2N/upI/BA1skYiTqHbfeQz77RjUcHIECW1m9FsVf0ksYcPZrONm3G/a3Wp8vVJ373A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntjwf3kigAGqOWgNrkLxi2ZAmK/8GNK+LZWDgQ2UE+s=;
 b=uB5laS6KzU74W6AVRqsJ3771+JYotJX1D83tyUnXcv0j8oX5zHHIYA5hduY/k2Yne8Y/DogS78w5pcJhBae4tVfsgOboNdalZLgkpDUJaMfMZD65ahxJMCnWY2Pbr6Iuh8Fy/9FBo0f8PhkC/oGuh+Q3EGgfDXHcc2joB5mZ0ss=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.28; Tue, 29 Dec
 2020 16:57:52 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::3d50:f4c3:fb52:cc93]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::3d50:f4c3:fb52:cc93%3]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 16:57:52 +0000
From:   Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx@lists.freedesktop.org
Cc:     Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Dave Airlie <airlied@gmail.com>,
        Josip Pavic <Josip.Pavic@amd.com>,
        Bindu Ramamurthy <bindu.r@amd.com>,
        Martin Leung <Martin.Leung@amd.com>
Subject: [PATCH] drm/amd/display: Initialize stack variable
Date:   Tue, 29 Dec 2020 11:57:40 -0500
Message-Id: <20201229165740.519759-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.30.0.rc2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2607:fea8:56e0:6d60:f639:9ff:fe01:4714]
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma1.hitronhub.home (2607:fea8:56e0:6d60:f639:9ff:fe01:4714) by YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19 via Frontend Transport; Tue, 29 Dec 2020 16:57:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d36cd2c8-e7b9-47ba-cc16-08d8ac1ae148
X-MS-TrafficTypeDiagnostic: CH2PR12MB4149:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB41494692141C9A39D53FA2B198D80@CH2PR12MB4149.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+c9Bu6eHhJgFYIa+hPH6Y0vX448z8SorK0rdtybwse7Sy0O3Rmq4hk2BHosAPpfkscIsZjUfggQkhQ3rJg1G+POsVcbph98kmfpNFtY/mlz9Lo17c3K09FRoJJDHVICLbDozWGnv2Kpy6BeF6GyDWKKAbOlR15c7wZKc1mZf6DpS1nNarkmdCzNeYumN3Sb0UzxwsJZyrt1fVscq+Lj+dByFxuv8uv18+cidwkHCmPT/GfKtR3s2OyNLjT+BJC3KUwDcbnk4azzv52JU+4BIpoJFNkFqNTa7ntmPekzeP2ZQk/2vll1KDelxS3OIpxW1e7H5Ysmx9n3bdfoTw5B7OFbJayZI8lvN8GDv3HgSCtVD8qN7d00t8Qt68yy5NOTbDMJkpQ9L7OyOFxZFpzMfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3781.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(4326008)(54906003)(110136005)(66556008)(66476007)(83380400001)(86362001)(8936002)(316002)(6486002)(8676002)(16526019)(66946007)(1076003)(5660300002)(478600001)(2906002)(6666004)(36756003)(52116002)(2616005)(6506007)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DmQPuEigKDZ4wa0HzXnR2+qPykRvI8+7Afeo6yOdaRARZEmyTO8op0nWF/vc?=
 =?us-ascii?Q?ow9UQ7Oo+Bq3rsCThvKQG99lu5/4E62CcagOiRI/AGCIUHVIZz+sNzIPhntj?=
 =?us-ascii?Q?wjbNuIsexdDxmrJhM6IMlR/qE7jfSDwxgo3GnhHKFwiFxDJhiZ+PePKxioIH?=
 =?us-ascii?Q?XSpmqxU9pwdzkV+odJ7fVYGFuwTPJy8vwuhhvfkWCcVCXcWcO1C00itwLLwV?=
 =?us-ascii?Q?RRFJDP60qAvqoZM3s8N7jdTbY7742QOOUUdTou7Vsoc4U4xnLGce5eNYNuNh?=
 =?us-ascii?Q?o1GAip1X1ODDNzYK8wGZu++zgnQBhfO5h2hSqkXva2BcdfHOCpZatXIU/eB6?=
 =?us-ascii?Q?+SBKM/a5Eufgivir+/gI7URczvvRGHowxjKTtYCneeCs9AT4Cr8Dd+MGS69p?=
 =?us-ascii?Q?rHxR+hC8pgG7Ehcsym3KdgtYc5cQpNGVlm2YmCi7AnjQeITNG9Uoaj78Q5YQ?=
 =?us-ascii?Q?xoZh0U5X6fbS6/MmEzi1BF2l/EJYbnjbttYWO7VQlEkYE/01V4Y/BZXhnnQ1?=
 =?us-ascii?Q?lYVe7j6AfOmW752NEgi/7zXKJ8wzbUX1CoEJqi52Iu1t4fMffpobd5R9B3GD?=
 =?us-ascii?Q?eM/50khyKQUqwlWctI2QEJsGHURoXMDLkQnt4UJStJ4qv54GNVZrfcIttpNr?=
 =?us-ascii?Q?Vxm6TJu+wb4UgxtM5xSWHYVPuqDJbpBfthAg1wajNKTq9oOmE+X08J7cplMM?=
 =?us-ascii?Q?KaDzeKH0Ol9WGBJZcKfkK4QQe811pp3d6HQoZzuggKEj++Xrq4PDFAtss7QR?=
 =?us-ascii?Q?E+xhRfRyfxEJjDCySHO3t9d4WLRu60cXjFUj0s/QgZPHUnjlKjYWw9hlIQFJ?=
 =?us-ascii?Q?ouRcl9WVpqrPVeO35GDXHNVLILSBwgUjZ5ejGGeod2cnpIo9BgeaQUpSUjo2?=
 =?us-ascii?Q?E2YpOfbzwYNN1OsAopwWv3vtjwy/yMJPrNwAZkzGaqlkpl+qXuyb44JAsgM9?=
 =?us-ascii?Q?eOiSnjt6Ah2B3w/H7HfiY2rLpUU/+DaZF5Wtz8feenPddT3l1cWb26tNpZEY?=
 =?us-ascii?Q?Z+XROPgahtNpjJ3lT1F0d8bq4Iw+PqrRwnaoLUNxsMjXsfvwPVmd/R7J/ZZc?=
 =?us-ascii?Q?MZEzgczq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2020 16:57:52.0097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: d36cd2c8-e7b9-47ba-cc16-08d8ac1ae148
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NnbHa7tyIR3LcZs7HXEGpPgpLEwyoe5iucBLRHFPyev4LGHgPY/1jtSMRiGAM/4TV5+8Tz1IhG6Tc/GM28qUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

The stack variable "val" is potentially unpopulate it, so initialize it
with the value 0xf (indicating an invalid mux).

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Dave Airlie <airlied@gmail.com>
Cc: Josip Pavic <Josip.Pavic@amd.com>
Cc: Bindu Ramamurthy <bindu.r@amd.com>
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
index a46cb20596fe..b096011acb49 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
@@ -470,7 +470,7 @@ void mpc1_cursor_lock(struct mpc *mpc, int opp_id, bool lock)
 unsigned int mpc1_get_mpc_out_mux(struct mpc *mpc, int opp_id)
 {
 	struct dcn10_mpc *mpc10 = TO_DCN10_MPC(mpc);
-	uint32_t val;
+	uint32_t val = 0xf;
 
 	if (opp_id < MAX_OPP && REG(MUX[opp_id]))
 		REG_GET(MUX[opp_id], MPC_OUT_MUX, &val);
-- 
2.30.0.rc2

