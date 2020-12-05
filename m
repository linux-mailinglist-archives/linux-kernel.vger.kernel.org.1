Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9BC2CFC47
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 18:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgLERIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 12:08:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:25092 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgLEQov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 11:44:51 -0500
IronPort-SDR: a3bSB7z6aFBZwWxEcJEeDZl3C2tT0o7WtTPzPHb3NGxK0xDx8g/jtSKcngBR5MgutDbv6LnEuK
 B8XR7UqIX59A==
X-IronPort-AV: E=McAfee;i="6000,8403,9826"; a="191780729"
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; 
   d="scan'208";a="191780729"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2020 08:37:29 -0800
IronPort-SDR: igHf0N6xZuNH0SjT8YI/hy5zRhwWLyy+64oCU0jf+FV6OI7OKrgISTgwa8nD2NkAaMLwNKWQ+j
 hGhiP784KX/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; 
   d="scan'208";a="406567438"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 05 Dec 2020 08:37:29 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 5 Dec 2020 08:37:28 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 5 Dec 2020 08:37:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 5 Dec 2020 08:37:28 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sat, 5 Dec 2020 08:37:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihIGl6lUeqS498MsGFb12pbLZOzCYYnX8KecXH6DLyXQExtbNIe5/BdoZO/EupmoQh4R80nC+ro6arUC6BXL6z1CQpq6Za9j0Tq5hgw9c2LZI4GmqcAYHlAapbe6gklYB8KEWS1dkAFMKfWXOy4K/FYDwai24VRqNxK4uzdt1OezqJqe7WMQY5K/b1MpP3lfkfss02R8G+ssuAaONc96vEQGdsmHbF15fMvwMNGfXJq69G9B9VmCKO/spNecJ50ZD4eZEe9bmdk+Eni9SbtLRKZ2XDRgTlnf90NIH1VJBUInFFBTR7DnJKO0FRAFagv9UMqBD3dt4PoeXFdzabpGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIdYuWcYW0KJ9xJ4rTBJF9vC82C/mqiQy2/Z4o8N5wY=;
 b=hmbwT0AM1fXPfcDL8KnGFaGlq0FoFsoyK4l0OLqDILurraB8kn4N1zA0bt2zXh5HS88YaofI/t278jMi98dO/qwFvt9lTQIYWkAEEjLF/rhSr+QHYJzvaZqphkKC8zfohmuV8i10sk9fZSb2h0Z+AvYGyCTw9jO40XnykH5sz6EPMjZ/xR7H2BIOKfBPwnk4adEWIQFzgTJizuKzdNK06ynzcoOrOdCwKRB0u1RHKbwKpG2id+NWR9eTEI3kyhu+w9M+Qt1vIdnVumWdRt2WJstRfpkG7PPxERt/GETCTNls3czjyNk+qfxTBvqp3vlft5VK6cWt4IHZot5mUaybMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIdYuWcYW0KJ9xJ4rTBJF9vC82C/mqiQy2/Z4o8N5wY=;
 b=ob0rZhMMFvr/jvPW/mYQOWG3JmUC5PAjR302AkYLrK3vgxGV2F9pnSvQnp3y14iF/E05ei7cZNKMfnfdHA/4v4x3JIJlEqEbmgx4aID2eoMfSGjpHJ6Id7iTQJOCcu3NFBIHey0lA2a9oOWRxb0EC9a8a0Qx94EP1EOC3etScNE=
Received: from MWHPR11MB1679.namprd11.prod.outlook.com (2603:10b6:301:f::12)
 by MWHPR11MB2029.namprd11.prod.outlook.com (2603:10b6:300:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Sat, 5 Dec
 2020 16:37:26 +0000
Received: from MWHPR11MB1679.namprd11.prod.outlook.com
 ([fe80::c84:799f:437b:19d0]) by MWHPR11MB1679.namprd11.prod.outlook.com
 ([fe80::c84:799f:437b:19d0%4]) with mapi id 15.20.3632.021; Sat, 5 Dec 2020
 16:37:26 +0000
From:   "Gross, Mark" <mark.gross@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        mark gross <mgross@linux.intel.com>
CC:     "markgross@kernel.org" <markgross@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@suse.de" <bp@suse.de>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alessandrelli, Daniele" <daniele.alessandrelli@intel.com>,
        "Iyer, Sundar" <sundar.iyer@intel.com>
Subject: RE: [PATCH 03/22] keembay-ipc: Add Keem Bay IPC module
Thread-Topic: [PATCH 03/22] keembay-ipc: Add Keem Bay IPC module
Thread-Index: AQHWyDJR6ibfO+n2Z0iYweamtROKuKnjVOgAgAC/kwCAABYoAIADtESAgABVJ4CAAIUUMA==
Date:   Sat, 5 Dec 2020 16:37:25 +0000
Message-ID: <MWHPR11MB16793B6D480A452273A60C5C8EF00@MWHPR11MB1679.namprd11.prod.outlook.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-4-mgross@linux.intel.com> <X8cxNA3GTi/LrTt/@kroah.com>
 <20201202174200.GG63356@mtg-dev.jf.intel.com> <X8fkflUXwSTGAoyQ@kroah.com>
 <20201205033517.GA49179@linux.intel.com> <X8tHY5W/ueQYEaN6@kroah.com>
In-Reply-To: <X8tHY5W/ueQYEaN6@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [50.53.49.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2a5516d-57a8-4106-6612-08d8993c0c91
x-ms-traffictypediagnostic: MWHPR11MB2029:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB2029A4241C99FC11809BDFDF8EF00@MWHPR11MB2029.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9kmS/NiOmZmsEEFrgIR7ILzMv6iRu3wia800CfeHiGfbrYCbZHR/JriPb4zG/An/LJjVuozNsBESRcoaeeB9g11ffqIQEq/kX8tQjsa/MnRF5OhZWlZ+FoC99geJ8k/G4pBvuP4mu8/ULTJrXaU7aU7QVTY3fVBjHEW5kd/rA70qYN+jmRcfOt/FLNZ/WGChqpc2LlJiKSaqDq+9OkNf/vAp3U5gbhOj8UO9agR2ZAsM1mFK2mPn18tbz3QTXu+CTr5qAlOhP4ZDO+TJyprVrQKKhNiGaKZG2W1N21TVTy1vIyR+7xNpXsXh7g9vQFvTIvcZwvx7Wu6esxCT5UJCYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1679.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(186003)(86362001)(52536014)(8936002)(4326008)(8676002)(83380400001)(53546011)(33656002)(6506007)(54906003)(478600001)(316002)(66946007)(26005)(66476007)(2906002)(76116006)(5660300002)(71200400001)(9686003)(110136005)(66556008)(66446008)(7416002)(55016002)(64756008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?O/G5su0a6j3s0y/3jseCoqHO8tyHCmWj8LPZ5P/wvy5yc7JUpDKU2YVLCUmi?=
 =?us-ascii?Q?dgMzPIdwhc0M2DmP71XH4LK0TrZt5XMDDP6LHNFAkzkMzH4th3sZ505Neekn?=
 =?us-ascii?Q?LfHdMPtK5MoDnmZNWdvEacJPbaqg4B9b42rF7a21Jq5eZN0OZQesSrPFExsu?=
 =?us-ascii?Q?ibyQQ70rtCk27Y8pw3Slv94fXBtvAZ8YwF6B3C5n+l1xVGAglAeCttDDFxVN?=
 =?us-ascii?Q?kfdPZZeZ2ClBnEpqjbEL+XJtkb4ca0A2hnM2lrqcqVKKwCwsp773jJrjten6?=
 =?us-ascii?Q?Iy5Rq3sj6g0i7uuSwBvUcuXEUQqL0NJnDr0oxOBLCbkFxr9ewsKRG0IEvKjN?=
 =?us-ascii?Q?HEtDUoinT1PW8u5OjWNchBbCvWiuhRL+fl7xe7YqQyPR2I1ATfMncTPb/hRk?=
 =?us-ascii?Q?5XSkkpIb0rLi5Bp/KQhI19eb/fP9w38kRZV5PdGp8al5jqblQQwMeBaqxOA4?=
 =?us-ascii?Q?koJkQk4b5BDY36l6Kz+J6ewDmtdJjBpXvAgbjZM5MaxWUr980c2jxnNHqBDA?=
 =?us-ascii?Q?wA8g1TVME0jP5e4agNFLPGuOnOAdSk2TbYUImdEnaYGPzuF2ZdQFrPDRJUOD?=
 =?us-ascii?Q?uFEaIn1RG6Pq2yqmZSSQrVdKpKZRLnZ+0whduVScocZQ8N8Da1SZXITs2eg3?=
 =?us-ascii?Q?BQXP9aOn4aSCarMXgA09Nwwr38td2k46zG6RzFfYk+spyHpGrT5wXE/pEHqU?=
 =?us-ascii?Q?2GXOAyr1HHgjUzDbUa8POF2qArf58B8saAkZBV6PRNW0BzSzLUZ9ud7NKog/?=
 =?us-ascii?Q?ghmMzsIB8V+lnzY9XGPhOIEh2acqil65/H2fCxONjSChDBgdOcwYZ5t594r7?=
 =?us-ascii?Q?O5qmAyrn8LWiYBFmKy0ANlv61ndz8ZaoxAEMSk+VTyeR2Z5TyLDarBCorBbJ?=
 =?us-ascii?Q?nux4SsKy1e8V3cFhoOMzpjSzKzAL8ByRjnS62GsGCrDk54UQ2XgWX62RfKFw?=
 =?us-ascii?Q?vB7iVTUS1XnrPoEk93dtiX7mIGhZXvd4Ky301qjr3Yo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1679.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a5516d-57a8-4106-6612-08d8993c0c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2020 16:37:25.9188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bA+GwF0BQcuqS5gCOn3O0bFIVDqlpJWlxz/px3nGLOfpzI3iMeRohjBmd8RL+KM/M3XHppM8X9aFeQtqEw1XNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2029
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Saturday, December 5, 2020 12:40 AM
> To: mark gross <mgross@linux.intel.com>
> Cc: markgross@kernel.org; arnd@arndb.de; bp@suse.de;
> damien.lemoal@wdc.com; dragan.cvetic@xilinx.com; corbet@lwn.net;
> leonard.crestez@nxp.com; palmerdabbelt@google.com;
> paul.walmsley@sifive.com; peng.fan@nxp.com; robh+dt@kernel.org;
> shawnguo@kernel.org; linux-kernel@vger.kernel.org; Alessandrelli, Daniele
> <daniele.alessandrelli@intel.com>; Iyer, Sundar <sundar.iyer@intel.com>
> Subject: Re: [PATCH 03/22] keembay-ipc: Add Keem Bay IPC module
>=20
> On Fri, Dec 04, 2020 at 07:35:17PM -0800, mark gross wrote:
> > On Wed, Dec 02, 2020 at 08:01:18PM +0100, Greg KH wrote:
> > > On Wed, Dec 02, 2020 at 09:42:00AM -0800, mark gross wrote:
> > > > On Wed, Dec 02, 2020 at 07:16:20AM +0100, Greg KH wrote:
> > > > > On Tue, Dec 01, 2020 at 02:34:52PM -0800, mgross@linux.intel.com =
wrote:
> > > > > > --- a/MAINTAINERS
> > > > > > +++ b/MAINTAINERS
> > > > > > @@ -8955,6 +8955,14 @@ M:	Deepak Saxena <dsaxena@plexity.net>
> > > > > >  S:	Maintained
> > > > > >  F:	drivers/char/hw_random/ixp4xx-rng.c
> > > > > >
> > > > > > +INTEL KEEM BAY IPC DRIVER
> > > > > > +M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > > > > > +M:	Mark Gross <mgross@linux.intel.com>
> > > > > > +S:	Maintained
> > > > > > +F:	Documentation/devicetree/bindings/soc/intel/intel,keembay-
> ipc.yaml
> > > > > > +F:	drivers/soc/intel/keembay-ipc.c
> > > > > > +F:	include/linux/soc/intel/keembay-ipc.h
> > > > >
> > > > > Sad that Intel is not going to actually pay you all to do this
> > > > > maintenance work for a brand new subsystem you are wanting to
> > > > > add to the tree :(
> > > > I thought adding my name to these maintainer items would help with
> > > > continuity as the individual engineers tend to move on to other thi=
ngs over
> time.
> > > >
> > > > While I'm paid for a number of things at intel this is one of
> > > > them.  My role is as stable as I choose it to be at the point I'm
> > > > at in my Intel career and the business unit I'm now part of.  We
> > > > can leave my name off if that would be better.
> > > >
> > > > Even if I'm not a VPU IP domain expert like Daniele is I can still
> > > > chase down the experts as needed after Daniele grows into other thi=
ngs over
> time.
> > >
> > > I'm not objecting to your, or anyone else's name on this at all.
> > > I'm just asking about Intel's support for this new codebase being add=
ed.
> > > Having a new subsystem from a major company and not have someone
> > > paid to actually maintain it seems really odd to me.
> > >
> > > That's all.  If that's Intel's stance, that's fine, just wanted to
> > > clarify it is correct as I know some people at Intel have been
> > > confused recently about just what the S: field means.
> > I've been following up on whether the status field should be
> > "Supported" or "Maintained" at this time.  For this current
> > instantiation of the VPU enabling under review here I think Maintained
> > most appropriate.  There are a good number of people who look after it.
> >
> > However; I have learned that the instantiations of the VPU after keem
> > bay and its follow on SoC will include an evolution of this stack and
> > between now and when those get close to landing that evolved version wi=
ll
> become "Supported".
> >
> > Given this, would it be more appropriate to put this stack into
> > staging for a while?
>=20
> drivers/staging/ is for code that for some reason is not good enough to b=
e merged
> to the "right" place in the kernel tree, and you need community help to g=
et it
> cleaned up because you can not do it yourself.
>=20
> Is that the case here?  If not, then no, it should not go into drivers/st=
aging/.
That is not the case here.  Lets proceed as we are on this then.

Thanks!

--mark
