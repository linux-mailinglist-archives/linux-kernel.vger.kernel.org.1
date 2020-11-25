Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BA32C4547
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbgKYQcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:32:52 -0500
Received: from mail-eopbgr150088.outbound.protection.outlook.com ([40.107.15.88]:41262
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730719AbgKYQct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:32:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4EZOxNTnoHwjpp575V9vEucuJcudCrHhdtjL2RAanRsn2/DWUHsrYxZ21QSxh4TIciNGgB7gtWFfzwkT0VewBvHk/U5IShkwNdmmqmvpLSruGrlimfdERHIgEOlecZgBsLlNUOFPa+DQrduZ9hLtvK7mnChBIB//s8XmwdG0CxVdGGLXyTWvdzctSgx5JQbL0mZLvZtwfBb2tvIT2OpWGAG7g8YJE4rbgVWqDrY9u7mxxic8uinEFN9u3qQ8UqOXGaw/EEtl1QzCdw5cmk/R7y1q1zA2fzqjlMrPUQf9VgBXwJhuhUcvhQXyGIf7aJB8qqy8cFLcZ0swjvg2jAnOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G2FdFDAa6W0BAQEl5iQZWQwDci3Hvk2LlQn4bMxxEo=;
 b=GFHAlnBlZZw9D01uitcONciPdbbkCn0BMt0Ifj4U4Foj2YhLoPgowKzYbtNqO9FfRFlBQMGxIHpwxJoB1eHGrg807B+DXfYxiv6iluokinf8akrpnPpMMnl60ZjrLVrgJeKK61ZuLnAgu1AFHxSmUpa8k3Hp/VeBzN/S/OPtDY/xdK+uCv8CfBJja5vN7L102+NDm73Q7YYqDD3BF1Jn7jBS/vkgCjRJBOO7bgs9KJ87bnOsEIkW5mC4SXtGeVc+v/2wKzgLTbXIjQ3LziI+LIjo9TWvIIX4Oea3pBu8K7j0ZrVTZX0cVf5F2pp1Dod/YgHVAI2lCTjtOG/iJ+oe8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G2FdFDAa6W0BAQEl5iQZWQwDci3Hvk2LlQn4bMxxEo=;
 b=BVfUSxZzBd1vFD+ydYMsMcA1J8SBzaLMVRwItY/iFjQYY/zFbLD/HbUutHip60vUqqiKonVRNzhyQ5UoBcOIO2eX6KajOCnnxdFChLSnMD/1TBPO7dfkmiQIxq9uzRCCgaVajq8veaxLC+cs/8xw00Wny2Ow6Sg9NchXbMs4uQA=
Received: from AM4PR0202CA0021.eurprd02.prod.outlook.com
 (2603:10a6:200:89::31) by DB8PR10MB2874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:e9::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Wed, 25 Nov
 2020 16:32:46 +0000
Received: from AM5EUR02FT028.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:200:89:cafe::7b) by AM4PR0202CA0021.outlook.office365.com
 (2603:10a6:200:89::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Wed, 25 Nov 2020 16:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT028.mail.protection.outlook.com (10.152.8.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3611.23 via Frontend Transport; Wed, 25 Nov 2020 16:32:45 +0000
Received: from krsrvapps-03.diasemi.com (10.93.17.2) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Wed, 25 Nov 2020 17:32:44 +0100
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 2997213F672; Thu, 26 Nov 2020 01:32:43 +0900 (KST)
Message-ID: <e2a01173699486519f8da85b9283c6af8481fbdb.1606320459.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1606320459.git.Roy.Im@diasemi.com>
References: <cover.1606320459.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Thu, 26 Nov 2020 01:07:39 +0900
Subject: [RESEND PATCH V20 1/3] MAINTAINERS: da7280 updates to the Dialog
 Semiconductor search terms
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da6639ba-d093-4ae8-9e03-08d8915fbda1
X-MS-TrafficTypeDiagnostic: DB8PR10MB2874:
X-Microsoft-Antispam-PRVS: <DB8PR10MB2874832ADA96B719CE8DFE37A2FA0@DB8PR10MB2874.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ikZVox/kq3QjAAZ2PbxO47+6SxAglD39j5gsy2mPVQAM8XZ4yaq45D50xHpBww3wz/i2pG0iIl4pM0m+T739+w+4lS0DhnIBO4F6qveRCuxh2ZBWmErY/dgwm98y/RiKG8vhaJl421jZpZzXDXbXKuEI0X0QThHnNGANim/1WPgin4fAhgOgeQjuzoysiR3YrY7fiAhW+3LlhI3kL7W6LoouzRcWiYCoAefE5xeGL3jffpJE2uU9EC1LBLKlwAZwneB78hFF/Nn69BeuZYwQlqgGsTjKUpk+KK2lZFEtUAHCNKVHDJ3X/dRe8dCljqr7v+SDIQJQ2HMasFR+RQ8XbI3sUz02X6z8mWC6liUhMC3OgflF+cWdSqgJez3gg4DHZmhKpjL58zpJXxaRqeE4ovSsDidfO6KVjLi/ObQDHBshLsDsIjslcxTOmM4GABb0IPQzquqLFWEoQ6TMha8tnIc/N/6QtYo/BXkQ9ClEZf9MBo/AxOlX5ptC1ISSf/mZ
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966005)(2906002)(8936002)(86362001)(8676002)(336012)(70206006)(426003)(5660300002)(70586007)(6666004)(36906005)(6266002)(42186006)(81166007)(82740400003)(356005)(36756003)(26005)(316002)(186003)(110136005)(82310400003)(2616005)(966005)(47076004)(478600001)(107886003)(33310700002)(83380400001)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 16:32:45.9842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da6639ba-d093-4ae8-9e03-08d8915fbda1
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT028.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2874
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
index a008b70..389d6e0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5107,6 +5107,7 @@ M:	Support Opensource <support.opensource@diasemi.com>
 S:	Supported
 W:	http://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
+F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
@@ -5117,6 +5118,7 @@ F:	Documentation/hwmon/da90??.rst
 F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
 F:	drivers/iio/adc/da91??-*.c
+F:	drivers/input/misc/da72??.[ch]
 F:	drivers/input/misc/da90??_onkey.c
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
-- 
end-of-patch for RESEND PATCH V20

