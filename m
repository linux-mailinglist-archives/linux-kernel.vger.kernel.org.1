Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC602AE5ED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 02:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbgKKBib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 20:38:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:38060 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731657AbgKKBia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 20:38:30 -0500
IronPort-SDR: 0bgQikedzcmfTasyT9WqPRPFiYVY6oXOYVAfkFQNsQlvTSbNY8q5b5U/lrTftNqcbopmTCrQzd
 QRCDXL4IBEMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="188054416"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="188054416"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 17:38:30 -0800
IronPort-SDR: p5MWCZPZfZPBRdSPqi2opxOgDgbM17DeUJP58FisYkUhX39yR/NJkqmKP3uQaZAUjhGZrPuXWU
 aXYEuuU6DE1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="360354721"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga002.fm.intel.com with ESMTP; 10 Nov 2020 17:38:30 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 17:38:29 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Nov 2020 17:38:29 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 10 Nov 2020 17:38:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDlthxrSF67s4CRlAnmLh5SR4k64raFUCLQK+L7zrZoQm7QoTElDU/BapOUsLhxTVpqQj21952YbyDn1KGd7RC9hj/YCToVahuT5AVFXswap/R8cr5BPW8Y91ONh/ZHmBIcfLUyJ0sHR0ImR1qm5wGyYHsXBdOj31C6Jytill17DHjThVIBawjqtkijlvuNuwgh0y/zl3XmfDF1uTx1jDoy1mRL6bw6q0WRCGF9ryKOl8cY3MEbb+IyHvIBxVFO9vrOcAcB56glMSmaqZOilhHkNoHEjYse/wZfyrgkSDtXzETqHyz4PBAKwt7SLoHgnnP+rNgF7YwRL0Jw7+SoOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ufxb8qH6PGudO8V76oTyLLBZDC8VTKwnoPtKU19wZ6w=;
 b=YAUP/TpbQjAVqAeXq7Vk2n0Xc0kf/0VDKs4O0u3drRLVGbCr57Aqfke0urvMQrrPueHLuFOSHuH84fsV10ySb6FPFHLDiEQF6hYcXTKDlyRe/+B6Wt3B/7haU4tcoW9f8hJwLdi+z5z27R85bgOSKHMOQgP2oCL9XBBRBg07lpZs2gFRw3tXudpHjuhhU5uJCTI7EcvmFZC+hrNfOVGTzJsf8OtehI6+v4jyKoDCGnS2+9sAzk35gqGtADTXgkboAJWrliIetM0Oq2a/WpTkgJ8/qX1lTuPbASRvdttOTigZoZ5UN/GrqD/6ettXNBYt1tCXtg1muaOI5Vvh/7Q5VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ufxb8qH6PGudO8V76oTyLLBZDC8VTKwnoPtKU19wZ6w=;
 b=eDZyt5iwDVqT6yxXmArpoNzIY35WGWbCeiJNUP6j7yvMYu6+wQ0Lu0DsJ7TCVJERnUm067CVR/tqPW6zk2vD+vpJ6xmUO2Z8IlqaaBqcm5UjsDDwKRAMfgfi8paPNQqBLIxqV1nLDEHvq0Ex+8oscukk6Lw4NqihX5UXv6CL/J0=
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by MW3PR11MB4538.namprd11.prod.outlook.com (2603:10b6:303:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 01:38:28 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ed62:6d3c:c9aa:4c4d]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ed62:6d3c:c9aa:4c4d%5]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 01:38:28 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        "Shaikh, Azhar" <azhar.shaikh@intel.com>
Subject: RE: [PATCH 1/8] usb: typec: Correct the bit values for the
 Thunderbolt rounded/non-rounded cable support
Thread-Topic: [PATCH 1/8] usb: typec: Correct the bit values for the
 Thunderbolt rounded/non-rounded cable support
Thread-Index: AQHWtvniBOcWMcAgx0mTjUqPTtn+0qnBSTgAgABcebA=
Date:   Wed, 11 Nov 2020 01:38:28 +0000
Message-ID: <MWHPR11MB0048B219E9BB7A304891F5EBA9E80@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20201110003716.5164-1-utkarsh.h.patel@intel.com>
 <20201110003716.5164-2-utkarsh.h.patel@intel.com>
 <20201110121824.GK1224435@kuha.fi.intel.com>
In-Reply-To: <20201110121824.GK1224435@kuha.fi.intel.com>
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
x-ms-office365-filtering-correlation-id: 015a75e6-06bc-4490-bc9c-08d885e27d4e
x-ms-traffictypediagnostic: MW3PR11MB4538:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB45384B421607B99C3AC37111A9E80@MW3PR11MB4538.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F+AOBYd7Yx+c+TwuGFWSIEGKHD7f2+Z37FSpunsBwD/wu8zcMVrm4SWC5lwKaLDDjG7gF7sVNLXxTbLoi++PJw2actfsNUBcGnLfXj3ZZHg6ESJzHn3qJaoXrNL31Wz+MFhsxpZmArK7rIUfDvj8dbLpqlLf74rQ41AP9YzlJsz9QMPf1A0FFIThk62kyadHezpbyMAsQQcJIZVDaiX9PxqO+bgP/P0k3Gi8kAeAxyHfbWnslRtzipOUlFibwethCiAZk5shuxrcwetkQOTXq0i7Fse78UcMWWJS3ZhUoiM/3IoqMh9clpNYW70IY4k9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(6916009)(52536014)(66946007)(8676002)(71200400001)(9686003)(64756008)(2906002)(5660300002)(33656002)(66476007)(8936002)(76116006)(4326008)(54906003)(316002)(53546011)(6506007)(478600001)(55016002)(86362001)(186003)(7696005)(83380400001)(26005)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NXW/GwtMMxGaoEmeL/sKiAr+gtE2UJLYdMsGhSPCgD+x3EYUW+J8UTV9AuMyQ0nAzcVjY2JIHvMb//Aal5XGDOcqX5O9zl6i/tqZgAuIXFaUmXdCMj339bqa2EToUg6dasI8jkpXQkQoTDszgXEBTwjjwkPqtCUc7a4iKCz5zNQDUNQhXQvCjbl2ZmYYuZXqRz64Y1JOJ20YjVK+pTjPp06/jb2WFueFYbT71rdTWaW/z/KRLUVAtkxQbHl2kmyh3eLJdBBLSnADjFWsx4WG8OvQcz7EPKhgwhvdRNrQpNkCQVmNdU1juwLH2RiHDP63X1dL1G+J2k2AQtBUZcDHHiPRqelQBr7XB5RoC2EzP69inV3JioAe4Szfd6RrI1fjMfobMj/Zchnd91H3FmDX9OBFMhXRavjYRp/fhCBBulIVn2bmC0u0trH3fml4g0Y1aN6R+BhaBiKnTLzTLoLYLdNxVL3MloyfqwFE9842QDgwb1S4jtxgvzOJaNtOVzFLXwgP0zc64kaSi3Rx/x5cjQzbU6DzIDcmxpM+1XwmOIi/C5a0UDawh6RvkC0hmgNwQLrWQ2+fgXNri1zm+ljJo9Y9bBBo1QDGFWJJvRkF0pdxKtJQv+NNMRC9ktDPTu7H9UNjcNipPw00UpCyM4qO9TgwF65oP7U7ar3RPFI3TJqjXpgY1HNcZJBncXRq53QBvktC2tOmOzMJgnatj0AHxrvqbrQjHt5b99Chh3MZhzt5+Ka/rKLlhQTPgC1MPARglk0x2Nral8q8KkepGp2wYG9whEJFfviPQrS2fuJrhWlU/bn633Zn+O/7SEr0i0PITIMvLqHO2VZy4+NySqdZ1ydvQzBLQTudHvGuSm3Q7WQ53c7Uvz0nz/ORTwg8ua39gBxnk0IJOIip7Y2lDKNjcw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015a75e6-06bc-4490-bc9c-08d885e27d4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 01:38:28.3051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZfxodplNXn0tpTcoU6MeHpRvNEjkL04mUlEZQ1lf0fUKtsdr9/yFCWHeb4m4+XQ1MBtublE4GtMeWsSXK0I9SJpPLCp4/zxJxDXeIxntuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4538
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

Thank you for the review.

> -----Original Message-----
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Sent: Tuesday, November 10, 2020 4:18 AM
> To: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> pmalani@chromium.org; enric.balletbo@collabora.com; Mani, Rajmohan
> <rajmohan.mani@intel.com>; Shaikh, Azhar <azhar.shaikh@intel.com>
> Subject: Re: [PATCH 1/8] usb: typec: Correct the bit values for the Thund=
erbolt
> rounded/non-rounded cable support
>=20
> On Mon, Nov 09, 2020 at 04:37:09PM -0800, Utkarsh Patel wrote:
> > Rounded and non-rounded Thunderbolt cables are represented by two bits
> > as per USB Type-C Connector specification v2.0 section F.2.6.
> > Corrected that in the Thunderbolt 3 cable discover mode VDO.
> >
> > Fixes: ca469c292edc ("usb: typec: Add definitions for Thunderbolt 3
> > Alternate Mode")
>=20
> Hold on... Why is this tagged as a fix? What is it fixing?

Ack. I will remove the fix tag in v2.=20

>=20
> Why do we even need this change? The field may have two bits, but only on=
e
> is used: "10b...11b =3D Reserved".

Today, only one bit is being used but as per the spec cable rounded support=
 needs to be two bits field.=20
There is no functional implication but since I am adding changes for rounde=
d cable support hence trying to follow the spec.=20

>=20
> > Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> > ---
> >  include/linux/usb/typec_tbt.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/linux/usb/typec_tbt.h
> > b/include/linux/usb/typec_tbt.h index 47c2d501ddce..aad648d14bb3
> > 100644
> > --- a/include/linux/usb/typec_tbt.h
> > +++ b/include/linux/usb/typec_tbt.h
> > @@ -40,11 +40,16 @@ struct typec_thunderbolt_data {
> >  #define   TBT_CABLE_USB3_PASSIVE	2
> >  #define   TBT_CABLE_10_AND_20GBPS	3
> >  #define TBT_CABLE_ROUNDED		BIT(19)
> > +#define TBT_CABLE_ROUNDED_SUPPORT(_vdo_) \
> > +					(((_vdo_) & GENMASK(20, 19)) >> 19)
> > +#define   TBT_GEN3_NON_ROUNDED                 0
> > +#define   TBT_GEN3_GEN4_ROUNDED_NON_ROUNDED    1
> >  #define TBT_CABLE_OPTICAL		BIT(21)
> >  #define TBT_CABLE_RETIMER		BIT(22)
> >  #define TBT_CABLE_LINK_TRAINING		BIT(23)
> >
> >  #define TBT_SET_CABLE_SPEED(_s_)	(((_s_) & GENMASK(2, 0)) << 16)
> > +#define TBT_SET_CABLE_ROUNDED(_g_)	(((_g_) & GENMASK(1, 0)) <<
> 19)
> >
> >  /* TBT3 Device Enter Mode VDO bits */
> >  #define TBT_ENTER_MODE_CABLE_SPEED(s)	TBT_SET_CABLE_SPEED(s)
>=20
> thanks,
>=20
> --
> Heikki

Sincerely,
Utkarsh Patel.
