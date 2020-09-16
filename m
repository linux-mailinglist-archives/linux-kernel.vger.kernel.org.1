Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BA226C576
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 18:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIPQ72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 12:59:28 -0400
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com ([40.107.237.46]:30017
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726591AbgIPQxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:53:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1Wxo/mvAM9xEeFsCZI0l8XxkkI8QRAAdJU6vI8n3zDvTuVBfnhzqYX/oQSNCWm3HKmx/clyJ1sKMvwUTXYAeXYvGAwggkx+BLU66sJKgF0UpTCf/8K+m4wR3CqtWfl3v8kxBCNSDwz9JYJ8nPrs20n41Xdd34o31o9c8N8zfO2hg0Cddeu2x1YSxjIcwowQNVfR4LfHKDbp0l0h6xtR3eg01DvYsx+QlPPjZag/MUpIUEQ/qnua2+o26ub19E28piSCEE/uNasn+CvpOjdAMcdFryl7z/Jipuj6SCMdrTf9MSC2ni2bGEw5X/RmBLhV/7bKIDZC9+ZNpjPFA/el+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ni3eEGUkp85vu4hlkINe1v0gFKSYVc8Ey4nz/sPfXGc=;
 b=CwTZmAs2Kk+/P12jqhY8lMl7GsLtkQ/ru+HcCYwshMbwIxajLD2quVa+VCx9O/oCJKpVWgNlz0OHpVj+AwHydxxFUDlP5474N+VGxu8BZY8btDw0Zd3DnUOVL2Usb/hTe6TnUYeKRsGuCHsWhRknF7aag2uwPFQjRF+9grpED7Sr9GKzQwdaUuerPw9Qc/sw43JOhdbFk7W9vHWaON/N+1y8yusvA/g1Lv0uOcp255rnj+vVM/Ne6My2UX2mQGBqpA9yZU7Qp1Vcv3XMOj1+w25zfZYelAMph8RzLrnqGHsf2oy7vz385vpMl6cAw4KCQNnHRM//LjAfAQLHFqEt0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ni3eEGUkp85vu4hlkINe1v0gFKSYVc8Ey4nz/sPfXGc=;
 b=GOGxItGo4ssnG2R1ERDfCPWlDzCJUiBAKwabO2NkvC8zHIXTPftKOvQHwwBv36f9pXILl+4DqjI9F24Jqfpd2NuwLiXJm8Izd/tEbARwasnxCFq6WRiXGhYJ9Y5D/DEreomNSDYcZG0FcPZLumju4oiAZoQSlVHUwN2tsWQxJPI=
Received: from BYAPR02MB5622.namprd02.prod.outlook.com (2603:10b6:a03:9b::32)
 by BY5PR02MB6852.namprd02.prod.outlook.com (2603:10b6:a03:207::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 16 Sep
 2020 16:53:25 +0000
Received: from BYAPR02MB5622.namprd02.prod.outlook.com
 ([fe80::dc74:73a0:fe2:6c6e]) by BYAPR02MB5622.namprd02.prod.outlook.com
 ([fe80::dc74:73a0:fe2:6c6e%6]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 16:53:25 +0000
From:   Amit Sunil Dhamne <amitsuni@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        Tejas Patel <TEJASP@xilinx.com>,
        Jolly Shah <JOLLYS@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>
Subject: RE: [PATCH 1/3] firmware: xilinx: Add validation check for IOCTL
Thread-Topic: [PATCH 1/3] firmware: xilinx: Add validation check for IOCTL
Thread-Index: AQHWhwg4A4eef5X5ukS95py8Uwip4KlrLFsAgABXakA=
Date:   Wed, 16 Sep 2020 16:53:24 +0000
Message-ID: <BYAPR02MB56225CBE23F9F9CCE157F63FA7210@BYAPR02MB5622.namprd02.prod.outlook.com>
References: <1599697204-32103-1-git-send-email-amit.sunil.dhamne@xilinx.com>
 <1599697204-32103-2-git-send-email-amit.sunil.dhamne@xilinx.com>
 <20200916113334.GB1124534@kroah.com>
In-Reply-To: <20200916113334.GB1124534@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=xilinx.com;
x-originating-ip: [24.130.17.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41be25ff-ce9f-48fc-8662-08d85a61073b
x-ms-traffictypediagnostic: BY5PR02MB6852:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB685275B870984F496C6FCF1BA7210@BY5PR02MB6852.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:374;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1OZhynxu2QTLMm6MmW/Ljne536dVSAwc07i8ZSfHqujei2dIamsQptm6Us/3fPpN1HGuAasflKRfJABdL/oZLwm2J/+/vQ9MKRJdvPSkTQvu2m0GBQsSJXn2aSXPNWiPV64GJQdQjZRFhLE6O8/+U7spepMlb1d8JVRkArllEinGR/UNi8ig9lsXCKJnWNY17d3HXan9Q6HYxUELtaIbdANrvtlwdK5BCIZQh2wZlcINi+AivUPX50pzv84ErHcrpxovAbBgUhuP6Ri0wIGBK4ORzpTx0s5v4w/veVe7eo5+pL+jGOV1z7Gzc7ohKocCd/UWvMkh6tfIZqbaR9CsUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5622.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(346002)(136003)(39860400002)(2906002)(7416002)(33656002)(83380400001)(4326008)(86362001)(9686003)(8936002)(6916009)(107886003)(8676002)(55016002)(64756008)(66556008)(478600001)(76116006)(66476007)(66446008)(66946007)(5660300002)(54906003)(52536014)(186003)(7696005)(71200400001)(316002)(26005)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: sju79GoIXFm3jyQuJV6bi0Kwv4M5iSjTrl8P95c/XN8Vw8Ouk8K5wXHY7HQVkMAhvw3FBrS1gOvJPli7pnHz/R6UBbJQqbRND3n0bnKooDw3Y+FHkh7eCwlPSrsVbbLFspihhISUDDAHZ3xX909riNC2VOhg14jpSVuJ4zT/Ld+8M5uFMPsGUeg7XxS7fytnmTrCk6txPQvutvx8edKfBNRKXQ/CpiIkVogasC4mtRyFXuwylSSn58Rgop26oeP1u8YRd6/Yu6/cgjMOs6UPR3FlxCwKTtGY3J2WoNhv9u/wieeDpmJvzqchicvOniV6ntHigDqEJGnpUg/C5KYz9gdO/V6uKs9WthnGiAw9mGec2scFE2MfRrDVuACKi+6uMCjUyahXA4cXAwwgfPAtCQGNIlQoN1e5nD0Xc6vrnHCG8Y8GAKLjJuN5kDNMXBA5XRS5NbzhiKwWTOeQLCTaEaPBw0kJ7TeAJ/LbqstseJ6/4k6uJpXqLIrTN47qyyx0RyFHF4x7pKMsWnDlpED5vn1qhinrLFmH2yeKDY5eoWEUFnL+FoEViZmR+CXF/X3RHmoYmLr7nyZOMbKdXocQ5EbxnajA0SW+YiXFSnc4lh9Ws+0GNGeiSGFczUOExXTY1H1M7E17jeZSLN9tucWcYw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5622.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41be25ff-ce9f-48fc-8662-08d85a61073b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 16:53:25.0385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kqsa6GXpD6O9F1x8VAcCbFJ06d1JxpKz+OwE+maCnNMBZKne7IOckcrLBUTKS8WDO70CRkpa7HquHTx0E1e+0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6852
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, September 16, 2020 4:34 AM
> To: Amit Sunil Dhamne <amitsuni@xilinx.com>
> Cc: ard.biesheuvel@linaro.org; mingo@kernel.org;
> matt@codeblueprint.co.uk; sudeep.holla@arm.com; hkallweit1@gmail.com;
> keescook@chromium.org; dmitry.torokhov@gmail.com; Michal Simek
> <michals@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; Tejas Patel
> <TEJASP@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Rajan Vaja
> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>
> Subject: Re: [PATCH 1/3] firmware: xilinx: Add validation check for IOCTL
>=20
> On Wed, Sep 09, 2020 at 05:20:02PM -0700, Amit Sunil Dhamne wrote:
> > From: Tejas Patel <tejas.patel@xilinx.com>
> >
> > Validate IOCTL ID for ZynqMP and Versal before calling
> > zynqmp_pm_invoke_fn().
> >
> > Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> > Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
> > ---
> >  drivers/firmware/xilinx/zynqmp.c | 117
> > +++++++++++++++++++++++++++++++--------
> >  1 file changed, 95 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/firmware/xilinx/zynqmp.c
> > b/drivers/firmware/xilinx/zynqmp.c
> > index 8d1ff24..8fe0912 100644
> > --- a/drivers/firmware/xilinx/zynqmp.c
> > +++ b/drivers/firmware/xilinx/zynqmp.c
> > @@ -514,6 +514,89 @@ int zynqmp_pm_clock_getparent(u32 clock_id, u32
> > *parent_id)  EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getparent);
> >
> >  /**
> > + * versal_is_valid_ioctl() - Check whether IOCTL ID is valid or not
> > +for versal
> > + * @ioctl_id:  IOCTL ID
> > + *
> > + * Return: 1 if IOCTL is valid else 0  */ static inline int
> > +versal_is_valid_ioctl(u32 ioctl_id) {
> > +       switch (ioctl_id) {
> > +       case IOCTL_SD_DLL_RESET:
> > +       case IOCTL_SET_SD_TAPDELAY:
> > +       case IOCTL_SET_PLL_FRAC_MODE:
> > +       case IOCTL_GET_PLL_FRAC_MODE:
> > +       case IOCTL_SET_PLL_FRAC_DATA:
> > +       case IOCTL_GET_PLL_FRAC_DATA:
> > +       case IOCTL_WRITE_GGS:
> > +       case IOCTL_READ_GGS:
> > +       case IOCTL_WRITE_PGGS:
> > +       case IOCTL_READ_PGGS:
> > +       case IOCTL_SET_BOOT_HEALTH_STATUS:
> > +               return 1;
> > +       default:
> > +               return 0;
>=20
> bool is nicer, right?
>=20
> > +       }
> > +}
> > +
> > +/**
> > + * zynqmp_is_valid_ioctl() - Check whether IOCTL ID is valid or not
> > + * @ioctl_id:  IOCTL ID
> > + *
> > + * Return: 1 if IOCTL is valid else 0  */ static inline int
> > +zynqmp_is_valid_ioctl(u32 ioctl_id) {
> > +       switch (ioctl_id) {
> > +       case IOCTL_SD_DLL_RESET:
> > +       case IOCTL_SET_SD_TAPDELAY:
> > +       case IOCTL_SET_PLL_FRAC_MODE:
> > +       case IOCTL_GET_PLL_FRAC_MODE:
> > +       case IOCTL_SET_PLL_FRAC_DATA:
> > +       case IOCTL_GET_PLL_FRAC_DATA:
> > +       case IOCTL_WRITE_GGS:
> > +       case IOCTL_READ_GGS:
> > +       case IOCTL_WRITE_PGGS:
> > +       case IOCTL_READ_PGGS:
> > +       case IOCTL_SET_BOOT_HEALTH_STATUS:
> > +               return 1;
> > +       default:
> > +               return 0;
> > +       }
> > +}
> > +
> > +/**
> > + * zynqmp_pm_ioctl() - PM IOCTL API for device control and configs
> > + * @node_id:   Node ID of the device
> > + * @ioctl_id:  ID of the requested IOCTL
> > + * @arg1:      Argument 1 to requested IOCTL call
> > + * @arg2:      Argument 2 to requested IOCTL call
> > + * @out:       Returned output value
> > + *
> > + * This function calls IOCTL to firmware for device control and
> configuration.
> > + *
> > + * Return: Returns status, either success or error+reason  */ static
> > +int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
> > +                          u32 *out)
> > +{
> > +       struct device_node *np;
> > +
> > +       np =3D of_find_compatible_node(NULL, NULL, "xlnx,versal");
> > +       if (np) {
> > +               if (!versal_is_valid_ioctl(ioctl_id))
> > +                       return -EINVAL;
>=20
> Wrong error value.
>=20
> > +       } else {
> > +               if (!zynqmp_is_valid_ioctl(ioctl_id))
> > +                       return -EINVAL;
>=20
> Wrong error value.
>=20
> > +       }
> > +       of_node_put(np);
> > +
> > +       return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, ioctl_id, arg1,
> arg2,
> > +                                  out);
>=20
> No other checking of ioctl commands and arguments?  Brave...
>=20
> > +}
> > +
> > +/**
> >   * zynqmp_pm_set_pll_frac_mode() - PM API for set PLL mode
> >   *
> >   * @clk_id:    PLL clock ID
> > @@ -525,8 +608,7 @@
> EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getparent);
> >   */
> >  int zynqmp_pm_set_pll_frac_mode(u32 clk_id, u32 mode)  {
> > -       return zynqmp_pm_invoke_fn(PM_IOCTL, 0,
> IOCTL_SET_PLL_FRAC_MODE,
> > -                                  clk_id, mode, NULL);
> > +       return zynqmp_pm_ioctl(0, IOCTL_SET_PLL_FRAC_MODE, clk_id,
> > + mode, NULL);
> >  }
> >  EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_mode);
> >
> > @@ -542,8 +624,7 @@
> EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_mode);
> >   */
> >  int zynqmp_pm_get_pll_frac_mode(u32 clk_id, u32 *mode)  {
> > -       return zynqmp_pm_invoke_fn(PM_IOCTL, 0,
> IOCTL_GET_PLL_FRAC_MODE,
> > -                                  clk_id, 0, mode);
> > +       return zynqmp_pm_ioctl(0, IOCTL_GET_PLL_FRAC_MODE, clk_id, 0,
> > + mode);
> >  }
> >  EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_mode);
> >
> > @@ -560,8 +641,7 @@
> EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_mode);
> >   */
> >  int zynqmp_pm_set_pll_frac_data(u32 clk_id, u32 data)  {
> > -       return zynqmp_pm_invoke_fn(PM_IOCTL, 0,
> IOCTL_SET_PLL_FRAC_DATA,
> > -                                  clk_id, data, NULL);
> > +       return zynqmp_pm_ioctl(0, IOCTL_SET_PLL_FRAC_DATA, clk_id,
> > + data, NULL);
> >  }
> >  EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_data);
> >
> > @@ -577,8 +657,7 @@
> EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_data);
> >   */
> >  int zynqmp_pm_get_pll_frac_data(u32 clk_id, u32 *data)  {
> > -       return zynqmp_pm_invoke_fn(PM_IOCTL, 0,
> IOCTL_GET_PLL_FRAC_DATA,
> > -                                  clk_id, 0, data);
> > +       return zynqmp_pm_ioctl(0, IOCTL_GET_PLL_FRAC_DATA, clk_id, 0,
> > + data);
> >  }
> >  EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_data);
> >
> > @@ -595,8 +674,8 @@
> EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_data);
> >   */
> >  int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value)  {
> > -       return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> IOCTL_SET_SD_TAPDELAY,
> > -                                  type, value, NULL);
> > +       return zynqmp_pm_ioctl(node_id, IOCTL_SET_SD_TAPDELAY, type,
> value,
> > +                              NULL);
> >  }
> >  EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_tapdelay);
> >
> > @@ -612,8 +691,7 @@
> EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_tapdelay);
> >   */
> >  int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)  {
> > -       return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> IOCTL_SET_SD_TAPDELAY,
> > -                                  type, 0, NULL);
> > +       return zynqmp_pm_ioctl(node_id, IOCTL_SET_SD_TAPDELAY, type,
> > + 0, NULL);
> >  }
> >  EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
> >
> > @@ -628,8 +706,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
> >   */
> >  int zynqmp_pm_write_ggs(u32 index, u32 value)  {
> > -       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_WRITE_GGS,
> > -                                  index, value, NULL);
> > +       return zynqmp_pm_ioctl(0, IOCTL_WRITE_GGS, index, value,
> > + NULL);
> >  }
> >  EXPORT_SYMBOL_GPL(zynqmp_pm_write_ggs);
> >
> > @@ -644,8 +721,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_write_ggs);
> >   */
> >  int zynqmp_pm_read_ggs(u32 index, u32 *value)  {
> > -       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_READ_GGS,
> > -                                  index, 0, value);
> > +       return zynqmp_pm_ioctl(0, IOCTL_READ_GGS, index, 0, value);
> >  }
> >  EXPORT_SYMBOL_GPL(zynqmp_pm_read_ggs);
> >
> > @@ -661,8 +737,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_read_ggs);
> >   */
> >  int zynqmp_pm_write_pggs(u32 index, u32 value)  {
> > -       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_WRITE_PGGS,
> index, value,
> > -                                  NULL);
> > +       return zynqmp_pm_ioctl(0, IOCTL_WRITE_PGGS, index, value,
> > + NULL);
> >  }
> >  EXPORT_SYMBOL_GPL(zynqmp_pm_write_pggs);
> >
> > @@ -678,8 +753,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_write_pggs);
> >   */
> >  int zynqmp_pm_read_pggs(u32 index, u32 *value)  {
> > -       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_READ_PGGS,
> index, 0,
> > -                                  value);
> > +       return zynqmp_pm_ioctl(0, IOCTL_READ_PGGS, index, 0, value);
> >  }
> >  EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
> >
> > @@ -694,8 +768,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
> >   */
> >  int zynqmp_pm_set_boot_health_status(u32 value)  {
> > -       return zynqmp_pm_invoke_fn(PM_IOCTL, 0,
> IOCTL_SET_BOOT_HEALTH_STATUS,
> > -                                  value, 0, NULL);
> > +       return zynqmp_pm_ioctl(0, IOCTL_SET_BOOT_HEALTH_STATUS,
> value,
> > + 0, NULL);
> >  }
> >
> >  /**
> > --
> > 2.7.4
> >
> > This email and any attachments are intended for the sole use of the nam=
ed
> recipient(s) and contain(s) confidential information that may be propriet=
ary,
> privileged or copyrighted under applicable law. If you are not the intend=
ed
> recipient, do not read, copy, or forward this email message or any
> attachments. Delete this email message and any attachments immediately.
>=20
> Oops, this means I have to drop this, it's not compatible with kernel
> development, sorry.
>=20
> greg k-h

I will incorporate your suggestions in the next version of patch-set. The
footer message has unfortunately cropped up. Will also fix that in the next=
 version.

Thanks,
Amit
