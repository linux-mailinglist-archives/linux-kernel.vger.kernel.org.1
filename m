Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FBE2C35AE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 01:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgKYAg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 19:36:27 -0500
Received: from mail-eopbgr140055.outbound.protection.outlook.com ([40.107.14.55]:15168
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727084AbgKYAg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 19:36:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STa80m3bm+1haitm4b0qPLRytkJThtQz7fG+VsQCMMY6+Lh1dNws3VNfzKmAVTMizHPlmz/aZnuqXJId2w2R4+CZ3MzNeTv7bhZEubd7wYkCNtb/9WqK8L8WHzrLNDkH27IMfSC8xZrcVVZUMVXjnp29jpD288VGE2uyHV5x80EtrvczxKfUviB4+8bID5JOW3e6a++jv8aobN5uGAIJYxOHHWPL5j8HKllu098ypOQs92FGFDAhrRYqprnMT2UmQ5cMdDyy6Pk179BNvoeLfYY7RfdTwbe0hir+wrRkYAeWHUIwvJQzRG9zq/r2VRnN9x4QvevSpx7+/6os6YNeLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Dq3aJImpcGVDJKUElYL2YNE2MqIA5ETK1iJTktxltc=;
 b=XDchmqAB6xPC2CBJ1oU0y17nvicYIw1BZHYC1T3vUJLNjL/3Q4VeNUPpZMXn6OZdhKi0HSb2/SRkT4EabL2GkKptgWbCw3VRtzvQPfFSPu5kGptPf+FGKQ4VsqApdyo8JcfyuugU+5K0zA9IKEDxGxt0hwPvWYjJnY+CNrpQU3Tlhth1ZBxzdDSmhD64rLnS1L8izEMohNV003sbjnGVrvCs6YFFtVpuZjL79OWXXa2ewjtz3rSaMqrG3O6PrvCP+uCAf15bdgt4yepN/Wu6RZlqc80Z3quwiECZi4WENtLuzU5Ltu0E0+WCVs44EtJX0dh9pFAeq0oToxaqfHghzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Dq3aJImpcGVDJKUElYL2YNE2MqIA5ETK1iJTktxltc=;
 b=FnVJB5H6vZP/jiz/vAMZYwnRS+D/snESgVT0vFfkn2bVH52OBbQQRmMeEXGvpX+12EVjQGYTYZPxFtSpUbZaOKw+JhQoa6VSc9Ty1XpSysv1zfDmslyn0K2oPIfP26yBgk7HaxKSosr/Sl1P04/pxTeQnIfFEnyqS6duj3Srzsw=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Wed, 25 Nov
 2020 00:36:19 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3589.030; Wed, 25 Nov 2020
 00:36:19 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "usb: cdns3: core: quit if it uses role switch
 class"
Thread-Topic: [PATCH] Revert "usb: cdns3: core: quit if it uses role switch
 class"
Thread-Index: AQHWwY7qvaWheOMvwU2q0XXgyvVqyqnW1uYAgAAxWYCAAAPXgIAAC1EAgAAUboCAAAn7gIAAzOsA
Date:   Wed, 25 Nov 2020 00:36:19 +0000
Message-ID: <20201125003550.GB9929@b29397-desktop>
References: <20201123115051.30047-1-rogerq@ti.com>
 <20201124064242.GA32310@b29397-desktop>
 <89067b6a-5b94-d7d2-b07a-f434c9e5e2bd@ti.com>
 <DBBPR04MB797982E6E190F0C0E0980F258BFB0@DBBPR04MB7979.eurprd04.prod.outlook.com>
 <bdb2b4cb-686e-9283-bc66-78808b92c349@ti.com>
 <20201124114641.GA9929@b29397-desktop>
 <1c4fb95a-97b7-9022-7062-8fafcfe42c3d@ti.com>
In-Reply-To: <1c4fb95a-97b7-9022-7062-8fafcfe42c3d@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 893187cd-ef49-4481-a95b-08d890da2071
x-ms-traffictypediagnostic: DBBPR04MB7515:
x-microsoft-antispam-prvs: <DBBPR04MB751501DBC9DE3D4798D4752F8BFA0@DBBPR04MB7515.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iKnKqI6tzgAGRKSvA0zCc4ozz3PAfxxE21CQOFZ2eKRemrp/gQWUEz6oVrL9urDMcRqhbae1X34i5IERPc7Q3q/DnITd1B/DjtvYU3Hm5VN6uGRJTUe6Y3m6pph52hoMBR35Z0LolUADWGboVQFnYYN/JL9fi/X1O/YUn5rfRUccTNQeQDnuiJW8z5NGAn0thv3WWa54VVYuIBA6H+NlwUh2D+2parR70ViFhubOVjq0F0AyWIHP9x6PyQCf+UayPkx9XsdAAR7gzEZe0kic57Ptl+XCeFuClluIfPr6I0hvFVf9KCLR/3RP6zy5EwnIAsk/pPvTanVPHuCG5CsAaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(346002)(39850400004)(376002)(136003)(366004)(396003)(2906002)(54906003)(1076003)(316002)(6916009)(33656002)(8936002)(4326008)(9686003)(26005)(66946007)(66556008)(64756008)(66446008)(91956017)(33716001)(6512007)(76116006)(71200400001)(44832011)(66476007)(6506007)(478600001)(186003)(6486002)(5660300002)(86362001)(8676002)(83380400001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: skmbeWwVHPx7VS83PgxFzyqhUJEeFGbLwV5QHKKRILi/7u1z921saAIrATdaGvJ6gwscMZZyyWJvbq5BDTL6nKX9w53FnLTbztV2lJL7OafqOC4ZzWV7N0bu9W+VCwY3/B2xnBi5DCQ1td5VgspVD68BWpIPo8XlOhdZ3/jUNjwkbIoijrPXCREr0za7DuSLJgzZ1YqGggY3qTFBTjZ8plCymM9Qq2yW5FDuHmKbcW6pfCVEnUOlFpJ4/p2SCdcXJKaNW5/l/RHZw+NjhLvTBhOSYb09S5kCxR4ObJeIGODxByxOSH0dcBNXWPy2+XHXAkGt92QwIOBEnZO1JPtwcphQIiKLlpGZJkiSW+09XJQSCMfhpwm5Eg3ZFeD+pT+WG6nOe5XC7szNTbQkw8Z7tPBqp1gQnP+A8mlRNNEkXvMbku0HYYX1kvHqJmcyNX+DGc4adLg3gQJEPVwz1lt0SRYx64oNHUgNwE9r9ecztq/2wMhjCbL+VKKVyOIzJK8ni4lNvjy7fQLSreLr3lYsgsQxphclMwExjgh/L5TnQdrjcTo02GOOeOOG1DAReKP/vx9y1IBvl6lu74hG9oAQLrTKSVHyOJhnwEj516/ZCNVBsF8gajSdRQs4gB78V/kyaXRa7Kpw1UVYk1BJ8zjWh4TyKpHSMOpltO1XgJztYdBOTsENrQw3JpKNu7kOIu16xupSfeqU2hm7DVp76MYh41kB6s07U4PVFmeUNazNkD6menwo1Q0WojuukGfFswTCcG1uc34tXlK6+zs7cOk1QfA0h8Qas9u3v5kRQfQ81E15uh1BxIWiT/hANSE0IfTOkFDi6o2wCZG40tuWiMFZEU9w/r3132Y9vl+mZNtNSZQhzb+ek4OWAWBUEN+QNn7V4oH8r0D8lycug4C7pf7SSg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B76D297D66AB314BB08491915D65B1CC@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893187cd-ef49-4481-a95b-08d890da2071
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 00:36:19.3878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zEuy1TFOUD4SDmYbLJ0N8nxv68XQFSflvEH0My96mB5A5wu2vp9pLsa83vJPeVbz64wXPZsUlmhGY6vjVLhZ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7515
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-24 14:22:25, Roger Quadros wrote:
> Peter,
>=20
> On 24/11/2020 13:47, Peter Chen wrote:
> > On 20-11-24 12:33:34, Roger Quadros wrote:
> > > > > >=20
> > > > > > I am sorry about that. Do you use role switch /sys entry, if yo=
u have
> > > > > > used, I prefer using "usb-role-switch" property at dts to judge=
 if SoC
> > > > > > OTG signals or external signals for role switch. If you have no=
t used
> > > > > > it, I prefer only setting cdns->role_sw for role switch use cas=
es.
> > > > > >=20
> > > > >=20
> > > > > We use both hardware role switch and /sys entries for manually fo=
rcing a
> > > > > certain role.
> > > > >=20
> > > > > We do not set any "usb-role-switch" property at DTS.
> > > > >=20
> > > > > Currently cdns->role_sw is being always set by driver irrespectiv=
e of any DT
> > > > > property, so this patch is clearly wrong and needs to be reverted=
.
> > > > >=20
> > > > > What do you think?
> > > > >=20
> > > >=20
> > > > Could you accept below fix?
> > > >=20
> > > > diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> > > > index 2e469139769f..fdd52e87a7b2 100644
> > > > --- a/drivers/usb/cdns3/core.c
> > > > +++ b/drivers/usb/cdns3/core.c
> > > > @@ -280,8 +280,8 @@ int cdns3_hw_role_switch(struct cdns3 *cdns)
> > > >           enum usb_role real_role, current_role;
> > > >           int ret =3D 0;
> > > >=20
> > > > -       /* Depends on role switch class */
> > > > -       if (cdns->role_sw)
> > > > +       /* quit if switch role through external signals */
> > > > +       if (device_property_read_bool(cdns->dev, "usb-role-switch")=
)
> > > >                   return 0;
> > > >=20
> > > >           pm_runtime_get_sync(cdns->dev);
> > >=20
> > > Although this will fix the issue I don't think this is making the dri=
ver to behave
> > > as expected with usb-role-switch property.
> > >=20
> > > Now, even if usb-role-switch property is not present the driver will =
still register
> > > the role switch driver.
> > >=20
> > > I think we need to register the role switch driver only if usb-role-s=
witch property
> > > is present. We would also need to set the default role if role-switch=
-default-mode is present.
> > >=20
> > > How about the following? It still doesn't handle role-switch-default-=
mode property though.
> > >=20
> >=20
> > Roger, you said you also use /sys entries (I suppose it means through r=
ole
> > switch class) to do role switch, with your change, there will be no /sy=
s
> > entry for role switch.
>=20
> Sorry for the confusion. Although we do need both features (SW role switc=
h + HW role switch)
> I don't think it is required to operate simultaneously. If users need SW =
control they can set the DT flag.
>=20

I see. I prefer embracing all things related to role switch under the
firmware entry condition. Besides, I find another issue that devm_request_i=
rq
for wakeup_irq does not call usb_role_switch_unregister if it has
failed. So, probably, two patches are needed. I am OK you send the
patches to fix both.

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 2e469139769f..fc6a8152406c 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -427,7 +427,6 @@ static irqreturn_t cdns3_wakeup_irq(int irq, void *data=
)
  */
 static int cdns3_probe(struct platform_device *pdev)
 {
-	struct usb_role_switch_desc sw_desc =3D { };
 	struct device *dev =3D &pdev->dev;
 	struct resource	*res;
 	struct cdns3 *cdns;
@@ -529,18 +528,21 @@ static int cdns3_probe(struct platform_device *pdev)
 	if (ret)
 		goto err2;
=20
-	sw_desc.set =3D cdns3_role_set;
-	sw_desc.get =3D cdns3_role_get;
-	sw_desc.allow_userspace_control =3D true;
-	sw_desc.driver_data =3D cdns;
-	if (device_property_read_bool(dev, "usb-role-switch"))
+	if (device_property_read_bool(dev, "usb-role-switch")) {
+		struct usb_role_switch_desc sw_desc =3D { };
+
+		sw_desc.set =3D cdns3_role_set;
+		sw_desc.get =3D cdns3_role_get;
+		sw_desc.allow_userspace_control =3D true;
+		sw_desc.driver_data =3D cdns;
 		sw_desc.fwnode =3D dev->fwnode;
=20
-	cdns->role_sw =3D usb_role_switch_register(dev, &sw_desc);
-	if (IS_ERR(cdns->role_sw)) {
-		ret =3D PTR_ERR(cdns->role_sw);
-		dev_warn(dev, "Unable to register Role Switch\n");
-		goto err3;
+		cdns->role_sw =3D usb_role_switch_register(dev, &sw_desc);
+		if (IS_ERR(cdns->role_sw)) {
+			ret =3D PTR_ERR(cdns->role_sw);
+			dev_warn(dev, "Unable to register Role Switch\n");
+			goto err3;
+		}
 	}
=20
 	if (cdns->wakeup_irq) {
@@ -583,7 +585,8 @@ static int cdns3_probe(struct platform_device *pdev)
 	return 0;
 err4:
 	cdns3_drd_exit(cdns);
-	usb_role_switch_unregister(cdns->role_sw);
+	if (cdns->role_sw)
+		usb_role_switch_unregister(cdns->role_sw);
 err3:
 	set_phy_power_off(cdns);
 err2:

--=20

Thanks,
Peter Chen=
