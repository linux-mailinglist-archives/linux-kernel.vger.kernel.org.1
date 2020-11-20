Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034C72BB124
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 18:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgKTREa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 12:04:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:56391 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728771AbgKTRE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 12:04:29 -0500
IronPort-SDR: +ler+I7+Q5lmus5oq14pmY7V0G1Lkj4pt+4IhdqMVPLbpQT/oBnWSWV4DgVlCmnUKl6gCwFpE5
 7CWu4gDONGkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="235650190"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="235650190"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 09:04:19 -0800
IronPort-SDR: CYQwH5GnmXbWjdG7TS+qFGkg43tIyonQmJHA4Y7Y/4v+4tADEozTk1dNWymSiMIEEf3HFeGazv
 MMzIekDZ4uPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="369269894"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 20 Nov 2020 09:04:19 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Nov 2020 09:04:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 20 Nov 2020 09:04:18 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 20 Nov 2020 09:04:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrwdI/d9ACB6GXxeh/AQ0ny9y0T60uDpL08kkAkmjJ/beDFTib38wgQl02fDuCNvJFsNmEGYvG2l31Pfz5vnhk7vgFaL1hglfgykxVmsZhlqau8SYdczqf8++CVs0i37lSZtpiXWKjLSjr0kIx7LkQy+7RMPT5WNt4UcwjNK7sZEsjoaiootqbXXZ+B1kPC6c3KoKd2On29es1cNlHKw9zl0z7MuhAWvyKowHvJzvw3rtNyTsA07kZHDYjdEOegvYAVsRp6MDc0jPTbn+FtdtVmJRmuCK4ENpV8FcqesjgBKMPSFU4g8LzbiZRex4jsZkGAjS+8cN0dzhQT3Z9yNdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0YGD4x3UxppzRmcDcSuovzxwvGI/BMHhR8h+ctV3QE=;
 b=kyoD2sZIcBWGOa2KMNHAKNKJ/BzLgP4E40u9PpL4so2YKyl0sM4BDIUbDxwOlPvy9b4yVNl0FkKcQ3W1X8yD88Qu+Q52uZuekaWGsmCLEpPgqp1vVanx+5pweAwYzUOQal2ohp7caVcGiz5LHUMHElBSEWpsObRqZ+OJpjYQD2Q7Ai7xSpExOFAXtg6Oe74kf+5zOfqcoll9Ysk5DGfeD9o2QXwyL+TCliVQVSPJCtbrpPxcKNlZnmeA3SoEEQ/Z41rVgS9YwAmZV2haJHOr/MUah1Tg/Ue06ojh6I4ag1f6K6RbFBRkSWRjhA9jeU5kV1DnY1JtauSwjRWv+mLSfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0YGD4x3UxppzRmcDcSuovzxwvGI/BMHhR8h+ctV3QE=;
 b=ih5Dx2xQGLEDMZSJ3ISxaVeWHzrLO+4NCvD5oC/DMKbPbmDo/BwUu4MTDql21GfAwH91evE/HhHHGZtma8ptfUUHY4xgFEpel4HzuSNsHQ52QGb7ZsKuykOUW4b07WAYoFm0o9Ld4YjdlOJrpgIiL/cOw3qzN2vcZuaAfm0YBOg=
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by MW3PR11MB4763.namprd11.prod.outlook.com (2603:10b6:303:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 20 Nov
 2020 17:04:17 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ed62:6d3c:c9aa:4c4d]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ed62:6d3c:c9aa:4c4d%5]) with mapi id 15.20.3541.028; Fri, 20 Nov 2020
 17:04:17 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        "Shaikh, Azhar" <azhar.shaikh@intel.com>
Subject: RE: [PATCH v3 1/4] usb: typec: Use Thunderbolt 3 cable discover mode
 VDO in Enter_USB message
Thread-Topic: [PATCH v3 1/4] usb: typec: Use Thunderbolt 3 cable discover mode
 VDO in Enter_USB message
Thread-Index: AQHWvj389Hr4wrGG80arW16208AyEanQq0QAgAAItoCAAASWAIAAh/cQ
Date:   Fri, 20 Nov 2020 17:04:17 +0000
Message-ID: <MWHPR11MB0048528765F61198C6C85A23A9FF0@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20201119063211.2264-1-utkarsh.h.patel@intel.com>
 <20201119063211.2264-2-utkarsh.h.patel@intel.com>
 <20201120080514.GC4120550@kuha.fi.intel.com>
 <20201120083625.GB4160865@google.com>
 <20201120085250.GD4120550@kuha.fi.intel.com>
In-Reply-To: <20201120085250.GD4120550@kuha.fi.intel.com>
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
x-ms-office365-filtering-correlation-id: 36ae7f81-07fa-4584-af30-08d88d7650f3
x-ms-traffictypediagnostic: MW3PR11MB4763:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB476324823D493FF39DF16344A9FF0@MW3PR11MB4763.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yjt8KP1o7qjHjEcRP4Tlhf463LxHI2xy1IUQQ4rwCO18LHemqT4l0xbL6YRilPdYKDldKlicR6aL6S370XuATWXTOQ6hF3NO0z8dggd0mFUF1JuO07/B7yD4FiAia1sAswGhhnAvxE8kFu4ol2Sg9m/FIz2ntB8/pFfPnsi6d7z4GBCpdv40ghx313L1Q2bXoPjPi9BB0wC47GaueevElhW8PS5E9cxJ050x2z9dKTh3H9aJSkFT9rhHjCGabZHDvgX7tjI2QnG2eddN8xPHIg074SREgCL1JQJC0Cvq4f1hW5fmsojWGiFyw4qLXdwQHbZlh5FgX2oT/Ojiq0ztGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(15650500001)(186003)(83380400001)(7696005)(9686003)(86362001)(26005)(4326008)(54906003)(6506007)(110136005)(8936002)(316002)(66476007)(8676002)(71200400001)(52536014)(478600001)(64756008)(5660300002)(2906002)(66946007)(76116006)(33656002)(55016002)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bc5qfdifWhUCZrqRAneGiYyBSK67gk+ics45Z8n/pq1yojYxHygh2YH6U3j+X+F9rOHsBBTGZqV5VcxEnpijmrqKsMMobS0VjhJvuFoTjXrDplNpvz2teDqClAfm7xzAY9aJyX0+MuY2H2KQbn93ThuHVK14RUHtScEN0kljyfAdQqYhNREKQBMkzTeyxKyB1QQhgWhoJSvhxzeZmr32L52/Lm9yL5HGLycDskcm94Kxk8khk9QtI8hrWB3xQpBpLTu/x8OmMHL+zhde0kxR63+oGcT5qcQCfynB+se37yagqO3v81qDOP0/vQbItsCjIwfl/RkJytR15buEPQtBoLxH8uAvJhgwcejLl6nUrfb7cy1ifyv1OSXhQOjS7lTE2ul2i87kjUdbjDKkuhl2Km/+cA9LRA+A2DMWaXbxGahoRMW9N1uEQ9s5566K/rxMOqkC9WHLOXx4u6bSkic+aZFOXFg6lwkV4jwNWVB7u1ZUcTjaaej94ZlRf+pNAFj+KdDPOjDthNURroxiGxPHU5KM1b1jJYiJXe2Iq8Xand0jSVsOFyeoPuUyxHf7hgimnJovh9koqHffGobH7sfhgZ+I/n0QXJ36Ic7qqwV2Ia1ppken5GKyVzvbAFYr25kJw6zNIJgit+eqzxpXIHbOqskPMZWk1NJ7p4IR4lTbNkkl8D4cU2gsu0ReyR2zdoo3gPm5QDNWNwAb7HzXoaQwTdN+trej0c9ScWnbhF5XrAHYyBnxsNYc6dPWhAzkqTnz2Qy9kgP9VSInpw+Ev6MvLs4RsLq+WcHZ+xSXln/pzTekmxq+64pe0mVVMHQviRxec59w5SuqITlRkZ0qOLFPSXpSKQcy8jsl4WJxTFJK5bh+bmLSbQjO1gWujcgjTS7Egg50IaO/XY90l964APz00Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ae7f81-07fa-4584-af30-08d88d7650f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 17:04:17.5250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cBw7AcYbwTVuRVX6vqqjVgPwEN8UOKhMoo9ebD8pXvM/OchMQRL23keGf+2Vpyt6D5E9ATmHrseUjBhB74Yy5lg9pJO7DQw8ar+pKaokup0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4763
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki and Prashant,

Thank you for the feedback.=20

> > > >  include/linux/usb/typec.h | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> > > > index 6be558045942..25731ed863fa 100644
> > > > --- a/include/linux/usb/typec.h
> > > > +++ b/include/linux/usb/typec.h
> > > > @@ -75,6 +75,10 @@ enum typec_orientation {
> > > >  /*
> > > >   * struct enter_usb_data - Enter_USB Message details
> > > >   * @eudo: Enter_USB Data Object
> > > > + * @tbt_cable_vdo: TBT3 Cable Discover Mode Response
> > >
> > > This is fine..
> > >
> > > > + * @tbt_cable_vdo needs to be filled with details of active cable
> > > > + plug link
> > > > + * training and cable rounded support when thunderbolt 3 cable is
> > > > + being used to
> > > > + * create USB4 connection. Do not fill this in case of USB4 cable.
> > >
> > > But this is not. The description of the member tells what the member
> > > contains, but it does not make sense to explain also how to use the
> > > member in the same place.
> >
> > Slightly tangential question here:
> >
> > Is there a need to mention "active cable plug link training" and
> > "cable rounded support" at all? Wouldn't it be sufficient to omit
> > those in the description (in case some mux implementation wants to use
> > the other fields of the VDO) ?
>=20
> No, I don't think so. I think it would be enough to just mention that we =
need
> the TBT3 Cable VDO only when the USB4 connection is created using TBT3
> cables. And that's it.

Ack.

>=20
>=20
> Br,
>=20
> --
> Heikki

Sincerely,
Utkarsh Patel.=20
