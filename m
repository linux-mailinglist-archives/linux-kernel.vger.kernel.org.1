Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5263033BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbhAZFEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:04:44 -0500
Received: from mail-co1nam11on2081.outbound.protection.outlook.com ([40.107.220.81]:24801
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726590AbhAYJ1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:27:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgR9ZLhrBPsr3W7+qbc6usWr2BdHXd2eVcwInX1Y8oYwzgPW9JUTzRRjyDGqqhmNco8JcTpeELHDSBabfdlQjlhoCfCZhWXGZo4wfL8YQBrdAZEpUBKw7xR4xC3P5nSzbCrJ9iBc0bxFr7GGX3MD4jU3VRZKjNQn9uVx+7fw4ERrneKt3eiI2xaHs2GrGlD7MYkSherIor0NbdR4JRkku6FXB3l19hl9GIjWa2C0qh9rhaQps22xa2bdwVy8IEHn4wTtcEemRtTdEi7f4fNpS82cLAwumtO0sxPdfYGaYF8azuzZI27lXP/Piw7FBFBboZEDu7ufL+YSUYai358ghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHECe6md8Uxehyyn2d3+pQ3Z7bNQb0RzNUDb750MxQ8=;
 b=Qoi117YCetzfn2j1Rcy4Pbkq7b13avosuy+YN0Xo8cVikhVOQz8vaG4/Wwcpy34HJpO+7n2d94uU9lfAPPOVDxTCC6uVgsN+laymnbnLCqu22iM9YuKKVxRwXFQ2SkhzU2PEd1+k7lz5I73SWPYZGJ77jxA7EuAjAXlsPoIx1AhQbP2+NBsgWs0X9QP7pO3d5PNYp1wZ4Kv20azAEXxDoYfZb8LaG8e5Fc96jAJb3ZmpEvWpzE0QQYKUnZ3//YqDiZTS6KVv3W/BJ5aFQaDiKM69xFlvosGO37EwqNTHmJ3If13lxQMga4XjYb0eDlfzV66drwsC9oKLA/wveq6ppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHECe6md8Uxehyyn2d3+pQ3Z7bNQb0RzNUDb750MxQ8=;
 b=HpWvsS6bYW5HDLWJPEK1+zw4j4qYUUrkGbIOHtn6VtVlY9VvI7yFjU+Rs7brB6MwiR68R1L4HfFjzVCr9Kx4NkK5my/WxztDRjc3QkqjsrBf2HS/htdZ9eNvr0ojUhndSIwUhbQGxYTk9Gfgdwy9bRBJuEVCnLQNg93MJWkKQYY=
Received: from SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17)
 by BY5PR11MB3910.namprd11.prod.outlook.com (2603:10b6:a03:185::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Mon, 25 Jan
 2021 09:26:55 +0000
Received: from SJ0PR11MB5008.namprd11.prod.outlook.com
 ([fe80::589d:3fe7:733c:eb72]) by SJ0PR11MB5008.namprd11.prod.outlook.com
 ([fe80::589d:3fe7:733c:eb72%7]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 09:26:55 +0000
From:   Pho Tran <Pho.Tran@silabs.com>
To:     "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Tung Pham <Tung.Pham@silabs.com>
Subject: [PATCH] USB: serial: cp210x: Add pid/vid for WSDA-200-USB
Thread-Topic: [PATCH] USB: serial: cp210x: Add pid/vid for WSDA-200-USB
Thread-Index: AQHW8vw4RSAQ130V60qksyLgAxTkIw==
Date:   Mon, 25 Jan 2021 09:26:54 +0000
Message-ID: <C3EAC35C-0CF6-481E-9532-024FFC176991@silabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.40.0.2.31)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=silabs.com;
x-originating-ip: [118.70.199.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cd3c933-db2b-4357-f72e-08d8c1135b2e
x-ms-traffictypediagnostic: BY5PR11MB3910:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB3910AFB6D12D3385210D4DDBE3BD9@BY5PR11MB3910.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:324;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cIGp8T2CQWQ3wKdW5LQmyaPa9a9Z3r7cYgN8/VF1/LXs3y9ep2ghdbBTDvSIR7cFisqlNnQ3NfkAG3zsjddYkiq10cuc6tV4nook84Won30IHzjZWc6qh0egy+Q7zsp9AAZnxTFbCk37S18NlkLwPwfgAWF1JQKIiR5Lu8ZLBcVKbVNg43rc4WmWMeK/rshHyaTJdbkV+/ifk7FoCpO8ylJei1Aw0BkL6qPDEmbsV+U1fdUf9JgX0tpYrORw9rm+/k+Vhxh/8Drapj7vpS6IanFaSyQXD1g29nsjVjbbIofO4nx9GDnIV1Z+J087ACEw95I1J/WrMFWIwLKWutx+PgbSlBlLSM4Dqqc5tKi0HOH14X6jBulzMG21F72qBZzOXzqeKG7IEcP8fuMQbhvu+up3kIXATHDiYTT6EPVr2TZbMw0uV/EF2cyFd78jNe7J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5008.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39850400004)(136003)(346002)(366004)(478600001)(33656002)(4744005)(6486002)(2616005)(26005)(6512007)(5660300002)(54906003)(86362001)(186003)(2906002)(83380400001)(316002)(71200400001)(8676002)(36756003)(6506007)(4326008)(66946007)(64756008)(66476007)(66446008)(8936002)(66556008)(91956017)(76116006)(110136005)(107886003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JblN+/fQAhw3jL6lU1Et2zkKfR58PBQKx3cKcAJ6M2Tq3cSwT9r3ItM4Caby?=
 =?us-ascii?Q?1lHzRBWvSckEDLGEHLRAB/zX4PZBM1+Q4vVVKMeOXTWgv8cNjzw8RIXI4tJe?=
 =?us-ascii?Q?yDHL+cLeHX+SUA704y5o6fd6WA1dy65icngdJ74Jh3IEPc4jym+p/8g5bdfP?=
 =?us-ascii?Q?sQtArxhhFutxWS5ETjnhharHI7uHh1V8UYBcaGGADoIc+uSmPtsRBxAZl7P/?=
 =?us-ascii?Q?MFYBBrbVr0JIu2igfBnxZN8igo5BzlaHMCw4Ee4QCbtXImVcXplcUHWn+xga?=
 =?us-ascii?Q?NhMSf+PEdu8eYq/2oVyg9pBeSXYb2K/7y/fjl+04VA6caCRTV2cffmJRZ/9U?=
 =?us-ascii?Q?Iz0jp7dPVlfPtZIza6KcyxMT3i9G9jXzuLUevhQXaQ0amyAEg6K1nt/yA3O9?=
 =?us-ascii?Q?VMcx9kTmCyGc3Q0Np7Flhcdwo+9ZAs3ybmscNdi6ie6joO1ZHTWdvs23VRMi?=
 =?us-ascii?Q?OXrGMTX/58KcBjW7n0EV4j4/p4zK/B9wAFwm+5ABX7YyRg+WcQWl1emsjUOZ?=
 =?us-ascii?Q?R41rjvFjxqxsFDy+xrooroEZX0xsmkrOi4oXsEqcEbLbIxJRxGul06+aiAnQ?=
 =?us-ascii?Q?agB+1wV3EqiVmPzVIMl1gmNaz4SWzJWp/0RdJIl1f0dCeIDvAImiSHWVgZqC?=
 =?us-ascii?Q?9l1bny1XBLK+P+g5x7sJqvHQieOznNJhK6m0e3wDN9pZKAZm4KRnGI7DLa4b?=
 =?us-ascii?Q?bbWAzS6EH34FT5GKk9H31y8lpIjjUrsgVMehtLzeEsf9AoYV4PFJQS7NSf89?=
 =?us-ascii?Q?iXJQEgViBr1LvsU7FSyQ3MnwPhPede7skD/zoVzrvWl08sbJLGZHWv/E1/Rb?=
 =?us-ascii?Q?TQvYV+uiHEQlMpNdy6Nka+mdh3z34KhL9ocUXBwJYmENsh2y2vFOAsph5tIg?=
 =?us-ascii?Q?RjHE5czR8OriKTaxWVGd8P76IE68tzfpQYT9m4RcDex/Q64t2zA6psvPGaMQ?=
 =?us-ascii?Q?cxMv6U70UexgWXX9w2yGTMsTpWGkbVkJTGqHUgCwf5js4Wp2IxRaprvyzWaV?=
 =?us-ascii?Q?X8EAgLCtxSAj20mKZG1/e1NDmNrjt8wo4Ro7EWI283EnmN58Q3fFArQtU2uY?=
 =?us-ascii?Q?m2gi6MQX?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D8FFD1CD447F74EBADADFC6707A93CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5008.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd3c933-db2b-4357-f72e-08d8c1135b2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 09:26:54.6500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +exnoehvqEw+2tXFNIu1J/cSmtPeoETarE4KjzG/JqNo8djKdPRFXNk5dnCdEZEReXV39kDRQuckx1PyQ5pyUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3910
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Information pid/vid of WSDA-200-USB, Lord corporation company:
vid: 199b
pid: ba30

Signed-off-by: Pho Tran <pho.tran@silabs.com>
---
 drivers/usb/serial/cp210x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index fbb10dfc56e3..669f52107f94 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -201,6 +201,7 @@ static const struct usb_device_id id_table[] =3D {
 	{ USB_DEVICE(0x1901, 0x0194) },	/* GE Healthcare Remote Alarm Box */
 	{ USB_DEVICE(0x1901, 0x0195) },	/* GE B850/B650/B450 CP2104 DP UART inter=
face */
 	{ USB_DEVICE(0x1901, 0x0196) },	/* GE B850 CP2105 DP UART interface */
+	{ USB_DEVICE(0x199B, 0xBA30) }, /* LORD Corporation */
 	{ USB_DEVICE(0x19CF, 0x3000) }, /* Parrot NMEA GPS Flight Recorder */
 	{ USB_DEVICE(0x1ADB, 0x0001) }, /* Schweitzer Engineering C662 Cable */
 	{ USB_DEVICE(0x1B1C, 0x1C00) }, /* Corsair USB Dongle */
--=20
2.17.1=
