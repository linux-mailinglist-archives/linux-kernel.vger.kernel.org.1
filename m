Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68D8274EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 04:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgIWCT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 22:19:56 -0400
Received: from mail-vi1eur05on2045.outbound.protection.outlook.com ([40.107.21.45]:10465
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727031AbgIWCT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:19:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEYXrnZbQabeOslYWUsSPJpe2HD46S/Y+wwcqLESDCXQ0cDcuGqQAkfFx5Pw5iZa2LemzX4/CcsIPED6P3M+AoobjWs8Qn3HDX5atn9rxZSlwf8xky2oiQaeWbjmffCguWIHhaxMAhMOSmqm175Mo1uOdyipUBJWXodzQ3PhC7Kk11Nmp60eraoYozTmOKNwTJXt2VOR/vmZBFJl6GFBKx34fmLHzhk0wiielE10g0J5z/1/gz6wk/3JTEGCLZV2Zi1ZqrlKKHVnBOacb+PIrwOY4jRSHGc3JN9plnJRGlqP9Y0JqhPW3DEK8z77ERIxQM2/rcmhA9AVq8isHAU4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66m/OgZDHWwTnlYOUohSUyFcCmk4dbbUNgyPOWNYyZk=;
 b=AhzgBGtAXJMTzSsGHJdpuLbmlOF5PUx2Kl3ImwleMvHSuyQAItTUMAT5Fg6Tik9lxKvbfOGjKGrRFiCWec3a9XerTcAMcvGm3FSsS07B7tmsiBSfgc+6WwTQMfKcmtH5ts4rDBnG7h98mPjcjReiIE01sQ6o4M3C3qJxnypkbXKycM8mzHoHmiTJoApVkUn4VlqKpjTRqrYj2QuXcBRBHPZYVrQfMyLWj+0N6z1Sp0b9DKckmKu+dKQe2PDKANcPqc8AfFoOwer1y7YMo1M31X7/ZFPl8F8YQnf7fy04I74R3dNq39T3vHjOryFOn/+mMXzQnZc/uE9A1oINCSQuMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=kernel.org smtp.mailfrom=diasemi.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=diasemi.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66m/OgZDHWwTnlYOUohSUyFcCmk4dbbUNgyPOWNYyZk=;
 b=nRx/WMeDODxCCW3wNtfTTmUjVZU2EaNjYxxF7ZKyyr+MaCsUjLi43Zs495JirFW4UPwRWO/hIkkc1rVbQkb5GQ/xjpU7qfBZX8RHS4eK95suZi6R8m697NquMzU1mEQYNZ/dx4m+uOaW33q47EvHN+L0LW3XoXfbR+Jgr5fYVYY=
Received: from FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::10)
 by AM5PR10MB1618.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:1e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 23 Sep
 2020 02:19:52 +0000
Received: from HE1EUR02FT044.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:d10:14:cafe::69) by FR2P281CA0023.outlook.office365.com
 (2603:10a6:d10:14::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.7 via Frontend
 Transport; Wed, 23 Sep 2020 02:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=fail action=none
 header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 HE1EUR02FT044.mail.protection.outlook.com (10.152.11.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3412.21 via Frontend Transport; Wed, 23 Sep 2020 02:19:52 +0000
Received: from krsrvapps-03.diasemi.com (10.93.17.2) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Wed, 23 Sep 2020 04:19:50 +0200
Received: by krsrvapps-03.diasemi.com (Postfix, from userid 22266)      id
 902F213F670; Wed, 23 Sep 2020 11:19:49 +0900 (KST)
Message-ID: <c781c628be6937f78f2b613f11f4ad78522c825c.1600823131.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1600823131.git.Roy.Im@diasemi.com>
References: <cover.1600823131.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Wed, 23 Sep 2020 10:05:30 +0900
Subject: [PATCH v20 1/3] MAINTAINERS: da7280 updates to the Dialog
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
X-MS-Office365-Filtering-Correlation-Id: fa38c5fa-5e81-422c-e309-08d85f67279c
X-MS-TrafficTypeDiagnostic: AM5PR10MB1618:
X-Microsoft-Antispam-PRVS: <AM5PR10MB161815387A2C88A3CC6AF92EA2380@AM5PR10MB1618.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lw2jh3uMKT4JY4sOyVm2ROAXajysgE+Ll3HWUQxnCyc2KpPdDCFh+TBRrIVNXDJ2xDwT1Qn8GFoCoa0AMoQMF6ObZ0H1eGXtT8S9gJgaZE7GgU/T+lAnn/t31WguQXynR97dKO5XambRfFYyvNjb7CpSF5Wib59a9rgqogW/DGtvoYM+eoAz2Xkz2BCv0H9/RL4IQr5WCRRA7lJs+eL41HX182xKJd/x4FQc8RItNXRr0DhVwu/MiyEiOJKI4fbqoniTkTCpFqLefxNJiN6s8Y+okSJVRZ8gBiWkii/KQSPqAk6V5DIX2bslmCVfaqd/NLt18EooPvE6aU0extXqAB2iLiXed6RHTloS70/kcP/MRh9Cx6cY4L8Vf0mCxKWacZ62KKQLwUV4yIFx4H04ppDy8ZU5bhTu+7QiDuSfVBeCVtdOzenRR6RJebgondzIrKmpiFyLRlwcNJQqblzIBgTTiux+mFcy0Vxilu7Y6MlVIDe2QHAfg/uDiCAHXEUPAbENrkVNAzODpEwd9jLjRMjHC+/NlglmeeAvX/FOMHeBOAIczy6ALoTN+cHpOjCk
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(46966005)(107886003)(4326008)(426003)(54906003)(336012)(6266002)(966005)(186003)(26005)(86362001)(47076004)(36756003)(356005)(82310400003)(83380400001)(81166007)(33310700002)(478600001)(82740400003)(70206006)(2616005)(316002)(6666004)(110136005)(36906005)(5660300002)(70586007)(42186006)(2906002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 02:19:52.0839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa38c5fa-5e81-422c-e309-08d85f67279c
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT044.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR10MB1618
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
index d746519..6eff440 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5081,6 +5081,7 @@ M:	Support Opensource <support.opensource@diasemi.com>
 S:	Supported
 W:	http://www.dialog-semiconductor.com/products
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
+F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
@@ -5091,6 +5092,7 @@ F:	Documentation/hwmon/da90??.rst
 F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
 F:	drivers/iio/adc/da91??-*.c
+F:	drivers/input/misc/da72??.[ch]
 F:	drivers/input/misc/da90??_onkey.c
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
-- 
end-of-patch for PATCH v20

