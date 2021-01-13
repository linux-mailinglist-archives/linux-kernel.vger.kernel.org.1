Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BB62F490F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 11:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbhAMKzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 05:55:22 -0500
Received: from mga03.intel.com ([134.134.136.65]:2993 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbhAMKzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:55:21 -0500
IronPort-SDR: jE7aF06vNSRVgcj9UW5GpbcbHMrdKSsi/WY1cY//Rg2rR8EAjho6yisvNupcZ4WYWe30D8K205
 B+8AXvd3a9yQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="178277282"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="178277282"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 02:54:40 -0800
IronPort-SDR: ElQCnopaFV3gKwHuyGN0NMdJOucoCI7fZqQeJ1LYIOUzLNCL3oOAydJiZGAzthBQjSsRHFMHRG
 QJirFt2kHhtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="363846900"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga002.jf.intel.com with ESMTP; 13 Jan 2021 02:54:39 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Jan 2021 02:54:39 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Jan 2021 02:54:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 Jan 2021 02:54:38 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.51) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 13 Jan 2021 02:54:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emBUIFG31nQzcXpW10elWtV8rmL3do80fLkjE8dyp154Xw3kxv5Qwm6/lCdpBSrFaqtrKQIkzka5kExqLnGqoeVkatFCuxi2FnssFhHrLhQAxlz++EnPst3a4rm9o1T5mjFyE3NSOfKJe+woDvbCDYX9Eakp/AFoLOM2wa6iOUyXYY5orhXJS+kGLytJ1gX3+iLyYb6EbtyX4dLoHa/ULiULh//0m+xmwSEWoWnun1RyxnYN6aGdbinoT5vPIag98lrc9Hlszkg1LWGeFnTqUtNC/4PqqyYP1JZVimXhQbnfsDnwMJHTBMWkFaTa6H6aozzFNkiG5tMMdTJz6+9t8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTSy2r0ydE/f7ER6o/+lu97wx5eOEsj6/4MXBCaeU50=;
 b=CrDoVwnuNRUD8HN9MaOPw4kaL3gIxwCAGIPkejQmO5c1f0UDbhhQfryULG/N7UAjjGA1mekTf+7VB7MYC716bnWgAp/pJnnGAijQmVm5sGZ69eQHzzDD39tlAXU7EKwpXmDGb1CmqLL4NvrVPELbGGQsSEk26HHpgRjpBfP9oHLhRIJUPSyGcRqhxgKuE9fngQahpW1hvin+VmE0XeN2Dk8t7ZPrngWYByZF+cTK2yRksq9UnfapBEhsIWmM5L4KJUZU0++1OTjcmDxLH6m6R6g60a3chcA2wU2Pm2ooAqC3pPeRxZcMSiZ7HhCqJAphXVjr5t2AHdtyKfi8/OuDvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTSy2r0ydE/f7ER6o/+lu97wx5eOEsj6/4MXBCaeU50=;
 b=uGMw+jqqry0OGv+eBStX90JIaKAvVBE3D0e74q7/mS93CI4ZbUvP85npfQqR4S0XZTqrwMNxyybt9pYvfASWnmZXQkRfmPUentRx2Dn0OGYcmaVuOuyQhNLsegVE2fIHtotGIfDg/d8Cgt6V8ytTiS1/D+qw3NXG3YXbmT2VygU=
Received: from DM6PR11MB4250.namprd11.prod.outlook.com (2603:10b6:5:1df::18)
 by DM6PR11MB2730.namprd11.prod.outlook.com (2603:10b6:5:c7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 10:54:37 +0000
Received: from DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::6da6:c2ee:aa4a:d21f]) by DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::6da6:c2ee:aa4a:d21f%5]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 10:54:37 +0000
From:   "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Seow, Chen Yong" <chen.yong.seow@intel.com>
Subject: RE: [PATCH v2 0/2] Add drivers for Intel Keem Bay SoC timer block
Thread-Topic: [PATCH v2 0/2] Add drivers for Intel Keem Bay SoC timer block
Thread-Index: AQHW3m7YxPa/m6s82EKpveVtdL87PqoldpUQ
Date:   Wed, 13 Jan 2021 10:54:37 +0000
Message-ID: <DM6PR11MB4250A1E8C1F2CA97516A2E59FBA90@DM6PR11MB4250.namprd11.prod.outlook.com>
References: <cover.1609306622.git.vijayakannan.ayyathurai@intel.com>
In-Reply-To: <cover.1609306622.git.vijayakannan.ayyathurai@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.106.177.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd8f34cf-0cf9-49b2-ccbb-08d8b7b19ee6
x-ms-traffictypediagnostic: DM6PR11MB2730:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2730226CA2C932F83FB396D9FBA90@DM6PR11MB2730.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N2mygedINpv/VjXaR8rxZsQ0YFL/yhJDHqTT7oPPLSHleXRgo/KzOJ61AARCzIP5bY79qYETwvU+KkmO+R3USaxysjcvVn8UD41kMCmJYg3fZ7Z8InK6K0pV21UaNpERCarO1VxUnb60wz3UxYDvJCZOnDIs0mP4B3aokZTYFPcsz+Su0UoPn6RMI5pAPanzol0gMcOGaKIkzbiaVYiDA76HR/CpXa7CjwR8LckhO0x+CrsPT6J+v2eYt7/ecYhmiJkzrgEFSctksB+H+P2yymLfjPH4yPGyFx06RNbO2Vrt0KAW2cFcpK+hfHUE8y19AzV3OqFkaFdeVE+fTX7LIVJxBRguPm9A8lHlfz/CYSO7LmWSOc2EZE9IBciaZlcN8sLcIKYjQo8J6XwjIaP/ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4250.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(5660300002)(8676002)(55016002)(54906003)(316002)(26005)(7696005)(52536014)(2906002)(478600001)(186003)(110136005)(4744005)(4326008)(86362001)(66476007)(66446008)(66556008)(83380400001)(64756008)(33656002)(76116006)(66946007)(8936002)(9686003)(71200400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?x5HS9+kfPEBFZURcZV2XA6gn/Vu2v5UPTfvScD/rx7Gwy7FWtjW3UWURg7ab?=
 =?us-ascii?Q?rfvctCPWdlY9GNZWZ/tcl7He1EfPHjOF5+cCKnG/XpUf/xKXkcUzkpFrPTwd?=
 =?us-ascii?Q?caPvtnoRUYjy8DfeFreGtQHTf5ws4eN7Qpa0MEFuMzrq4WKiWCIy+Zae5Lui?=
 =?us-ascii?Q?2y6H8WSYUp0kcTnYYUKhmfNg9kQ2pOpqUIFQu7+g0M7HDGjA6qtStH+sKum8?=
 =?us-ascii?Q?TmWE5T9qQd24mIlF/YRAXztg9tXZm5WSw4j6cOs7VwFMLK6Lh3XosgVpCedK?=
 =?us-ascii?Q?lRJ6TNjac6xQRtu/AWkSy9eXSVPu76X4n6i6Or+RHfz7p+ofmloFbbaakM+j?=
 =?us-ascii?Q?x4GlY3wEyBYvKF4PRuvY2Pat+Cz8Im5ZJUilyz56VxRnFH+eIXzhXiZuOedQ?=
 =?us-ascii?Q?lkMUqdMlftHaaj8YWjNr2z5gN6NNuHk8j+eJ2AmBkGS7sZlo3nu141vaqqNz?=
 =?us-ascii?Q?uK9lDilYqvZb1VK+3Ac8zCUdFrZk89JXwonfRpcfN0LxQws/yErQdebOkLwI?=
 =?us-ascii?Q?gGa1N6rjwb9CDGlPYSG+Vkat4CKu15oFp8pZXmFk1rP+MNed5osvuQwCPMzM?=
 =?us-ascii?Q?PVyHNrDFPILCt2KzjhRwMltMHfvpMA8PP51A4zV7A34bKIGRFiZbv7kfBYnJ?=
 =?us-ascii?Q?xDCojyK+I0JtEOuxv29/DcaaWzt6i+jWY6N7RIUvb3rQMAaBbAH+kptirjK8?=
 =?us-ascii?Q?KiyEsUnxrdQxXOoNI87QD7MPfEoyc05ylCuEGaunD+OCqq9OMFOFdks7y5br?=
 =?us-ascii?Q?0tAIhGdcEykZggYKxJ1/rWkkzgBQJ4httFABjfYl/6hS/sC8WeoY9f9FcGwW?=
 =?us-ascii?Q?zAr1Xw5f6qGO2Th1kDAiji/vIlE6LbsaE6AQKIwOw+ZEdh2ny6+7HxrZYQ5l?=
 =?us-ascii?Q?uVc4C0j0h7KZyWcgS9nSjMtSVrewM8LAF3RMf8eMdx+ioPnCm5QKQmHX7jBs?=
 =?us-ascii?Q?+O+uwifRbZJF6CIqwbAu+yh4m6C3S/PfrieM9V+LjgM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4250.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8f34cf-0cf9-49b2-ccbb-08d8b7b19ee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 10:54:37.4716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0UlcDHqzgyhJqiZUxViAtsHol1+UA5LSQSE0UB3Ehj7O6h99lAmHhxaMT1Xe8e3cpN19fBjLHyedVZV4vzw/UrJIyYyEd4SXACKYCzMOWbUVGsyuTAybnVI83NnaScj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2730
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
>=20
> Changes since v1:
>  - Add support for KEEMBAY_TIMER to get selected through Kconfig.platform=
s.
>  - Add CLOCK_EVT_FEAT_DYNIRQ as part of clockevent feature.
>  - Avoid overlapping reg regions across 2 device nodes.
>  - Simplify 2 device nodes as 1 because both are from same IP block.
>  - Adapt the driver code according to the new simplified devicetree.
>=20
> Vijayakannan Ayyathurai (2):
>   dt-bindings: timer: Add bindings for Intel Keem Bay SoC timer
>   clocksource: Add Intel Keem Bay Timer Support

Kindly help us to review this updated patch(v2) set.

Thanks,
Vijay
