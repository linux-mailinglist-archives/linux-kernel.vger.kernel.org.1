Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61852F6D40
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbhANVcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:32:08 -0500
Received: from mga05.intel.com ([192.55.52.43]:9695 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbhANVcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:32:04 -0500
IronPort-SDR: y/7zOT31DbriTNFDOHxxKX6pCFUIGHTfR0Goxq8DiuEld5w3EjD0s7zy8D9obJ9EPLLyi0Ai52
 Fo+aI3nl190Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="263239475"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="263239475"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 13:31:22 -0800
IronPort-SDR: zaNIUsnETZZNyuncrsH7YHt5tvJm4J4nnqcUNk4jBEUhqq6aNCq4OGIf6w6IiUFchOrrsPxmZf
 DSZdWalWx9Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="354049557"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jan 2021 13:31:22 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 14 Jan 2021 13:31:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 14 Jan 2021 13:31:22 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 14 Jan 2021 13:31:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHP0qVPo3v2zNDuzMBOZqMy0sK4+rNMecPlM82RAEQNoZRfNy7wvEcv1F1qB4pR7+xDHm5bkPyIBokJ+zaoUcnFhM7/YKEn550cGdob2IHhklK4GHcPSNlZv9wLEThJsCvCpDkX3MP434XEW0fUQDfcMT+2V9KpqAxRoiPxZOqlYkr5P95GayVmz0+TIU+EfE/5e4LAxhNIwdD1v1GQnHYgv8Rn/M9u9MuF4kyU7bqT7Doj2boABKrWYfDC+TfqAm8A+4kpqTz9zwwxYOe1Cv1S/AEAkJWjYQlGDH7S+/qdkwdCR5gy5qiYBs85QcmkHIHNbhjdjDm7aeZiBlHAdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH2PH5gxc0SjoP/LeEnuFXKnpjBChGeIMzQv/Dt4JFs=;
 b=NzXNKeOi/poKaSIH20W2M7rsvMIxoXEn0ZYOzdTIU0SxlOk6IgCxPmMQDNaWBJHgWlqx6RsxyAkSQyOY5vNXRyAQ0dxJM6SirYuCL+aKV//hJ7jDKpwxqahgunhXiuVZzVlNRuztHzK5N6vJz9UPpaFG1U8YwRjmro0PGTfyHmN4Uo8UYJy5CP4zFQDIxr1sgy94tWNq3b/LnqTctsBu3kKGH96dFu3Vv1WA6yGxvQnLtTiL0Dw7Dof7ODPMxI68kT24VpeI7O1w5NAGTtGfAweQ38fO9TSs8MP2n4UM3VjwfSIWYqORAO5P9EIKCkXYw0y7xNMCDi6DAF0GHKcjFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH2PH5gxc0SjoP/LeEnuFXKnpjBChGeIMzQv/Dt4JFs=;
 b=FhLAyCY/FgpK7rMRm5Suv+mKcTF6VAr1wcsjDfsZ/sh/h0oy6A9ITl3KQ3I0L36z5/fOBqS8/PHj1h5KBMfsTdZXbUkw9ie8P42FIMSPgog4mWExnBqFOqmQP9dnWhnkaZtsdM2ydQAqWbkpFOB2JyTz1YRvQOow3+b1jxkOEYE=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4981.namprd11.prod.outlook.com (2603:10b6:510:39::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 14 Jan
 2021 21:31:20 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::d8ce:8971:4d20:c430]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::d8ce:8971:4d20:c430%6]) with mapi id 15.20.3763.011; Thu, 14 Jan 2021
 21:31:20 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Borislav Petkov <bp@suse.de>, "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 21/21] x86/fpu/xstate: Introduce boot-parameters to
 control some state component support
Thread-Topic: [PATCH v3 21/21] x86/fpu/xstate: Introduce boot-parameters to
 control some state component support
Thread-Index: AQHW2UTqMFTBIOFRX0elOMp17XLu66oFAucAgCLDwIA=
Date:   Thu, 14 Jan 2021 21:31:19 +0000
Message-ID: <3AB31479-2394-4BFF-B309-F692E9135CE0@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-22-chang.seok.bae@intel.com>
 <64c67e40-ecba-5d9b-7c4b-4c64ea62906a@infradead.org>
In-Reply-To: <64c67e40-ecba-5d9b-7c4b-4c64ea62906a@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a16095b6-6d31-4e12-2283-08d8b8d3bbbf
x-ms-traffictypediagnostic: PH0PR11MB4981:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB498114428F1CDAB467D4032DD8A80@PH0PR11MB4981.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FQehml6Ayx3pa/NHDwQSISXQ7wWdV8mfs9qSyxliBaC00tFSBKHIGaIVcvdIf3Y+0Ul9YWB0u5mtA9aWMmEJgdHr3ygBaRi4E+z41jYakswALcY+zt7At95s9vvG7nYaCgciQq0Gpm8dYfI0Meu3lBweZnsNyX/KO3uzCu4S72pPm09lFiHKCbEQ4tjp/y2Su81p0Lw5r2BaATwCvSRM7Wrdh5601Y+1wIsCKlS22Pg7fHMiTLrUI/6LCmd5LODg2r7XA0SsmwMy/b9NMYZKHcCUaESNak2RoZVnOFoh8Bf3lGmwEF2z4Crh941GZ3aUsLEy5gjFGB1k3OinO8hQbR6kBjP4fwvZVgGHGHhaDwTihGMKu1Aaxk7C92VIYFaSfD+hyzfWwMV9QjeKiq/JJNWSmQZjwcU2YG7sulCXErvAV2Xe/S4BeDdM8JjLbmob
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(33656002)(5660300002)(26005)(6506007)(316002)(54906003)(6916009)(8936002)(36756003)(2906002)(86362001)(8676002)(4326008)(6512007)(53546011)(76116006)(66946007)(186003)(478600001)(66476007)(2616005)(71200400001)(66446008)(66556008)(6486002)(64756008)(83380400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NPtJnarliJX9UTpHLQ/08Eg2hrAIEe0PBBPs908aIPqC8KiidDbs2haAqIHq?=
 =?us-ascii?Q?vU2mqXysQ0bv0Iye2sPpSCrsDvBhNTywjt5oExFJ2W6foYBzFAz3oW8hfD1O?=
 =?us-ascii?Q?cyXnr7lyfKVZfkY/QHel7FO+CjIVDI9j9SHcVnE1abtUsbKOtt/tBRj/6dc7?=
 =?us-ascii?Q?h3lR6plhJP8+IbxZ+pz1q5OcNXXxcOx9t8KfClrX82qpxmeOOhSf/KGi8EqW?=
 =?us-ascii?Q?Fr7kydfT/MhUuxudHKZEEU0aTVKbAQ7bfh5CZzLiIWqTQqQFk14Y7ovYyFF8?=
 =?us-ascii?Q?6wLIpkfvluB0MjqTWSTHOMvVIX4HL2SnIbABM3zhGimLYe280pDCEYn8WP53?=
 =?us-ascii?Q?HV4TJwPFJ8iWWceobgFcXwLO4jEaDUwlF9cUFF+egW2dA4semA3NHsfSRpMJ?=
 =?us-ascii?Q?XGoR9Nhy7rrPo1EF1soL6DbntOTs8rlq5C5m+sECcLQSTn3rgbWxDMLTrhP4?=
 =?us-ascii?Q?Sd47K+M8pDor18cRcBgoHQTyd5opRrpDsOn8FoFDKoDbZ7GqVIzK34SRWNzh?=
 =?us-ascii?Q?zkmoepGAK8KBJ5keZKBscBcuGcPoZazI8BtmOrz+o0lvSMGix/foZCqHRe9r?=
 =?us-ascii?Q?MeaantRZEAjsrODL/Ruwrbs+qhs03UnU4LDv+YtHgsjq90p/ScQACMQJ8AuI?=
 =?us-ascii?Q?ZLLH5sdMAmJZRH7KqWURz0rDFJhpIGhI6nr+hhpYvaxlcN8QKm0thX3BH7Fm?=
 =?us-ascii?Q?e5dU4sPmZ8cJYobLsJ//sOH8YYRdIrrlmVhsU6OT6bkd6mtFdEpOXxJE1Bii?=
 =?us-ascii?Q?zhEOkqBwl78SLMx1kmBotPS5RmFD/RHKK58Qfa6fHCu6x0gp3fq6lZlm/YuP?=
 =?us-ascii?Q?Ey2g5bZwF/ZGKYys3ukn7uLopHcawWkAqHTBv+++eo8vs8jGKV7fQjms74F6?=
 =?us-ascii?Q?0SEn8hrKP7jVWuEg09AfwIQVRAYAgaUi2QB8lCv/srO/laOJxEYfU0NhcBJi?=
 =?us-ascii?Q?1RgA13fCoFvz8r4hdSMh9sw9VpUQtIyExFrZHIhdgfxMRbuI+NQOIdccSIzl?=
 =?us-ascii?Q?OjxL?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DED39FD0EB253948AA0D03405BFDF618@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16095b6-6d31-4e12-2283-08d8b8d3bbbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 21:31:19.9365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i86DLPZhBU+KmTyMwU5tFuUNMx6eyShk6SjxEl731gDkcsGPB07bsG8k6qHWyda59WcaDlvy7o8vdpyksNzCwvMKp7nnIU7MfbA/j/jYjgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4981
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Dec 23, 2020, at 10:37, Randy Dunlap <rdunlap@infradead.org> wrote:
>=20
> On 12/23/20 7:57 AM, Chang S. Bae wrote:
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documenta=
tion/admin-guide/kernel-parameters.txt
>> index 44fde25bb221..a67ae04d43c5 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -6002,6 +6002,21 @@
>> 			which allow the hypervisor to 'idle' the guest on lock
>> 			contention.
>>=20
>> +	xstate.enable=3D	[X86-64]
>> +	xstate.disable=3D	[X86-64]
>> +			The kernel is compiled with a default xstate bitmask --
>> +			enabling it to use the XSAVE hardware to efficiently
>> +			save and restore thread states on context switch.
>> +			xstate.enable allows adding to that default mask at
>> +			boot-time without recompiling the kernel just to support
>> +			the new thread state. (Note that the kernel will ignore
>> +			any bits in the mask that do not correspond to features
>> +			that are actually available in CPUID)  xstate.disable
>=20
> 			                               CPUID.)
>=20
>> +			allows clearing bits in the default mask, forcing the
>> +			kernel to forget that it supports the specified thread
>> +			state. When a bit set for both, the kernel takes
>> +			xstate.disable in a priority.
>=20
> 			               as a priority.
> ?

Thank you. I fixed those typos in my tree.

Chang=
