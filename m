Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AF427D137
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgI2OeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:34:16 -0400
Received: from mail-eopbgr80138.outbound.protection.outlook.com ([40.107.8.138]:5703
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725554AbgI2OeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWG7Nx9q1C2Grx7c/nWS4+L9zJ0Iz7+HRTGsFHaLUGQ=;
 b=BlUDho43r7be35Tcxjpb7gqGHu3+/FU+cdXi9CQQMJHbCo40qS5XUOHAoh/VWaIz4s9qd8m4Ai5peUcTeBKBzRzL9/7Nhg2MDtPdhm8UM29L60WgNdk1R4qtYfO9TE8Kkpn4eItH+pTRrnsqaZ08iYEfN9QEE/0r+TmOQAQi48U=
Received: from AM5PR0701CA0005.eurprd07.prod.outlook.com
 (2603:10a6:203:51::15) by AM0PR10MB3331.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:18b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 14:34:13 +0000
Received: from AM5EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:51:cafe::b7) by AM5PR0701CA0005.outlook.office365.com
 (2603:10a6:203:51::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.18 via Frontend
 Transport; Tue, 29 Sep 2020 14:34:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 104.40.229.156)
 smtp.mailfrom=aerq.com; vger.kernel.org; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received-SPF: Fail (protection.outlook.com: domain of aerq.com does not
 designate 104.40.229.156 as permitted sender)
 receiver=protection.outlook.com; client-ip=104.40.229.156;
 helo=eu1.smtp.exclaimer.net;
Received: from eu1.smtp.exclaimer.net (104.40.229.156) by
 AM5EUR03FT059.mail.protection.outlook.com (10.152.17.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3412.21 via Frontend Transport; Tue, 29 Sep 2020 14:34:12 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.175)
         by eu1.smtp.exclaimer.net (104.40.229.156) with Exclaimer Signature Manager
         ESMTP Proxy eu1.smtp.exclaimer.net (tlsversion=TLS12,
         tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Tue, 29 Sep 2020 14:34:13 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 11184970
X-ExclaimerImprintLatency: 664734
X-ExclaimerImprintAction: 27a206c0bcef49c5a066bbbe6637220b
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYkU8rbrrMTQHRn12bgK4acxpzcremEUrFaf7iCaVFCQ61gtxsDNMW7hq8CVdOgR+ii8ICDit/3/38CDEblZErzL/xuFMEKhrgFzQ+lkBuwITqe3pnKy2It+aEhV3a/QQuCmPzA0FaOS5sreYkbNMRxvSTo3tyXWWOCDjfzTKmwCOHSHeBELya90x1CVvepSJvMa8lsiwWOS3VxlMuCzWL9tch5u95xj66IlMLJGwzCo0STViSN6nzUYPF/izVGHLftVF7sOc35G2YH+y+787Q0nWUGdtyM6+7pOCJUdXlWLVK8Tx1v6lHEVFZkqTd0qH3atAMiEZ/6tldmxi+xdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T25PbV/QSKtT8hZ6FDFVSomYkj+fX8WWtRcSAe16HHA=;
 b=WCt7dX1oumLLEKCc+stluM2iXGLrq1g8pn6Rj1SylW5H0w4M2pRto5TkGSbtdXUMO9LWDlETqZK6h0MBXXJltIPgKxznO/79san6ezmP7zvTsxncQIXoSNbVEkvngwfEPWbNIT8O+r+uLE8zTVUFxMqQPKqSFjRjd+y3G0c0RVNHw5qX0DDAXXHfJJioni1ob5X5za8g35BRPWr88nbCbiNbobO6TK2u06HxRaAQ1KsFG3Sh7VQz7GMqqx4Z30WSQvTHRKnQLc19fRp/0y5OtDnqLrkR/LSwTlEbm/7BpmXEKCQxIjBg5Sv+bJlcA1pFMnRHm35sZM5RfAOvJRNGGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T25PbV/QSKtT8hZ6FDFVSomYkj+fX8WWtRcSAe16HHA=;
 b=emJGUmDyaYvPHOndH8HD+ny2KoU3w9VGJZmCd5e1ypVFUXb7ArEe0cOtlMpFDqZMiHl6P620kdUNJ2No5wk7a4vfv4JkBHdktDrWj0Hg0gnnNRzApg/aIAGjAhu3Qejx1dl5rqE/l84iNtc8BdK9YRZzx5xgvTd2nJhETVfqn6k=
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received: from DB8PR10MB3434.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:e4::19)
 by DBAPR10MB4091.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Tue, 29 Sep
 2020 14:34:09 +0000
Received: from DB8PR10MB3434.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14f7:2e71:2913:d431]) by DB8PR10MB3434.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14f7:2e71:2913:d431%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 14:34:09 +0000
From:   Alban Bedel <alban.bedel@aerq.com>
To:     linux-hwmon@vger.kernel.org
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alban Bedel <alban.bedel@aerq.com>
Subject: [PATCH v3 0/3] hwmon: (lm75) Add regulator support
Date:   Tue, 29 Sep 2020 16:33:42 +0200
Message-ID: <20200929143345.73170-1-alban.bedel@aerq.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [88.130.152.63]
X-ClientProxiedBy: AM0PR04CA0065.eurprd04.prod.outlook.com
 (2603:10a6:208:1::42) To DB8PR10MB3434.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:e4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aerq-nb-1030.dotsec.gv (88.130.152.63) by AM0PR04CA0065.eurprd04.prod.outlook.com (2603:10a6:208:1::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 29 Sep 2020 14:34:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59479558-16c2-4553-423f-08d86484bc76
X-MS-TrafficTypeDiagnostic: DBAPR10MB4091:|AM0PR10MB3331:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB3331661F516098FD115105F996320@AM0PR10MB3331.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 14m3+3Y2dIfmW5Q4bYSiDQ+jpMyKj+iC46lwZXISYkwQmpsvW8TCavOR2gJm89E953bnfUfJ1eIkJfTffgiOzdArujFIhhiBZ6HLJKf2HAfY3fkOMoVjfawjE/I6HUWNODwgPfNfmmURJUufeswxYN3/7R0p8UslH5Ht7O7kxAFiB/UQIBMnoIriFcMj0HSUqvOytHy71Oj8h/88nnM7DjriTkcKXuI2+phK+6clhfYaihCARYkSlyWg4H8e8r6322HyglHhgeDu1AsF+2UpEuF1HS9NktlMMybbin7lCkuPvnEmR47Gq1nUcjdhF9nk7d1qhTH8nQJEKCGPDEIObIYLjANC6KrA5A0BDZml/caqg3sHTFcdEn2cfsObFoYv
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3434.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(396003)(366004)(346002)(376002)(2616005)(44832011)(6666004)(6506007)(1076003)(26005)(54906003)(36756003)(8936002)(186003)(52116002)(83380400001)(66946007)(5660300002)(508600001)(16526019)(6916009)(8676002)(6512007)(6486002)(956004)(2906002)(107886003)(66476007)(4326008)(66556008)(86362001)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: WbopKMMnMZcexsvjHvKNyWdw+wm9vCEycTcz1lWViNVerjYl7FVH93gO2wMaHUY/zvBKCWUEBfapvsuMcyxOGmk/FeVdavP2oiNz5VO2B3ncNgrV/H8VkH4DMe75KT8RSx6i1+1fi5uG/fojfecGWv3NDvpV2aXnqnfgg2PMApWMHRMbdxJ01s+iX8/84I9WM/Petryt6cUIc0k4h+tHJ5GJXQ2rbI+0LF7x1PcwTP+hV8rHk+DwvQXJcUaB9/YoivLv1YdYswaQK8ug5kumHcnrNhKnL1o1YX2ojZayszx5XkBWYLSFYuESU5Qdj0lx6XMyRBUd+9nDdrqBrZQbcmfyYG8PXJDa3t3kRWxV58TOHIieZfxbVQHISQrOHM8mNLwjk3PXC0IV49MN/bkF7C8196oVSPafiDjZlRUZZw+cdsrihT5pb9zAxCT+9MoFjcspVUrjxlYXSUx2qV2YljRaaFral+7dC0Dft5peF8m7C+0H2Gm01dCKLdkRG9Yx9X6ay84gBdl/4o0nrMoeBqCFyuJudXeKjV+aodbUvkOQo0Gu/s2MGusHnQaPpzZNE7DndzNToJF96CwtNdvGBSEph1Av6cDcelpqcLjRjZAlDEwwsJh1tnWdwEuyaHWTL+Zc6VC/zQVRmD5sltwldQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4091
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 60983e86-d50f-4d06-22ee-08d86484b9ca
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SImweB1Hcbs1V/WlGARoef/wrWu0NQ/sype5BGbaq0gJYuRiFx2/aAKZyzH7ZyTtlvdb9SAewshh6YXmhH7+U8mpNb6dKJLNDvs9kZEhu2YsrdEELblKew/eBsPeKp62TqO2B+sOQnNFkjPxrRssWj5swElLXmYO2PAPbLmYFfwXee6f7D0PF1jFLPuB2CBlJY52twYGbqZNuXnjersgCpeDxXTqTFP3RWHD5djsdhvYrS7pML9GepSVnUWny+zM+Rwtm8eVopN5JnbnNr8qgwmDxVxQCM5yZaZJAWTA+Nk75ax+b6LoZvYpcTTqXRWK007d7wbJhOL062VRJ2tbbISkmiGQX6DFFtricl49eRWE/R/BKf1bnq8pTYsY9XiQnCyF24Q49S8aBHjayR5JA7EtkmbvFyaNE6zjBOsafQr4RJkWIEZfUPLa3MtatbXrFpOQ39QEuY+FwBg1BTtQSa2B8MDbdYA1T1yATmcl/3A=
X-Forefront-Antispam-Report: CIP:104.40.229.156;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu1.smtp.exclaimer.net;PTR:eu1.smtp.exclaimer.net;CAT:NONE;SFS:(346002)(396003)(39830400003)(376002)(46966005)(6512007)(16526019)(186003)(6486002)(47076004)(26005)(54906003)(36756003)(5660300002)(70586007)(2906002)(8936002)(8676002)(4744005)(70206006)(6666004)(1076003)(508600001)(956004)(336012)(2616005)(316002)(86362001)(44832011)(6916009)(82310400003)(356005)(83380400001)(4326008)(7636003)(6506007)(7596003)(33310700002)(107886003);DIR:OUT;SFP:1102;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 14:34:12.6116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59479558-16c2-4553-423f-08d86484bc76
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[104.40.229.156];Helo=[eu1.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3331
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: - Fixed the DT example while converting to YAML
    - Removed the unneeded maxItems from the binding documentation
    - Use dummy regulator insted of explicitly handling missing regulator

v3: - Use a devm action to handle disabling the regulator

Alban Bedel (3):
  dt-bindings: hwmon: Convert lm75 bindings to yaml
  dt-bindings: hwmon: Add the +vs supply to the lm75 bindings
  hwmon: (lm75) Add regulator support

 .../devicetree/bindings/hwmon/lm75.txt        | 39 -----------
 .../devicetree/bindings/hwmon/lm75.yaml       | 64 +++++++++++++++++++
 drivers/hwmon/lm75.c                          | 24 +++++++
 3 files changed, 88 insertions(+), 39 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/lm75.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/lm75.yaml

--=20
2.25.1

