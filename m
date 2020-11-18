Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007472B753E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 05:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgKREHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 23:07:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:62296 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgKREHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 23:07:18 -0500
IronPort-SDR: UdmvnV2cZJK4F06uT5P8bUJP3wWMRiixJ61XNJXv1ihHGRfxCCeHg5UmTAXZdgcK8LCxEIwZ8s
 U0TPl+zFzHqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="158836030"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="158836030"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 20:07:17 -0800
IronPort-SDR: Z2FHuHWAnYNcZoeZxthW2uvCWGxTrTq7+pV4s4MlEF2TJa3bSJaIQO9foIZBymCdSLNTpChVTb
 7xVksetpAp8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="359164901"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 17 Nov 2020 20:07:17 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Nov 2020 20:07:16 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Nov 2020 20:07:16 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Nov 2020 20:07:16 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 17 Nov 2020 20:07:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4rMOeG8wtd0r7Mcp1s9t80zQzNVz88RusYX2zPpXVrLweAQr0Wu2Ez8EJtREHKe8iq0DUIcGKEZq3I62UXkgX3O1DKQ9ybk0BOfax/IUXxsaP9xMpx2rleqAMG59Yptop4FSBdpQ9aJPscvJdEDHQRcCxHd/GDCixlv4VJKY9zO1a9uP5mCmo/nAIDbe6sFZKh9W+3B2RN8WYytGHMnUOudOB6jyeQN7T4IgeG7xy9CcHKud2xvS0wxVNhjQ2wDkNVxQxJbi1aUWhHRrOSHyvP/AiQtlfZgX7BUmcB4TR13Yh4a0ZQD2ZIC6wjwJUiiT0PExYGUV6eIq0PEfV+hSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wl4a8pyJ8vP5wYSXC4rERJxkx2rTyLznsdafI/LSFME=;
 b=OkxUIWB726RDxUndvi9A9cRLFKrqjPBN2d5LZmrZxDpevwTiVONQi4fJVNLfweWsz7aapWi2NctP/vi0GfOtYcFt1GlZoBxHymO6oEEB7fUiV3OUgISOkN+akACE0rtaMxlmcnfzCLPsof5q3pHM2Pcl89VJjPB2rHt6Vbqdb6GduoZ4nMwungigdBFVt5uTC6bQ9DKKd5q1Q0Vua8JJC24kk1Od7KS8AgNASbjzCDlmfyTXclQ5W7b0sV0SflKHFOcKiuYj7skuNd0FSRUXc3t0IA42dAaayp/01HvsYjhLlGwSJ15jFxbDLPOczLuyQT7SfL0J4KeyEKxEeVLCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wl4a8pyJ8vP5wYSXC4rERJxkx2rTyLznsdafI/LSFME=;
 b=F8CU72vAnYr8uVDFlylsmJQwaB6V8x4kWUBLq6KWJjAUWaUHmicIXz864vkh/girYSFblKQ1Vv0qXTM0wDHG06FW7P0xgM829H9xkCQYLPI0PaiQSWfzZRy4inVZUtAbF7OgeV6sfIJY2RDLbyIoUUa+YrtAt/AaAtNOdRURlI0=
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by MW3PR11MB4553.namprd11.prod.outlook.com (2603:10b6:303:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Wed, 18 Nov
 2020 04:07:13 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ed62:6d3c:c9aa:4c4d]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ed62:6d3c:c9aa:4c4d%5]) with mapi id 15.20.3541.028; Wed, 18 Nov 2020
 04:07:13 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Prashant Malani <pmalani@chromium.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        "Shaikh, Azhar" <azhar.shaikh@intel.com>
Subject: RE: [PATCH v2 6/8] platform/chrome: cros_ec_typec: Use Thunderbolt 3
 cable discover mode VDO in USB4 mode
Thread-Topic: [PATCH v2 6/8] platform/chrome: cros_ec_typec: Use Thunderbolt 3
 cable discover mode VDO in USB4 mode
Thread-Index: AQHWuftcA9UeMdxr60uOTAh25LiOwqnMqFwAgABxtwCAACW0sA==
Date:   Wed, 18 Nov 2020 04:07:13 +0000
Message-ID: <MWHPR11MB0048EBE0C9E0CCC44E79D7B0A9E10@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
 <20201113202503.6559-7-utkarsh.h.patel@intel.com>
 <20201117181918.GB1819103@google.com>
 <CACeCKacedkvQDq7pJm7G5qbu__5PerUkTK5DjtWy5StMShSB3w@mail.gmail.com>
In-Reply-To: <CACeCKacedkvQDq7pJm7G5qbu__5PerUkTK5DjtWy5StMShSB3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [50.39.100.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2953d78b-74b9-4002-74b0-08d88b776e15
x-ms-traffictypediagnostic: MW3PR11MB4553:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4553A92557E8259FA962E7C5A9E10@MW3PR11MB4553.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nog3h/q3Onl9UkMGWnC4kE8Z7I1XuAW0AXLsGwzMUcyiKgybF2KFfJ3G1vt4QaECUUkY5KLa4eOg/9Y7pDSFkfOu1YJrxbWwr7860zg0KwRJU8gcwAPF6N6IKm0+DTJVRW0m3mRvLaVkCyO9FrfMeHgjDRiCVQQfRwvEMVd65QicFtr76iY7zZQqKTWuYVgpy+v8likbDT5n2NAFBelBjYaPSsYeI8KIxOm6n+aROVK26J/CaWPRI8Gjq7EL1YfJbnlElGfgbbO2VFah6vIYbgaLqggyx+XlYY/iwVCuopePGF3zfelPTIv9em7Fy5If
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(52536014)(86362001)(55016002)(6506007)(5660300002)(9686003)(4326008)(54906003)(478600001)(7696005)(316002)(53546011)(2906002)(26005)(71200400001)(83380400001)(186003)(6916009)(8936002)(33656002)(66446008)(64756008)(8676002)(66946007)(66476007)(66556008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: eWTSjaXTajjAUjUwIQNlP7kytv7LxwFw9/kix9+GNqkJ/bKtCJgRclBCsyzGp+4vr+1Z8j6MFr0CrnK9aWCEyEk2waVOSBjGKsjjMyWf3py3LDhtxTfXrhWsbS3ck+55KiYLvDf6ZN0Ia6jRtD/eMCp1TFSE2G7/U/5Y85InFUqQPpky0ag/D3ChOSEPTd+xf1hDdH24uXylAeZyy0cMnF4VfOvB/WV7llwMwaR8W6s1GhaNJNUKiQsJ5EyLwpGCpuzZxZ1lzEuOzGQRP9NMRgCm7qdqlmF2BXb7iYUqB8dx0msNtjph3XfURwqzmysUCFX5YEVZ/PhL6IlO7vvKUtkKIjlJ//fx2AmM34ZhgOrgqN8M9S3m7on5cpUZRbBU8FfPWOrg6DBxb759oTmsxjursEL20qt2rnCjeC+ML2DQpv5YadGUSDi9mYC6K+IskHDmQYWbcHsrP4WUp/MVTkAEdCYF1mLHOzaEncmrqWyoK98uCtUhGSPdAm08l47xotzQJQRLTpQ4zC7QrRRXXWaIb7Dw11l6rN/1RnXBBovPRnoY9kXhRMjpbFVyuSTx9+JGqmpDYAlBFiQjhA4u/nZLZVfQOCQ89NEP6+gHmEFa80aZZwaj6fsIUlOV/jQR/AQU8sGlIqCH8JPZ9ydSsBfWUD8/YO+FSEjMlXMrTK5co8BQkcMhTp4kZrbqB5a2Cfn1u+mWIoQQSa1C1C6yvGq0SxHgGfbXVLvocOm5V2cTGSWxrYdDz7tZ7gPbgnGTO7nUUQKwjrP3IbWkvydFSfQzmpyp7u9vP0jjdiH0ub7PFOu2aXyzXFXT9ms/z+j5tjpT2lE8iK0S34bD+ZrqaHh+BKXZjUceyySRV3pezMT+xxfZWL2cPw7T3qJbsSj+AP7c21OcKgBydXy01LROyQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2953d78b-74b9-4002-74b0-08d88b776e15
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 04:07:13.3816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /E+xspt7MGEAoZ1rsdN/D+NHBC/o+b85Gswx0OeUuOTCmwnOczCMBlTmXgoNppilxhjxekq/hDgnTR8MUuG+CITcQm9rXmfQSK0ESbzNoeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4553
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Thank you for the review and feedback.=20

> On Tue, Nov 17, 2020 at 10:19 AM Prashant Malani <pmalani@chromium.org>
> wrote:
> >
> > Hi Utkarsh,
> >
> > On Fri, Nov 13, 2020 at 12:25:01PM -0800, Utkarsh Patel wrote:
> > > Configure Thunderbolt3/USB4 cable generation value by filing
> > > Thunderbolt 3 cable discover mode VDO to support rounded and
> > > non-rounded Thunderbolt3/
> > > USB4 cables.
> > > While we are here use Thunderbolt 3 cable discover mode VDO to fill
> > > active cable plug link training value.
> > >
> > > Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> > >
> > > --
> > > Changes in v2:
> > > - No change.
> > > --
> > > ---
> > >  drivers/platform/chrome/cros_ec_typec.c | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/platform/chrome/cros_ec_typec.c
> > > b/drivers/platform/chrome/cros_ec_typec.c
> > > index 8111ed1fc574..b7416e82c3b3 100644
> > > --- a/drivers/platform/chrome/cros_ec_typec.c
> > > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > > @@ -514,8 +514,18 @@ static int cros_typec_enable_usb4(struct
> cros_typec_data *typec,
> > >       else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
> > >               data.eudo |=3D EUDO_CABLE_TYPE_RE_TIMER <<
> > > EUDO_CABLE_TYPE_SHIFT;
> > >
> > > -     data.active_link_training =3D !!(pd_ctrl->control_flags &
> > > -                                    USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
> > > +     /*
> > > +      * This driver does not have access to the identity information=
 or
> > > +      * capabilities of the cable, so we don't know is it a real USB=
4 or
> > > +      * TBT3 cable. Therefore pretending that it's always TBT3 cable=
 by
> > > +      * filling the TBT3 Cable VDO.
> > > +      */
> > > +     data.tbt_cable_vdo =3D TBT_MODE;
> >
> > Is it safe to be making this assumption unconditionally? It might work
> > for Intel Mux agent but is it guaranteed to be safe for any other
> > future mux implementation? In other words, what if a "true" USB4 cable
> > is connected which doesn't have the Thunderbolt SVID alt mode?
>=20
> I dug into this a bit more and can maybe articulate my concern better:
>=20
> Is there a situation where both of the following are true ? :
> - Cable type =3D EUDO_CABLE_TYPE_OPTICAL or EUDO_CABLE_TYPE_RE_TIMER
> - No TBT_CABLE_LINK_TRAINING or TBT_CABLE_ROUNDED_SUPPORT defined
> (both
>   these are 0).

No, not in the case of USB4.=20

>=20
> If both the above are true, then in Patch 7/8, wouldn't we never hit the =
else
> condition (labeled "Active USB cable") and therefore not set the mode_dat=
a
> correctly?
>=20
> >
> > (Pre-fetching some alternatives in case the answer is no)
> >
> > You might want to check with the Cros EC team if you can repurpose a
> > bit of the "reserved" field for specifying whether the cable is TBT or =
not.
> >
> > Either that or see if there is a way to determine from the
> > pd_ctrl->cable_speed whether the cable is actually TBT or not.
>=20
> It seems link cable_gen and USB_PD_CTRL_ACTIVE_LINK_UNIDIR are
> reasonable proxies for whether the cable has TBT support, so perhaps we
> should only set tbt_cable_vdo =3D TBT_MODE if either of those are non-zer=
o?
>=20
> WDYT?

Since we do not have these information available with USB4 cables, we can u=
se them to check for TBT support and then set tbt_cable_vdo.=20

>=20
> Best regards,
>=20
> -Prashant

Sincerely,
Utkarsh Patel.=20
