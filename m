Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E762FB70E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389340AbhASKCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:02:21 -0500
Received: from mail-eopbgr750045.outbound.protection.outlook.com ([40.107.75.45]:32418
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387798AbhASJoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:44:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyJZycvbzC0+gRkNeZvS0bMMw1JxDXcFOQp3/1O2UvfPK5A5zz73OhUQQ4Ph9CoEj3R4GEaaqfbBoKa6BpS/tAa/YE+mQSsnU10UVM+pZF5j/HYmuGM+d0eG0wbcAyPxSHGDr2Mdd5GkrZhM7fphfoSJO7LsbRSXFNpUkiPtmkRdxWI/2AdgJgFm9ybdz8JWw/P+Yp5ujWrfuc+NYhsxzp3yzPkDYulNjn9PqIn3gx/QY2am6s3WGzdbwVHBKuO40lEDwW/8KS6W2QQ6+DGWEBbDH9FPYcMzbBUj5LrTrTokskFNoJa/Bp/q2QNKM72RyHl0XBdtbpfAudh6rXP1yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PG2E1w1ll4gbYlz6K7nwsWoByj8dlr07EitUuHU8qs=;
 b=mrUAeowkA4XpmhfptY5uWC75+SsQOIbhD+UnWsTtWfDm6c1fnHa082yvDFyI4XxT0yCc2IyKUxQw3/PUQi6dbKw3D5y+PQVUuDYa8FFzBiFp/xhyhMg3q7JQ/KXEO3HDiTQkwkq2Bs/zFslTOdTy/luGzUDYWDiNYBO7QRADAgWJHwa5EOg9+1FKJmIjoeALAJ9yUHUZmZ3WNaJuh07SyQWZLqogj+1GbowPamzju/q4TZAFdo9HkwXpdAEjMVqcj6f7SHi9BhDGfTFxaX69DufevvyIVMUyRbIdAJKBqJwbgN2WlaGqrnQRWSziM+PpBM4CyMtWDf6sRugxaoCAMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PG2E1w1ll4gbYlz6K7nwsWoByj8dlr07EitUuHU8qs=;
 b=g4w1QeptMnTRd3YNbOjXX4pEbOfWYhDtROrimSsoWfepbInsMTFgjHKAk/LUnwoxsHvVJAe0hHZTcX/bBYz4dB2iuHx6qren5p9olzay5fCBL3GJSdOcfFjoPBbj5n/LY5OAXay3ma210gt5XecyOIrRGRrVc1bo+M0OreFuLgI=
Received: from SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17)
 by BY5PR11MB4242.namprd11.prod.outlook.com (2603:10b6:a03:1c1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12; Tue, 19 Jan
 2021 09:43:13 +0000
Received: from SJ0PR11MB5008.namprd11.prod.outlook.com
 ([fe80::589d:3fe7:733c:eb72]) by SJ0PR11MB5008.namprd11.prod.outlook.com
 ([fe80::589d:3fe7:733c:eb72%6]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 09:43:13 +0000
From:   Pho Tran <Pho.Tran@silabs.com>
To:     "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "inux-usb@vger.kernel.org" <inux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] USB: serial: cp210x: Fix error 32 when hardware flow control
  is enabled.
Thread-Topic: [PATCH] USB: serial: cp210x: Fix error 32 when hardware flow
 control  is enabled.
Thread-Index: AQHW7keBkUVh9dKpX0uN/Ls1iOAoLg==
Date:   Tue, 19 Jan 2021 09:43:13 +0000
Message-ID: <658ABD80-572C-44BD-8DBD-79396109A175@silabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.40.0.2.31)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=silabs.com;
x-originating-ip: [118.70.199.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d3ae3fb-6391-4684-82bb-08d8bc5ea3ef
x-ms-traffictypediagnostic: BY5PR11MB4242:
x-microsoft-antispam-prvs: <BY5PR11MB424223972E97C6AB0EA570A6E3A30@BY5PR11MB4242.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EZBbwppCuvuk7Ub/f+5oej0BGlxVOIqLwFJSEFawDox9lrGQkahrACXAEzXANNn/enmtrzCEXAtvfPKI6bL8Ww9Z+tfhTH+c6QzhJ+xF6Bz6RzxVx9vIw7s7f79z6yLJgd6CTmA8zBCUUr4d/mT0HTNeFDIlsoh/gJuiEu/+ExErAQd91aUS2m826/uWZ8CdC0Yi9V93d6NDDbQceFsLjvIzHCgyoB/k0xHJJTN/mTrxouBtyGYsCJPq8rLFOQrHD4o1MYBYNooiu3BoOQ0JiJT8IanoU7xzFzwptdHd1awLjd0acigb7A713CE+LCDt3bNj4DJI7so1dDm/9SoxN0TQqq/S+H6UuhQlzTQ5g3/O/qacOyL5c5hhPbavxl3T8g26J9qZx86x38jC+/K/9NxP/I539j/FMaKYMwNDd1MH6Ek+QXCl26aOiq2COdWb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5008.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39850400004)(366004)(396003)(6506007)(83380400001)(66556008)(33656002)(86362001)(26005)(76116006)(64756008)(91956017)(6512007)(5660300002)(316002)(6486002)(8676002)(186003)(110136005)(54906003)(36756003)(71200400001)(478600001)(66446008)(4326008)(66946007)(2616005)(8936002)(2906002)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nr5BPZy9mj9C0hE3ShK/TfuYBs8k5WK55i2odUwltvIXM050aIbUjdPT/qBd?=
 =?us-ascii?Q?wQM02gEn7dD2e3WLIAndY1eXDUfw5hP6YfjzJI70K5tvzR8+NqepGihxm/Mp?=
 =?us-ascii?Q?Mwhb9r0Xtotwqw2Iz/hpJGTVb8IQn/XUZ9WJL1aW9xP62r1e3basc2D2H9Co?=
 =?us-ascii?Q?WCa2RKePQO8VO6gQY87/GPNVL0btDkMbOj41GP7PlAINDfV65RvZ/Vt7WTQc?=
 =?us-ascii?Q?3JJq/QOEyrlQkhUQlU+/3t8Zq79PRhjEH8Q8feef3QUwhExQwpN+IhIQ516t?=
 =?us-ascii?Q?O9l8ctCvf4hsnbtJdLVy2zEyLGU2EX6Sa3zZPI9X1ksc5So5kmovPts44kgQ?=
 =?us-ascii?Q?fVJSRrniLFPDYrA8p5nIBV4hYXxviPHwu7V9EgJUN+9L2j4ue/3/m0EhECi4?=
 =?us-ascii?Q?0msWgWJ5rm0KShabYfm5YWsfPEcr3SKeclB7j3Y5bSJGqE/J3ynVmQ6PpSk8?=
 =?us-ascii?Q?bgrU01QoCbR+7YURhDpBIQkV+FDMv90RdXP1T5CJ1Sb2OGYozJU7q/L0TGPC?=
 =?us-ascii?Q?W+t0F1IqGJT2/O2rWQVfYSNZRqq6T/3ab6MVLWBdH/V5+TPG6r4EZLkE5rCR?=
 =?us-ascii?Q?5VrVozc5GTxB+xWIAB+Gyu7/ZbQ/JEsRf7qv59BQNslp7gakhlO6tI3E28iK?=
 =?us-ascii?Q?jjQ9qlXqRG7feGao1o1m+2EF1xog+d8ilCwWfsWIIoSv04ktar1k6isAXsm8?=
 =?us-ascii?Q?Yo4NwAc2g/1qLTerUC2tnbfF5Rqbty5Gra6Nq8uf9nQFQnrbZlllGTzFBUec?=
 =?us-ascii?Q?E4BFxYxxCf5W4I5Hh/Op3fP0aSsriEJvMGUtSYmyDvV2+vTBhqwuf6ZF7A70?=
 =?us-ascii?Q?9s5NuPoArbGPXGOd2RYcgD/+7b6KIW8v7PKi8jEmoPdNgG2mn3FmMhueJ2QE?=
 =?us-ascii?Q?SJiQ4UjKwD4j/1XUJRtNlPDJ5K8RvqU18BXGd0Dq+IuSTTLqu4WbDG5ClW1X?=
 =?us-ascii?Q?ToLBqmtEqOJL5g0eAy6K7+m5S+lcVH9ejjfJHTGZXg/xQXG4aXTNa9og5xG7?=
 =?us-ascii?Q?nO2b?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <64831C329BA8B745B6972C35C453CA04@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5008.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3ae3fb-6391-4684-82bb-08d8bc5ea3ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 09:43:13.5469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oo94pSl+RjYPC0/7ZMDDmcZMXgiy01A5U36Jv5z9wyeE/TdqgLSKEtXE6EVVMBfDxn8/IoGG3MbcaUg6nXwAdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4242
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
any attempt to control those pin will cause error 32 from the device.
This fix will block MHS command(command to control RTS/DTR pins) to the dev=
ice
if hardware flow control is being used.

Signed-off-by: Pho Tran <pho.tran@silabs.com>
---
 drivers/usb/serial/cp210x.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index fbb10dfc56e3..1835ccf2aa2f 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1211,6 +1211,11 @@ static int cp210x_tiocmset_port(struct usb_serial_po=
rt *port,
 		unsigned int set, unsigned int clear)
 {
 	u16 control =3D 0;
+	struct cp210x_flow_ctl flow_ctl;
+	u32 ctl_hs =3D 0;
+	u32 flow_repl =3D 0;
+	bool auto_dtr =3D false;
+	bool auto_rts =3D false;
=20
 	if (set & TIOCM_RTS) {
 		control |=3D CONTROL_RTS;
@@ -1230,6 +1235,25 @@ static int cp210x_tiocmset_port(struct usb_serial_po=
rt *port,
 	}
=20
 	dev_dbg(&port->dev, "%s - control =3D 0x%.4x\n", __func__, control);
+	//Don't send MHS command if device in hardware flowcontrol mode
+	cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl, sizeof(flow_ctl))=
;
+	ctl_hs =3D le32_to_cpu(flow_ctl.ulControlHandshake);
+	flow_repl =3D le32_to_cpu(flow_ctl.ulFlowReplace);
+
+	if (CP210X_SERIAL_DTR_SHIFT(CP210X_SERIAL_DTR_FLOW_CTL) =3D=3D (ctl_hs & =
CP210X_SERIAL_DTR_MASK))
+		auto_dtr =3D true;
+	else
+		auto_dtr =3D false;
+
+	if (CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_FLOW_CTL) =3D=3D (flow_repl=
 & CP210X_SERIAL_RTS_MASK))
+		auto_rts =3D true;
+	else
+		auto_rts =3D false;
+
+	if (auto_dtr || auto_rts) {
+		dev_dbg(&port->dev, "Don't set MHS when while device in flow control mod=
e\n");
+		return 0;
+	}
=20
 	return cp210x_write_u16_reg(port, CP210X_SET_MHS, control);
 }
--=20
2.17.1=
