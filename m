Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A9E2028E1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 07:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgFUFqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 01:46:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:28462 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgFUFqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 01:46:48 -0400
IronPort-SDR: csn+Vzt7MAy0kAJ11vLY9UKhpFokaIqDNzMqtfQ2udi8+9nE7PWJTlycjUJKJX3Y2EDG61p4oh
 yLENddGqrlbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9658"; a="143445694"
X-IronPort-AV: E=Sophos;i="5.75,261,1589266800"; 
   d="scan'208";a="143445694"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2020 22:46:47 -0700
IronPort-SDR: 9TMKAjb0+JsYBfXAaxYTEwyv0cNcL1t3RfUbdkqID/H6PgnopPn2aa34XCb9Kt0l25NyCoO4d1
 LNkxmDhw9QAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,261,1589266800"; 
   d="scan'208";a="262686422"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jun 2020 22:46:47 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 20 Jun 2020 22:46:47 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX126.amr.corp.intel.com (10.18.125.43) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 20 Jun 2020 22:46:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sat, 20 Jun 2020 22:46:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mk617rLV313QoUKfWcw3ype6RbTRD+psuLKMy2W6Gl4ErYsmhZT0D0qjSYHROWKxGPpY4NFUHec7ilzgvlwj1fS9INAW7jcbwH1K5Z0qJ+mQy3sWfsmEBo1S8kJgLLjUchrhzASAu0agVDjOXqeyB76zMAzGrbsTCAdxLVzq5+2mW0BkaXsZ4yTFcak9tvyQQ9Pes38HZyp2gVsltFJHrfmMHDUa8ycyZ43zshtA8kbQgq2Zk1jukEY4JQrtll1ytWPyboA/KTkGBvMJOabql+QcS051Pb+nG9u6haUBGlpv8UH3V946Pw8Nn0jmwKoiiLfV3jb3ubpYX26V3RL+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcYnF1mPZurEtYP5BcgEwwK77kg424uMIJwjxE57ayU=;
 b=IMtC8W3Mm3HkHYK2wkb4z4K4YrlEVNIyNoeI7FPBpATvvc8R0C0P8ycpJfz4DXAOtSra3ZBArbbRIe04xAHQgwiBaBVWDZIAa1Eg828NY9T+C9kHqH8IUMtyVyWfFvat978PFIPQdE7CYyE5hcHpzkvYakWqrs64yG0mz0XQdCI4ifk/ifuFpMNA5AxcSsFPm4fa72GjIeXhFhhsNg6ijoFUu1ZNdwpU+LRqWSerupfXTDef6osnBSLPmAE4Urm1HOHTccSaUGmgF5Mvp+UcVxdip4hVG80PFBfbw1uEM96E6D5oa8D+b65VV42KTeA/3nR9SlOnnPFtaD2a0+SeUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcYnF1mPZurEtYP5BcgEwwK77kg424uMIJwjxE57ayU=;
 b=Zwdf/dCL+GL2i4ShtyrqgF0Tx6FGaWrIV3ryLu5iVqqyas4gKAC8QmRVQsLzWo2phf6uqMTpdwnxapdZfjr3d2gfw1jX8ET/guM6uGVMIWRYNeVlHuvXJeJdjPP1wAHpHfA0ioyNYh3q5s1GNslC88ML9zJUNr1zLjWA9N1sisM=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3417.namprd11.prod.outlook.com (2603:10b6:5:68::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.23; Sun, 21 Jun 2020 05:46:45 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c%6]) with mapi id 15.20.3109.023; Sun, 21 Jun 2020
 05:46:45 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Jonathan Corbet" <corbet@lwn.net>
Subject: RE: [PATCH v2 1/3] docs: IOMMU user API
Thread-Topic: [PATCH v2 1/3] docs: IOMMU user API
Thread-Index: AQHWP6WkhOQLPQDE2EquIdJoSq1UYKjTj/yAgABESYCAAA2bgIAAP1SAgAdDUQCAAPjyYIAAJcYAgAJxwoCAADPkoIAAIdmAgAAFjiCAAOBlAIACbjqg
Date:   Sun, 21 Jun 2020 05:46:45 +0000
Message-ID: <DM5PR11MB14354781F76472F435F3EC46C3960@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1591848735-12447-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200611094741.6d118fa8@w520.home>     <20200611125205.1e0280d3@jacob-builder>
        <20200611144047.79613c32@x1.home>       <20200611172727.78dbb822@jacob-builder>
        <20200616082212.0c1611dd@jacob-builder>
        <DM5PR11MB1435DD578488DA08A1E699ACC39A0@DM5PR11MB1435.namprd11.prod.outlook.com>
        <MWHPR11MB164595B754BE441255902DCA8C9A0@MWHPR11MB1645.namprd11.prod.outlook.com>
        <20200618154805.049219db@w520.home>
        <DM5PR11MB1435FA1C517087E8C5DEACB3C3980@DM5PR11MB1435.namprd11.prod.outlook.com>
        <20200618205457.6969f9a7@x1.home>
        <DM5PR11MB14355A49810AA611DD8540D9C3980@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20200619103758.3167d4f9@w520.home>
In-Reply-To: <20200619103758.3167d4f9@w520.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20519283-459a-4be4-59c7-08d815a67b77
x-ms-traffictypediagnostic: DM6PR11MB3417:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3417E2C903F2E96F248FFBB3C3960@DM6PR11MB3417.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04410E544A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WfmCbOSkwweSLVGwbagEp3W02alAGS4ACLG5/YIwerRPHclAROrwBalkiz+Ky2O+CcxsjJXkKo6/FCtAtfvn48wHjrf1GjlVmsEDOmbGEDYsElsA3/onUtXLCa/5H6KMNInY0QMttmTZuVvs8BgZlmEsEVUP/y6HiwKqQsDiqqb7MgNB/OhUIxx70ENJiJgNscHMNCSx9EqY6kkP5oV/ZQ8PUdpZRWn44Cx+jX+/2RMT8h0B8ad/5guBVVSZRhdNfWpHlz1Fs+oj7I5tXanxPLMRg1TKVjDudEUVK1Qd+O2WaHA17yIbcsylI0q48nTDGLSD0gBFbBNK1ndAqYXcuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(316002)(26005)(186003)(52536014)(71200400001)(33656002)(83380400001)(4326008)(54906003)(8936002)(2906002)(6506007)(55016002)(7696005)(5660300002)(9686003)(64756008)(66556008)(66476007)(66446008)(6916009)(478600001)(8676002)(7416002)(66946007)(76116006)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0DMp7PMPFZnW1hM3rwFTQnnnUzkQinqviow2TYROQvTW/TuNj04dK1cc33raDxPyY9sREAHy3OJde1TPQs91T0lEcSV5Ziy5NMvByR3Ye1hAqr8nONl6MtzTfbTM7mD5WEAyQTdICtK5jxj6uPsTDBn/eX2mquESfIUGEjGTEe3l8c2pus5P/nX3qwTz/9PNtkE9RrSUYddh9rS1AZAUKwwopUB2WW+khDT4Qn0yh+IkSu0SjCFjQmHY+Ml8Uvfj41dnUL3Ojsc8hiPEFKQs3+NYJcz9IZ7/eHArwba99f4DnB/M9G7SwTq3wpPisC/2VkYSdXPVFBx9i3bYuHhZamhpM5Pbp5coxzcUXURsziyERANqvef8fklQYV/1R6cZ5XBqVHoQZnA3h2glbHEDgRDUdJ7Ry2+/0Jkw6+5q2xA95+GTCOYh0SL5SHC6ICsYj6m4yw5bbnBQx4IVdVKfLMaUdlI0Vi8uwsC8mbGzq35YJdj4KpmgajTpA50ob58P
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 20519283-459a-4be4-59c7-08d815a67b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2020 05:46:45.1879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1LQ/pm3HURvB6CqMhwitLULUnPhVRua3+G0DGDaAGaz5g/KLFSQ8xixpfba6vpEYvJbXMdkLHDimF29RcPSqmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3417
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Saturday, June 20, 2020 12:38 AM
>=20
> On Fri, 19 Jun 2020 03:30:24 +0000
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
>=20
> > Hi Alex,
> >
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Friday, June 19, 2020 10:55 AM
> > >
> > > On Fri, 19 Jun 2020 02:15:36 +0000
> > > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> > >
> > > > Hi Alex,
> > > >
> > > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > > Sent: Friday, June 19, 2020 5:48 AM
> > > > >
> > > > > On Wed, 17 Jun 2020 08:28:24 +0000
> > > > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > > >
> > > > > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > > > > Sent: Wednesday, June 17, 2020 2:20 PM
> > > > > > >
> > > > > > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > > > > > Sent: Tuesday, June 16, 2020 11:22 PM
> > > > > > > >
> > > > > > > > On Thu, 11 Jun 2020 17:27:27 -0700 Jacob Pan
> > > > > > > > <jacob.jun.pan@linux.intel.com> wrote:
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > But then I thought it even better if VFIO leaves the
> > > > > > > > > > entire
> > > > > > > > > > copy_from_user() to the layer consuming it.
> > > > > > > > > >
> > > > > > > > > OK. Sounds good, that was what Kevin suggested also. I ju=
st
> > > > > > > > > wasn't sure how much VFIO wants to inspect, I thought VFI=
O
> > > > > > > > > layer wanted to do a sanity check.
> > > > > > > > >
> > > > > > > > > Anyway, I will move copy_from_user to iommu uapi layer.
> > > > > > > >
> > > > > > > > Just one more point brought up by Yi when we discuss this o=
ffline.
> > > > > > > >
> > > > > > > > If we move copy_from_user to iommu uapi layer, then there w=
ill
> > > > > > > > be
> > > > > > > multiple
> > > > > > > > copy_from_user calls for the same data when a VFIO containe=
r
> > > > > > > > has
> > > > > > > multiple domains,
> > > > > > > > devices. For bind, it might be OK. But might be additional
> > > > > > > > overhead for TLB
> > > > > > > flush
> > > > > > > > request from the guest.
> > > > > > >
> > > > > > > I think it is the same with bind and TLB flush path. will be
> > > > > > > multiple copy_from_user.
> > > > > >
> > > > > > multiple copies is possibly fine. In reality we allow only one
> > > > > > group per nesting container (as described in patch [03/15]), an=
d
> > > > > > usually there is just one SVA-capable device per group.
> > > > > >
> > > > > > >
> > > > > > > BTW. for moving data copy to iommy layer, there is another po=
int
> > > > > > > which need to consider. VFIO needs to do unbind in bind path =
if
> > > > > > > bind failed, so it will assemble unbind_data and pass to iomm=
u
> > > > > > > layer. If iommu layer do the copy_from_user, I think it will =
be failed.
> any
> > > idea?
> > > > >
> > > > > If a call into a UAPI fails, there should be nothing to undo.
> > > > > Creating a partial setup for a failed call that needs to be undon=
e
> > > > > by the caller is not good practice.
> > > >
> > > > is it still a problem if it's the VFIO to undo the partial setup
> > > > before returning to user space?
> > >
> > > Yes.  If a UAPI function fails there should be no residual effect.
> >
> > ok. the iommu_sva_bind_gpasid() is per device call. There is no residua=
l
> > effect if it failed. so no partial setup will happen per device.
> >
> > but VFIO needs to use iommu_group_for_each_dev() to do bind, so
> > if iommu_group_for_each_dev() failed, I guess VFIO needs to undo
> > the partial setup for the group. right?
>=20
> Yes, each individual call should make no changes if it fails, but the
> caller would need to unwind separate calls.  If this introduces too
> much knowledge to the caller for the group case, maybe there should be
> a group-level function in the iommu code to handle that.  Thanks,


got you. I don't think VFIO needs too much knowledge except the
group info and the bind data. may send updated version based on
your comments.

Thanks,
Yi Liu

> Alex
>=20
> > > > > > This might be mitigated if we go back to use the same bind_data
> > > > > > for both bind/unbind. Then you can reuse the user object for un=
winding.
> > > > > >
> > > > > > However there is another case where VFIO may need to assemble t=
he
> > > > > > bind_data itself. When a VM is killed, VFIO needs to walk
> > > > > > allocated PASIDs and unbind them one-by-one. In such case
> > > > > > copy_from_user doesn't work since the data is created by kernel=
.
> > > > > > Alex, do you have a suggestion how this usage can be supported?
> > > > > > e.g. asking IOMMU driver to provide two sets of APIs to handle
> user/kernel
> > > generated requests?
> > > > >
> > > > > Yes, it seems like vfio would need to make use of a driver API to=
 do
> > > > > this, we shouldn't be faking a user buffer in the kernel in order=
 to
> > > > > call through to a UAPI.  Thanks,
> > > >
> > > > ok, so if VFIO wants to issue unbind by itself, it should use an AP=
I
> > > > which passes kernel buffer to IOMMU layer. If the unbind request is
> > > > from user space, then VFIO should use another API which passes user
> > > > buffer pointer to IOMMU layer. makes sense. will align with jacob.
> > >
> > > Sounds right to me.  Different approaches might be used for the drive=
r API
> versus
> > > the UAPI, perhaps there is no buffer.  Thanks,
> >
> > thanks for your coaching. It may require Jacob to add APIs in iommu lay=
er
> > for the two purposes.
> >
> > Regards,
> > Yi Liu
> >
> > > Alex
> >

