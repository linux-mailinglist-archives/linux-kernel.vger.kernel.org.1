Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18CF26D8B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIQKTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:19:53 -0400
Received: from mail-db8eur05on2106.outbound.protection.outlook.com ([40.107.20.106]:53344
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726217AbgIQKTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZLMW/hlxk1FwzWVxOl9UF8uIkqH1AY9FXPxFitvDxY=;
 b=nWYe8PBzLRtxG77tfLANdNu1rHRpcLh2L78svh2L2V8sg/VGCO/WyP2E7HfzWY1vLQ7Qmm+ISLkh0ZEzJSp/dFZAiDVYcOpItjaci/v3r9YEvT7t/DMwqS8YFQ+Xq2D0EmHJkkQF4CuZHwt5gELRCMtEHfFyuKHOS30OfZXhRs0=
Received: from AM7PR02CA0005.eurprd02.prod.outlook.com (2603:10a6:20b:100::15)
 by DB8PR10MB3196.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Thu, 17 Sep
 2020 10:18:51 +0000
Received: from AM5EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:100:cafe::1f) by AM7PR02CA0005.outlook.office365.com
 (2603:10a6:20b:100::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Thu, 17 Sep 2020 10:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.169.0.179)
 smtp.mailfrom=aerq.com; vger.kernel.org; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received-SPF: Fail (protection.outlook.com: domain of aerq.com does not
 designate 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 AM5EUR03FT026.mail.protection.outlook.com (10.152.16.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3391.15 via Frontend Transport; Thu, 17 Sep 2020 10:18:50 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (104.47.5.53) by
         eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
         ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
         tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Thu, 17 Sep 2020 10:18:51 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 12642427
X-ExclaimerImprintLatency: 1197914
X-ExclaimerImprintAction: d79d676030824bfc97ad443d6614e144
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZRr05mCjE3uEN2iCfYvyVNsoBjpCsQNu/UQ7V2GFe58pxhU7O1exMXdVQfcuCa3lhUOGa7dBjldONK0/xnrFpd6lM4IE1vJOt19dTS0cQzkAvDgkP2MIXM0VR45GD21vEhQEBW5xzKhUcOP63uvbVBoLWoc8NPCtxJtMvQtoOnx3ISRg/szjJmro1UC8Ub5UzzJHhDw/NxfSg4hUmS9TqVXDmvpYB/nO01g9SYv7ituxaFzcyLlQ+4q01NCy/Dp3SCpq10RcriC/vs+hMdzQRkKoKnmCYOgZJeo/fTBNdOe6spPcwh2e15v3B3rMrvYhu9/60FLEwDrHYhjsr5mEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ck8tOYcvLH+Oy7Ub8sVe8KXlUif/Sclw1PAf8bvttQM=;
 b=g6JuFWw3KB0jn5LF0nNFl3DipIruaCVu7Yxu4idxXFLeALmL/rn+n1JCOZxh6HWSKTWwem9LR7FXRglAKxn8KNhKRiU7DDyVcG4EOqbz/IEfRVn37fiaCWlELacjYYbLncDJSI0uYwb1wjsHtg2JbTGXlERYXD4586/i8t70XS+x+RLat2Zw1E7n0fGQZN3hclAOw5MMiU93xF6fsjDG7ifl4SO3duWiDWju6Voh72WuREU66A80gIzUweY2zVdBvRe1b4yNand9GMLmt1YvK2kA24r5ovqHZcz8MZktmUpQhRUkk9sMSX+pyvtjnZSboL18gybo9Btybvs4ttuTxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ck8tOYcvLH+Oy7Ub8sVe8KXlUif/Sclw1PAf8bvttQM=;
 b=Z4bHe6A0hiHclcre4r37+AHS1+BOK88+5LpopyBnVmG4G9MFBO0ljvonrgPFc4HfGGey/W2hy3kTP3j3KbDqK1rguyyUggaas4+g79JoxTShgcdJIh8pX6KA9nmvD5VWi8f2fFuqe38glprkpaCbG0FP+sUY6cWp1WwklISDk5I=
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:161::27)
 by AM8PR10MB3987.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Thu, 17 Sep
 2020 10:18:48 +0000
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4]) by AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4%7]) with mapi id 15.20.3391.014; Thu, 17 Sep 2020
 10:18:48 +0000
From:   Alban Bedel <alban.bedel@aerq.com>
To:     linux-hwmon@vger.kernel.org
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alban Bedel <alban.bedel@aerq.com>
Subject: [PATCH 0/3] hwmon: (lm75) Add regulator support
Date:   Thu, 17 Sep 2020 12:18:16 +0200
Message-ID: <20200917101819.32045-1-alban.bedel@aerq.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0701CA0017.eurprd07.prod.outlook.com
 (2603:10a6:203:51::27) To AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:161::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aerq-nb-1030.dotsec.gv (87.123.201.53) by AM5PR0701CA0017.eurprd07.prod.outlook.com (2603:10a6:203:51::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.4 via Frontend Transport; Thu, 17 Sep 2020 10:18:47 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [87.123.201.53]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90d6005d-ade4-434b-373f-08d85af31324
X-MS-TrafficTypeDiagnostic: AM8PR10MB3987:|DB8PR10MB3196:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR10MB3196115868CF750A08F5AC15963E0@DB8PR10MB3196.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: TFG3oAJP+rDj3XuDtLQgrwQJJRdBwsQvIqNHzbPXX5WocuhQafqjWAmlcexVRIP9Fe9sqvOs6KkPHwdQ5X0VdnZlw8C5leBtOomut1HvlD1KvH/AdJ/ueC8wh67Rgz+O97aDZyKqdjqr9mjy607e9M79NyMYraFWjFHZfjhfoHR0dExmX3QN5pcUYRHKg2CnjLyyF/kY/AYLzcroCL8Rco2mIYPb8dlUgIZFXXSM+ABMaZrAkkzu00x923R+JQOkbd+638bUTfKiQBB8KQnU6X9noFv0ic3SNd+O5AMkMdiWSHoOTqEXUJQcUX7fZ6XF2yiCnDJXrRd5Y08BgFrgNg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(136003)(39840400004)(1076003)(4744005)(83380400001)(36756003)(66946007)(66556008)(66476007)(44832011)(316002)(6506007)(8676002)(107886003)(2616005)(956004)(4326008)(52116002)(6666004)(16526019)(26005)(5660300002)(186003)(54906003)(86362001)(2906002)(478600001)(6486002)(6512007)(6916009)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 7OjLLQxVLduVNsdU9pqmowMJtaVNWtHDpEsFTi/9eXd3SsRWqEXmm8jMOB0rNPpiQePEJycav/niWputQ/TNYEqveY68vl4oh4kHAVWqm59oSkwANS2Gj+uif/UG94IbZc7nhGyYhcTNsqT2P3kF+sUljGFIdOVh9S6F4won6QL5IFTk7y4B9V0woprSyQ+mdAId8jVl7tXgfbhWbO1ID7B45yopNrwN4rTTNybOmG6bvBVVjugxo4jndRbmMfnu998VUPJKFiXUYkHOars5jHxUb09ySDUIk4xTh/mtQ/1JU9HLVqs/Bww8ON8KaHE1bGBr+1dvDGxMWRpWAWIgiVT+UzgZ+C53gRR0NpMu/3OQO2FdBzah7DHcBUvWK/KstHdY5UJGwTcAd/eXw+Wh1AuwXbFCE44XcJT1YJfI8YIujgyY3hbCY7th1pD4/EmyexVO3IM3RjHMxgRhntWG0kg5baFbjv8/6RukHDwUYAjNvyJmebt10T50Y5+sAqOTrajtd/3oO0zTq6LZTqGLrHtjaCv4OEw9cEJkQ+BO04R6AMXUWzdEaC7yRrk0TT32Z9f4t3AlH7NRb3zS3ppcjuSWzYCJi0Bx4rkj8vu6yelGtzfjXcbQivhhO5nHHkau1ZotIpwbS1aaCYYLO9OxJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB3987
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 10768976-4e5b-438b-7471-08d85af310db
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjDImoynheKYLxYVB5KUU8x8Hjzk6XmflSC3yCsPJ2iLX8YxZ0PSSNRvjGeJg6h7YgDYARnxBMHXN8eWUcVnOPL1OfN5t/Ms51Ejx0316GlroJodXPHYLrdNNORBz/vvMdzz3UK8EJKNXBOhHGZftdQLT/+l36kSA+ag9D9VzL5vWJ35XFWeV/Eisq9WNDombZ0KMu42MhAsjMIZ8ZAER5PgG5QDtJLguyv49mA9YvVPs1N84QQ6/Y8o9yrNdGUq75FiGm5Dj/Wza39sF6rmsc78uZ+OBPAUi1mCTkFCER/h3uzneYLR3gGRl2rBitbWiY24kvU9Qxtlyw7HPtHuTknOeQCPjjKEmFh6SxhK+IrJ/eACEb1AENkt6eWwfUbNWjU/Yzesrq6KsGCCLSxNKDYr8iu/GUcHbqkyWafJVy+Ary0IaIfqrZUaBknpEBnH
X-Forefront-Antispam-Report: CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(346002)(376002)(396003)(39840400004)(136003)(46966005)(82310400003)(33310700002)(83380400001)(44832011)(54906003)(6486002)(956004)(6506007)(8676002)(336012)(5660300002)(2616005)(6666004)(86362001)(4744005)(4326008)(186003)(47076004)(1076003)(107886003)(16526019)(7636003)(6916009)(2906002)(8936002)(70586007)(7596003)(70206006)(316002)(36756003)(26005)(356005)(478600001)(6512007);DIR:OUT;SFP:1102;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 10:18:50.9053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d6005d-ade4-434b-373f-08d85af31324
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3196
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

this small series add regulator support to the lm75 driver for boards
that don't always power such a sensor. While at it also convert the
DT bindings to yaml.

Alban Bedel (3):
  dt-bindings: hwmon: Convert lm75 bindings to yaml
  dt-bindings: hwmon: Add the +vs supply to the lm75 bindings
  hwmon: (lm75) Add regulator support

 .../devicetree/bindings/hwmon/lm75.txt        | 39 ------------
 .../devicetree/bindings/hwmon/lm75.yaml       | 60 +++++++++++++++++++
 drivers/hwmon/lm75.c                          | 31 +++++++++-
 3 files changed, 89 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/lm75.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/lm75.yaml

--=20
2.25.1

