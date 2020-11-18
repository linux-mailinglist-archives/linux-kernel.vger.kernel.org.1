Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A112B870F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 23:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgKRWCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 17:02:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:52742 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgKRWCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 17:02:09 -0500
IronPort-SDR: Qujo/VrzFsgDCh71MaMdDwSyS9adO4OQymRqeLJLJmvuXGLNnwxAwEErxkZGVShxEE2hTurQ2Q
 Xl482Z1RtvRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="235340047"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="235340047"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 14:02:08 -0800
IronPort-SDR: GG0gRlwKO9RcfOcJDZBy102wAcWo89RgJOGgz3Sd8Ke6AeaV5kc++0Yo8/i+mHEK5yGgMm/QwD
 L3ShUfTFMQug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="311409941"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga007.fm.intel.com with ESMTP; 18 Nov 2020 14:02:08 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Nov 2020 14:02:07 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 18 Nov 2020 14:02:07 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 18 Nov 2020 14:02:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLe0S/SDsi3kQ+uW64kOD2sl5l3dJLaTPWqGpZ2IScGU2e/sNigWe/xHyi5M9Rr3jBJNMUAJifdA1OW3vyU4veblDLzPbFWXVG7bYyFgs/rcVsmBuPRF5302zpVRu2wjK7sTR0G0C3HHyFPJlrciYz1oy7IDy8BzLsApFKQmlk4acyooChJH+3sOb6ng6AMHc4MF5Im6RqgQgrVS+qFtTn94SEGExNg6m9SxMa3g5mJSyitCUiLMwN9yXGRs2+j2EXh2nNnDV7YyyRg3GRGn0vbkzqNceL3EgEO1QJJlnaAnk47gak9gc3SMdmABP/WDmrhtQQyz+rTYW2CnGjETLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0fe7CQ8bDsG4IEPjq+afeSDWWOZiycfnY4R2qua+k0=;
 b=hQe4m/uuczQ6oPM8SKhb7Vo7skwcZMyfNazehuFBDt9uHDNS0gokD2U6s2xbCPl+yJSngU+KtMwV4JYiwWNKXM8KGl2nJETLU0qGuPmFx5xcJulAxd4nHJna7287elIqAaMftcqDV5IQUlLRJT3KTn36gjZSoCf9afG31LeOSOjY38GHzsVIvqKmYEfb04qeANHnsW7mOYEG+vxK8qTG8TuPLw4NcMwcYGXW1NwA3a/Z90H9qPlK8n6hmKLDATomrMyXwSxapSm8Oa2l62nX1KRok+00ZDOluODjL3O67pBTjxMWfaDqzBKCwZ6Q6Ch55/GLzSKs/DDn2mfyMwvCTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0fe7CQ8bDsG4IEPjq+afeSDWWOZiycfnY4R2qua+k0=;
 b=luoz0i4ODdkDRnwdnDg0jk1mqq+GTd5ls16qLKtXHPbw1xFrVJbWcwHXfbyjZCnPE1gP8C7++5UMXegmAYhDj6Vw6PTjxBvxVVgODBI7rwgYV2LInYtkNbCHgq4ibqXO6Fh2HwqIyw8wVtWNFgqCpUYbAaFdrL5E0Q1kVuwSbSQ=
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by CO1PR11MB5172.namprd11.prod.outlook.com (2603:10b6:303:95::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 18 Nov
 2020 22:02:06 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ed62:6d3c:c9aa:4c4d]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ed62:6d3c:c9aa:4c4d%5]) with mapi id 15.20.3541.028; Wed, 18 Nov 2020
 22:02:06 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        "Shaikh, Azhar" <azhar.shaikh@intel.com>
Subject: RE: [PATCH v2 0/8] Thunderbolt3/USB4 cable rounded and active cable
 plug link training support
Thread-Topic: [PATCH v2 0/8] Thunderbolt3/USB4 cable rounded and active cable
 plug link training support
Thread-Index: AQHWuftXnI3dNY35T0mGuceb4bexK6nNzzUAgACj2uA=
Date:   Wed, 18 Nov 2020 22:02:06 +0000
Message-ID: <MWHPR11MB0048710972B015E9302C8008A9E10@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
 <X7ULfA//gU3vsIqd@kroah.com>
In-Reply-To: <X7ULfA//gU3vsIqd@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [134.134.136.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3724c381-06fe-4c47-5989-08d88c0d96c2
x-ms-traffictypediagnostic: CO1PR11MB5172:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB5172791F957081AA7632FD2AA9E10@CO1PR11MB5172.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fwD9e3183haBHBnzFmhRZJhT2TFBdH+AbaKZspon/vLiTFjOnJNvruuB/E/RtLV8Ex0O9zElPQlqnNlMngzSdnseYnejsws95mhSaLPXyqVAlA8sna5+vPCzCs7kKgK03th/4D1nBUUxAhsOkievZgfecePED9msaEtvr0tNukFdHMdeVk3QXhAKq9KHkHwFXHIKNJYJOL5NA9vIy6S9Ivw06IrHd407XefQv9EGwqUwlW7fWHOt/gw8NsXGmiv3JLbylOqsLwYG9CYR6l0jeSfEeZseK4x4p4+woGBRiS9ImjHVAgjcHVO/Q3Xc9+wQLHgedoyJ3Ay4WowqKXnHkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(9686003)(6916009)(8936002)(53546011)(478600001)(71200400001)(4744005)(33656002)(5660300002)(316002)(8676002)(2906002)(54906003)(86362001)(66946007)(186003)(26005)(83380400001)(55016002)(7696005)(76116006)(6506007)(4326008)(66476007)(64756008)(66556008)(66446008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: eJ312QpqgZOljtlLA8m11es5QIHOwhaRILtB+ysckENyMRrqpdHxcvlemx5t63HBAbGANOQewMaOTWOIYf073733+biKcZKmauAscSFpWLIPETD8Ltd8pYgMOQRmiQLbTS1KzzEVxKHGKVUHMGZEPGjYJ+X+93efyghtZQFYyMc51v2r2tZo2EKRqecLMljLXGx05LHkU/3ki051xVZHDpHjb/QVpR0t2fiBW9Q1YTHjh5X+J4w40fDQgxvauj0JW2bwxztMpFLRGEpREOdJAv6orR50eYrQXAeNZo3EfvDuR/BhBpTzewNLRFBaE6KE0pDxx4ufty3Zh2hqLcQ4fLXcIylOPoa8cgWoIHwcy5LICrzoHOvkBvF6n+rhjvVFIZKXPkA+vTNE4kRkqjiaUMIcd4enhv2Xda+KofyCQ5cFzrqJKMmg0SoWfz+YT/kRrwu+7AdFu/obBJAo/DVJKVWAjtmneNlEIQK8i+PU25oBThMT1XRPHAWijyQtpWnFwo5p7zx89rBXyedlAvi/KChCm2mfOian1Jmu52+lZroFMWxmy5HtVieYj2VRINsWm19ZoVG/Vjjtp6zmrErr5UOuyPTEyhyxhecD6oxV5UuzKG/KX0xvvTH9nFXA+RJu6ewS/SS2i3JLFF9ZuAx3u865wuYNxJ6sSibY4L4fVoEPF7NmUCusjkt3h+kD0g3mP8MvtT7DiOAfI2cvj+eIoF5UzyoaUslH37Uz4de92VtPHJdUfYNME817oFYB1kfr7k+9rEeJWMYlEhWHSGoZnu4xZuOFeXVNiDkOmJrlNtMEyflrHRkW/X9fnoppW0Mjty2dvu5tePYePc/fAwo7fHlegohfaKSMc5Aw864p9RRyJAC1URwKaD1GvoqVxOulRd8coBChC6OVhPDcudyw6g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3724c381-06fe-4c47-5989-08d88c0d96c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 22:02:06.3158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/PuwuY+GNtdC3R87NIY0KZPXuj+OcgMXT3POokJ5qh6qSpJWhs6brGpLldEpY9t6dCdcNLarhZKTvY6qTSTQmyxY8vAguXndXOSzfzSnhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5172
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, November 18, 2020 3:55 AM
> To: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> heikki.krogerus@linux.intel.com; pmalani@chromium.org;
> enric.balletbo@collabora.com; Mani, Rajmohan <rajmohan.mani@intel.com>;
> Shaikh, Azhar <azhar.shaikh@intel.com>
> Subject: Re: [PATCH v2 0/8] Thunderbolt3/USB4 cable rounded and active
> cable plug link training support
>=20
> On Fri, Nov 13, 2020 at 12:24:55PM -0800, Utkarsh Patel wrote:
> > This patch series adds the support for Thunderbolt3/USB4 rounded and
> > non-rounded frequencies cables and fixes the active cable plug link
> > training support.
> >
> > Changes in v2:
> > - Removed the fixes tag as there is no functional implication from patc=
hes
> >   1/8, 2/8 and 4/8.
>=20
> I've queued up the first 4 patches of this series.  Feel free to redo the=
 rest and
> resend.

Thank you. I will send v3 with the rest of the patches.=20

>=20
> thanks,
>=20
> greg k-h

Sincerely,
Utkarsh Patel.
