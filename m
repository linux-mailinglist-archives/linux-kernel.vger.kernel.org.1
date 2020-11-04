Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EDC2A5D52
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 05:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgKDEWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 23:22:13 -0500
Received: from mail-eopbgr30052.outbound.protection.outlook.com ([40.107.3.52]:17381
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728431AbgKDEWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 23:22:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pko6qyL/ggc+CHqAMos2nL3374C8+uR6KIhF0vgnXEch9wsLly6/NShNOULigR91MZoo0MzOQp0RasIi7W4yOzEqg7TMK5P5AyGQC1KuSAth5tKH2NXn6wdbKT5P1ZLb7eQCZKEDI3E2/ifBpKfSoIdM6GphC4Ety6mHsn5kVj/jpqXkKEzE+7P6c7A33gOVszwiYQEJEHSDNyxlkFNFhTP0ntPupWrT4oQ7nhwf0Lx8IGQ3L/laDRtwOtezWh6W3ct50VvFBE6NCrlu2XGfrGHjdTc8agRNh6yWwGCZiWmqVxnWtwFL1kkibb6O6PFy1yGi4yi6eg4R+RS6ia5L8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8UYNMRHWJFuO+5uta/T08M+ZueZfMu8jMvyRo5F5Zk=;
 b=DksnkYjlDZFhPphdqj/qH/ttFSuEZ2QjccEw4mPWHSGxyVQPDQZpCI42HuLHI2q0Ef3ApLocSMJJwIOxAAEo/FP15STzrJyQQbzue8UtgffNYm0e2MiqSjgadwTdnvPJ7Trmky+jknJuQJ6aG+VQJBXv/KQTLjKccjoWrTDKPU7ieAEZenD20yXzohL8y7Y6oXG1QvvB6bT4gTkDXK6N2c2lvN02BaMBfOMVbGYRAgYhngWnBll5FsJG1IxhWjfWzkjDKnWpcYTBII9diVc3moEi5RQ9YIHNdzCIMkOu/LEgUU0mPHulwQq0TxXDe+dwYvCame6Qy61iFvkSODQBww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8UYNMRHWJFuO+5uta/T08M+ZueZfMu8jMvyRo5F5Zk=;
 b=Ydh/AJjOBEtcC9S1eC6SfWhmlczAMl6ET3E/y1+K1hKZgv3Vai+lzd2sfYlJ3hReYmsrcK+APFg40FV1enMqk9IcfQaZGN97AHiR4uC4Yg4LqjqXw6b9W9WcdgsrpD7yeCXRP1cUog5BwauqDiZLWhPz17opyhMP+DY0THi3b/s=
Received: from AM5PR04CA0006.eurprd04.prod.outlook.com (2603:10a6:206:1::19)
 by AM7PR10MB3142.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 04:22:09 +0000
Received: from HE1EUR02FT057.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:206:1:cafe::55) by AM5PR04CA0006.outlook.office365.com
 (2603:10a6:206:1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend
 Transport; Wed, 4 Nov 2020 04:22:09 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 HE1EUR02FT057.mail.protection.outlook.com (10.152.11.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3520.15 via Frontend Transport; Wed, 4 Nov 2020 04:22:07 +0000
Received: from krsrvapps-03.diasemi.com (10.93.17.2) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Wed, 4 Nov 2020 05:22:02 +0100
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 605A813F670; Wed,  4 Nov 2020 13:22:01 +0900 (KST)
Message-ID: <d7ebf9ed5df15a2e4cced45b76e7a637cdea1079.1604451966.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1604451966.git.Roy.Im@diasemi.com>
References: <cover.1604451966.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Wed, 4 Nov 2020 10:06:06 +0900
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
X-MS-Office365-Filtering-Correlation-Id: a1f9eb98-5b91-43cc-200f-08d880793111
X-MS-TrafficTypeDiagnostic: AM7PR10MB3142:
X-Microsoft-Antispam-PRVS: <AM7PR10MB314227833D7AF501D06F61B7A2EF0@AM7PR10MB3142.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5nIaQP6pmqYdCVh+YIGH8GR+e9rqxmk7ADGq8K8KdD8ZYGFUPVlHhe56/v6efaAGDh2MREalWOB0QmWuBVpdKpNlRd+V+D58Xf0LspHQI7o9ntML47m2m0m7ZM0SSTt9VRrhCXU5MCFoppvevM9FQ2ONoEJDu3UU71+QeL3IulZOcmPIw9Rhqj3kgzMfphIg5at/BwXB//TikQqFf0bFCnj2MugM0/cRjp11h/1vD1MSP1s8jRpkH1z2kWruBd277stJ3V7AgrhSd9ZNjX+ZMJ5mgohjP8kQo/XE++bJ5Mm9KrLEJmByC2aNeCV0vKoTSeb9qtsYmpiHnXjxYzMKDzwzSg6wL+r/jTzUdf3I/3CiYWW3L7Mm1rdZKeYL4ONcMYKES/HmiJ3GwR6YyGyGcR+6y8l3GRao6ltQSQFoUjZyu3xG5SocNgMfBJaU7z5pmvWDgZp7zl79TALx80IuazIj7kDVi39XTZnOBRam1Tc70SrSuiqbFyw+PzsSVJLG
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39850400004)(46966005)(6266002)(36756003)(70206006)(186003)(26005)(966005)(2906002)(2616005)(478600001)(426003)(81166007)(70586007)(336012)(107886003)(5660300002)(110136005)(82310400003)(4326008)(82740400003)(47076004)(54906003)(86362001)(356005)(8936002)(36906005)(42186006)(316002)(8676002)(33310700002)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 04:22:07.2520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f9eb98-5b91-43cc-200f-08d880793111
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT057.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3142
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
index b516bb3..f64e18b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5117,6 +5117,7 @@ M:	Support Opensource <support.opensource@diasemi.com>
 S:	Supported
 W:	http://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
+F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
@@ -5127,6 +5128,7 @@ F:	Documentation/hwmon/da90??.rst
 F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
 F:	drivers/iio/adc/da91??-*.c
+F:	drivers/input/misc/da72??.[ch]
 F:	drivers/input/misc/da90??_onkey.c
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
-- 
end-of-patch for RESEND PATCH v20

