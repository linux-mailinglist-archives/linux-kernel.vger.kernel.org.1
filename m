Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CA02F0C01
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 05:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbhAKE4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 23:56:14 -0500
Received: from mail-bn7nam10on2051.outbound.protection.outlook.com ([40.107.92.51]:14561
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727043AbhAKE4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 23:56:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/RLhvDk17cgEcUtH2UOb6Z+gq7vemlBp499CnQZX1kKeX4nDfZQZYBhK3iyYoRXlOzUg5WIm+RTeY6/tTk90ctBKiUNqMg43sexUygAV9bB3ml33eUeGzIUEZodlcacr8TjiEQd6YT6reFCYt+4EvtL+Do9T5f7dd46IODoqtetaBJFM/X5026q5pNLGyb3stJ/m75ITSAH+GPkLqdpskJi1czsgLC5AM4SYF/A7iOcmR1Vk7JelFYq8g+emt7Ol8oo9ZBn9xJ0fuXxXJKa91XQjV1+C6N/Gv/DMLEGR9T4Xv5INYWJvfWEsvGnfwqiyGnUi0wxTYuFhPjcxfHP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Im1XgOUxAZ4+sALQiFyqGZ+io5YJsVlsSEGDgjFCl3Q=;
 b=AUElHssJZw2NTWCfNVg2EfcKCP4CPa0M2ihz+5iiMWJT/d3AkbLuQtw7FcpvuXrE18JcbDRi5RB2RIUXkzH1UaoOxKaXnyS26kDPm63MEWBC4sJJm4AArHoXx6SyGRdHdx1knteyOkCa9RtCd6O63UvRygFiDjnj9pq8405zQv1y/L+gAjEDFYDQyaRcIGVoiWxHsg0BkxpoRQZxfSFOPDvHHskx8fFHBC8fzSdhM7PF31/rj3GX0mTrxFH6iAnyseZlt609MQR+6ksagKxNcy9cZmBIVyMDb85hwXbKNmc4epEVyfYyglPZ+qtwPDnVEcOWSVJv5kMNr1vdbfS1SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Im1XgOUxAZ4+sALQiFyqGZ+io5YJsVlsSEGDgjFCl3Q=;
 b=avjBTcTB7/TXrEVfKrtPAIxgkADY+VapjapsAJdyVOrglc2LnehQBxfnNs2U1ofN+vICqCU5NJkXtKDuEDOOaDYtQe9a4SSQ9LHlbnfTwG6DY+DaAG/9xeXLTjzXtIZhcEas2trnIZZVVxsWMCHmcqED1VldqBOPGHhLB37Jz30=
Received: from SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17)
 by BY5PR11MB4007.namprd11.prod.outlook.com (2603:10b6:a03:189::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 04:55:22 +0000
Received: from SJ0PR11MB5008.namprd11.prod.outlook.com
 ([fe80::589d:3fe7:733c:eb72]) by SJ0PR11MB5008.namprd11.prod.outlook.com
 ([fe80::589d:3fe7:733c:eb72%6]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 04:55:22 +0000
From:   Pho Tran <Pho.Tran@silabs.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Tung Pham <Tung.Pham@silabs.com>
Subject: [PATCH] USB: otg: Fix error 32 when enable hardware flow control.
Thread-Topic: [PATCH] USB: otg: Fix error 32 when enable hardware flow
 control.
Thread-Index: AQHW59X3zHF6wEm0PEC++j/MCSj8dQ==
Date:   Mon, 11 Jan 2021 04:55:22 +0000
Message-ID: <C429CBAD-FE44-42AE-909C-4C33052A7413@silabs.com>
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
x-ms-office365-filtering-correlation-id: ad525140-165c-4628-699d-08d8b5ed1a2d
x-ms-traffictypediagnostic: BY5PR11MB4007:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB40079952530C63FF59337A3BE3AB0@BY5PR11MB4007.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:86;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PZn4n5bi8xOJGYWhbKVUFNqn9cVCC5smtib2gtRifzm6z4Ppg+gQocNDMw3SD8KaoIfDDSA+Bz6UMPzHfb6iLlS6fEx1XZ3CePN7ZTLjpfECiPXG4blgtmrwKAFwT+/mus8wuVYUkdTsUX1ixKvWj4b7D93JueuYul3hdv5kYqhNAcSkFXwu6doKUSy+Gy1deueTAmAcujy7yyBtLiPc1P8zHUT7Rl6l7+Yk5n4nywfW0SxGtUiqi45def+jxawDT6bNgR/wtyc/mPPW0joZ5klTWnsaNWEzkH6fecAD8Ux4GhbxjnepN+ll7fkKfxmaSZrndOaET0GKmO+sxGxZEu38cOKudO5av4rQzckTmAu5KIS66powZTd6zsSKlsCUIpIAnWuvq7f7tNNGfPv59v5tccZn8X0w6udEJJZmoDtGyMW3TuL+CO/043NYnnCa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5008.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(376002)(366004)(346002)(396003)(136003)(83380400001)(6512007)(8936002)(54906003)(6486002)(8676002)(36756003)(2906002)(186003)(316002)(33656002)(26005)(478600001)(2616005)(6506007)(66946007)(91956017)(66556008)(64756008)(76116006)(86362001)(66476007)(6916009)(71200400001)(66446008)(107886003)(5660300002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?c5eooreWxw2xzdHcwIVC5/o/YFdPbSRPE5pE4yd07w907VmhZKby29ZYW8kl?=
 =?us-ascii?Q?/q19v+lJhbwZnj5FrYa2dlEmMiGqb/7yd8GoxZO24J/Oe4uGTMaO6ULZrbuG?=
 =?us-ascii?Q?0OFwYg/k0xo/nMGgLRTNnOj71Dhmzely5raDapa5TJxOdGVTiKS6zAiiI3Ho?=
 =?us-ascii?Q?HiwHamf2EjzrO8ufmCVRDlIqNqvKaliwBFUeGl1F30ZYYYXJ26WMjQCUguDh?=
 =?us-ascii?Q?FxiKsfNY7jnMm/ep03dZ+MZCdsqs6rAvFrGA5PNyKI2neAFtRHftkfafK3F7?=
 =?us-ascii?Q?GUabEdQEqdE0p7+DinYjs7vSTa1Ksu83nZXYFM9dLE3PbtCIil35CgvMTj5V?=
 =?us-ascii?Q?VpzhNgRHCwWbwR0ayNtin0eJR0+GpGwY7xTiS4Rl2lS2qBfq2+lphRWh2m74?=
 =?us-ascii?Q?HcjQy2ZXMdTBYVB+n6UbKDdxKep5YW9PbD4i4hdiGi4RSQI5sGCtMCkq0Qf6?=
 =?us-ascii?Q?HD9nQm/J6YQaPrvfvn7mIfVrXthVbx4+GeyDjQ0qe7XXqdgwh+Whx1dNcgNG?=
 =?us-ascii?Q?/FGKNY3cBzxBm+8ZjAC9K21pdjEvQIiDui++TgBX3VwJIaQiTjKsAGBhLybw?=
 =?us-ascii?Q?Ns0QkO2e6G7bt3fXw0GqrjSiepu1FYMlpW9pQmRCIhhnynLjiY0UrvJrVcp6?=
 =?us-ascii?Q?W+3raQRb2oExnDIqxqhQe+bpZ/4hLWVMtvfiZy379BuhS5Hw9cv21TPPMK0M?=
 =?us-ascii?Q?ujAl9xYO5FLenw9MkbnN4XKCgKj0jdZbW7F2XJy6cQt5+wwmU8rHaf+4Fsu/?=
 =?us-ascii?Q?csZrGhOkgYYojJ9ZhsnGIu5rBJBfyO6VTN2jWoeCgm2VBGsSPzr+iIyO8Nwj?=
 =?us-ascii?Q?o/yNqUGs6hCeutSyyench3FtLHhaus0yXGanAnjgx4tfappqVPPVSlKKqRB9?=
 =?us-ascii?Q?VGiW7QM+GpsJmNYRgM/Of3YAmAVSahVtUPs2uBBpGYuy40309uUVffRA8v+/?=
 =?us-ascii?Q?9Uu4TDc/CL00SQAReZU+AU2vRaOf09n+7cWHtoY/7BUYMcHCfkgSxJ7wlMk2?=
 =?us-ascii?Q?JP58?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C898074B790CF542A0F2053BAF3B6385@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5008.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad525140-165c-4628-699d-08d8b5ed1a2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2021 04:55:22.0152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2jHYC2TcBS22PlhuubHngzhXAKxV8RkwijTnF0TwNZ8xq0uSpJMM3vgpgkBujc8cNleKgYl09dQ4WjfBP1Blw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4007
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hardware flow control is enabled,
don't allow host send MHS command to cp210x.

Signed-off-by: Pho Tran<pho.tran@silabs.com>
---
 drivers/usb/serial/cp210x.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index fbb10dfc56e3..f231cecdaf7d 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1204,6 +1204,7 @@ static int cp210x_tiocmset(struct tty_struct *tty,
 		unsigned int set, unsigned int clear)
 {
 	struct usb_serial_port *port =3D tty->driver_data;
+
 	return cp210x_tiocmset_port(port, set, clear);
 }
=20
@@ -1211,6 +1212,11 @@ static int cp210x_tiocmset_port(struct usb_serial_po=
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
@@ -1230,6 +1236,30 @@ static int cp210x_tiocmset_port(struct usb_serial_po=
rt *port,
 	}
=20
 	dev_dbg(&port->dev, "%s - control =3D 0x%.4x\n", __func__, control);
+	/*
+	 *	Don't send MHS command if device in hardware flowcontrol mode
+	 */
+	cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl,
+				sizeof(flow_ctl));
+	ctl_hs =3D le32_to_cpu(flow_ctl.ulControlHandshake);
+	flow_repl =3D le32_to_cpu(flow_ctl.ulFlowReplace);
+
+	if (CP210X_SERIAL_DTR_SHIFT(CP210X_SERIAL_DTR_FLOW_CTL)
+		=3D=3D (ctl_hs & CP210X_SERIAL_DTR_MASK))
+		auto_dtr =3D true;
+	else
+		auto_dtr =3D false;
+
+	if (CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_FLOW_CTL)
+		=3D=3D (flow_repl & CP210X_SERIAL_RTS_MASK))
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
@@ -1256,7 +1286,7 @@ static int cp210x_tiocmget(struct tty_struct *tty)
 		|((control & CONTROL_RTS) ? TIOCM_RTS : 0)
 		|((control & CONTROL_CTS) ? TIOCM_CTS : 0)
 		|((control & CONTROL_DSR) ? TIOCM_DSR : 0)
-		|((control & CONTROL_RING)? TIOCM_RI  : 0)
+		|((control & CONTROL_RING) ? TIOCM_RI  : 0)
 		|((control & CONTROL_DCD) ? TIOCM_CD  : 0);
=20
 	dev_dbg(&port->dev, "%s - control =3D 0x%.2x\n", __func__, control);
--=20
2.17.1=
