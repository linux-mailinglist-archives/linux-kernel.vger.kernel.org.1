Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4145278186
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgIYH1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:27:54 -0400
Received: from mail-eopbgr10048.outbound.protection.outlook.com ([40.107.1.48]:59876
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbgIYH1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:27:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7sHDhielF2H5+Sl4tD5zSnr5PByM/OTWHzmmcmyDf4K5Qtyp9l5geWbRGDXS2YgIcE1en50pQNOobXJ8nTcN6aUQutR+WUE3w50t46WsdzLs1etKcjx/zyq6w94DolAIWtmxe7bDvCndTJOsbg6Cfa6i51jrHIQgen5JBYW5orJ1wXuZftvp9dSc2tT7lVa/mCk05jm0QoDwTf86tjoyOexgjUv89kkEWOzHi+vsUTGYPPv3waC+KVxQoIwTPrcEB3gUNv/9PovSGodziEJaE+nkRc9a/gFNfkJzPdvqM8+Y1Xsnp1+HuhUyfkYuAUUSXagQJyE6JkvjFTR0xmLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhFPpn2g9q+1UuduzRXh0hGTnhQN0nYdNw6Zx/ccC7E=;
 b=IrnMkviQtE5LzlR/VT2Wulby1ctZ/mAbdVdn5kT4jAMUZF7jvzXSrepmxBnPAhiRsAmiWwbEoh92cJks2O+se0huXg4n8n0foqxucNJujRHWCV+JoiO44lZ8IS0VmkXUIygD1ndqktL+tnL0eMQJmTHgODzBDtk5m5vXh+gkoW49+5DKOXwV7Xnsf+Lr6da7FBLhRFoxfEhGY0apip95ylpXUSc7jQv0TvkUeDqqwOKakI+TU+95csTfOGt+IRnyXrWY6vwRZ0gcLs1FUfQci7n46Eg+szzBWHJJFOSCozldAEITRw3sOyriS8+Xxjiyx68qB5oeVkCc6UPHT9LKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhFPpn2g9q+1UuduzRXh0hGTnhQN0nYdNw6Zx/ccC7E=;
 b=KXjArw8CqiRFpUTZZRn2kIJl5U5FWrZA5gO4rCPmeQPWuH0Ce8mJP/tY2pmkqxrcNtIsU3lOEFj9N4/mw2kHw9ihuaNq0oDSquv0U002jScT9U05UE83IX87nJ2VhaZi+WeY3sqh6T2zdvfIT28aDcYNghS9yUaqh8AVggK0P+Y=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB5919.eurprd04.prod.outlook.com (2603:10a6:803:eb::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Fri, 25 Sep
 2020 07:27:48 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 07:27:48 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, wang.yi59@zte.com.cn,
        huang.zijiang@zte.com.cn, rikard.falkeborn@gmail.com,
        lee.jones@linaro.org, mst@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 4/5] misc: vop: set VIRTIO_F_ACCESS_PLATFORM for nocoherent platform
Date:   Fri, 25 Sep 2020 15:26:29 +0800
Message-Id: <20200925072630.8157-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925072630.8157-1-sherry.sun@nxp.com>
References: <20200925072630.8157-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::13) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23 via Frontend Transport; Fri, 25 Sep 2020 07:27:43 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e842a6f-1385-4220-ab2a-08d861248095
X-MS-TrafficTypeDiagnostic: VI1PR04MB5919:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB591903934F03E57FCFE4320092360@VI1PR04MB5919.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z5+uAbRDAatAfUh+oz42jQwVx2ewDR587b8X9IJWIOPUvuieBUGNAupkP/8fXgAglqsc2zdHNJOe1ZU1V9VjG4g2G9EkWu54eU6KLyATCFi8+r2Aqm/311tUMR50UStiZfXrAASsfSgMb0iwlfZ3vscuUx7esjZiIEbOqJ/pqdoHRXoQTjmuZoN55Ty9AMQkDpdu6CAqz/J801ANmKV2EOKj3/FSZQjwqbR3L4nvEnO3tbKS4YuHo4Vzg2IFVZbFPzWYqbDxf3RcD1dNpPI86jSzBnO+jWDlYNcYYaePJe+vLlRO6YQFSFAIkLV2WRv767vMkI+3IoN5PHz37EZnoT941ytbYDFAygUKcb80uIztHShB3XdKmqYr34YUOCt4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(6486002)(8676002)(4326008)(6666004)(7416002)(83380400001)(8936002)(1076003)(5660300002)(6512007)(66556008)(66476007)(66946007)(4744005)(86362001)(2906002)(44832011)(26005)(36756003)(16526019)(6506007)(52116002)(2616005)(316002)(478600001)(956004)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: sgd9CPyh3ASRzhxwDn1aadwE+2pcOnu4MggVDiVoMseGR8p7dBPjRei5f+vLUL1Ze899MHd6outTJbD3F5nho7c8ZcOCtFrYoe3AFtVcItZ0lNYULwfurPHcAVAzPWiQRld0DeTs1TAucQx3Fq3goDTLmdTxaM903524WaMOIOfKCTYtlqL0sUJA1+K7DPXLbOI42EjBtpUpDuBhPxKucz6BHzPgIHF4ai8Pq2rnW3k3okQRjit4g87RgI964dnH+QtsLpIyqVOpJfubWWXaXK4yItl/MyAQeDLnAnwSOAmq8xoo1UTFiudwnym92LG1jR3xhD7naclcMli1dnDxSkGvhoDgodmDt9Cg9tDcoDCZ5j0vH9TLE2D/BH7uk4LQoTfmU5+hv0GHUfXu3aW67cBWqux7EnyfpS9ZLR0VrsmZVArHS/WzQXhcWFkO0SbPINVdPmBeDkyuQLvP/x1NiuDhg/pF9xUwvbGy/o3PeFSa0NVc/E7YTArbrDMyzstkqpda4kKArbLCwjJQLuAErw+u4P4aQOR/1zXvHq4uk77ijGRK7kQieJYpLJZdpAafoQuE5QvPdi2q+QPDZ6/A18svGL9qps1u88Urj50AEAjXEKcS7lySKS9v8MjN7MBQ6l72Xjjlogl2MBcIcvNXKg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e842a6f-1385-4220-ab2a-08d861248095
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 07:27:48.1441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXfJuvmJKr0PuKp+g0E4yUU8T6wbQLKzQfbXfRVFTKMIbvdKdZhp7Aq0h7yDTJLV6vfNS8qHWjl9Hrr9VoWBuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5919
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set VIRTIO_F_ACCESS_PLATFORM feature for nocoherent platform, since
it needs the DMA API for virtio.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/misc/mic/vop/vop_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index d3645122c983..d609f0dc6124 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -125,6 +125,9 @@ static void vop_transport_features(struct virtio_device *vdev)
 	 * creates virtio rings on preallocated memory.
 	 */
 	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
+
+	if (!dev_is_dma_coherent(vdev->dev.parent))
+		__virtio_set_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
 }
 
 static int vop_finalize_features(struct virtio_device *vdev)
-- 
2.17.1

