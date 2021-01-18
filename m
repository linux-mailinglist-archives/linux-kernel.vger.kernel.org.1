Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18C52F9868
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 04:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbhARD6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 22:58:48 -0500
Received: from mail-eopbgr750040.outbound.protection.outlook.com ([40.107.75.40]:26509
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731849AbhARD6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 22:58:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elwHDrWR/NeXV1KTpWLwPGJIsZ2AQZbngzwoFA+eGyhUO7O638T2tlI5SEzfHqC+jAm0/hz/O47dpzu+8s3LDBsfPkRK/Yh59Jw7B1X8Ba4V4udiShKZtSitTBNL9yvk4BPu8dnzzZtNpR2I4gw+8H/UTt72eM1pBdcn1wgDDeOajv6zEqOhGgxFpt0iYk1H1ESpXTeiueO8vbJ1lsAt/wg0Qk2SpKA1pOJEuAckjT/US/J0ZmGtnxfteaw0apVU8/y+G4ex+dgkGShrhhObfb+ubOs5roiJcaiq78fJOyNxergDlbMrH5g/13b6vZhRPbe4SN5uo//KbJS+IHaQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/1bqC1k2pJPQzHsSO4pkjuiAWghSqRSrVKVmdSGCDI=;
 b=RwhF5bRVrVq+Mw//hMfJ7YgXTk15HFoenRtDqzkyog0TC4fLv/4zKVN/qAE9cTc9FVmiuO12Uy3F1Qfz018lL3NKajgEaydnYjI1jeVPdhf3Y/TOwI/U3sC4fU0wjTxSzI9xB7TI7JjA/yL5ObgDDvfR/1og6FDQLr8CRIgD3ayJJ2IUZNsWUz/Rqok0UPEe28eAxm/ebr/a+Jo4lnkGKtpwB7SZ59vsu1RwJ9epGvQX/zkPsD27o88kkCt5tCOhrQRL61AX7ElUkz6SeoFsloh0pmlDbGMd5oIUYiZyMYi70mMtB5oQIeiU0qlfGWgIimasoWZ7zipbBYlR+jl3Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/1bqC1k2pJPQzHsSO4pkjuiAWghSqRSrVKVmdSGCDI=;
 b=A2ictPwRymD2Cup+RMlntc1whYJW1bV535l8kTYR0XWOcrldyz+xQzq/MXWV/nuki1n8VrAXRFj5bEnm3X+n+ncuye+Sr/wgO+hBXqmqaLpWF8SAE1Q9Ff3d/137ZEvXmfaVfoCACdddpoqFHiR8px+W/KNAnzpqtiBYxTjfrAA=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB4878.namprd08.prod.outlook.com (2603:10b6:805:75::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 03:57:44 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0%4]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 03:57:44 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v2 2/6] mfd: iqs62x: Remove unused bit mask
Date:   Sun, 17 Jan 2021 21:57:04 -0600
Message-Id: <1610942228-7275-3-git-send-email-jeff@labundy.com>
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
Received: from localhost.localdomain (136.49.173.128) by SN4PR0501CA0055.namprd05.prod.outlook.com (2603:10b6:803:41::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3784.6 via Frontend Transport; Mon, 18 Jan 2021 03:57:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6f8e488-f3bd-4138-1b65-08d8bb6535fd
X-MS-TrafficTypeDiagnostic: SN6PR08MB4878:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR08MB487852F07F3A9524C2A8A237D3A40@SN6PR08MB4878.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOVJVTeAi77M+eJzdBn1G2QkKjf6MtTRH+2dnNXXmq6cmcajMVbuV1OWI11l9943XHdxTt2GZGcVss386xl9elMMHnbfdowuzABjh/txzaKsjOd+EU7WxUtezA/r0X832tSi+jlDgnMYQgjj7SjBvbDqFCVLo/YKkkpCeRw1wnJUfmCw07FgPJAefKyBh4k11g8S4z9LzYcAnpV1YxZTonTMJmJOjBh7BX18ugMR0tKIdnpgU8DQvpGCvTi+8J5qTnvj2bJJRWHblK4sAfKBQv+QVPxvHDYGjGeqjs28Mjz1aLapJrhmqRIUyIgIDxdl6v7hQp6HaubTXjYCj4OVucp8LE+5eQZecfr2YkXYSs3gHRwBvJspCZ7C0EIaexWxhS/rmdwCy6RSo6J0xVgvH2LT5gcpgdazE7WgTJtX+GtFQ3XAS3C0mLXvvd0eI/tX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(346002)(136003)(366004)(376002)(396003)(52116002)(66946007)(107886003)(8936002)(5660300002)(6512007)(69590400011)(16526019)(6666004)(66476007)(478600001)(956004)(316002)(8676002)(6486002)(6506007)(83380400001)(6916009)(2906002)(4744005)(86362001)(36756003)(4326008)(26005)(186003)(66556008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FCacn6pRX9ERYJC+p9flZwjwUwakliocKOijm7e0giP9BRbC/UwjOAV9Q98c?=
 =?us-ascii?Q?dgucKyg1SP7ekfL3alMGyroD87ix+du6ngpmJWeY+BkkB+0WEcXS+YhPIGpp?=
 =?us-ascii?Q?/BdwfvVXhtSFpHiGemFeRrBYmW71hkptWOGnL0QTyb+zawIxoCFaf3sMNiLF?=
 =?us-ascii?Q?Difj7UHLugbTC9gvQpCguCSZyibX2zI/3fzaFhEEEsdNO4KKWF4hEp4boA1i?=
 =?us-ascii?Q?EwEYc3TzsCknBRAPLxp8A+v6ejiQXuSz/d5O4V7WFVnsM2A7dIZ76la+y4a+?=
 =?us-ascii?Q?uawFgcvvTjSkNqIGdNcUl03oyggRnyZXoKnBt08kScNaiqHxtwSWVMYqYa8P?=
 =?us-ascii?Q?69Q3J7tLK3bWvLVDaAO+JnW8LA8NoKAuj6d8TldU4mq2X2zDMBXBBX5HuyHH?=
 =?us-ascii?Q?l4T9DgTsfL060HHE+g53jekeYOEmtu7q36eqIxZ4AMiomerpOAu9oF61Vy6P?=
 =?us-ascii?Q?eyjN4X97YHdC/dKthfaKb2aROm89J+yi45Lfa+nfDs9PGS7qWhmogrxTL5qL?=
 =?us-ascii?Q?i/AglO4+vcerH21qaHMc7oBoKU8KolOxgL31hDYeqyHgQJsGrvJ8M+Xu5Lo8?=
 =?us-ascii?Q?PTcE1Srb2m71lCVp+HB0xg+NaI+XyFhMWxEGgiic2jJP34r5GexvF7Qjj0kz?=
 =?us-ascii?Q?RPVCjcfFfdPrZRL33Gi0Q7qXq2TQhUNep8/7lpu9UIuhD997BSAtiD/tzW3z?=
 =?us-ascii?Q?8y8HCAqpxCRHY0pWyow2+xsc5Su9f2Cr3aNty+DY9rPnj4BekaCNoHyDMdHz?=
 =?us-ascii?Q?I8lyH6nhk6+MeQ/4JN3lXiABFEkcQWRisj1XNkobdl9+hHO+yUS1et+RCtdj?=
 =?us-ascii?Q?LPAL2MoXdLGFwmSgArrfWyksMLYJJaazfQWQg3y4/aB9NnhZkZYrnkSbfG5K?=
 =?us-ascii?Q?m6QPMT1+5DeZP0/uc76wFtvqB0hQgYo3+hdnCrMGpBht3DaZEMj419n7dYbV?=
 =?us-ascii?Q?tRDNRPAXsL26jTkL73Ovkc4xz+wbpvUD3HbH+PU98wPjRfAxrYIOcF3JTx+v?=
 =?us-ascii?Q?PnB8?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f8e488-f3bd-4138-1b65-08d8bb6535fd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 03:57:44.6143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +B1b6z4s6Wh73lbe+22yHYZ1fekdAQrUIp9jL5WzA09NXYlk1Il4TtQv6/JQEqLfBuvUs+f2DKpmUiFGTuyCFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4878
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register write that performed a mandatory soft reset during
probe was removed during development of the driver, however the
IQS62X_SYS_SETTINGS_SOFT_RESET bit mask was left behind. Remove
it to keep stray macros out of the driver.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
Changes in v2:
  - Added Acked-for-MFD-by trailer

 drivers/mfd/iqs62x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/iqs62x.c b/drivers/mfd/iqs62x.c
index ec4c790..ff968dc 100644
--- a/drivers/mfd/iqs62x.c
+++ b/drivers/mfd/iqs62x.c
@@ -57,7 +57,6 @@
 #define IQS620_TEMP_CAL_OFFS			0xC4

 #define IQS62X_SYS_SETTINGS			0xD0
-#define IQS62X_SYS_SETTINGS_SOFT_RESET		BIT(7)
 #define IQS62X_SYS_SETTINGS_ACK_RESET		BIT(6)
 #define IQS62X_SYS_SETTINGS_EVENT_MODE		BIT(5)
 #define IQS62X_SYS_SETTINGS_CLK_DIV		BIT(4)
--
2.7.4

