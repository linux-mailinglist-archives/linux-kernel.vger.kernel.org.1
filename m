Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22952AE5F4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 02:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbgKKBis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 20:38:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:51945 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732589AbgKKBil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 20:38:41 -0500
IronPort-SDR: CFW0g1Q+lLfw7m2dpO6TN6z/icmEDanwRJ7IRGh5J3pRIBO4PvUfhYowYrE07KEtbD2jDAOixc
 XQhTpGtovrTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="170187714"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="170187714"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 17:38:38 -0800
IronPort-SDR: TwF3ER8Puo/NaoBaImTSrCL+JwSQ0fg9wZT7ay0B9tL5j/gqH1udypG4ucFyomNRVOWjYkLn44
 wg+ZIZdm8HKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="530043476"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga006.fm.intel.com with ESMTP; 10 Nov 2020 17:38:38 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 17:38:38 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Nov 2020 17:38:38 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 10 Nov 2020 17:38:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lu1CL+StyEmoY2VVLh7bjQlToCF4b6moDSzJ5Eaequnm5tqflTxyqjppdS8b6m/Pzs6rlFPbLwXDZi8PJrgOKMvkmE++0+XY/e8hZp1St4rekZaAf/we6BuHP3I+HatChdiGD23kTEK84kBon8m8JneP5oIfJTfbs0uD4P65WzIW6y8ehxlMohtgGEHbgHu9rV0AR8UHKuKkBrENPWowKOYjrkvF2s/8v0adcwbC4llkHWNVWjPjj5Kho6KUyxD0a+LdFO/j1Fz4XyxB0Bp5QcFUXK/QSmSmaz+H4n8rMrYfEPQsTvOycA0IpB4UkrqvgqXBZcMttoV0BBtD4RWZ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1SG5z9IEC1xQYtZRl65ru1Zd+QVTE521fE4M/uAAtA=;
 b=CiUWaQTudSedjGqszokUAhXASdiAtqDDHu01fka3xdMWXkidqZeyBCrOE3Dzj/50z3npI0l6BLvPhQUIzWo0aYyC68ns1zgc2QiaRUPaW/3wsugDVFYq7IRX9j9egboiLHK3MOsSGkzDFGl4080ZIBDdIKFGMVh42/NleCpofxDn1rYtuqA+cI8M/BRKqP0xUBCGmN2IKVQGCE20RRQgYyB+WaqzuOXYOwKV5x4iER+3tZLAx4QLeOjlOQ+QSSHRrA5iD5oQFTuFWYR6JcJQskGUuqWf6usRYoqlRgxzN/GMIhp3/fVfYZsGdSZ2ZxylzDQej29hyMtQpjbevViKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1SG5z9IEC1xQYtZRl65ru1Zd+QVTE521fE4M/uAAtA=;
 b=HWIxa4MNj29jE7mQB2mS+x9MjJrHZ9E4sc9bEt7bAZBG1GjTbAtPJ97/IUYeEP84CzB5V/MuDx5Vbd1TynFPtiXbl8SAls4c0pvpxXIEgUlMBS6F0VUHKG3I4Kde3frvrk0UEGLL/VU4ldfzAD7NaTrUgicxVejrTcO4CApZB/w=
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by MW3PR11MB4538.namprd11.prod.outlook.com (2603:10b6:303:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 01:38:36 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ed62:6d3c:c9aa:4c4d]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ed62:6d3c:c9aa:4c4d%5]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 01:38:36 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        "Shaikh, Azhar" <azhar.shaikh@intel.com>
Subject: RE: [PATCH 2/8] platform/chrome: cros_ec_typec: Correct the
 Thunderbolt rounded/non-rounded cable support
Thread-Topic: [PATCH 2/8] platform/chrome: cros_ec_typec: Correct the
 Thunderbolt rounded/non-rounded cable support
Thread-Index: AQHWtvniYYs6KGJknEKpFjqe8iaM/6nBSV2AgACA5LA=
Date:   Wed, 11 Nov 2020 01:38:36 +0000
Message-ID: <MWHPR11MB00484E0077F00B83AE8258F7A9E80@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20201110003716.5164-1-utkarsh.h.patel@intel.com>
 <20201110003716.5164-3-utkarsh.h.patel@intel.com>
 <20201110121855.GL1224435@kuha.fi.intel.com>
In-Reply-To: <20201110121855.GL1224435@kuha.fi.intel.com>
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
x-ms-office365-filtering-correlation-id: 87f696d1-7f73-42d8-57ee-08d885e28227
x-ms-traffictypediagnostic: MW3PR11MB4538:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB45380B61E47D9C9F9686F0D3A9E80@MW3PR11MB4538.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eDtBu2Vdcb/2UwYYjDIy05QgMomJ4YrBjLut3icLqm3AEPdAYhxqbjr7oJJYglqOp5kFFmumIUGenwIQFURzJvcCoMkvUQ7gE9JujznUVHJBdb78fAGRGmvcS42kKUi+Y/+pneohs6OL/SmhMDWhJUkZrvNdB9FRGs0I0nZAtLeCtTEsPIdgR5fUNjQAVTEKZZjj3Fl4IRHDE5t2SZuA9CKZB0huerkWE4fwjuOVnT11Zvo9hutzkcU0KG0BBoCx7T9++ByYhQdJfPCt4gV6M2GIvG1ojVCp5aqjJ+ONva9uQKu8q3NSi5HkI2wG/U4qfcF4McuXB88cTMWBVFHUWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(6916009)(52536014)(66946007)(8676002)(71200400001)(9686003)(64756008)(2906002)(5660300002)(33656002)(66476007)(8936002)(76116006)(4326008)(54906003)(316002)(53546011)(6506007)(478600001)(55016002)(86362001)(186003)(7696005)(83380400001)(26005)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 4RbS/1SYEdHsUZCvGZ2YnS737Xg1n+3JUUuowC7LDI9olz60dziuNpF11VOcApuwRohHQQg67F032+Q1kNFgsTPIDuJv1IJrEt+m+HBegXfzu81T7aJS6XbzUtDOuHsJvj6AmAvIRz9cR0IkdVWBXQTp+XnrhmsfQpkHwB6YuD/Fcm6jc7pUSwT6RO8fCdgve6oJiRaYwXCjaRefq+gPk0Wjf0Ck+ZedgvewqqHLcEpgM2eVXLecaJcunGN/Ubl+zU5QTuuVPb/Y0T1HWWQLU9RkJWqyuDLgEcxtkxZ8N8FCS6Re+HmdMUCn6CfCAbW709ExdwBpywqDXxtU15l8yKeLgPg2fNhEcIbQxeRwf48rpiWe3XRVl+xR27YHSuNmTVCebitZ2PFLGPcFr+2GPAleEagbiHX0tXJ5x6g/4YDSoNlddPSq5gozgWRYeWFQsGdBKC7OEAxCnH9N6HDbdunL48YUYY3piYjXKrKURu8l0VlFdQRC8Wf6R00BYEWZou1VShZYbs6AoS/Tnmp8MV+KbC72Q5JO3Iwpa/rba9sJfybHLQi/gCu2nHjmMEMU4fU26omzVqEX8xjdpQ8aSsBOwsAvu7DcmLZqF31dlqgXKbyJOsRS7DpuyLsYZ7QliY1N/9p7twsN5P33KAv25e/Dp/25dJlhJe6Gbb2Q4hFTrAWEKVEVQpSG3bJmx8VtJ4u4iN2T8Cv/H1p5G7jrUWLR0NJ0IN3ZqvJ0qYFNtTPNbIbrKyVC/7nnm0oB0/Hvtk32UZ9DZk2MccHmg3nb4aCqiWWMEBGIZzDf/vTw9VKCB5cX74ww1BaDoucw+BCRWtqW9MQDL1iWRk8yc9V1/6iL3mZre4L0rkHvrxLGTtaMaMUmF8qQBR2OVySjU+umkLCxV2wfVKUBdrdHq+k+cg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f696d1-7f73-42d8-57ee-08d885e28227
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 01:38:36.5235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GWI6MPHpWQQh732t36C0+aQaxob4j3tiV6EK4hcX2P2hKm7Sz5gfJAtBa2jJHJ7hk0oTdi+rHEbwkEh25XAGGmiok10RH27E0SAmRlMduW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4538
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

> -----Original Message-----
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Sent: Tuesday, November 10, 2020 4:19 AM
> To: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> pmalani@chromium.org; enric.balletbo@collabora.com; Mani, Rajmohan
> <rajmohan.mani@intel.com>; Shaikh, Azhar <azhar.shaikh@intel.com>
> Subject: Re: [PATCH 2/8] platform/chrome: cros_ec_typec: Correct the
> Thunderbolt rounded/non-rounded cable support
>=20
> On Mon, Nov 09, 2020 at 04:37:10PM -0800, Utkarsh Patel wrote:
> > Thunderbolt rounded/non-rounded cable support is two bits value.
> > Correcting it as per the Thunderbolt 3 cable discover mode VDO changes
> > done in the Thunderbolt 3 alternate mode header.
> >
> > Fixes: 5b30bd35aab4 ("platform/chrome: cros_ec_typec: Add TBT compat
> > support")
>=20
> Again the fix tag?

Ack. I will remove the fix tag in v2.

>=20
> > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> > ---
> >  drivers/platform/chrome/cros_ec_typec.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c
> > b/drivers/platform/chrome/cros_ec_typec.c
> > index 31be31161350..8111ed1fc574 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -438,8 +438,7 @@ static int cros_typec_enable_tbt(struct
> cros_typec_data *typec,
> >  	if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
> >  		data.cable_mode |=3D TBT_CABLE_LINK_TRAINING;
> >
> > -	if (pd_ctrl->cable_gen)
> > -		data.cable_mode |=3D TBT_CABLE_ROUNDED;
> > +	data.cable_mode |=3D TBT_SET_CABLE_ROUNDED(pd_ctrl->cable_gen);
> >
> >  	/* Enter Mode VDO */
> >  	data.enter_vdo =3D TBT_SET_CABLE_SPEED(pd_ctrl->cable_speed);
> > --
> > 2.17.1
>=20
> thanks,
>=20
> --
> Heikki

Sincerely,
Utkarsh Patel.
