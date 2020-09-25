Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFB927804B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgIYGHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:07:08 -0400
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com ([40.107.237.41]:55008
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727044AbgIYGHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:07:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vn6kv65wX3rJrG2HsgD/LHxzcpKNVKtEb1kPYj9OqyZKrHPR8nHq6M5n2btbexRLxeDhwauehWFgLj72rCNdEPH3DZxCWv2P3NtpoKwoOiZn7nC7CyFQ6c/9CgE3W7EUNBUzUqTun60nIH7j/Wy55yHRUO0J6MyJbMndKXtXx7a3sDexDZLiHP9iYIystYh3d9uOLAH9CBCNz8qAyDdfluwneXSQNepaDxtURO6VgaLobm4HpRLuuY79ZrmijCmYuL7/w8fHoEXJMLqmLs2D520mzn2lQedgjGGKjB7GTPXwYojgr2y5Fijo3qojFFa4HRKEdl4DPIA3PXsxkmdPHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLDQPMsAtllTz6qivQnpp/NuGc1u8Q0Zl+Ymaw521RY=;
 b=QbionZHWedUCr/S3Dw05WcoN3eB2BSXp79JOYQWdEqbMo+bR9v5iAl9nkR1j7bo7N2NQNt8hja2K1ZIa3tKDzw+cjH82HaneVkUqN06t7a5FyFdBJfFRSmQtdli+5aYN8VKE6TsZmKeScGStTa4ka+AVtqPkrRIgbHqPz+sdSSF/c45G4t7F4eUtcRW1CV+PDONChS1V7j8FQ/gHe1LmP9Ab3fcpqhe+vtLKwFuNJuzrJRVe/LHKU229VfKG8zSHpuKy2roVZMKHGNSvBHhiGaXtxL0nFMVhcVm8pmwKVEWHqA8fzMg1A1zEghmE4eFCylQlBpPGYrObSEQjVJEJRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLDQPMsAtllTz6qivQnpp/NuGc1u8Q0Zl+Ymaw521RY=;
 b=LzKAtlitrA9gshNVf3gn/L/FSUCkDEULlC8rISpOU/D7dmcaQz13j3gPKf51G59Yv+4xac/DMxZpVD+TJJU5Wgp+A+hVAUTL9fOJGevJOI3cp2e5eTokCd2EK7bnQ3W4t2OvGNf9zR9nC7eLmVexuMGQwb6IYvM+RbBSoszo8Y0=
Received: from BYAPR02MB5896.namprd02.prod.outlook.com (2603:10b6:a03:122::10)
 by BY5PR02MB7028.namprd02.prod.outlook.com (2603:10b6:a03:233::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 25 Sep
 2020 06:07:02 +0000
Received: from BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::84b5:71be:1584:f314]) by BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::84b5:71be:1584:f314%7]) with mapi id 15.20.3391.024; Fri, 25 Sep 2020
 06:07:02 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>, Rob Herring <robh@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: usb: dwc3-xilinx: Add documentation
 for Versal DWC3 Controller
Thread-Topic: [PATCH v2 1/2] dt-bindings: usb: dwc3-xilinx: Add documentation
 for Versal DWC3 Controller
Thread-Index: AQHWhty7FzdXEfNw1kSmR8l21jgZnKl1JowAgAJRB4CAAXjVwA==
Date:   Fri, 25 Sep 2020 06:07:02 +0000
Message-ID: <BYAPR02MB5896E374297AF46A63CDAD30C1360@BYAPR02MB5896.namprd02.prod.outlook.com>
References: <1599678185-119412-1-git-send-email-manish.narani@xilinx.com>
 <1599678185-119412-2-git-send-email-manish.narani@xilinx.com>
 <20200922195410.GA3122345@bogus> <87wo0jejae.fsf@kernel.org>
In-Reply-To: <87wo0jejae.fsf@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [183.83.139.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0fe51c3a-80ab-471b-cfe2-08d8611938aa
x-ms-traffictypediagnostic: BY5PR02MB7028:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB7028A03B5037E05F86C9954BC1360@BY5PR02MB7028.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UhTWXH3g3mx570g3FrcL2d8Q031mplrB55sotMopL3U3M6N02E7dLqcL+ZLmWSS2Kl7EnUMMpy0cXeDw9lGSB+7z4lGSy30s2P9TZNQxT6oEEkr6mBWGbq7v6DlWFsSJWJmRfSA0K2q6q94MiNS1H7Boe88ZkFeK356kmjXCWeah37YJGi3wCQaCZnEIgB+vi/zCoRRUnMshndoh/5B6G5WfaxbY85yE/U79Qs1O5vzA0hhLU8DFOWaTeMBk9pbNePiMyfyUMtBEg7SeF67Q70D7QOZ3ArTSfgIVzqMTdNrrOiY1qzGrw0Sl7gImIjtKQ8mBxq5d39bysCvDcNYSwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5896.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(39860400002)(136003)(366004)(83380400001)(44832011)(9686003)(4326008)(2906002)(66476007)(107886003)(52536014)(7696005)(76116006)(55016002)(5660300002)(8936002)(478600001)(66946007)(64756008)(53546011)(66556008)(26005)(54906003)(110136005)(33656002)(66446008)(186003)(6506007)(71200400001)(316002)(8676002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 0T4MAkj2+Klw5/IeY4hbcPDEvVULwQWhoAZr9WB1QTPw43D1GXFuJpULrD5Ick9YhomPINbm/Zrv2FQIba9nIhmZHzfktb7mJWdINVQK3iiIF++FsZpqxK/olLoH2MjTSgOl3gjetRf2ELhIogzMobZK5OcrDfBc53ir9wYjWZ4xpVxtMew1VgnlFMYnioOon0lWY7L7NsKLQLlLDOzsr2DgZOutKD7jX/dvSn+DU7uvbSuhnCOU7CPfq8xbX9HtJPBUFS/sScZwvZVA7LiTEzp29YwadVvsQn1kb4ky9nblZC73hFq6ZNpyxxkXrmJmgctjRD4nmounGXrFMczMQFN6AhZm/DaVpOLbBxinc18kTz1NYHLq4ArfmG6cqv2lWFI9alrltXdCIHfikNe6NJGIuHhmIITBLJpUhUoID2eZs2vYrrirKBrlp0cMDa9sLFQ6AESRWw8XxT1vmRR4wiBpRCm9K0DMgDM3oIlih/XGQS3oBNMjrPVHuIMANLCSkWU2YqIoq3P1kQqWrlRBfceLgkbb7Ia4dTm8M+3jB8UkD8W7Wdz/vPT6H1mj5lYHUSr5Z9DVR4dnOUQTHfIviEZlHKx4mF7WH0agRlyoOvzCOcd0KMJ2i53WMuyLxEcmkXQ3fX0pp44qpLzheeeC3Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5896.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe51c3a-80ab-471b-cfe2-08d8611938aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2020 06:07:02.3381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CmLLSapBEO+33QSvLceFTO7sSHvEcit8489FNnZEWn/PGVdvIehPpy04ZOgo1drKIIBczOrDoBWpt115hZouMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob/Felipe,

Thanks for the review.

> -----Original Message-----
> From: Felipe Balbi <balbi@kernel.org>
> Sent: Thursday, September 24, 2020 12:47 PM
> To: Rob Herring <robh@kernel.org>; Manish Narani <MNARANI@xilinx.com>
> Cc: gregkh@linuxfoundation.org; Michal Simek <michals@xilinx.com>;
> p.zabel@pengutronix.de; linux-usb@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git <git@xilinx.com>
> Subject: Re: [PATCH v2 1/2] dt-bindings: usb: dwc3-xilinx: Add
> documentation for Versal DWC3 Controller
>=20
> Rob Herring <robh@kernel.org> writes:
>=20
> > On Thu, Sep 10, 2020 at 12:33:04AM +0530, Manish Narani wrote:
> >> Add documentation for Versal DWC3 controller. Add required property
> >> 'reg' for the same. Also add optional properties for snps,dwc3.
> >>
> >> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> >> ---
> >>  .../devicetree/bindings/usb/dwc3-xilinx.txt   | 20 +++++++++++++++++-=
-
> >>  1 file changed, 18 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> >> index 4aae5b2cef56..219b5780dbee 100644
> >> --- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> >> +++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> >> @@ -1,7 +1,8 @@
> >>  Xilinx SuperSpeed DWC3 USB SoC controller
> >>
> >>  Required properties:
> >> -- compatible:	Should contain "xlnx,zynqmp-dwc3"
> >> +- compatible:	May contain "xlnx,zynqmp-dwc3" or "xlnx,versal-
> dwc3"
> >> +- reg:		Base address and length of the register control block
> >>  - clocks:	A list of phandles for the clocks listed in clock-names
> >>  - clock-names:	Should contain the following:
> >>    "bus_clk"	 Master/Core clock, have to be >=3D 125 MHz for SS
> >> @@ -13,12 +14,24 @@ Required child node:
> >>  A child node must exist to represent the core DWC3 IP block. The name=
 of
> >>  the node is not important. The content of the node is defined in dwc3=
.txt.
> >>
> >> +Optional properties for snps,dwc3:
> >> +- dma-coherent:	Enable this flag if CCI is enabled in design. Adding =
this
> >> +		flag configures Global SoC bus Configuration Register and
> >> +		Xilinx USB 3.0 IP - USB coherency register to enable CCI.
> >> +- snps,enable-hibernation: Add this flag to enable hibernation suppor=
t
> for
> >> +		peripheral mode.
> >
> > This belongs in the DWC3 binding. It also implies that hibernation is
> > not supported by any other DWC3 based platform. Can't this be implied b=
y
> > the compatible string (in the parent)?

Rob, We can move this to dwc3 bindings. If Felipe is okay with below respon=
se.

>=20
> hibernation support is detectable in runtime, and we've been using that.

Felipe, Yes, this flag is to control the enable/disable hibernation.
I did not see has_hibernation flag being set anywhere in the driver.
Can we control the hibernation enable/disable through DT entry? See below:
-----
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 2eb34c8b4065..1baf44d8d566 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -769,8 +769,15 @@ static void dwc3_core_setup_global_control(struct dwc3=
 *dwc)
                        reg &=3D ~DWC3_GCTL_DSBLCLKGTNG;
                break;
        case DWC3_GHWPARAMS1_EN_PWROPT_HIB:
-               /* enable hibernation here */
-               dwc->nr_scratch =3D DWC3_GHWPARAMS4_HIBER_SCRATCHBUFS(hwpar=
ams4);
+               if (!device_property_read_bool(dwc->dev,
+                                              "snps,enable-hibernation")) =
{
+                       dev_dbg(dwc->dev, "Hibernation not enabled\n");
+               } else {
+                       /* enable hibernation here */
+                       dwc->nr_scratch =3D
+                               DWC3_GHWPARAMS4_HIBER_SCRATCHBUFS(hwparams4=
);
+                       dwc->has_hibernation =3D 1;
+               }

                /*
                 * REVISIT Enabling this bit so that host-mode hibernation
-----

Please provide your inputs.

Thanks,
Manish
