Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F362C2FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 19:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390919AbgKXSWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 13:22:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:23535 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733264AbgKXSWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 13:22:35 -0500
IronPort-SDR: D9kxOF8mPI7nl8c5hAUi736xAfZbanch+JKpVAVtpJ4zOfAlzXG8mJEN8ZDwj1ynZ31SD35ezc
 4p+5lEHKU4FQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="168485798"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="168485798"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 10:22:34 -0800
IronPort-SDR: NMxQiMz1dhrffA+udDy2GMwT1AWoQVe1MMeRVJ4OxxiiMG1KRTJNC68EkkA8CAoXccmwNdnTN4
 1evI0778UKoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="402997770"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga001.jf.intel.com with ESMTP; 24 Nov 2020 10:22:34 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Nov 2020 10:22:33 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 24 Nov 2020 10:22:33 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 24 Nov 2020 10:22:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jn0w+o4yOUuJMO2vW7+OE5e335KFJDwD2MteRYfi1K8oh/AgBNexR/3M1V4XoMDlcMsiG1NTuWARlkRseBzr/09WmTCTWHE5DERWVl6tTaLC3Jasjk3UQj5YoHrF5UvdJ5FcQ0NGBCic1BQ4s3U1KpqTBoRuq2nCiAh5cJZxByVSxcyCkevbkgE3VgAx3VpPBN38wrgc9P+rJAZt3HMEB9eA5zUhkseX3Zb09Jz/wzeWXuS0UCZXzbRWoFEXOaT0Fza16eTdP+7NcShboPBU458xJzeC9/TYE+KR3tQ3Xq1pD3fsQ5pFWDuAsmorw1AxhXJe3K8uGRS43KNIv/MMzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsKwqJGLXRiiI3k+Vz6X+4nUam80vZUuOhVqZG9XuNs=;
 b=bPLHJiHIZP7gp4+VSjJAWIsYEzBE/uSjhXaLVKYaJeLs4CD3IZxxMiXy81iOPqEI37Suy4dvVGra6ThSHO50jtHZ1FdaKdkXtdrv4CZSKOeRaV1gtkJfwDKyCBlV8FJBVzGUPB6jbnP02EAWGjs/blicf3elAXYuLd4EteVA9sLSj1ol1zWysoLEWRlIwUczls2Il+VeNmTTS2U7HRvZvXXIsno7hXHCeKtB2lr0Lir1HkeWIJV0fmx5qVJDq/aAIYDUl8YxYsvXF1muF72YS9eQCzGKkQ7RVKqtSYphZVOpYyIyQ0CHjiDq/g1z5dhGBoU+WfTbPoTJhcOuqhSoHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsKwqJGLXRiiI3k+Vz6X+4nUam80vZUuOhVqZG9XuNs=;
 b=USnraVCnIsXf7tabypM4uNv+q6ho4vDJeXHl8vcTnwTfQVNBu0qCev06p8UuowZZ6uTiDzSW1nzhKTpbUaDW9jUoBG1XVwFtbiG1dNp211jUuBBeF3m8HAUvK0YiNwQ9li9FiwxGfkkmbleqLuwmrqJfCUHpt+wrkq5o1emrBww=
Received: from BY5PR11MB4056.namprd11.prod.outlook.com (2603:10b6:a03:18c::17)
 by BY5PR11MB4055.namprd11.prod.outlook.com (2603:10b6:a03:18b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Tue, 24 Nov
 2020 18:22:31 +0000
Received: from BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::a556:7843:c77:936a]) by BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::a556:7843:c77:936a%5]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 18:22:31 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        X86 ML <x86@kernel.org>, "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 15/22] x86/fpu/xstate: Support ptracer-induced xstate
 area expansion
Thread-Topic: [PATCH v2 15/22] x86/fpu/xstate: Support ptracer-induced xstate
 area expansion
Thread-Index: AQHWvsznQG60NzoojESgLM5m/NNfkqnQeGSAgAcnjAA=
Date:   Tue, 24 Nov 2020 18:22:31 +0000
Message-ID: <246DCF46-D7F4-4F68-ADF8-2F694FEFD2AC@intel.com>
References: <20201119233257.2939-1-chang.seok.bae@intel.com>
 <20201119233257.2939-16-chang.seok.bae@intel.com>
 <CALCETrW415uoRD3AFUnz8G2Yoj1TvC+hwi5AT=QiLtq6Vm9J=g@mail.gmail.com>
In-Reply-To: <CALCETrW415uoRD3AFUnz8G2Yoj1TvC+hwi5AT=QiLtq6Vm9J=g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 800d5b88-648f-4a56-f919-08d890a5e849
x-ms-traffictypediagnostic: BY5PR11MB4055:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB405537D4E3A639A8FD0C1988D8FB0@BY5PR11MB4055.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LyGnZ3DzXh7n0nJ96kQzK53sxQ+I2g5i7ho/3YL0Gm7HdkUEKFhTdqg9/zKF7M4moxyyYryBXh8wMfSN5kHUuGQS0cmtzUjjMuWYowz2JkfzUPUYi3gzazqZwv46Xni0xTK1RNjVLD3Tu6kuk1g+nwZId5xRus2r3G0qv12TvcoMaIKxMQCL4KG8pwgwVcrVJEIvaGjSgU8atidZ64keUZA6A5Xo1no79iDSuq77EW8oXXn/tC8Tkpuv4f/syYnjDnp1I7n0y1EOuQ+zEkMp7zSSjAmlF1o4qoCqrxe0mwQWAZrTTHuzYP2ixDzw7jAlxjiBf6DUMrrn5an2h6qcb6awG3D1dW3dLsIrycgFWMrWV5PEdzMZLzbUqItU32IbIeEO66SX8cpbT4WUhl+rZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(8676002)(33656002)(8936002)(6916009)(2616005)(86362001)(186003)(26005)(71200400001)(4326008)(2906002)(6506007)(53546011)(478600001)(5660300002)(966005)(66476007)(6512007)(76116006)(6486002)(66556008)(66446008)(64756008)(66946007)(54906003)(83380400001)(316002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?stdQuPoWB9n+YvX6jLP0R9O50nrfc8lycseYvha1x9uKmVeC7dp+jAdirO0r?=
 =?us-ascii?Q?36Kh0S5wrGro4/V3ULKfatQ+jyAei7a1drvF/+q5VooDJPhp6SHIxNMfP7b5?=
 =?us-ascii?Q?kTrlgMRxERAe9MU0qk5Nx4XgCZHca4InEVevaZf6TeLYtvFFNEkm2LACTwDW?=
 =?us-ascii?Q?2FRYdxZnSPJuisd6QRpWQQZKuTFB8S3Lyv2EvVtjUZlEWAxGM8GEmXRdoP0q?=
 =?us-ascii?Q?oGxwOWpcLw+CgCI+6cwTitW/tfdITrgBAnWsgfJ1+OTcW4j6BEXSsOW+aL/1?=
 =?us-ascii?Q?8mM2QS85yYK4baiA1EFCqwkVfcDMugILMkdTAHf/HCLhT6B3TU9iBuEalGGp?=
 =?us-ascii?Q?32bPrYrSCsK3e7mG4LnNETKDYoGZfOPOMifM81k6qMd8AbWcCtiWztxVw7lL?=
 =?us-ascii?Q?ITCktcMWa/kpuuP1loQFlM9CARHHqQ1/qa+n2oL+/n/XnkBTYFp3isBvt6xM?=
 =?us-ascii?Q?CHyDfe6LuPT+o9KVG81Y1sAeVsDhFrJJlkdPiP43UDr2HpQ176kq1PbVIrmW?=
 =?us-ascii?Q?xk9UWS5ypcG+LxhbD4u70odGMinzmQ/TUJL8fXGjVAJSPFU/qUOclwaoP/qe?=
 =?us-ascii?Q?tu+PH/fVlcoDHnE5Ao7BhETaUHfLRvUwgcJh7+etR7geG/wjOdoj5Gtlvwz4?=
 =?us-ascii?Q?yW0mPXo9OyXvblYSGAAaBqhqmfczMdkPv9NvD26CiWchz69uDyZvUadh1p65?=
 =?us-ascii?Q?uX0dkK+amXv/DhZptaOBEUSk3kSF4K7hRF5AWnwUAnGV3/ttPljhHE0SCpCL?=
 =?us-ascii?Q?mL7MWo5biFvW9eI+123hKck+BLqHJsboPamzeGeWvI+JE/PwFDkuE03huyfy?=
 =?us-ascii?Q?WT/cvjC0PPEqv1H4eUs3P5/XRw7K+GrWm//oD0V8WKfVyr2qH5Mpq3JKgQzN?=
 =?us-ascii?Q?oCGPgFT20dGrWHA/wgBO1ATrJZ6+E0qpQSeunLU3Tv6uufl7m0lZIhE5RFQr?=
 =?us-ascii?Q?VZQUvEfP0TzE0t8myFHvLe6mfYxUU81a//cqbjZ3DWMUUNm7XAIQiH7k0HQe?=
 =?us-ascii?Q?/xWL?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FBAB2BCABEDF2B4892B8446AE25A2CE8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800d5b88-648f-4a56-f919-08d890a5e849
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 18:22:31.2981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7tbFwUzXuNR+Avp9idb69pd1s01TKxaHVqZSeRyDlht/MXz4Kut2PhCAH/T6PEza1sddlEuRugtC8XuMQEuicR87OPtbf58GljiXJWFoLn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4055
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 19, 2020, at 21:07, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> On Thu, Nov 19, 2020 at 3:37 PM Chang S. Bae <chang.seok.bae@intel.com> w=
rote:
>>=20
>>=20
>> diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
>> index 8d863240b9c6..6b9d0c0a266d 100644
>> --- a/arch/x86/kernel/fpu/regset.c
>> +++ b/arch/x86/kernel/fpu/regset.c
>> @@ -125,6 +125,35 @@ int xstateregs_set(struct task_struct *target, cons=
t struct user_regset *regset,
>>=20
>>        xsave =3D __xsave(fpu);
>>=20
>> +       /*
>> +        * When a ptracer attempts to write any state in task->fpu but n=
ot allocated,
>> +        * it dynamically expands the xstate area of fpu->state_ptr.
>> +        */
>> +       if (count > get_xstate_size(fpu->state_mask)) {
>> +               unsigned int offset, size;
>> +               struct xstate_header hdr;
>> +               u64 mask;
>> +
>> +               offset =3D offsetof(struct xregs_state, header);
>> +               size =3D sizeof(hdr);
>> +
>> +               /* Retrieve XSTATE_BV */
>> +               if (kbuf) {
>> +                       memcpy(&hdr, kbuf + offset, size);
>> +               } else {
>> +                       ret =3D __copy_from_user(&hdr, ubuf + offset, si=
ze);
>> +                       if (ret)
>> +                               return ret;
>> +               }
>> +
>> +               mask =3D hdr.xfeatures & xfeatures_mask_user_dynamic;
>> +               if (!mask) {
>> +                       ret =3D alloc_xstate_area(fpu, mask, NULL);
>> +                       if (ret)
>> +                               return ret;
>> +               }
>> +       }
>> +
>=20
> This whole function is garbage.  The count parameter is entirely
> ignored except that the beginning of the function compares it to the
> constant known size.  Now that it's dynamic, you need to actually
> validate the count.  Right now, you will happily overrun the buffer if
> the mask in the buffer isn't consistent with count.

In practice, copy_{kernel|user}_to_xstate() is the copy function. It actual=
ly
relies on the mask [1], rather than the count. If the state bit not set in =
the
mask, the state is not copied.

This path may be better to be clean up for readability. We can try to clean=
up=20
in a separate series.

Also, I think the series needs to enable XFD only with XSAVES -- the compac=
ted
format used in the kernel.

Thanks,
Chang

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/x86/kernel/fpu/xstate.c#n1148=
