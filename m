Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402E42FE6CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbhAUJyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:54:16 -0500
Received: from mail-eopbgr750083.outbound.protection.outlook.com ([40.107.75.83]:21230
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728501AbhAUJxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:53:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ylow4rxo45LFTlk3+8J+NerqD8KGyM97JYXI52poGs+wuLXqFNNDDB2/xV4i2i6h5Jj2VLNFFPAsWgwo3p4xchV8Gp0BvGPjesElLwdlddtqwNgxVOCFXTKqzEiRfWR+cCGspPOFXEH2eEGhBaWbd4txFEGfFXBm1zxPvgt9x1LkYjw6yh+waAICBA+x+ZPPOq2pSvdz0h4MDq0oXQpVSoB7xa+NujsTXTqp7OKms75WhFZ7E+zCFYmGhUI1c5tnHSNm2nPCG1EK+AI436gQtoArZOpwyfBzY7IbX02jmCqfXIEoe+KyrjD4gffMGlsPcPHQ5OHc68gvqCvLI2iINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qFaC4iLh5bxuRInL0bj6hoQIZKhzsHlSebnQPC/yLg=;
 b=HmdeleryejjRqkt0LJvli3YTHDkmqL6yYHJtWiCse9rtKg3mY0/+3ZPoDz2zoSbGO7YeDmKr6QVleM/v2u34NDeLDhDOCFH1gRNskbUoH14+qlffj0lRIulWPPd9hs1X7QjPcAXaoaCfIDq3aLUsI9dJUTL8d6RJQV/UWNnBCs9dlhNWJS99LPcOhI2h5L04q2CyucY9CrvpG/fW/vY0Y2rQ1SVKhNHsA8WcMFAmz2B3PVWZg2oSQ0e/f9jjUHmYvc9kglO/D7wpizXCVOE+R1CLy5RWoQtmM8pXtK9kQ0oIb2BVBhzFeEonHFI7m23usNAk3tUWho5PU+pbxdp+uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qFaC4iLh5bxuRInL0bj6hoQIZKhzsHlSebnQPC/yLg=;
 b=PfydkT0Dzf/FVPIbW2Yt3nRYuLnOegG2i7bVaU2cTQ9jnPVgtkS4e9xb/DCKDscQei1Ok+TgQWWYGfqiBIAhkUGRVGhI33tzlEwf4XA+WZJth/CILAJoVk3qjpkD1XTEIjTHXJnbV29xF/uknSHQZYctI9dSNfdZFnbIkYIdGTQ=
Received: from SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17)
 by BYAPR11MB3624.namprd11.prod.outlook.com (2603:10b6:a03:b1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Thu, 21 Jan
 2021 09:52:23 +0000
Received: from SJ0PR11MB5008.namprd11.prod.outlook.com
 ([fe80::589d:3fe7:733c:eb72]) by SJ0PR11MB5008.namprd11.prod.outlook.com
 ([fe80::589d:3fe7:733c:eb72%6]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 09:52:23 +0000
From:   Pho Tran <Pho.Tran@silabs.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "johan@kernel.org" <johan@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: [PATCH v4] USB: serial: cp210x: Fix error 32 when hardware flow
 control  is enabled.
Thread-Topic: [PATCH v4] USB: serial: cp210x: Fix error 32 when hardware flow
 control  is enabled.
Thread-Index: AQHW79sd4Ac+7L+UKUGhl4u2SgY08w==
Date:   Thu, 21 Jan 2021 09:52:23 +0000
Message-ID: <E0AAFEFF-2250-4991-8ED8-9B6EE14111EC@silabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.40.0.2.31)
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=silabs.com;
x-originating-ip: [118.70.199.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76690e7d-21ba-4263-7f61-08d8bdf24050
x-ms-traffictypediagnostic: BYAPR11MB3624:
x-microsoft-antispam-prvs: <BYAPR11MB3624B654EA408427F6525406E3A19@BYAPR11MB3624.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1oQJIVQwLWpkrGtGgPmn7LU7rvBCIhB3FbvpnNX+2NtjMPa5odJ554y7uWPZiiMyUpvEm5j1B3jYjryhO3DrfZd9wFpQ8940vR5i24Y5DRymTf0xOEK31GvpR0uq9Jhlja4qGlQKFMvSrSgiSSc64s7S0nMTSdTZi8MKJd6gGRiFaam5b9wFwfil/2zPGiTuuV+hWXD/jTuyQg8Z3ibi7xKFDd0nmcafw1PMDu3HYBJUKuwULCTCsNyRLs2B8qudzxOq8Oz5uuOHD5KliagYz2QEI+sY3m3Kh+U28YkBeEuUKpYMeXWv9WSeNHq9wy+8ZZUFzjIw+fWJcZgPOF4I7IIhiU028c6qepZG/R4CGCqR3pj0122ZAWYkUAeXdoVLdeAdOkjQidq7vASjHfbpn74V4Dug3L2x1OfPYRJlO49+hhTCuKG5RbMbh/0DrUL1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5008.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39850400004)(366004)(136003)(396003)(71200400001)(6486002)(4326008)(86362001)(6512007)(5660300002)(83380400001)(110136005)(54906003)(316002)(91956017)(64756008)(2906002)(478600001)(8936002)(186003)(8676002)(66476007)(76116006)(2616005)(66446008)(66556008)(66946007)(6506007)(33656002)(26005)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/jlU3lV5lDgCzEko3pFuMVeFUesMa1dl6JvR1R7gQaribc0uWDNOuM1OPW0U?=
 =?us-ascii?Q?K9ZcuP2PRjOFE91q6GUhaRuMcVrdIDwUBXpmYyVD/sHSgk9QNGbpy+Pq2whY?=
 =?us-ascii?Q?EXI/7V93QQUen4hUo4qgboN8IQYFhctLkTgT/EOZiniGzheWqhkS1gaiRgEY?=
 =?us-ascii?Q?j1ne1X1eaLCBhRAeMWXuzF9H8o9DKKyj3PhDHO1QiuDb++nKQCD3k2mOcOSX?=
 =?us-ascii?Q?bS2X+nna243KQIl50jEAWejvqaUhvwZ/A270XVnpiEpCN+kdvL1NgkfltN16?=
 =?us-ascii?Q?V8YtN1r/NeykJnjN2yX64pwvEcparUcNKjKgTBaCsybGyBHVwwn6TFlrRow9?=
 =?us-ascii?Q?YZXARVTtdvvEq7W5/3lbjs75Dz6mVem69SpfWLfxN578Kwbj+qqDzHrsN3Rn?=
 =?us-ascii?Q?AyIOeqsC96jOY3vh9yFXmeSZU1ibvxruBbLi6ijNTzqJQ7d7iyycUSmkH3My?=
 =?us-ascii?Q?NLnmLxIHpzpa7O0Y339C0uok9j9yR0U2q9at1nsQ+JvzSKW7Ef0Vvy+KK9W2?=
 =?us-ascii?Q?M5TSM3xnRY1ZFla9EdaJJNMXhYy00XlUZPX9mO5LppjGSkRbdjCMYLLZBUs5?=
 =?us-ascii?Q?1HnoNXmrFBeOeEhBtDO4jYQoZTR9OSAvYaQIm4+susmfDn7YQDJKL5CwBJx/?=
 =?us-ascii?Q?DBbKYeuWbnpu7jKxBUNXg6nNLwSAlWg7lovNXEH4boN5ZLBqgwTr0jlM6ne7?=
 =?us-ascii?Q?GFvwHE1DYHAO6q3dMFmqB6N1BGQUpyMl6a0gkFjHgMHCzopcOXjxc1kGNu/1?=
 =?us-ascii?Q?9wN+ebaHwdCCUkBysVBnt4GcW82Ax7J07Fz0a9PLDS/Qp25R5K4s6N97KrE+?=
 =?us-ascii?Q?3lqPMxnjwu6UCMiQNK8AP3t0KN68Bv8nSOYf9XxSGtDsPp/89OGT8Zi6VuIf?=
 =?us-ascii?Q?TS/tzZ6DX5RLUh56VRoOGPl2L/q/8JmSg6z73SHN2viNj/HmvbHSRqrS066N?=
 =?us-ascii?Q?hwZWb1DCYFhBXWsXCg72Bt8HfTE3FOoIUm0+/2oSWBiQ/N8aJ0P0jX2UeL1Z?=
 =?us-ascii?Q?z79E?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7035E485B6690F4390DA422383227251@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5008.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76690e7d-21ba-4263-7f61-08d8bdf24050
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 09:52:23.1040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 48uWNQOmytUzqlddNzn7/o6CTVy+ixukSseN9b0bDmU7W4pCVOb5ZclOmETiFLbjD4tx3F5iaGDZYGg5YF6OKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3624
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix error 32 returned by CP210X_SET_MHS when hardware flow control is enabl=
ed.

The root cause of error 32 is that user application (CoolTerm, linux-serial=
-test)
opened cp210x device with hardware flow control then attempt to control RTS=
/DTR pins.
In hardware flow control, RTS/DTR pins will be controlled by hardware only,
any attempt to control those pins will cause error 32 from the device.
This fix will block MHS command(command to control RTS/DTR pins) to the dev=
ice
if hardware flow control is being used.

Signed-off-by: Pho Tran <pho.tran@silabs.com>
---
01/21/2021: Patch v3 modified based on comment from Greg Kroah-Hartman <gre=
gkh@linuxfoundation.org>
01/19/2021: Patch v2  Modified based on comment from Johan Hovold <johan@ke=
rnel.org>
and Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/cp210x.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index fbb10dfc56e3..814dff5fee98 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1204,7 +1204,12 @@ static int cp210x_tiocmset(struct tty_struct *tty,
 		unsigned int set, unsigned int clear)
 {
 	struct usb_serial_port *port =3D tty->driver_data;
-	return cp210x_tiocmset_port(port, set, clear);
+
+	/* Don't send SET_MHS command if device in hardware flow control mode. */
+	if (C_CRTSCTS(tty))
+		return 0;
+	else
+		return cp210x_tiocmset_port(port, set, clear);
 }
=20
 static int cp210x_tiocmset_port(struct usb_serial_port *port,
--=20
2.17.1

