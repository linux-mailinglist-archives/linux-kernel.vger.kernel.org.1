Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012282FE390
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbhAUHN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:13:26 -0500
Received: from mail-bn7nam10on2056.outbound.protection.outlook.com ([40.107.92.56]:26453
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727137AbhAUHKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:10:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRGjvtO5zi3E+0/gPYQ8cTlczc+XRbQ3/4H6k679fkeztSxqTyprIOAWnDgKi0g9145Cc8CERrmU5jcsjovRB2tZ4kntG/O41JBvObxByy1y+A+bhgMlIEN34maEeVziQI1OlsYh0MDUAko5SDxhaQMaX4z0BCYOev1QBK2A6N/gw3jA0QRWuzwT1hg8kOZ4oVH+1Im7y9tQlwbaqucMjUatYXXOJ6vF+83Ay9emM9yeNeTFYBGTxd1BotbOzxTk90blIMtNr71UQbDVbZaVwpehMt7X0mGHR5vlF+4pEziRqkHiXzZzvEqWRc8n9P4wizAM8qdcnDMFRn9+PHIbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxetTTll30cOVnhIHGW6MMVu5pf/gn45hNLNlkR9itQ=;
 b=ONdHo3eSgGv4S78Aviq3XDKOVDCgJo16O1pnux0WTGPke1WYLcPSQaqq0+3YoZyh9YFs8B8lBvamlRaa7s1jhr8ErzVakAhb8QOMC1i+7uBOiRNikdQeOUKiZdRpbchmUV2A7u7LvYVplBCpJmPqGpqRT3VgJuYkQa0tA7Z6/KJ1a2dOdInfXcLhz+bQ5x+GOLtb3i8zx7EKipJjS92fBWaLG0j7lyiAeSBKa+OLfPVHOiZSYPQJO/sCXmB1/+FGUeOtCjk69+BTsE7LIdtLj4RiHCg+F5Fzn/x8ydK+to1F1g0mAPaCHnRll2h6LjB77LGTom0HO2bniM8jJ5lwCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxetTTll30cOVnhIHGW6MMVu5pf/gn45hNLNlkR9itQ=;
 b=M7FN7sqzPHYT8BCROFk2A3lVXK1aKPbgGlDt7QkTQBX8zw+q8cEcS0TJXN8AFt+ASSgN1uHml5sEB+hA8IKDcW3+XxwcoCmdb5l/vkKfDHfArVA+UJyaq8gVVQVo2HFjYHUcNGpUyeVt9Se/ZlXfKfneoPfLoIqrvwODILhun9o=
Received: from SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17)
 by BY5PR11MB4370.namprd11.prod.outlook.com (2603:10b6:a03:1c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Thu, 21 Jan
 2021 07:09:13 +0000
Received: from SJ0PR11MB5008.namprd11.prod.outlook.com
 ([fe80::589d:3fe7:733c:eb72]) by SJ0PR11MB5008.namprd11.prod.outlook.com
 ([fe80::589d:3fe7:733c:eb72%6]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 07:09:13 +0000
From:   Pho Tran <Pho.Tran@silabs.com>
To:     "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>
Subject: [PATCH v3] USB: serial: cp210x: Fix error 32 when hardware flow
 control  is enabled.
Thread-Topic: [PATCH v3] USB: serial: cp210x: Fix error 32 when hardware flow
 control  is enabled.
Thread-Index: AQHW78RS/gguW8VF5Ua24JAN1mAAiQ==
Date:   Thu, 21 Jan 2021 07:09:13 +0000
Message-ID: <9E531B87-06A8-45F0-A2A8-EC6FA61A99A7@silabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.40.0.2.31)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=silabs.com;
x-originating-ip: [118.70.199.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 324a62c4-1a18-48f9-fd7f-08d8bddb7557
x-ms-traffictypediagnostic: BY5PR11MB4370:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB43701E6842AF8B46FAE165BAE3A10@BY5PR11MB4370.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ct+Y1YB15zHtbsA8uTstDqxD/l6dE8w7znSIP8dkq+JV5SWQBa9a5AhBaln/0S+n1FboI387Ru6hN0zd4EaAoMub4g6tZUu/eB+hB46f2mFAgswnJiMY/+CbRARfVw05qVWUjFw7hto7q15Ai1JpMJRKkvEio8YEF7DrhBGeIJJBS59k/BvijoPOFGKaotfSmqrTIxAvOEKmaGY6VQdqpfX3qu5IyZL2pO45q5fEXo0a2FdWk4Ad7CakSznKPRsaHqCvzTtyAP7zMPxc13ujKJv0m+tYt1nghxX2Ou/Xu8MigANNgi+2ap4/2b7uUHmcciBiZwIoaDYSzHFxe4tZlfBreB8GZpMwT4xx4+DTB7jt8ualCet4+CEp75EovMmDVjKvTgmbZRk8CUlvcWgCrrTY3WTdPsX2/61vOb0GTpx9ImIn+CRtUDF2n10xZqOY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5008.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(39850400004)(396003)(346002)(478600001)(91956017)(4326008)(8936002)(83380400001)(6506007)(186003)(54906003)(2616005)(6486002)(76116006)(71200400001)(86362001)(316002)(2906002)(110136005)(5660300002)(66946007)(107886003)(66476007)(66446008)(6512007)(64756008)(26005)(66556008)(33656002)(36756003)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5X6GMiFwUXQvTuSqlu0xyP9CU2UMfF8Bhcgo020RXBcQe3nm9cMoAWEQZ0iS?=
 =?us-ascii?Q?ZxojN0g3DYmEwP9jRImbgpXa0Fp9W0OGfvgf8p9iIh6azwsddjR9if+wPTBX?=
 =?us-ascii?Q?5yNT3r69tvj3YsDBWvSkCkK4uhfySvQSpJGBO4YJS57K/P6ppRsx/HLSVSi3?=
 =?us-ascii?Q?qu1Ze/Atu08j2xPa75MCIEc+RvOzDjAOHr4y1yQblyUWxMjapI4qRbi7Qner?=
 =?us-ascii?Q?nBkkGjQ2NEcXGBlmsq7Mehes/cQfCz5EuNo6pCJGdXdrfPFGbAfXICgEd7YC?=
 =?us-ascii?Q?C/fObGU9dyCdoLtQkXTnWiINK4lqrb2L/uT6N6ZMXjZZ6YVP9m955qvSoXsb?=
 =?us-ascii?Q?WAuX7J3otugO6sHxKxLEHz/sOvOf0noHitNLIXrOWZOPoqQiOH1WwS4zqYmy?=
 =?us-ascii?Q?EnZsMgxKr8EYktkGcIyq7PNWe48uxXaypWZKZpmzrtCdUe8oGeQVXhqHHnRN?=
 =?us-ascii?Q?7l5OPve0HhKTO9ZxDplyJ50xSCjcALw8Hz7G0f5RQd376psk4QbmMI3jDxKV?=
 =?us-ascii?Q?e83Q4xgOHc93DPvz+n/1GpzsB0QJZSZXQ3LMkAvJ86J5/z84xD9V1FbFruol?=
 =?us-ascii?Q?smGsxxPXoGgsmhaKJtF8KJ2jr51cBfA7WrMSS5pu6tz0q0il7S4XoO/KquPr?=
 =?us-ascii?Q?HucIEZ4iXN/r7b9N8/elNkxj34L+ETENPB0TQMnlsiJcAj+AZMmXauIUduqW?=
 =?us-ascii?Q?4r4NNzrDEdphi6VE8bH7N9cSg6IMEhWEBseASJzaZtjSQw2o3hmtyXeA5ZFp?=
 =?us-ascii?Q?ePuMJ52UxX1L+Sp7sKvrf8YE9ACiPQ1UOJdYv8Xhx6/fvJ5IeP/C5g+RU7BL?=
 =?us-ascii?Q?qCr1drpmssX1eeJvFJvDNRhnW71GNiIlqkHblwqIrRqTfUxB5FC7ZWhMXCx/?=
 =?us-ascii?Q?OkZK4RH527Si0cMRLqaIiW8U+JW0MWv4RbgEz6umhwB1cTNP1PWTQBsBPSDX?=
 =?us-ascii?Q?w7aBvJGDf4mJFv2eJ0z4XdKc+5nKl4EOYnbr41sp+3jnrpYzf60r4RBScNu2?=
 =?us-ascii?Q?7zI9?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B46D3A9C9C1AA9418B6E09CEB5F1968F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5008.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324a62c4-1a18-48f9-fd7f-08d8bddb7557
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 07:09:13.6476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e5rf1ZTWqqRC007AMhFh6Rd+AQvVRaRTfZ0kJxBHfGZ+OEG6GHAEA7/3UaD3x5jq+qF+yPPiH5Wvzaiqh4lppQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4370
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
01/19/2021: Patch v2  Modified based on comment from Johan Hovold <johan@ke=
rnel.org>
and Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/cp210x.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index fbb10dfc56e3..5b6bbda2b424 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1204,7 +1204,12 @@ static int cp210x_tiocmset(struct tty_struct *tty,
 		unsigned int set, unsigned int clear)
 {
 	struct usb_serial_port *port =3D tty->driver_data;
-	return cp210x_tiocmset_port(port, set, clear);
+	if (C_CRTSCTS(tty))
+
+	/* Don't send SET_MHS command if device in hardware flow control mode. */
+		return 0;
+	else
+		return cp210x_tiocmset_port(port, set, clear);
 }
=20
 static int cp210x_tiocmset_port(struct usb_serial_port *port,
--=20
2.17.1

