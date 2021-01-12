Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F02A2F284B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 07:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733038AbhALGQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 01:16:26 -0500
Received: from mga07.intel.com ([134.134.136.100]:52779 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732765AbhALGQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 01:16:24 -0500
IronPort-SDR: kMnzUcUrpscmZIC3mds28ZT6PAi188JJ7BA7JiZq058Zx2NiSytzaeZILRrB1S1334QL/LUCJ9
 1ZVHZBBlkrcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="242061087"
X-IronPort-AV: E=Sophos;i="5.79,340,1602572400"; 
   d="scan'208";a="242061087"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 22:15:43 -0800
IronPort-SDR: Lwzll5SxgfuJX278Sat3r7KsJbNup75Ra6FCSG/LQptrzc8GuRIMYHxji+I9QacQluA7jPPYOA
 gKTeWl3TTOqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,340,1602572400"; 
   d="scan'208";a="345118829"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jan 2021 22:15:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 11 Jan 2021 22:15:41 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 11 Jan 2021 22:15:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Jan 2021 22:15:40 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 11 Jan 2021 22:15:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCkYJwwKl0gP4iEQ+tXmDoABbT+38eDZzLyP+7OmT2HmM4VQi0UgB/m7L7sH444R8y6tD9wM9AyiqGuI4wf5FC9i4GGZW2bhzvLwoWsTp6hzPaOq2Yn6gKH1WEg1KZf53001NL9jA5WhjoD/SF5ZnKIBts7dCzbOFXZcp8t9Rfl6SZYbtCg6tCUVx8EyJGsufaQmb89K/t99tkl+xvi6yS+/RXfXkSKJQQdKcGd3+Te9C72Z1tYifR0XLDxveu4EG3L0XQgfRjG7DST8+cfDyhAlzKwgjUYeyFvWHYOstMJyNqDw6wqhTwglAT3Pp2ZeNEOX+f6cRvtdQkIzoThQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0foxNFKItpLsOCKsyZbN1HilRbmLTCbXCxQsipZ3uzE=;
 b=fJh2j6WYMa0/+rHe+JQZzTa0oybVnsk5ytSanvd2taxmMRF/5L8Ws11xYkt255bNUDRJTgXrT6jRY37ED0JDcfIK26x43H1XJMp8HmnVkQNlExtuAfxFHaDdpMS2AwzharHzCUR5gRHTRCcNpcyI1/9Z5ZOKiWfFSLaCF9Sb3eB5J6giuBrqtddkPqdm0A44LaRfBOAh2hvQAdtTV6W04ZvhfXFZP5oDQh9rpiDgWqMz0cwOxoQBwzF2SUEF0J/cMll/jp/ytumESy0vnLppcx6eNGG/aXzLAP/4NZwphJOR3UPWHUT+pIVjWi+Hg2Pt+uAsR6w2gLsmoHSrRNnIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0foxNFKItpLsOCKsyZbN1HilRbmLTCbXCxQsipZ3uzE=;
 b=lJVXKVvFf3x0shRzDP2E9NN84wTJ/SBmE73ihtHes8vC7UJkudi0AIwsyoLk6Jihj0I2GBkzjbVYVrEH6lLTgd1apADwtAXTKs/Rv49w4aHSt+c+h0bXifUTW3SPS2vuDeNW21b/XbD5VgFCOQdYFHOdFuBq3yVwtU0JwlhUprU=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4917.namprd11.prod.outlook.com (2603:10b6:510:32::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 06:15:40 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::d8ce:8971:4d20:c430]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::d8ce:8971:4d20:c430%6]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 06:15:40 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Lutomirski, Andy" <luto@amacapital.net>
CC:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        "tdevries@suse.com" <tdevries@suse.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>
Subject: Re: gdbserver + fsgsbase kaputt
Thread-Topic: gdbserver + fsgsbase kaputt
Thread-Index: AQHW6EXGGSDS0D32IEu+vSvpt9UFe6oizxgAgAAJLICAABKQAIAAmVKA
Date:   Tue, 12 Jan 2021 06:15:39 +0000
Message-ID: <5B5C1F0A-9780-4E42-BC65-742BAEE920BF@intel.com>
References: <20210111200027.GH25645@zn.tnic>
 <E74AC970-CFCF-4CFD-A71F-F719F5BCE2DC@amacapital.net>
In-Reply-To: <E74AC970-CFCF-4CFD-A71F-F719F5BCE2DC@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: amacapital.net; dkim=none (message not signed)
 header.d=none;amacapital.net; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 169c2b0d-edd6-432a-0006-08d8b6c17c2c
x-ms-traffictypediagnostic: PH0PR11MB4917:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB49177A5E95BE13F2B2C07888D8AA0@PH0PR11MB4917.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KOoAHNj4XWTRN/9OlwIi1pixniCTFy2yE/NuaZDN8E8EWyxgk3sA6EL8k1+V8oBZoFLtcGZnb/G9Cvzlf/ghyexX9jllMzJPszRQRiuH1w4truHBiropQS8A7+TcLYr1RYuS7YBt/vODvJdyQFMXatJepV1+doM7hXCM4WAiNIsyLcvKK9n9tXoUGCi4gfmsA03pSFApfGk/xqfVOyrPjdoZBH9uU1GxfBtS/znSL73b+XhiDAUxsM36ucjcyfpSROYquhCl3JFby3Vcf/OR2k2QkZwTK0MBjSUJaVd/VqCE2ka56L1HhQU9R0R+5lYFk8piPNPAJow0P05aK3rfh1BI78c0TXs/yo7cWq2tnfwGtGKDuAC1JUpN1Mf/OVrMD7HOcmU0YgY8aFDcAmFGWzY7tdE+38cT2Gh5hs0Wijwa6Maz+EsmEGJPSb9pd6aw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(66556008)(6512007)(66446008)(66476007)(5660300002)(66946007)(64756008)(33656002)(6506007)(6916009)(8936002)(107886003)(6486002)(26005)(53546011)(71200400001)(2906002)(54906003)(8676002)(36756003)(186003)(478600001)(2616005)(86362001)(76116006)(4326008)(316002)(4744005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+S2mLaSYE9htJQyDYvnXkZGHbrIvjFjBXL6jRAGFJhwo63V3Vpzop3p4wa57?=
 =?us-ascii?Q?3J19ktspPP2cjdcmxojqVBmqdaizkvTiMk1OLk80BmZywcybyTj0jTk92q9W?=
 =?us-ascii?Q?iv3L1YeCUKj40arHkkncViN9Bsl0+ft/djGoPkMauSloNG4ojVGPDoMp1EzL?=
 =?us-ascii?Q?iFSOOC7g8FxAnFBg+aQ6yCkj0Au3V4vMQcpq3cDL4o9Cy+2SGGd9JeFJ49ki?=
 =?us-ascii?Q?kZ04HI9RNIF7n7FD19oNPXDq9iL6JpIfoGUumHdCA4RqZ3my+p1C5ISMUHw/?=
 =?us-ascii?Q?VYuXupMWsulebtq0m8EElGJw7p7c/p4XADmvZpetP/uKin6Ei4otN68ZkpFl?=
 =?us-ascii?Q?u/MM5npfDYNDX9w52Xk+pdOwwpkhxY5Zkv30CLgcM/SWV22PJ4KjE9nbFjvC?=
 =?us-ascii?Q?7BdNPSO2hWRyNyjCX7MQcY2GOAe4hH4jNsZD3/McQ0c9lTkHJSlbRP2e1bli?=
 =?us-ascii?Q?ub4/vusnvkeOyqVdU1yVcsgey40cwS4g3621Y9ZY2Y2Kw2FZEjHGr3w1ppUR?=
 =?us-ascii?Q?pfqX92Uh03chPOZD6cbkkKy10RM1THAfuyjGr/yoFOhgw6C1psXS2hcgGSMD?=
 =?us-ascii?Q?UvTs/swaWw6Pz3K371NZBoRHnNWnaTr3YVGJMKeGNjicVX/umIy4yPzBxvrn?=
 =?us-ascii?Q?0vUET4vo9kWZgdbYEW9dxoKEbGQLc22R7rLwoz5s2b2zFWIADAr2CqoX9xjw?=
 =?us-ascii?Q?9t56hhZ3QbMdh3vJXVFX+9YR9S8YpyWw6fswDb/3ZYnCp30TVFOKxZh1oFLo?=
 =?us-ascii?Q?o09XTYdzBXNsYUJdE9919OPaiKXAVOpHoRU3pprDKjCJ9v+myw5zM5lZ/YR/?=
 =?us-ascii?Q?Hjzjk/Z78AtHYmtSBz0bnirL0iHc+hPte4zRKRABJjaXIulHZT8ZH/Ft0gQX?=
 =?us-ascii?Q?SFy2NYFpLRDtfur0MhetXVhxxqPZmx/uLgWwwFZD6YsQK41PXSwZHvvXoRPK?=
 =?us-ascii?Q?m/4lqZba7jCck0x8Cx4f33xVaQrILNNWPegGwzNgB8roEA19NyN1DNy6mzQp?=
 =?us-ascii?Q?YUr1?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9C1DD6E9B24AA642B97CF772D98C9AF6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169c2b0d-edd6-432a-0006-08d8b6c17c2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 06:15:39.9683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXLSeNNxnkGRUBJADuO1VsxMCEf/OcrJwd00GsPVgG49ajpxGYGqdMPHN7NCq39/yhpTnrD10EItgFhT/hRF7ZpxaZOhu2WUWkPU8H4/jWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4917
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jan 11, 2021, at 13:06, Andy Lutomirski <luto@amacapital.net> wrote:
>=20
>> On Jan 11, 2021, at 12:00 PM, Borislav Petkov <bp@alien8.de> wrote:
>>=20
>> Or do you mean I should add "unsafe_fsgsbase" to grub cmdline and bisect
>> with fsgsbase enabled in all test kernels?
>=20
> Yes. But I can also look myself in a bit.

I was able to find this patch in that way:

commit 0bf7e460361c703333f3a82e50e7871465fe20f9
Author: Andy Lutomirski <luto@kernel.org>
Date:   Thu May 28 16:13:51 2020 -0400

    x86/process/64: Use FSBSBASE in switch_to() if available


The GDB behavior looks to be different between the two cases -- with vs
without gdb server, when I checked the GS/GSBASE values on the ptrace front=
.

It set the correct GSBASE (e.g.,=3D0xf7fcf0c0) of GS=3D0x63 without running=
 the
server. But GSBASE=3D0 with the server. When I forced to set the correct ba=
se,
it exited normally.

Thanks,
Chang

