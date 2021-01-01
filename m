Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145CC2E842A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 17:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbhAAQNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 11:13:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:62981 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbhAAQNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 11:13:31 -0500
IronPort-SDR: XwAktixPBHT13xJXiIW6BB1MsUanuJPVmt31tfqWlv4PYMTLuBZM9DpEvpR+swIKZi6tiv5nyD
 p7xs0zoZyhZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9851"; a="176005519"
X-IronPort-AV: E=Sophos;i="5.78,467,1599548400"; 
   d="scan'208";a="176005519"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2021 08:12:50 -0800
IronPort-SDR: mbYag28ClgXRrzOhh+rnwC795CZG8Lys5KwZsGYkNxtyiMus+lQvSUW61dOKhe6P7B5CFicf1G
 GSKACl1FN4ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,467,1599548400"; 
   d="scan'208";a="396591937"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jan 2021 08:12:49 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 1 Jan 2021 08:12:49 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 1 Jan 2021 08:12:49 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 1 Jan 2021 08:12:49 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 1 Jan 2021 08:12:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRFK70/y4yHPTsEMKyXZiKJCpc/aE/fRdQPXomoNYTeQuUiCAtW3SeHEBwWRgJunuYOp06sbWLpEr/07DmyTzzhjHULCgmy+B55e/Ej8QZmeAdZ68ZiVM2yhrh8bUcZ/06cZcsy8Zpyb/MQUXbCq2BPhhMWEYYAk/RRo2rpLVqsKixvdFmwSESrSgr810XoF5O5GU2CKyN5wd5dvpRPvXtEAb8LWpj8/Y2chan7xjYtm+0qlVKqtqRi7RrPlMBX+VGOfnMMyUp24JiVSkMUrt301AHuNM8zdMZN1/TSSlbUWb5UC9iyLShss5E8n8JOsVMFgjpeOlLCAqoiNQc3o+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeDTdnDMlhmkthPSgEyJ3pchb4W/WJbsZMwSL1R3S3o=;
 b=ihyJFL/5qKTUizQdL9mvcA2+y+Qev5HT+3z36gifaHAMT2VAL17PgtcMl+z2L3kUIe2qb4yRbnWGnWqEmsv+1WNOEwWZzTKibYFmWgAMpRMK7AKnKSH4Otz5OlRw7PvjXYfvJ4GmPQUNAIdA1MTln71r43yTapBerh5tN717J0BdIk8nfEPqg5ktOBr5kCdFZFiGj/4Ju3Oldgw4THdOPG21ODecieMA4vqbBj113J3oTpjWBpvT/afCl0H2jz72m5zwIHq+n4QmOgD4uxvJF1F2a8F+Thipc6FtZWT5+2IBYhUyqY+RohzXrI2kdTZUBzbEFw/QdGGei/TxUVUQJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeDTdnDMlhmkthPSgEyJ3pchb4W/WJbsZMwSL1R3S3o=;
 b=W4mZKne+2lK4WXvta+GsLDwT30MSfFtkDnWG+TYukM8dqfwkZ5bkTx2/MCcgW/XBNpHrYQVrsSY4i7r2OGT2kz0tWr2NF6Fm+BemXJAFDY38mp0e2+9WQC7HEyTP8QZx44h2mFs+Nt1g44KIi+k1TTuKii8F1qX15EFRKdefxmo=
Received: from DM6PR11MB4250.namprd11.prod.outlook.com (2603:10b6:5:1df::18)
 by DM6PR11MB3772.namprd11.prod.outlook.com (2603:10b6:5:143::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Fri, 1 Jan
 2021 16:12:47 +0000
Received: from DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::b90d:d053:9de6:e5ef]) by DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::b90d:d053:9de6:e5ef%4]) with mapi id 15.20.3700.031; Fri, 1 Jan 2021
 16:12:47 +0000
From:   "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Seow, Chen Yong" <chen.yong.seow@intel.com>,
        "will@kernel.org" <will@kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC timer
Thread-Topic: [PATCH v2 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC timer
Thread-Index: AQHW3m7Yk5ViONF5vEWJVi9nhbpVkKoRWBQAgAGbi+A=
Date:   Fri, 1 Jan 2021 16:12:47 +0000
Message-ID: <DM6PR11MB425006F13B3361CDCDC255D5FBD50@DM6PR11MB4250.namprd11.prod.outlook.com>
References: <cover.1609306622.git.vijayakannan.ayyathurai@intel.com>
 <907e6379ae5fc8f5decdb344485123425de7afc1.1609306622.git.vijayakannan.ayyathurai@intel.com>
 <1609428888.834957.1828656.nullmailer@robh.at.kernel.org>
In-Reply-To: <1609428888.834957.1828656.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.106.176.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5115c3cc-84e2-4f5a-1943-08d8ae70148f
x-ms-traffictypediagnostic: DM6PR11MB3772:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3772B8EB8EDEB8E6DBA0F7AEFBD50@DM6PR11MB3772.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 25UXIwqdvutj5kb27fOkXZ67pF9nYmH1VrIZhNiRiBHtBPqczfdL23VFywlq+lcO9OutVLb3T+Dmow4JEpRDG1Jiyz2sJFomODqyk4/HHE+Wg2+NN/gjuyJxHAd53waMagdvRQzvVMUNd25JOYHmwwY4JQk/aNMT7f/RqiJWMNTjtBc1qZerXG8NIiMCJ7q1GPfJw6DHNQuDRBSuatTblBf313SBU+1e+NBfzjzm8v+71vtBd0N40wtqPkiE3qKNARiRKz4zaj8ZfRBV87TThq097E+F0I3Bg2ouoNedkDWE7eN1fDIFvw+E8jcoUP+KQRZO98uU8R1RvO+JlZmuQ84cq70HNdVmgSkAvQEDSr53QZ5xT5DRWdgB+bSsMyvSEObMbbMkKdFchLiWeUA4hIEKCzPIef+6EpwGTO93avvoKlaF5BileF4d/vvCBbcMHjss4cYZqy20m/e+thCSiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4250.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(66476007)(66556008)(7416002)(66446008)(26005)(5660300002)(76116006)(66946007)(86362001)(6506007)(54906003)(966005)(71200400001)(316002)(186003)(478600001)(64756008)(2906002)(52536014)(6916009)(33656002)(83380400001)(8936002)(9686003)(55016002)(4326008)(8676002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vR7UHOdipI1Rvh1/bqmn7ifZ/FE091nLm8Og7knNNAHp9W0BER15y2x18ewU?=
 =?us-ascii?Q?BGPi0sKivcLXdQt2RXlebJ2lVFlROz5xsMZc3dQ9yrhXHLImsZsmGE+2DRb/?=
 =?us-ascii?Q?UMUegyz4b/S96+ZBC1dQJ9BDXaJESLExjDaKmVHBI8f2bgAXHAILHpU/r0mc?=
 =?us-ascii?Q?aEHyf8dIbg7/W/hzqCUUp3Ta/pL62HWrI4n1OJ9JhrmnYk9J0q5vm26xL9ad?=
 =?us-ascii?Q?fB7MGoe1XARIm1fJLs4zkr1E0ONR6GG2pNOv/RPAdob6QgqsgJXGvv2huhSX?=
 =?us-ascii?Q?90GbTPQFa0gz2YoEhLKxB0nfLhv5xIA5WB3muLp/XlO9D5jJsWQy90O7i+pn?=
 =?us-ascii?Q?BgWP6mtzkNC6+iY9zgangmb8NBv0KirNyENnTsLOggc5K+s4R6nM1NV4ZY/m?=
 =?us-ascii?Q?IiN9Q5ndszO1eJyakp9SE/ICOqBbM9GU9fkP3qGsrXB861bBbQKXbs543cXT?=
 =?us-ascii?Q?7t/tiIuJGDo5lDzv48Qg6hu3VQYS5Dfke/+bMFZpS/Ew7Zf/YzrVIxiij1X2?=
 =?us-ascii?Q?9aqHuIq6PWKZIEQ0CCvz6VuCQ/LGUkQ/JeAr1NkYhYjTl7VYAQqMLvldgYlU?=
 =?us-ascii?Q?DfkEMIMqePmPf8AW1DMXc5Sz+Z06XV+kjON9Ui9Fip60HhlPOlRAeciCgshu?=
 =?us-ascii?Q?3T7NwfMTh2cplyjdg91NrMGYAryqGenbFgRWSXX4i4EDs/vc9Pg0qqtH2vgt?=
 =?us-ascii?Q?XYEb98l8Fw1U6aSYMn4YjN3TwZiELbRi7arocPJZ2724s5IgNbtR2AyWhCVl?=
 =?us-ascii?Q?oKAYlcZHc5V7IT3z02l5sRkEZq7bcKRqyy0Z5Xqdby9Isx7qoGdm7uPLx09G?=
 =?us-ascii?Q?d1pX8bsbElvh139AWyePnQ2pZkN6qR+Qug4is2/1lbnmxz4CqrlyWCL7nEfF?=
 =?us-ascii?Q?qPwSsdoMex0JrjPmH7P/tajTgZpWKpnVijrzxmJfyGClKAWS6sQ4wB4ingNh?=
 =?us-ascii?Q?Kp3vKbgD7rpnR+3rSfnrouFhS0j8/oqp2ep/vO/fidI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4250.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5115c3cc-84e2-4f5a-1943-08d8ae70148f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2021 16:12:47.6498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TfFhZQDYUecjqEJrX7P9CTpigOi5XFPJbHyvYmEIXu7uB0cgLNU+GSQSlPY2AOMpYx76xxNr4GlBCOgGMsGJ3V1NuhuCkG7ldVItmPRFnp33fJVIJGQHNDzVNMEYp2h+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3772
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> From: Rob Herring <robh@kernel.org>
> > From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> >
> > Add Device Tree bindings for the Timer IP, which used as clocksource an=
d
> > clockevent device in the Intel Keem Bay SoC.
> >
> > Acked-by: Mark Gross <mgross@linux.intel.com>
> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Vijayakannan Ayyathurai
> <vijayakannan.ayyathurai@intel.com>
> > ---
> >  .../bindings/timer/intel,keembay-timer.yaml   | 52 +++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> >
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/timer/intel,keembay-
> timer.example.dts:32.3-33.1 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:344:
> Documentation/devicetree/bindings/timer/intel,keembay-
> timer.example.dt.yaml] Error 1
> make: *** [Makefile:1370: dt_binding_check] Error 2
>=20
> See https://patchwork.ozlabs.org/patch/1421313
>=20
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.

Thanks for the review. Let me check again and re-submit in the next version=
.

Thanks,
Vijay
