Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A00027B112
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgI1Pj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:39:59 -0400
Received: from mail-eopbgr80103.outbound.protection.outlook.com ([40.107.8.103]:10213
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726327AbgI1Pjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpUQZW40Nlv6By6eLD1iZASlbRifFrgriX9Bmfsm+EI=;
 b=nKtaU1cHnRfAepPIxYyQlWtfl+IKp8MBJUFeg5KdfQwFA/+sugXG3UOUGWL+LhzzuH3JiRcUuFDWArOsSq6mN6AM2bUUw/LemePYyIjRnMtbj1go2GFyersNQRCsgHoTXXr8a8t7EPY1cc1x4HlLytRPosUHaa6/8x2pOAp0oYg=
Received: from AM5PR04CA0030.eurprd04.prod.outlook.com (2603:10a6:206:1::43)
 by DB7PR10MB1898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:5:12::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Mon, 28 Sep
 2020 15:39:45 +0000
Received: from AM5EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:1:cafe::c9) by AM5PR04CA0030.outlook.office365.com
 (2603:10a6:206:1::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend
 Transport; Mon, 28 Sep 2020 15:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.169.0.179)
 smtp.mailfrom=aerq.com; vger.kernel.org; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received-SPF: Fail (protection.outlook.com: domain of aerq.com does not
 designate 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 AM5EUR03FT012.mail.protection.outlook.com (10.152.16.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3412.21 via Frontend Transport; Mon, 28 Sep 2020 15:39:44 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (104.47.6.54) by
         eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
         ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
         tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Mon, 28 Sep 2020 15:39:45 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 10737839
X-ExclaimerImprintLatency: 590473
X-ExclaimerImprintAction: 98e0cdf0001d4f14b53e12dd0932a93d
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfCQUIFU4qXUo5BTJPh61iRnXQS4SQOscxcMK6I3hhm+j6yXlCLJh4RHcoPS0UasSYnorWbOg4y2XtdXy1qePPI5V9WdCzM/gK/5kRxzYBth3EZXCAd1UnrjH3c6VrZez74IUxhqWGRaG86wb+bsT2QtHBAcD0eAhW0TS+lU0DVXyU8gZLa2Q2qOZjmGE3qB+qqEDqH0BffxvukSUMI4SotqBUB50l/GVaRlbNdHNRtMisxGIRkwuJQxZGoZ3sHtk03im1reRswa9cY50LrHODvagaDLEM38u0usCdMSoZR96U/YcTkDTmta1LvrXs12cQYZ7jpW62c0OebGdXxW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1Dd941obfvcbMcy+8wgmePUhSxT9Z7BkFeMhc+O9LU=;
 b=Nfb+MVwYbPz9T1JSJqvcDUNeoXCB2GwY9J9K7PkhXaWzPtHj2jAWAwmQp/Y9+VDw/SEXZm63IU4Ozba9gUlIrtygOO3ajKdGbZqjJOgLaNp3/y9K0xU+XQ9GpgRW3JOPDQQhzGMSsRqgE5NvZyTdkScYAmtjcYaTvYAgUSgAcVdJjhAfxWZDCLvzs9qeO6uUYG1oJ8lcPsHdktNYcHzdfl9e2S9C7gQLQr8QdFHARrH0Au8K1mBjPCXpx8BwWitAbxvOaxGgDtRiQw5KI0fS4aAhGhqYg/EUmc0lQ+lwThIel3AR0ffPMxQjMZZW3jq4KOObH2kCA38edJf0IrgGBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1Dd941obfvcbMcy+8wgmePUhSxT9Z7BkFeMhc+O9LU=;
 b=CjEbAmqKqoI2ZfO7Ql1Im5uTDFpDnelT3HZahpd3TRwN4XZdQ9DTWrTFWU2MCg5kzq0ce4OpaBJkvWACtO18LmIpSjeVon8KiJbYDKABh/D8DMPsBMTuIAWH6KPlGcGIZFfEDmKTwyhTlz7hx5DKaO764d62tOB0d9jGbJZOqXM=
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=aerq.com;
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:161::27)
 by AM0PR10MB3057.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:162::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Mon, 28 Sep
 2020 15:39:39 +0000
Received: from AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4]) by AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4c24:8830:7ae8:87a4%7]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 15:39:39 +0000
From:   Alban Bedel <alban.bedel@aerq.com>
To:     linux-hwmon@vger.kernel.org
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alban Bedel <alban.bedel@aerq.com>
Subject: [PATCH v2 0/3] hwmon: (lm75) Add regulator support
Date:   Mon, 28 Sep 2020 17:39:20 +0200
Message-ID: <20200928153923.134151-1-alban.bedel@aerq.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM4P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::25) To AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:161::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aerq-nb-1030.aerq.local (62.214.82.242) by AM4P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Mon, 28 Sep 2020 15:39:39 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [62.214.82.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 467933c8-fdef-459c-e342-08d863c4b99d
X-MS-TrafficTypeDiagnostic: AM0PR10MB3057:|DB7PR10MB1898:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR10MB18983372B062B835668171E296350@DB7PR10MB1898.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: FXg34UNeERHIgQQjP9/tXCaYWrN8gIH7TDmrh38DJN6hR0tFJ0mfBywI9hdnYIbrwPNtWV6bIkXiDQQ+F7DKp3Sdn21d5HHVP6OFusIald0kSjsfxpMWon3kTQ17lukzDYFBkA5aZhd0MO99XQCSKKSMSYJGmJH2/jk+oJEVVJAjlYMyAg69fTvRSNrbk9RyTRoktH4CdgEgZfjLAn1okQZZ/SVG3RpXx9xj6Uz6rFjhvwYrOrHbUoHslqrT8oTtVFFb5kqDKm48ew4HZ9StsEjuSkoXSshxI2gSDcDOQEGq7brpz4bVgt/5D9oAwzyyA6d9ETQJhD+vv5ls+taiTzJZLYbQftc7BAD5xvpy/XE6j07aZ2fnKIHLf64pwiWI
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3428.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(346002)(39840400004)(366004)(396003)(136003)(6506007)(316002)(4326008)(5660300002)(66476007)(66556008)(16526019)(186003)(6512007)(26005)(6486002)(1076003)(6666004)(66946007)(83380400001)(8936002)(36756003)(86362001)(8676002)(4744005)(54906003)(107886003)(52116002)(478600001)(2906002)(44832011)(956004)(2616005)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: gF6XNmBeq3TlCOl1o3uKYewosrLfD528uS0rsHdPRU1rPhn2tDsC0j0A23xCxEQP8lVaVg7jTJ2gXKwfQ/PFMFktDB1drJVc+lTPxOULpT/V/EJL4nq3+YVlx6pjTyaUf7uDButzgqNo/EiQF9aKBjAQNVFW2CnwfZc5CVjsatldy+TgiqxjQklh+8WuXO9KYHI4/MbWnPTjBGjARJhCeVmd3iT1vdE9sWRVLzis1SHbyOg+k19UytvV5nYBIvZWLP97At9ad8J66Mb0TYRFkZnXuPIJOMchYoE3hF49XIWK6xF6hwEDmmLcbDoIRv6i6cFNRgbFRcQhtlX3e8G/FKLpYXWY1y0T/ld2ZB/OD/mmy1GIBM05Nxy83tj4ZF8759spRMyZvRlnX/Yr0MLnaBXGPRB5DK7tZK1fIQgOuXwdEfdxwBXVXubKc2vqNl1Blgr4+kGJSM2Fvdh0JwjkFerE3jHARYusdgnf13CWBFugsBa8/LbOORlIsmuNAfOrinz8cndtulIl92uirXH9WUggOmi/iAblZ7P8eIvPRyaN7n52OAFiwzrQkKgH2p3cUrqNqs6M02Wvyd81H4p1P/5mil2PwgzWEk7gklmKvU4XJEP3IGZVzoT0ODpJ3ix0qbyt7gTVnYNjQrPrguuxHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3057
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 77fa194f-badd-4a74-c8ea-08d863c4b62b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2lCEpDAllCoGR16ghIrSJfXTe50ViMF2BlR4+V1VZys5TYh/vzSTWisZznpWNKFBDlTKK6LIon+S9+kmpxVe6rv2iCztliwNztVOQoyRKwZRWFCuKEKGBHh9mR0V8smT6X3cr1/DRIw1FPpdo8wN2Hjp282Sbx8IBAsCCYKMlb5IZzvFuGnAxbTZsbVY8o5b1OAJrXBHXnNrJUm/ZnB9O3fbtgDwNyTHUHTAZJJAEvUN81aSdBAMrBvt2V5mHyc2gQFRJ8yDcZcUOcE9bhwhUquvVnxvyqtN5nPBaR90NH9nErTNo7f4GwaPvblBiZVKhyuGkeGh504bp+AIASlPwjqh0CwO4v8pGiFkTsR1bCOGJcX3JsRBpzE5AJ2UzjYaAynp6TMflMB9xXQgg6ENIwNWiPAHUk3KrbPp/ai46cHlj8qdmw/zoQ2RUuYEVFphSg5QMAkQ4uonPaHK6iAYlCb4qNGWAgiPWMrKv+xIDY=
X-Forefront-Antispam-Report: CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(376002)(136003)(346002)(396003)(39840400004)(46966005)(2616005)(478600001)(356005)(316002)(70586007)(186003)(16526019)(33310700002)(7636003)(6512007)(47076004)(86362001)(82310400003)(83380400001)(7596003)(336012)(6506007)(6916009)(26005)(107886003)(4326008)(5660300002)(956004)(8936002)(1076003)(6486002)(4744005)(6666004)(2906002)(70206006)(44832011)(54906003)(8676002)(36756003);DIR:OUT;SFP:1102;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 15:39:44.4120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 467933c8-fdef-459c-e342-08d863c4b99d
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB1898
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

Alban Bedel (3):
  dt-bindings: hwmon: Convert lm75 bindings to yaml
  dt-bindings: hwmon: Add the +vs supply to the lm75 bindings
  hwmon: (lm75) Add regulator support

 .../devicetree/bindings/hwmon/lm75.txt        | 39 -----------
 .../devicetree/bindings/hwmon/lm75.yaml       | 64 +++++++++++++++++++
 drivers/hwmon/lm75.c                          | 23 ++++++-
 3 files changed, 85 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/lm75.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/lm75.yaml

--=20
2.25.1

