Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5F828CA14
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391332AbgJMIVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:21:08 -0400
Received: from mail-eopbgr60043.outbound.protection.outlook.com ([40.107.6.43]:37793
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728702AbgJMIVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:21:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8mOFxsTES32D7W5hxssb0J9F7E9JgLBfqs3f6pupRTZ60d88Pa0URbzUpkbfOEwHDySri+GMKZfI1Rpj5z7IQI2zW6uJ5Wi2PxJO6flrxM9bdzHWuAGveCTjdYnnrFrV+6n9O+QI8uDG1CaoPL1nszqYq1z/KIdUYCmrYlwfw7lJj1AIoeOpfATWA1h+JAdhFV+DGiEEoZrNiUYVOeWdtDisbRkB99BhHkLE7kwRcJJL8UnTun023Xq7uS8HaAUJkqjUJSAm1vJzg8rD+Ndb5o2kxsUwsZy7JlBcFu61cpR1GcDJp73b6WBUJSC4wtrSOGVISnYrphi87bwzvw4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQ26sEIa9PyHTOHgpPrFu3OKfXQJdz4/I20DPaCiXoc=;
 b=RaFZK3UMjxt6+X1BZv01OU7W3ExG0/ViEzOCD0KBBaqZ7W8Rtxq/prDDQj1ZmJePafYsMsZGSAfQZJJjrfXIF8HsQgoB3ZuWFAQpjDRLLTvDnELeEHNd6pNmKrKPybIunRAZ9e+ft/eX04GkRjxJEkQPEm5da1OjhU9DdGwde1BpeImeHF3WNNrbxBg3sGO4YEfZSr7sSALyjsq2xy/Qi0dBYtPfu8hdpEzhR3CF9sy8hSnw6l4zwehJ/mO3U1DX1lEaXLX+ww5lzwUvPVylZALH4e4hW+seZ0NyTf1lHZuNKs/zDJki7GCjvOc88LrFErIa4JQ9uTgopybRmoWTBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQ26sEIa9PyHTOHgpPrFu3OKfXQJdz4/I20DPaCiXoc=;
 b=VZwo9YZ1Van38ZD9fVQhM9LCWmIDl2Pp5zfGAYwrME4rlyXu0AQsXsX/TwTl7LYdn2LXdKPjL2eBCdnipieW5WfX/At2Rp/PMes2f6xmydrstlziuwXslWssEHjkW468yzvY7uwvt2u1ifJPkRyFuQkkDUOVt7yb9bVhI1N0/iA=
Received: from AM7PR03CA0008.eurprd03.prod.outlook.com (2603:10a6:20b:130::18)
 by AM6PR10MB2600.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:ae::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Tue, 13 Oct
 2020 08:21:05 +0000
Received: from HE1EUR02FT012.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:130:cafe::34) by AM7PR03CA0008.outlook.office365.com
 (2603:10a6:20b:130::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend
 Transport; Tue, 13 Oct 2020 08:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 HE1EUR02FT012.mail.protection.outlook.com (10.152.10.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3455.23 via Frontend Transport; Tue, 13 Oct 2020 08:21:05 +0000
Received: from krsrvapps-03.diasemi.com (10.93.17.2) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 13 Oct 2020 10:21:03 +0200
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 DC43C13F670; Tue, 13 Oct 2020 17:21:01 +0900 (KST)
Message-ID: <1b93a70156678278db12601855a198bd1257b9fd.1602570380.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1602570380.git.Roy.Im@diasemi.com>
References: <cover.1602570380.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Tue, 13 Oct 2020 15:26:19 +0900
Subject: [RESEND PATCH v20 1/3] MAINTAINERS: da7280 updates to the Dialog
 Semiconductor search terms
To:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe9f3c91-378c-4842-a432-08d86f50ee03
X-MS-TrafficTypeDiagnostic: AM6PR10MB2600:
X-Microsoft-Antispam-PRVS: <AM6PR10MB26003CBC7DA4CE75D661B44EA2040@AM6PR10MB2600.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u7JzVkqpbdnKq9d7EXoh/J/jSG6lmr5CHIu5/2cC3n00DwFr7aVjsIBnXONXSLEVKHEb9sq3NhfEWHas1Y97+LORcBK9VLZGDO97V6MWpmPEEP3SqlJ+dExrzNi/hkjQ2vryHZ0fMwCOu/jLpgRXPr7s6OeGWrrYOFNoJXloI1i3Wfkwc9amJ1VvywgTRUlCiH91FHbCjV8vf6SY1A2xD7wDMx0Qni+R+b96x+P3FCYDBVrHKb2nENG++hOBxgNEMxD75mwRsRrwZUOR76YD/k6e5PBQrejZoP6efHu5ybv8XFS/FMZmEC1nLgSo/4AbrXg56lQIKRw1K7Ho76vG0EgP4V7k/yiLwx2PH+EbCI3cq01jUVo9cj0D2zw8xBfX5EpM2dE3Q6HPavF7DQ0hlBF2OjYTAVWtJHQrITToObIsgm/Sy7tUc0RshKdpLEcoOP+fn28dT45c79xhw0RdAuG7o0MUW6h4b1QhHstcgueR0AMANgph7F7sgLOocKsV
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39850400004)(396003)(46966005)(8676002)(6666004)(86362001)(966005)(33310700002)(107886003)(2906002)(478600001)(426003)(4326008)(83380400001)(47076004)(36756003)(2616005)(42186006)(70206006)(83080400001)(81166007)(82310400003)(316002)(54906003)(6266002)(186003)(70586007)(36906005)(110136005)(82740400003)(26005)(8936002)(5660300002)(356005)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2020 08:21:05.3538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9f3c91-378c-4842-a432-08d86f50ee03
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT012.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2600
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the da7280 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
v20: No changes.
v19: No changes.
v18: No changes.
v17: No changes.
v16: No changes.
v15: No changes.
v14: No changes.
v13: No changes.
v12: Corrected file list order.
v11: No changes.
v10: No changes.
v9: No changes.
v8: No changes.
v7: No changes.
v6: No changes.
v5: No changes.
v4: No changes.
v3: No changes.
v2: No changes.


 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8671573..f206d4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5080,6 +5080,7 @@ M:	Support Opensource <support.opensource@diasemi.com>
 S:	Supported
 W:	http://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
+F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
@@ -5090,6 +5091,7 @@ F:	Documentation/hwmon/da90??.rst
 F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
 F:	drivers/iio/adc/da91??-*.c
+F:	drivers/input/misc/da72??.[ch]
 F:	drivers/input/misc/da90??_onkey.c
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
-- 
end-of-patch for RESEND PATCH v20

