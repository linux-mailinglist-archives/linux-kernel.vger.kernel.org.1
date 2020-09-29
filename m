Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30A627C00D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgI2IvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:51:23 -0400
Received: from mail-eopbgr60051.outbound.protection.outlook.com ([40.107.6.51]:41543
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727767AbgI2IvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:51:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kubaBWVp+GXHNJ0IF+zwU9Qr+KUjQCbJ7l8mfBr4jhaW3amCwva971wDHy+z67Fvf9gHC3HVAKH2XtkckRUA9TdXRBDNsNe55R5tats1ogMhAyRbb/0L+f324LkvtfbchoT2U8YuEAjbnEuFWMCSfVDj84EYvXYBwWpKTov/qe24Bb7C5XdvoBix5NXUfxKwCRnGgF6FCbYduKrpnIQ5lD+zPq9bLpS6J+6BgPNhRUX5uI539vKcmai9DhQPrB4J+ju2b8R/kxIdsYf9T5u0JTkuhcKOEBIh5DReFPidIYkWkC7Zg+yU/A9Wuu6eVfkbO8cal9wAPsPVLei/Zh5MfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6HhvjT/8nVQrx1wxW05HfbXgxwOamED8B40CUxMzEQ=;
 b=odaGECn+ZW1w38BUmrBE6+8AFh+ZpZZu7D/RxHKQkpl0MeRBzjG9C/MJ7qcHU7+Q/nCgIof5hd2ubLPxCYwY5yJkbrDOd60sk/kAxVHdhPKsS3+09xOxmOgOswETSjuhBIUttaNnOuB1ONyJpXplGG2fTB9dWiDNboRkOi6TxvY4T5cwyAMw/RgVOJDiayNQCY7vqJ1Vn+8nl+wFep6VbTfBiZn7U4rujsoFQjp7WtXsoqBPWbZ2E5z6yWIiZkP4SkdgXpGTSK7CkNmaZhtRSuI5DpRTrUFf4T6Sc4Tz5luo0/jCthwsbW9JicqgIPrt7hgMyQqYm6RoB2f9GQ70hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6HhvjT/8nVQrx1wxW05HfbXgxwOamED8B40CUxMzEQ=;
 b=hE4MAHloI3As6kl8P7dUmLMgeLggn+Mlmr1czncIfRjqXufEs7Yhyy56fEcWgDSzvPJ2itISLxnbdy5F6hqe/YHS3vcs4+HdP2U7jfo1+YNp/iiLJnqAmYb+DQtsSO0IydiN9S0m0+xd0bx1mnhZinbb7iWbLWSDwpqFtf4Xc60=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB6910.eurprd04.prod.outlook.com (2603:10a6:803:135::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 08:51:19 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 08:51:19 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     hch@infradead.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH] misc: vop: set VIRTIO_F_ACCESS_PLATFORM for vop driver
Date:   Tue, 29 Sep 2020 16:49:44 +0800
Message-Id: <20200929084944.24146-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0186.apcprd04.prod.outlook.com
 (2603:1096:4:14::24) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by SG2PR04CA0186.apcprd04.prod.outlook.com (2603:1096:4:14::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Tue, 29 Sep 2020 08:51:16 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab7dbc04-1028-4bad-0a58-08d86454d524
X-MS-TrafficTypeDiagnostic: VI1PR04MB6910:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6910959D344343E8A5973DCD92320@VI1PR04MB6910.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QxVIbeqVjIwljgavZbel071ZEV2tm5+VyjJvLuRqczFMRj7DqYCq+fHJvNk3WiUtvp0J25d/936689m6qQzRVMMqVwNAY1wqa5FoonAT7Q7w9E4wgLYHv1u5wlgal3ky9UG1ixjUMHX1jkDCK+Q1jafLzvVn/meP7DWekd91zpMT9gYE0cJ0hL+yx0aEflSSxBVl4Vd3HwG8iLsuFAd5oli4hOej7R4Mwsyh0zqk8pub7cuZjXg2b+zTIUu1sRYC/eEmzaYnZgOQxbrs7dsM01FHFkPzjZYuE3siBvEwInpsUHXfdfXX4YFXwltymCLlQb+lggO0ZhJ3OMTabFystISM0WPiINQalre+2UCYMBnH+FhzQsDmD6DAcEEL+unr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(2616005)(186003)(956004)(316002)(6666004)(8936002)(6506007)(52116002)(478600001)(4744005)(6486002)(5660300002)(66946007)(1076003)(26005)(4326008)(6512007)(16526019)(8676002)(2906002)(86362001)(83380400001)(66556008)(44832011)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: A0zYINdM/EYJJaAdtt1i4YQlERlKo51fiW4frRRdZHnld2kKyo49V9EuZHlSWYswJs9HDMKSMERA4deWa1PlA10hQeP0kO+OkEF7/DRqiBto1waWzIBEdz9EOlS4uUUY8V4R3s55xG+0vJsDCwLctdSrGmiVo2SfyDnO76QKmlQ4DgzeO0QFFjEwZ9sgYiiPkk4vPwWTOUBAMxlMOSUbedbeG+UOve6X8wZhdooGfT2zonZsQ0QNEm25h6WQVr/EoxDcWeLzglY5L94iBSIwuHf3Hl666v/efROXyRDYPKRkVsOFsKGQnKLJ2fPhLRDnYcmSk3LFtVPbmWGtn4woyAtgSqYrxm47AP9VLR4EP6m08ZzrtogGmGVHpHD9YZt5y4tH+s3QInQZ9ymQfpCtH3Lvh9vRdUqViMZlyZQPy1T9wklIMUBWH23si24n3JgBS5YJ/rDo2jjEI0tse4rndnZXzg8dJwXNtAO+suR/VKGfwKOflh+rapyio5YPnpXnfmpJFka3/t3f8JX0Wm7jGKsQVZSBij4FxbXDUqEGwK3I7jlCM8pwgK+QuA2PP1vICOPH1uwqEDkLrsX+1eb5KChRJfFV2JOyuRJ7BPHCgJ2RuYoHtK+ZHgn5XDvdDlT+fDwj2QbjDof+83E+cEn13Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7dbc04-1028-4bad-0a58-08d86454d524
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 08:51:19.2572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cu0e1M2hnXAqTU+rAdphsKDAc7xRIqYYt8YvCE4qwvnrJEhwcrA3JT0g/ynEw7FnnNLG0JKp/7ZJ0cFmZQXKaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6910
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set VIRTIO_F_ACCESS_PLATFORM feature for vop driver, as the DMA mapping
details shouldn't decide on the virtio implementation, but the host PCIe
implementation.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/misc/mic/vop/vop_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index 6722c726b259..714b94f42d38 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -124,6 +124,7 @@ static void vop_transport_features(struct virtio_device *vdev)
 	 * creates virtio rings on preallocated memory.
 	 */
 	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
+	__virtio_set_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
 }
 
 static int vop_finalize_features(struct virtio_device *vdev)
-- 
2.17.1

