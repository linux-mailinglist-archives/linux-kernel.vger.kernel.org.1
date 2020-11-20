Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1832BA074
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 03:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgKTCc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 21:32:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:24853 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgKTCc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 21:32:28 -0500
IronPort-SDR: wtBvjoRb7IDzUBPZ1ChmQGNGL/YuroMhwLBj4LV8SAVCZlmrEkZ/Ygz/yguG2k/O+wP7jsCPGu
 dQpwHyj1Enzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="171500017"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="171500017"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 18:32:26 -0800
IronPort-SDR: NAuq667yFYMEkEwZNtP5rvIie1z4KB/ESFq08FwHV6AqvBE0Eo6IzOd8P86yBmBhTKI72mg9X5
 5z4cjh3MS7KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="545269166"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga005.jf.intel.com with ESMTP; 19 Nov 2020 18:32:26 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Nov 2020 18:32:26 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Nov 2020 18:32:26 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 19 Nov 2020 18:32:26 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 19 Nov 2020 18:32:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SECr0N9ZRoxuF59Mp0caN9hmrhXGiBOS0IGV4tC4ATnv5rNESsmOV2kJsHbWbun+i7NiOhYoo4pzVrjtsB40cVs77G/POA3WqvlIWhMFTqYocfIzYntLWy6Mgq7g6x4vGb4APuWyeasMtdEpdhYuNnqG18Ck/IrsupZGGNThGPkGI7T4KbTwrfiqo0E8TH6m/zWBCl1cYWR3NYzCzt1ppPLMrBfWq4Y0YrpE6r/eNFGjPqRozawjcsvfaX3yuIGvwrZGZP6BpdWfBGUgnl3dUSl0tl5B4fNlfBN7YBEITYjrE9+JDOvNiWiwWaOtedEFmunBRYUtsoHxhkzkoXC2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjLhoMLn8YcALFzGshlGtuHI8jxisSJQ9THUby6/SOU=;
 b=IgfFt4/VUOqvU177O3ndexOGmlqyD+1HNHhqzX6orPhVRP2H1E8ZKISOQcG9RXgYJBxocMgxKyqmsxoXk7Hrus0rpKOIc2b33kxzpL73BRXLkJNRtxXw6tEioLchr2Q8+dsSymBnGJHL56c1KDOYUd8Qu4OFyM6Y3ooriu+1aNBF6bwLcuPgzACZ4mD5TK+uuwpHwiGekZmBc7Nsog0l5I/NHS9ycSJTPJnRoEntefJbZ6fAkcjQeZ3BjZRF58OJSFh/HquJhulvX0BtEIUqeMNz1rPeZWOczbC6ms+QbsmAK6D0F9ICC5StFp2Y65M3MSnRKAcH9qYXXsVfcObGjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjLhoMLn8YcALFzGshlGtuHI8jxisSJQ9THUby6/SOU=;
 b=YV3Bl8fWBdLxWrkalGYqwHuEOpaFi/YAQl56yorkA9i/tldrIw8jfYx0LeRXds/q9ndSAlBPoQvF5D9j+OZk+v8d6V7+6YwMYujjW4H0RcNv3QhM5X0MWT90WdeDkf04GHjrFd2Ls21+fNP1b7rL9brPpk00DZ8H3WDoj3TD2Kw=
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by MWHPR11MB1437.namprd11.prod.outlook.com (2603:10b6:301:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 20 Nov
 2020 02:32:24 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ed62:6d3c:c9aa:4c4d]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ed62:6d3c:c9aa:4c4d%5]) with mapi id 15.20.3541.028; Fri, 20 Nov 2020
 02:32:24 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Prashant Malani <pmalani@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        "Shaikh, Azhar" <azhar.shaikh@intel.com>
Subject: RE: [PATCH v3 2/4] platform/chrome: cros_ec_typec: Use Thunderbolt 3
 cable discover mode VDO in USB4 mode
Thread-Topic: [PATCH v3 2/4] platform/chrome: cros_ec_typec: Use Thunderbolt 3
 cable discover mode VDO in USB4 mode
Thread-Index: AQHWvj38P4aA1Z7OikiHPeCCNaPmQ6nPGgQAgAEtF2A=
Date:   Fri, 20 Nov 2020 02:32:24 +0000
Message-ID: <MWHPR11MB004898556A4CF622742D3EAAA9FF0@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20201119063211.2264-1-utkarsh.h.patel@intel.com>
 <20201119063211.2264-3-utkarsh.h.patel@intel.com>
 <20201119080906.GE3652649@google.com>
In-Reply-To: <20201119080906.GE3652649@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51c1ba90-e87e-41e0-607f-08d88cfc83a3
x-ms-traffictypediagnostic: MWHPR11MB1437:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB143711521A95F802ADAFAA35A9FF0@MWHPR11MB1437.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lNoBz7JWeSXWjIg1ufS7zSmew6d83wVgepSkZ+TqG9hcSE7NzTD/0deki/ayv3re8Iax0XCTFIXFScgH1u7DPu1ohGzM1xJl4SI1AGpmFMEvI216jlIjr7eqtHi1wkdTzNcJIkJnrjj2koqgaQlkc+FP0tp8dDIz3DRY81coGDlZk3xFScaPDppUzyXozP8d2pZfxVObLFAPg3TyXHC7HbUaEJ8eUc5+1B4Bzu6iVs8eUX7ZrHk8IcyqOV0JMioFIGA1rauUSMUgjb6VbBYRDXvGPyUO4tBWQESuJkYqVri0C/+eXKqPTm/SA372TkbB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(9686003)(6916009)(83380400001)(8936002)(7696005)(86362001)(2906002)(33656002)(6506007)(26005)(8676002)(316002)(186003)(53546011)(54906003)(55016002)(478600001)(66946007)(5660300002)(52536014)(4326008)(66556008)(66476007)(66446008)(71200400001)(64756008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Gylz4/RlwZ5wJxfkHyUJupBgf7u0m27+6HInPbu2Ydol523OMKcotULfZPH790DaQHtECdK8kKuz1p/5xBNkGOaKrG2COw2YsiskV8iYoRvmZPwBGSMhCUX/hukcKSY0/RaQQV/BiCr5qgYbteZ6P4AKLxlPfUlX9SFnetUSmdQDsP2dYvQufyPdayWDH1h2ywqnPJ1W4gfT6jXWozKxciLiqq5zatzUFE0arMvf80LPEeBKVPwBc27eMFkgXHIH5hdMK2TezW/+LU9UyvL7XscT4s+mTA+6Ef0S1G6/0PXWwtD9tjCFYzVNVDsI/uTF7rWBETKQvIhbtceJiBAbAWncg/R0O1bewlwAoYUFiLl4EfsMtjkbYw62ZWSaB34WRd4RKSfEhrxjljICbYdFjTHSbqjmGfb6B5jP4c3uSWPzXxeTU1yRBK723qKON02jWwukONARdE0/elI0Oc+1mD9w1wm+sIbAzDeLZekU/N7b3CXoaMjDWd4aSwAF+m0KAiBp+N5Oyk3e8uZU56vmqjMB80Xvun5c2bG8PaDw22tU42zwQPRRjsvaIt7ZtejW9NarZh8BUQerhnjuVRD8nRN5VS2QDB57Wi8TBpPUhwSsbEp+Qc3wjjfFYu8E3igLZLFY6fxpsWgRyiEcM4Dwz3+Nu6gfld6Hm+dg0zrhHaKTsdMDoluhwGduzfRph2lTdHCVB9YvmnT2w2GBxnLewhLNTHJGnML+0ps/PWPSAiZqkVX821y6wOqX4OvkiYmhaK0o1iUo4fO0xr5nlYUAxsHyORICUmJlz0pcCOKSGjBei3npuaKUTBMt9bBAULUjbKcmDSEB1isCwQlVEKCxZG5aSTVfiwsuri6jwLKm5/YgrTgJduJzHLi1Vs1u92HRok32g5lEs8RkENewzK3tHQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c1ba90-e87e-41e0-607f-08d88cfc83a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 02:32:24.0325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iltgLUZs7Yvz48RHeQkOmlBh41GVvLwMVScnuV0LD7zofjZBH9UH68NmF7EDoJfPVSA7ukgP3DPPCQNPig5TFB688+7TFmvFqyHXFAEaBlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1437
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

> -----Original Message-----
> From: Prashant Malani <pmalani@chromium.org>
> Sent: Thursday, November 19, 2020 12:09 AM
> To: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> heikki.krogerus@linux.intel.com; enric.balletbo@collabora.com; Mani,
> Rajmohan <rajmohan.mani@intel.com>; Shaikh, Azhar
> <azhar.shaikh@intel.com>
> Subject: Re: [PATCH v3 2/4] platform/chrome: cros_ec_typec: Use Thunderbo=
lt
> 3 cable discover mode VDO in USB4 mode
>=20
> Hi Utkarsh,
>=20
> On Wed, Nov 18, 2020 at 10:32:09PM -0800, Utkarsh Patel wrote:
> > Configure Thunderbolt 3 cable generation value by filling Thunderbolt
> > 3 cable discover mode VDO to support rounded Thunderbolt 3 cables.
> > While we are here use Thunderbolt 3 cable discover mode VDO to fill
> > active cable plug link training value.
> >
> > Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> >
> > --
> > Changes in v3:
> > - Added a check for cable's TBT support before filling TBT3 discover mo=
de
> >   VDO.
> >
> > Changes in v2:
> > - No change.
> > --
> > ---
> >  drivers/platform/chrome/cros_ec_typec.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c
> > b/drivers/platform/chrome/cros_ec_typec.c
> > index 8111ed1fc574..68b17ee1d1ae 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -514,8 +514,18 @@ static int cros_typec_enable_usb4(struct
> cros_typec_data *typec,
> >  	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
> >  		data.eudo |=3D EUDO_CABLE_TYPE_RE_TIMER <<
> EUDO_CABLE_TYPE_SHIFT;
> >
> > -	data.active_link_training =3D !!(pd_ctrl->control_flags &
> > -				       USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
> > +	/*
> > +	 * Filling TBT3 Cable VDO when TBT3 cable is being used to establish
> > +	 * USB4 connection.
> > +	 */
> > +	if (pd_ctrl->cable_gen) {
> > +		data.tbt_cable_vdo =3D TBT_MODE;
> > +
> > +		if (pd_ctrl->control_flags &
> USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
> > +			data.tbt_cable_vdo |=3D TBT_CABLE_LINK_TRAINING;
> > +
> > +		data.tbt_cable_vdo |=3D TBT_SET_CABLE_ROUNDED(pd_ctrl-
> >cable_gen);
> > +	}
>=20
> I think the following would decouple Rounded Support and Active Cable Lin=
k
> Training?:

Any reason you would want to decouple them?
As for the TBT3 active cable to create USB4 connection, it needs have round=
ed data rates.=20

>=20
> 	struct typec_thunderbolt_data data =3D {}; ...
> 	if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
> 		data.tbt_cable_vdo |=3D TBT_CABLE_LINK_TRAINING;
>=20
> 	data.tbt_cable_vdo |=3D TBT_SET_CABLE_ROUNDED(pd_ctrl-
> >cable_gen);
>=20
> 	if (data.tbt_cable_vdo)
> 		data.tbt_cable_vdo |=3D TBT_MODE;
>=20
>=20
> Best regards,
>=20
> -Prashant

Sincerely,
Utkarsh Patel.
