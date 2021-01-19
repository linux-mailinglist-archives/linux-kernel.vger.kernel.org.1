Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D052FB772
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404698AbhASKyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:54:24 -0500
Received: from mail-bn8nam11on2053.outbound.protection.outlook.com ([40.107.236.53]:3314
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404482AbhASKnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:43:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNKwCegSWeKo2YTJggRq10GtVUhfv0noCgFecFLvHiuf8YNoH+AHDYlRSn7A3BMOEfFs1hloEKZYD2zpP4yeFNCXrpVhBrFsC+i+8myo2smqg9XKrNAwivWR3uE74PseFiqnVdkH8aBR89VHaUQyFTNmlTJyb61kQICTus5tegDctXQ0nnqS6O6+2e8JV6/Bwv07jEBn2gBr7lUtS7Acy7A/mtnz/6673w7YGq0JZo1R/2LbAIeYUSk8XnrP4BOwkmUnoYMVYcEs/Gl+gA6/CRCclItHtdKECHRfm3do7q0FWEeu6e53YRvpYdSYrCPobeaXb3ZMzSthLN8CSeFZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrlxLo5f9dVS1dJUgEsBIcT64zB2gvcyqLxKOZKD+Yw=;
 b=Rowa/darKqqlB2f3xXASN3K8SvN+vK+sPbUob9xj4GtoxJGkg+/660XdlWceiGk6GN/ylOFY6oTLr8hDDXxNp5iSzxvwDaFflVm9BCSPUXbppz11Rcpd40dmQtu/dTBrDAB1r5YyiOc/aG5U3n9LBaaA2W6DUZ4liYJum6JfC8dlOSMWr9iob/E9tnq30D5ixXzGbdzwiMZf3jRmqsNjxdNux4H3H31NjPohZcjMFsO3j0vF4TsLd3MKsKEEflL8tOb+AakN+qMwNi1JPLq+To5uXGUVbofSNQ0HduBdBI2zkq6f+aiCQshXK/TZFSVIKjgo2+vNIbj1IcSMva1gFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrlxLo5f9dVS1dJUgEsBIcT64zB2gvcyqLxKOZKD+Yw=;
 b=CVTc368z5FPTqUpIQHfFuV/fY0y3HUiYJLPNtRtUyXxf6Oe19FD27BDmDecVmtSlUmmnVdOwfLbjZNBjvI1rStjLVisB2cHVgLXqHkxa7FTma+Vibjmde/CWFFdfQI73+C4GXAjahZaDBKr1ZLmqpJ8CZkbEw7qqiNiJoMnH0RE=
Received: from SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17)
 by BYAPR11MB2806.namprd11.prod.outlook.com (2603:10b6:a02:c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 10:42:33 +0000
Received: from SJ0PR11MB5008.namprd11.prod.outlook.com
 ([fe80::589d:3fe7:733c:eb72]) by SJ0PR11MB5008.namprd11.prod.outlook.com
 ([fe80::589d:3fe7:733c:eb72%6]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 10:42:33 +0000
From:   Pho Tran <Pho.Tran@silabs.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "johan@kernel.org" <johan@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Tung Pham <Tung.Pham@silabs.com>
Subject: [PATCH] USB: serial: cp210x: Fix error 32 when hardware flow control
  is enabled.
Thread-Topic: [PATCH] USB: serial: cp210x: Fix error 32 when hardware flow
 control  is enabled.
Thread-Index: AQHW7k/Lr4wvXm4zSEeYaCxGmsK9ZA==
Date:   Tue, 19 Jan 2021 10:42:33 +0000
Message-ID: <EFED51C2-797F-49CD-9B05-923993641BDE@silabs.com>
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
x-ms-office365-filtering-correlation-id: 5aba72a9-3060-4a8e-9abc-08d8bc66edc3
x-ms-traffictypediagnostic: BYAPR11MB2806:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2806F9AE20EA0AF3A56CFA26E3A30@BYAPR11MB2806.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qlrQbVJf2PtpUO1bOM1+tmd5oZ0O3PcLmPYe0vGMTRS2cIXe1uyfXyvSuXC7kSgdRg4Ba63k9jyL/LTkhOK4IEz7xA149qU922uGAdpKSvfrGpdIOI3geSoI0FsrgJEJrsJMZJczIeYroUWcR5JVqWP7AjrGzssq/mDVfrzOJ92iQ21/7p2Wfnk66FhXFSCgdsOQvDjuZ1E/NFwmEesEekeVNvM7hAXwK6MOR6NKBfljbGkV0/8QDtYz/I827yWbNOefzw5bz8w9cNgi1K+eVclMHbnfGdYSwxst9pdQ3E8cUH5g8ygu37GPit1EOr7/cpsbbOb5THedz8LYKstTovVql0sw1EZoafRCIYlobrQxZtKFHPFy60stZW+eWTYIDcvR3gAF6yyqj5w3NM/sekpVsJGTcILjoQvOK84/VsYtCoH0/tL7gbn2JIAIRKLt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5008.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(66946007)(186003)(66556008)(66446008)(64756008)(66476007)(71200400001)(86362001)(76116006)(6506007)(91956017)(5660300002)(36756003)(8936002)(498600001)(54906003)(107886003)(6512007)(26005)(4326008)(83380400001)(6486002)(33656002)(2906002)(8676002)(110136005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?S2rbAhatgvY2efEnnnOgdom8ivsjDiOSfkoPUbPHJMHQ3eaNzpMERjWouFJO?=
 =?us-ascii?Q?D1EpvFhhKT9HcpyHsrd/lD69i1WgTj1slbb8t+6Fh4oWbbMSDsAC5wsRR9K7?=
 =?us-ascii?Q?RGUXnhCYGxCY4dfOc0LTciFiOcYbN431bvwVT569fQXbwZGaw+Tp+Wk8n+2g?=
 =?us-ascii?Q?hAxq6G7BzcrKDNhiU/N3N6BJuHiXobu2Pzz62JiK2kpEBQr8q2uaFZSzbF/j?=
 =?us-ascii?Q?u5q9lXxnTJFj4n/vUWAOQw74VjvcqQCdpahXSoqaDNGxWhrqYWedvI85z8+W?=
 =?us-ascii?Q?4/rJj3nNx8PT8zYcSQJE8TcowiilAoOGKSTGckfY6lAa53y6OdRwimf9/nmf?=
 =?us-ascii?Q?CQMpQdLrPvuvnVUHWg2o3Wl7nPIC9B4AhyOqrF7z5Iowo9HEqKTOCojaPv8+?=
 =?us-ascii?Q?fub55t8ufBm6KJ6nRECwplS8uYbTBjwX07HACxvIKNg5rnC5/BNp/nBJxXhy?=
 =?us-ascii?Q?5BrwU14+hZYwG7yqK3GX0OpURwendx2FBS0RfvlGkiWABS55tiTTgrujOAHj?=
 =?us-ascii?Q?gs2PhtJTIqyCC1jPkA+EuGXhrsa4gcIvFLWRpj5kyUh9WzIuylf/9bidGPtV?=
 =?us-ascii?Q?8cCBBB49Wna8CQQFOS8haUOVQ050g7F2s/Lpug76eioOnZ6pnmZckOsRre8E?=
 =?us-ascii?Q?YI1UzMhWhgaOeBLe6uW1Hhs7HZ2Gs6jcmO4ZSCOc8966wl43g00Q/lbtk2WF?=
 =?us-ascii?Q?y+50GxyojvIpAWw0+RSZczJOewDdYIeUUspi1ifbUGuxJVsr8fqN+f+3Cd68?=
 =?us-ascii?Q?nrccrePVDe8K+vH8HKhzzpjUyewMoVztdrHwjVv+cCA2GCOmZBAtaKPlsDE1?=
 =?us-ascii?Q?jHlqINcw+u+eGy1DpGP/RIIxfa8hJ2vmV0CsIvo79UWXLfWeNrOvFc25hq4t?=
 =?us-ascii?Q?xURYGfaofzJnmVZShP6NItdSvk3uKgpzVNYNd8mkXH7Qspng6M3Zy5xFcpAc?=
 =?us-ascii?Q?EbjGCT6ZAuLttaSVCXmuI/oVwmFy0s4RE45etorBj0tiMcgHc1vR4aQFE1yA?=
 =?us-ascii?Q?zC50?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18DBE83EB4E8B1469714D6CB56916A81@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5008.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aba72a9-3060-4a8e-9abc-08d8bc66edc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 10:42:33.3396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VI+71yE5rspeVzo8dqXDvlrr8pEs/okYGu1u8QImXTfHvGWaVAnruYWN3dO2ywN9Q/kz142uhaMUM1dHiMz2iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2806
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
 drivers/usb/serial/cp210x.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index fbb10dfc56e3..3694b7c62290 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1211,6 +1211,12 @@ static int cp210x_tiocmset_port(struct usb_serial_po=
rt *port,
 		unsigned int set, unsigned int clear)
 {
 	u16 control =3D 0;
+	struct cp210x_flow_ctl flow_ctl;
+	u32 ctl_hs =3D 0;
+	u32 flow_repl =3D 0;
+	bool auto_dtr =3D false;
+	bool auto_rts =3D false;
+	int ret;
=20
 	if (set & TIOCM_RTS) {
 		control |=3D CONTROL_RTS;
@@ -1231,6 +1237,27 @@ static int cp210x_tiocmset_port(struct usb_serial_po=
rt *port,
=20
 	dev_dbg(&port->dev, "%s - control =3D 0x%.4x\n", __func__, control);
=20
+	// Don't send MHS command if device in hardware flowcontrol mode
+	ret =3D cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl, sizeof(fl=
ow_ctl));
+	if (ret)
+		return ret;
+
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
+	if (auto_dtr || auto_rts)
+		return 0;
+
 	return cp210x_write_u16_reg(port, CP210X_SET_MHS, control);
 }
=20
--=20
2.17.1=
