Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D742801E2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbgJAO6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:58:09 -0400
Received: from mail-eopbgr130122.outbound.protection.outlook.com ([40.107.13.122]:47645
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732620AbgJAO54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPz7tgoijVFB4KqXP5M4sM//rBR6HhH3hyDevQtaNqA=;
 b=SzTyvcDLM+8A4g+Eu+0LCfoi0IGOJijHkdGnGFKGvVZO7GAiz9RfUXvwozUHyfRkrEVhQeuqexUah2ldNd7OJfyl9u0/mzfOQIvin5jIXEapac3CMVMxXn0/7lKB2MFQekkUTn+R95v58/8qehO9vscysd0YRIDoCZJbo5wQJKU=
Received: from AM6P193CA0081.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::22)
 by AM0PR10MB3012.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Thu, 1 Oct
 2020 14:57:51 +0000
Received: from AM5EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:88:cafe::d7) by AM6P193CA0081.outlook.office365.com
 (2603:10a6:209:88::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend
 Transport; Thu, 1 Oct 2020 14:57:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.169.0.179)
 smtp.mailfrom=aerq.com; vger.kernel.org; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received-SPF: Fail (protection.outlook.com: domain of aerq.com does not
 designate 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 AM5EUR03FT064.mail.protection.outlook.com (10.152.17.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3433.34 via Frontend Transport; Thu, 1 Oct 2020 14:57:49 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (104.47.1.54) by
         eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
         ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
         tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Thu, 1 Oct 2020 14:57:50 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 15390854
X-ExclaimerImprintLatency: 908080
X-ExclaimerImprintAction: 5966083044c64435ab591bedbfe11f85
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyjudMRjsJ8xXqhvpaMg8aYOfxvdy+7ONIpIO6Oa9jNnVMdX+8oyyLiE6hjVQIibye1FpA4+nQp8gMergKIfXAb4v5TGl9heNXH3vROXcwO/f9kwAbRKK/CLIJSRioXfIMGrDeiTSUQ8kvqyOnU+e8F6iw9fbhpUELATUgBiaJwsSb41FiPmQQxjotyHpigf5S+PzAgc2QPk1Mw2F7S06N+9AMaqb2v8EdZtfk0Gr05MqIA2vBdzLrP16AihaXOG+FlFknqiSltck+GXvXn8zg3OATnQF9dVWbtANXg+hHkBnEODQWKNuyRIdOHBMMIm9R1E11pRl6aXff5aoDS9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUnAJCTvZKBJYUbbr7y5fEwWpmOayshQpGCtBQd6ekc=;
 b=Uw2jBHl946KcbYNnzQGkvGxW6XsvQm3phDRJ3aK0X/AbRq3RQzeXtNH2FOgfc3/prm6bQ9N0lEliUHjT64RraUWxZxko5WdMMB0LB+d4/+PprIZcbBCW13G7GZtQGXVsKOR26+Y1O3Dn/uAIEjFGHQAlWi3t5r7C6rjQ8KTojtaFJrf5xV34Q04KsFqk1bqa92+kCihy2HuScAdUWBX6KSPUJCu5Yfhq/6zi/wmVx/W4ucq8cnDldYMEgv1BPyXmNvfFG8jz87dHARStbptg2tao2/MqGuBMAil2IE4yZR/QiQSr6piUbGe4vuZX5Yzz40CVtp1z1nxo4zm1pBszyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUnAJCTvZKBJYUbbr7y5fEwWpmOayshQpGCtBQd6ekc=;
 b=BKrQqrRWl8KgH6N7FzkuAlrr7ojguYfn0fb8MZbhbKxuf6p89tusRqh13FqHt/zv6bo77VQYA1a9/cSMugZz2Hq3bYNJ+Uv0H++1dA2+17cd38sgimwSW80vMIGjqpBoiw6E4YiX3itt43fehstNFG/dXqD1nBSYRdEAA7bjueQ=
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:161::27)
 by AM0PR10MB2417.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Thu, 1 Oct
 2020 14:57:47 +0000
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4]) by AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4%7]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 14:57:47 +0000
From:   Alban Bedel <alban.bedel@aerq.com>
To:     linux-hwmon@vger.kernel.org
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alban Bedel <alban.bedel@aerq.com>
Subject: [PATCH v4 0/3] hwmon: (lm75) Add regulator support
Date:   Thu,  1 Oct 2020 16:57:35 +0200
Message-ID: <20201001145738.17326-1-alban.bedel@aerq.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [87.123.201.111]
X-ClientProxiedBy: AM0PR06CA0121.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::26) To AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:161::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aerq-nb-1030.dotsec.gv (87.123.201.111) by AM0PR06CA0121.eurprd06.prod.outlook.com (2603:10a6:208:ab::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Thu, 1 Oct 2020 14:57:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51c32c98-e978-4c68-f114-08d8661a5e41
X-MS-TrafficTypeDiagnostic: AM0PR10MB2417:|AM0PR10MB3012:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB30126BECD6CDC136E66447F396300@AM0PR10MB3012.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 7QXyRFuvJvTJ8Pfg9SY0IDP1hI/mnqsR9k8Gseyfqv+9GbmNoO3aNslnyNJI2+d2hiKMWQs3xzKffi6zH6E5YCc2Rjrgykh3PBMCjXd2mlYbvUR55NURzZi0s/a2JBQhxWTAARjAKVJgSjtjH6aKcY3p9l/8jTBy3utm5ysmJd7Z87wVj4EwYeO7UM320eVWuQiLU7+V3gX4cMRq/UYsfDZpfmLmP1nK+w/UawoF8uY2+NwWp2TfHfy/d8VbERaT2GqEx8R3gEN5sE0WzWFIYam3N48huFHhsZmwE6iEpG25h7r6Sk+fe5owzeFIOznY4ma5rzD0AMtJxQ+lgWRz1w==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39840400004)(366004)(136003)(346002)(376002)(8936002)(26005)(4326008)(36756003)(5660300002)(54906003)(8676002)(2616005)(86362001)(186003)(478600001)(16526019)(6486002)(52116002)(6506007)(44832011)(83380400001)(66946007)(2906002)(6666004)(6916009)(316002)(956004)(6512007)(1076003)(66556008)(66476007)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 7nNuEwVe017E5Srjc3Udw4UqZNBTAhOuMZheUq4ryH3SMGZgTT6O2M6IHhsn9nAOTc7SuD+wAWImh3oc73KYW4F00ED4zKsjDvha13e0yGn2usQRL/jIh6ll+/zT0O+XJmCTDoJyGI4cHOIzrLAgMIe51+rArFqM+d65wWebuwxP7CkyXiIOTjDy3nINV+wZTqGXBUzhrAImwj8673RkLIxMnYRfoDuGPuW3ggcoP+TNbM06VlNF/rUOP2Tcq81yrkjQdjh32LFHP+pbFrQ6rWmJ6bqPPtJ+MFk23Sh/9nZdk5plts9pEZCPj8Qgadti1ddGzG5xgeb3Arw+66GuUWPa8dXG3cyKwuAZyAK201x+ukbgkxPeeqoIbOYNQ+yisIqSP950yTTnlXUQc0rpPgqN20313nJ4/7tcu/CdaU+AEL8Cb7WlCP02BpVND0krCvCREjUAfQiZhNuZ59409mBR9FWh5KKEM+bScXDlNOOZPeYeNGWu+uQvGb8W/kr0oOp533Rm7XN8Jgtw8tmDHMVpG0EJUlaYNgC79jf1dFWFwiaolXjJMAmIBxseraRSKEqDQptdBZ79NwmcKYE7T6gjNb3oeM4DJv9m9rm1X8wb7wGBCBO/XbH9XNJB8Wi/UzRY9nWg43jnCCmh6TziIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2417
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: a65f07b7-585c-47e2-4068-08d8661a5c20
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ishGFLotlbXoVUl310KD36rfR7SljO3Y5qBYFUnbRzCceowL6qQpGYOexqcZsRFJ1gCuBMSdRA/zzupniXXrjx+hd4g99urcsRBlpyTnYPnxoiWuln04ZwUvKvVrm1FJqZEhv75mhcBHxjvkPvD+6ZbmH0uB8b6mz7Paa2WZxlMCo7fZHbfC8ex52Q2ZWVUgqLyJabZD+NhkTZ2EUR7ioUwMZ3iIhjopn/mtKVA2WwL97Y26D3R37LYQM5cVkE+DqBtZuSbVz7YEtrefSR/zpTlAlQGzndRiQ8cOQfcAreCZPfDwB2fKEmv2AeKW0o6Pxj+wgwt2JlFS+glSFGlcIEmNhVpeeGSTiy5usZgJWBIxIL6wPJGiTK0oP/p7nreCABRFVtPn5T+vJ/aDTGfkS2ewvbVBixuPtFfVVop3SX+y1jBZ53IRY0o++4kc5mon
X-Forefront-Antispam-Report: CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(396003)(376002)(346002)(39840400004)(136003)(46966005)(316002)(6486002)(1076003)(356005)(7636003)(7596003)(8676002)(33310700002)(8936002)(956004)(6666004)(2616005)(6916009)(70206006)(70586007)(26005)(44832011)(6506007)(5660300002)(186003)(47076004)(2906002)(478600001)(336012)(16526019)(36756003)(6512007)(4326008)(82310400003)(86362001)(107886003)(54906003)(83380400001);DIR:OUT;SFP:1102;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 14:57:49.7743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c32c98-e978-4c68-f114-08d8661a5e41
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3012
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

this small series add regulator support to the lm75 driver for boards
that don't always power such a sensor. While at it also convert the
DT bindings to yaml.

v2: - Fixed the DT example while converting to YAML
    - Removed the unneeded maxItems from the binding documentation
    - Use dummy regulator insted of explicitly handling missing regulator

v3: - Use a devm action to handle disabling the regulator

v4: - Added the missing `additionalProperties: false` when converting
      the binding documentation to yaml

Alban Bedel (3):
  dt-bindings: hwmon: Convert lm75 bindings to yaml
  dt-bindings: hwmon: Add the +vs supply to the lm75 bindings
  hwmon: (lm75) Add regulator support

 .../devicetree/bindings/hwmon/lm75.txt        | 39 -----------
 .../devicetree/bindings/hwmon/lm75.yaml       | 66 +++++++++++++++++++
 drivers/hwmon/lm75.c                          | 24 +++++++
 3 files changed, 90 insertions(+), 39 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/lm75.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/lm75.yaml

--=20
2.25.1

