Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A202F6D41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbhANVcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:32:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:9419 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbhANVcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:32:18 -0500
IronPort-SDR: 4Ugl9eOIHEuXqosPAo9fEnJgbSTBsapK6k2+Xm3PW/XZzMlnMpBv9evMe/oYrLMgvZhjZFKg1q
 6fQF7zG8XMBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="178597397"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="178597397"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 13:31:35 -0800
IronPort-SDR: w2U/ELkcAvN/i0bKTD+FGdOK59OE27/bYbwqHsqk1rI7x7iEshpBLPjJPovIdm1dFtw0Q2H0hi
 ToLjyLDsypPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="352622515"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 14 Jan 2021 13:31:35 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 14 Jan 2021 13:31:35 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 14 Jan 2021 13:31:34 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 14 Jan 2021 13:31:34 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 14 Jan 2021 13:31:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRucJyEXy9tm1Ex92ARRLsewuUwoHUO0lxe8+XVXabrz+ntWR0mgpajr8CY0JPaHj+S5VHG6HfNBY3cXdcEVCQCLdFGBb/7LOaM/ZivRmWFl2QQ/EkL05/YZ0XSA4JLXA5S+taahFla9/HhfRahf2SHVEhXasKKOZu1Kb6dwaHWhuEmwUChLvgGLTpaiNqYP6SsSV9RR8NCqthjfqP3r5MQx+sm62RxYPOoyXJ5xWZ782CdcAgdIQYTW02N2lJv+rMuBBw6/UXUNrImVmmlnl6d1OzHvYxC/litYNY5GR0tdhM4ZFWS5MHeSfnZ435e5RlFiMYdFO55xMvwVRiIYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1pE8Iexm81bAxUqLV1iCI4yZCAFqrR1JC4QuyRQNLI=;
 b=PvqguePasJgI7CINF875bicZdFw8X+GtK07TjArIPeuufQw3G2AO0aT9yFWnpSnQmz0+hJxxicXkEl2SGrltmv+vWJi0S/87xJOEfKn5SFlJVHts5ZZGGrXIdyowf/Lo7MJbLQAgOjoLFswYTI8aSqNUX5m4pBI1rKaRO3SScCtIz7jPCflkGF/FipS48JUxHYaIoJXXh/rRd90v/D2XyAcRH30meKEsFUiMGGiA2DN0+uiLBhwtElKFwraNq3jx+Ry1pWm5pAi7auaLWhRk/EdS/v7oEqT+s/WDP5w9ilVneJk+VviMTFvDif3/CqvtQhNV1c7EKhDdm91pe2i97A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1pE8Iexm81bAxUqLV1iCI4yZCAFqrR1JC4QuyRQNLI=;
 b=hf5C3kcBoeUXPFmEvb+Lz5sH0apHd5MIRchrGQR0tjPo2JxCwsFl4P1enHFQSVIXM86w8xC78BN5qr7Cu+4eFF74vIcd8c+hD0zsw5UgatmIxeqEpHLqZ2SvBHRIGSXs/WVav7Tn8TymirsBVTwjW3tVMSDxapnm5KZgWCau1IU=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4981.namprd11.prod.outlook.com (2603:10b6:510:39::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 14 Jan
 2021 21:31:32 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::d8ce:8971:4d20:c430]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::d8ce:8971:4d20:c430%6]) with mapi id 15.20.3763.011; Thu, 14 Jan 2021
 21:31:32 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86-ml <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/21] x86: Support Intel Advanced Matrix Extensions
Thread-Topic: [PATCH v3 00/21] x86: Support Intel Advanced Matrix Extensions
Thread-Index: AQHW2UTouPROUkH5LkqzIxrTwNoN76onxrcA
Date:   Thu, 14 Jan 2021 21:31:32 +0000
Message-ID: <E2F25564-A7DA-48D9-9CC4-E2398241624B@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
In-Reply-To: <20201223155717.19556-1-chang.seok.bae@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a1fc0a8-3481-46ef-e8cf-08d8b8d3c36b
x-ms-traffictypediagnostic: PH0PR11MB4981:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB4981F915D1CF23C17A9473A4D8A80@PH0PR11MB4981.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OH6B702T08ldJFAuOZQ/3Jw8tZZSKRgWc+m4pUo1OJvY7ZVWY0j9ijMvUPSadGPtyqgmcrRduaQ3CZEIMO1PQWhXziatL9TM1zcbgl4+NpgddHBmiRpqdphwfylQiItM7oyO/cKSzH4XuHV9qoZfDG7vfwbQGzu/QO2BwztGIyuUSk1cd1HFWIP8xLfH4vJ3vEX0K/fvKc7nM57pAx8iHhqKRMVIPBfjXgGemDD2VMJdibwNhig947jBkNgV/JkW2qSZ7PFQ5YuXM3Phx3N9veFdata6hwTLJHJD55wdOzbtkdi4VEGwB+PT8zugp5xKFeW4tp8eOtKHKSiaII+GwqwEeGKnUaXUQwcmEQbBhPup/miEzCgCxlDeVBq3vrBLjJRI5+LKLFpzN/B4bzuc/jpz34czvFKUP5qOJsine4wjQCbr5SMZyhqwvOY8uojs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(33656002)(4744005)(5660300002)(26005)(6506007)(316002)(54906003)(8936002)(36756003)(110136005)(2906002)(86362001)(8676002)(4326008)(6512007)(53546011)(76116006)(66946007)(186003)(478600001)(66476007)(2616005)(71200400001)(66446008)(66556008)(6486002)(64756008)(83380400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QnGfeyN9xcVp4KcRS114YQp86cKlPsfrr6FhkZTOqK4IQxpxxw9zMOalhhiN?=
 =?us-ascii?Q?uYStV+Urz527A4Dy83VGxMNDRloJgtXOBBv9UixM7BzF+8iPDw8sjEnwMU5j?=
 =?us-ascii?Q?r3dZS7vxEfvfGrtMPeJ/NadWuQs0H2Sfubl0ahjYqDkY6Pa0I1qItkEbloNR?=
 =?us-ascii?Q?QHhcYSrIvgixS1KJJozkDaU0mUe25bxFUTugPCW8gBBmbNWfsZL/qniVni1q?=
 =?us-ascii?Q?RT8BX4NswJzDpZWGlVXVHuCIQRV55qaeonVZz8PzSsimzNCvGXvL7JPw1IKc?=
 =?us-ascii?Q?d4eYjhII3kcIUL8cDpF90T5TtdDC6Wq5Z+Y7bdFIOr9Ty1V59WXT1k36Xehh?=
 =?us-ascii?Q?6qu4vDxvXNB13pGd6GHe8d9rwoMJNI/iYDda/FeIdMe9xh7+0zdJx2oyh4sl?=
 =?us-ascii?Q?Vk0IMdxssam965JJDNl74CMzwRGMz1Gy1RhjY1Mt6TDCUo3yTFQrb2EelhEP?=
 =?us-ascii?Q?iq2rzrvwKNF4+ddD4+ckseJe5SV2K9ybKZtZ8hYBC91/NEAu1RWxXDIfEkxT?=
 =?us-ascii?Q?cS5m5njbP0tXtmZNxledyCV5VrXVrLvpVxlc/LuJ9fMoVmCRnxquhToiboik?=
 =?us-ascii?Q?2JER5Zrx/m84FUTX5bqUmqneFQi3bj1Xg7I6copQuAbUGB3elY94CDSxzW5w?=
 =?us-ascii?Q?ZJXbeIsWqSoL4JII3qrFfsWrV7pd83HpuvnojxpZY+6b2sOcqwO9c0wrOdzr?=
 =?us-ascii?Q?6wY+VMvxR4rmPJvQ4n9o1a926da/0XkQSfgvZVzjGc8lVRwf8IAhMKtRR/9I?=
 =?us-ascii?Q?qiEXKUvDORLsNNCjG9gr+FE0/ZrSJtcuP7GbfZz9EPhOdqWEesBkZVRBOK1I?=
 =?us-ascii?Q?LZ40EMFLcOJlBQSf5S8Fx/lc73KvYBqRQLn0PvWlppU4dB95+0SWUKSdNcGU?=
 =?us-ascii?Q?CGNbZ/CE7lNfjbMHGQRQgybJ614PAJTbwsMdcpYve2nglud00ITqyT8HXXQT?=
 =?us-ascii?Q?wTNEvMrZ1DE22Bgjx5AlTFHYxgeciBF+1fv0M7aK7rwh0swGkWydlsx2VRP6?=
 =?us-ascii?Q?LFxR?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F4C723A17A94F44B68927435C628D89@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1fc0a8-3481-46ef-e8cf-08d8b8d3c36b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 21:31:32.7969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nO6tgDvQ4cn1JDif8FMsoiu7xwT5tsBQhkpi2uw2teEFOhd6icB2MwrdJoDALz2JbgjazrjwQSAmqjP9qF0asaycQH5sngaQ2bwhy7Ra4Bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4981
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Dec 23, 2020, at 07:56, Bae, Chang Seok <chang.seok.bae@intel.com> wro=
te:
>=20
> Changes from v2 [5]:
> * Removed the patch for the tile data inheritance. Also, updated the
>  selftest patch. (Andy Lutomirski)
> * Changed the kernel tainted when any unknown state is enabled. (Andy
>  Lutomirski)
> * Changed to use the XFD feature only when the compacted format in use.
> * Improved the test code.
> * Simplified the cmdline handling.
> * Removed 'task->fpu' in changelogs. (Boris Petkov)
> * Updated the variable name / comments / changelogs for clarification.

Hi Boris,

Thanks for the feedback. Please let me know if this updated commit messages
meet your expectations.

Thanks,
Chang=
