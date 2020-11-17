Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525F22B71AB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgKQWh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:37:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:12860 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbgKQWh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:37:28 -0500
IronPort-SDR: wbyc1icAw/y192UhnbxVpYH1CtUyYEhm7NL89erFjlR4opMbSzoy4pe8t+z0IQRNY1lUWIO8QU
 Th6aB5+JamBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150873266"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="150873266"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 14:37:27 -0800
IronPort-SDR: HIlCh1KOX1pPhZ9KS7XK8yqJ6mEdM7DMX9cQRE6pLy1UkkDUkZ+n+Ec+S+SwcNKlw1PYX65PV5
 LN62wwn7ATwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="325335070"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2020 14:37:27 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Nov 2020 14:37:27 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Nov 2020 14:37:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Nov 2020 14:37:27 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 17 Nov 2020 14:37:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEf1P54Wlt0frGLhsC9MbpkmlqbO6OXUDi69fDrwLXDEsAtwu7nxgSWLyxaWu8urho5UcBUrR58H8m9JkUbbwrLkzgtWqX8KYXoiP0IRmBpVRv7jxm56mdmh3WPpAdPsAEtcBIePpy3j40oB9OrUWAiOruHkw19FPHlnrqwf8c7CnGp+UMP+1VxYdw1QjeHb0nSjIUeRreX4NN35ejXKe0z+wyNsB5COZDzyt5US57Rfu9Qxd+k6fslL6bIDFq47yr7WT5iaslgFLR+QZi1iafM/Cs1mKa3abdG3VsJJ3aKA+dLaRL/j9nFHPPT+Nx0zsdTr+ykeTvVI9BJyMBhuMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRMgesPTdkZ9Pj8JdlJNGruyf/IHbu8ESkqCnn2VCkI=;
 b=GGwsS9EEGy2j7N1+benuPBtGEBjWT1yIgnyj/AKGMWoSAHwnBkVGnp3X+nHcjgyDG2k4VXZuGMsarV1gA0/PGcsIoMaQq9VpWFlv1sZyuPKSU8SGv9jyqpn3HL3KHcYShgnaL7qnrfJxlM6KplWZxZCNLBydeTnGe9IhVXGaE2fWSsmIkuposazM1baRnaDfCmhDB19g3g68/w2ZnVqjYFq+A6ZgqNhc10N5NEUgKhbFYpRpazdPTTuX79IjdLa0ADRtJi/tZmNzq69HhowXPWI5d8fIHpJQ4HeXQJ6BROIDWne0Nanufasjd4Ta3RZKl1obwQlwsS62zOw9XO9g2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRMgesPTdkZ9Pj8JdlJNGruyf/IHbu8ESkqCnn2VCkI=;
 b=dw4Qx3ECBk+CTVemKHWbEqd/U/i/peMKADWy60PKCrrV8XvdYdqaIZNVz7Wfj/WbvLitYjSYl+yQwcjZddI3Y4e7FKzK9pJHP9I0JtcP1M43eZIKdyDv/s/4H8ti9CWpGpGYYCinGgR2Je1shnK8nHg4zQz1wdrjS8Ksa/876/0=
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by MWHPR11MB1439.namprd11.prod.outlook.com (2603:10b6:301:9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 22:37:25 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ed62:6d3c:c9aa:4c4d]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ed62:6d3c:c9aa:4c4d%5]) with mapi id 15.20.3541.028; Tue, 17 Nov 2020
 22:37:25 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        "Shaikh, Azhar" <azhar.shaikh@intel.com>
Subject: RE: [PATCH v2 7/8] usb: typec: intel_pmc_mux: Configure active cable
 properties for USB4
Thread-Topic: [PATCH v2 7/8] usb: typec: intel_pmc_mux: Configure active cable
 properties for USB4
Thread-Index: AQHWuftcvRTGQa9W7k+FodjnNhK3kanMRG2AgACrpwA=
Date:   Tue, 17 Nov 2020 22:37:25 +0000
Message-ID: <MWHPR11MB004881BD25EDEA77F68931C1A9E20@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
 <20201113202503.6559-8-utkarsh.h.patel@intel.com>
 <20201117122137.GG3437448@kuha.fi.intel.com>
In-Reply-To: <20201117122137.GG3437448@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [50.39.100.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6900c43e-9b38-4011-35bd-08d88b495b84
x-ms-traffictypediagnostic: MWHPR11MB1439:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB14395A40060E15A316E76070A9E20@MWHPR11MB1439.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jgVbWRYpIEQHqsv9PR6dFAm7oA/EBYHsANnqHNJDmSWSCt9D4xlZKnpFUGatdWjya5SmTe5MCk41jXVnNgyl9ITINHsJtziV0kX/xpKylTK6NG+CGKOxVk2PNwtnqAYQJLISdfRsO2nqam1Gxxkt7UywyaDY90rgVAhQpmRR/qbqzQtzZMWrzcx0ScK+ibS0DGtovG69c+1z6VK1MTWcjzdSJ87ymdOe2dWF8197B6Cyyq3S3UdmUp56owgr8p3I4BpOv+ALXWo/z8qagGW5pr5stVTwYzvpk/mJ6hMgftDcSSO7uCVoYglejp92Wm7oRW9+SS8fgCUgT7RSox4IrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(53546011)(76116006)(2906002)(5660300002)(8936002)(86362001)(186003)(478600001)(33656002)(52536014)(55016002)(9686003)(8676002)(66946007)(83380400001)(26005)(54906003)(4326008)(66556008)(66476007)(66446008)(6916009)(316002)(6506007)(71200400001)(64756008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: kprsJWxVU8xvAtbL+NzZtOLXre83W8kbfeBXuy+tniPvbWzqiwGjvpHhQ6yB3EKuVPx/tn0xtWChyHwVYwVN1CX0ZBHE9N6JQkDagXcpWRA7R8Fn7hkn//cVmIZgKWzgMsjZUNbtU8Cd/Umf7s7QYF3z3wzQpLzucOGQz/Bm6ItTQRgIkci1rgO5MMOjpfpvASeAgTucDqrXlJ+jSt9yAmTw01teidM5dyekCgt4+DuiOFMw5LfprKyMYkHWi7zqhSELb4h681kK4azG7bQ01k4kZZdn++IdPPWSd5Btrp0ZACNYJEwazLRB+2NYmCdoTJF7HaM7+XhKUaSX7k7q3Alo/T08fEK0Mu+DGVD8pP3jXwPQH2Ad9SS8xfsDuZYqbhuDNi7QazKO+HUvU2dPf+DF9OBuGWYhovABPXvgAwZY/4oxC5vzW6/dve9b1/2Ex8vIvzStT71/lO27FxfH4aNnsESdhp5z1hn71IqgJoLR4G0O5TCu13A+KbJgp4vY5sq0IEhPPRZiUzARRiMioVlhePXfomS/Vwr0kjoznZDqXgWIY8aXf8LW+NsvbyS6Bs8yIKV3g9C80j+0mxiTkMaH1IrfEY531PYd1bK2l1VdkO35peTzEQnHaOEajekZ/M/h2zn1rkCprpK/onJ84hkW/cDZGdHcXtblCJplyMiziPrgpJt4nCUBRBPANZOqp3fcZ1bb3s3McZmdc1jGlQd2au3kXP5Vfg6eWDfm6a1JIFbYNu9PKfZKFYZmx8X0DcSg7QsaTPGrqFA/5b+lYniFVShLsB6WQue+3wsLDD708xDs/EGQI8DiOBSC3yxrxTKm6Ch4JG7wqjH/7KvCFS0WVRyCTukU3kA3r9bHKNZeeiTP7FElx7pTTBoUZ2H5o5Y8w5eBNO0FBqYX5ooXVw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6900c43e-9b38-4011-35bd-08d88b495b84
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 22:37:25.5980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKrZLVdR6v2j46xpxfI2kXxY8T/WMyvqrGKoCdXbBYAXa6L6UdCRpepxW+YQjcLDnG5P4KFxHTqwW1Vlj2tf/Koobbbby3DRGHQwQ5nEQXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1439
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

> -----Original Message-----
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Sent: Tuesday, November 17, 2020 4:22 AM
> To: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> pmalani@chromium.org; enric.balletbo@collabora.com; Mani, Rajmohan
> <rajmohan.mani@intel.com>; Shaikh, Azhar <azhar.shaikh@intel.com>
> Subject: Re: [PATCH v2 7/8] usb: typec: intel_pmc_mux: Configure active c=
able
> properties for USB4
>=20
> On Fri, Nov 13, 2020 at 12:25:02PM -0800, Utkarsh Patel wrote:
> > Value received as a part of Thunderbolt 3 cable discover mode VDO
> > needs to be configured in the USB4 mode for the Thunderbolt rounded
> > support and active cable plug link training.
> >
> > Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> >
> > --
> > Changes in v2:
> > - No change.
> > --
> > ---
> >  drivers/usb/typec/mux/intel_pmc_mux.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c
> > b/drivers/usb/typec/mux/intel_pmc_mux.c
> > index aa3211f1c4c3..61feb358aad3 100644
> > --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> > +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> > @@ -295,6 +295,7 @@ pmc_usb_mux_usb4(struct pmc_usb_port *port,
> struct
> > typec_mux_state *state)  {
> >  	struct enter_usb_data *data =3D state->data;
> >  	struct altmode_req req =3D { };
> > +	u8 cable_rounded;
> >  	u8 cable_speed;
> >
> >  	if (IOM_PORT_ACTIVITY_IS(port->iom_status, TBT) || @@ -308,9
> +309,6
> > @@ pmc_usb_mux_usb4(struct pmc_usb_port *port, struct
> typec_mux_state *state)
> >  	/* USB4 Mode */
> >  	req.mode_data =3D PMC_USB_ALTMODE_FORCE_LSR;
> >
> > -	if (data->active_link_training)
> > -		req.mode_data |=3D PMC_USB_ALTMODE_ACTIVE_LINK;
> > -
> >  	req.mode_data |=3D (port->orientation - 1) <<
> PMC_USB_ALTMODE_ORI_SHIFT;
> >  	req.mode_data |=3D (port->role - 1) << PMC_USB_ALTMODE_UFP_SHIFT;
> >
> > @@ -322,6 +320,20 @@ pmc_usb_mux_usb4(struct pmc_usb_port *port,
> struct typec_mux_state *state)
> >  		fallthrough;
> >  	default:
> >  		req.mode_data |=3D PMC_USB_ALTMODE_ACTIVE_CABLE;
> > +
> > +		if (data->tbt_cable_vdo) {
> > +			/* Active Thunderbolt 3 cable */
> > +			if (data->tbt_cable_vdo &
> TBT_CABLE_LINK_TRAINING)
> > +				req.mode_data |=3D
> PMC_USB_ALTMODE_ACTIVE_LINK;
> > +
> > +			cable_rounded =3D
> > +				TBT_CABLE_ROUNDED_SUPPORT(data-
> >tbt_cable_vdo);
>=20
> No need for the newline:

Ack

>=20
> 			cable_rounded =3D
> TBT_CABLE_ROUNDED_SUPPORT(data->tbt_cable_vdo);
>=20
> > +			req.mode_data |=3D
> PMC_USB_ALTMODE_TBT_GEN(cable_rounded);
> > +		} else {
> > +			/* Active USB4 cable */
> > +			req.mode_data |=3D PMC_USB_ALTMODE_ACTIVE_LINK
> |
> > +				PMC_USB_ALTMODE_TBT_GEN(1);
> > +		}
> >  		break;
> >  	}
>=20
> thanks,
>=20
> --
> Heikki

Sincerely,
Utkarsh Patel.
