Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDED2B92CA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgKSMtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:49:04 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:12632 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgKSMtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605790141; x=1637326141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D0Am/jkmbbxbUQlLmHOPEstM+UE7Ov0JhAnQ6WJzXU0=;
  b=McjYRgbROUX7Q6FW9UZxXRI4eU0wHYe24hbN5+enJS0rW+QDgL8nWhax
   fZMk7Y0eXCoAnYMPN8zuoOm2dTkqpcNmC5/Oy2XO7hj45pmrdQ1XJ6N6m
   rtU2vh3h8TyLVctZmzq2DC5kjIZvGycY5/9uSeNOjp7QVc7+90Q3Ub92Y
   bD99+XqoUGmt9+43F7gXdZiurx6OoTEtbMzpTpYqA3YStINYnFYaphKPp
   BcFomMf++RwIFkUANIb3vpWywXLIPYtbqLMmAWBnzYmx/8MBPKrrmrMF8
   qxHGNFPoAbzTTqEyblscHDGQ16DG9XV8lh85S+RdId1OB4Xn/m2C2sdok
   w==;
IronPort-SDR: 6eox4MqJB7fwa7Xe1R3ya13eNSJhRpMkXIi5rcQeQ7XsfB0XBW3OoZYxnk0haQfEe88pnmwXCY
 YNm7L+iSaHgfF/zmY6mHqabJviOoVnrtZi0hxQel6EaqdbjhYxOOak1twVyBmfoRP58VTqqkT0
 ACtOURbyb946njGnzw5XZrYPQsMM86UVVoqRec9xXm/tCuH2E4VK5tKX7yzsflp4GuqgA1ojnZ
 Scrs3KmBql/2FlSgOkYHEZXt32J10m996O/Al4jkX4wuovmrn/TDPbM8Kemh6HeQXs5C6CSuoh
 g+A=
X-IronPort-AV: E=Sophos;i="5.77,490,1596470400"; 
   d="scan'208";a="157458553"
Received: from mail-bn3nam04lp2058.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.58])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2020 20:49:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WspkAUnWyz8sXrkk8UEgA2uoI1BO5YNRH1k+7oi+AEdaDofuhiWhvCCB3jelwC5ZhOJgEd5lt7SSMuvCmCm9TYS+MfFYuLdjo+8o3Oi0+3tvhPvdx5ZHgTec8EKf6uGZeBpFDcDyGOOhcSaOsOAj1cmYrYyWgU5LFge4QnwpZaEZjbVN64GhXYbP2oDCuIkuYDt1vI/+Gx/CO3R9f5Jgu60WDmxVcMooP0wn2hpWUZAL7j8F6EGkvB3SyaRAYbCx3r9W/O36Tz7w6anyyez57wo70fX2giuM4dMHJmGPw897j5lGB7A71wTkGxBMAtiFi4ZJDY7DvC7U059lEit4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0Am/jkmbbxbUQlLmHOPEstM+UE7Ov0JhAnQ6WJzXU0=;
 b=SQqwlW0sQ8UFsMDvSmmCl9AyaUwBS8QJsolW0/XL5A9jE+dLUn7Wd1RomwhONdytVfG7bbEj5v5Q1A2JGvZBRqU1JusAhfUeicJDOdlshDK+6WWL4zH/at1tDx/sgU9MiAcvgmRN6OZu1+V6LqTRlfP6m3FxsFzaJzRL4pEr9bL5fPt9p+VxnoYmBCRk1uvTlb5zoAF8d7ZGOZjltu8rpzMCgx6dNvrxWkMJzFUoh00K9T4FrPkidgPuihZd9VboUDizkrChyYzp5oWJ1coaM1ZN+ntmP5Ma6IK8ObiMi1vWEqeXjD7PiSXtSBl6J0NnaFyF1IiE1j2a9Na7cCcW6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0Am/jkmbbxbUQlLmHOPEstM+UE7Ov0JhAnQ6WJzXU0=;
 b=NDtxNOx3Smm7EdqcUzpYCJEy1ub3u5RbTcZ04yfVb2PTCgqHwW4MpJ00tR5jB2X86S4zhrsMDHvZES6Gv4dRLRMyWVC6OLUn9lACNNBqO6/LAabWoWTA2D/9MTcoD++RilWmLFijATqrEmr6KL7I5+3BjfIma5PQI1a3ACDUXeA=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by SJ0PR04MB7583.namprd04.prod.outlook.com (2603:10b6:a03:319::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Thu, 19 Nov
 2020 12:48:58 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::5154:e14a:2e36:bc95]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::5154:e14a:2e36:bc95%3]) with mapi id 15.20.3541.029; Thu, 19 Nov 2020
 12:48:58 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        X86 ML <x86@kernel.org>
Subject: Re: WARNING: can't access registers at asm_common_interrupt
Thread-Topic: WARNING: can't access registers at asm_common_interrupt
Thread-Index: AQHWtAKoC1N6UC8gbUaAN5Wk5A+R6KnDMbkAgAALvACAAAc6AIAACUOAgAAPgQCAAAS5AIAAAmAAgAACHwCAAALvAIAC9PyAgARYcQCAABLpgIACu3AAgAAaoACAAcx5gIAAAuYAgAANSgA=
Date:   Thu, 19 Nov 2020 12:48:57 +0000
Message-ID: <20201119124856.wpvhzstbtrujvdxa@shindev.dhcp.fujisawa.hgst.com>
References: <20201111200730.GM2628@hirez.programming.kicks-ass.net>
 <20201111201506.bftpmx4svxn376tn@treble>
 <61b2538f-7be6-8f4a-9395-03071b5cc6f0@citrix.com>
 <CALCETrXcTKB_j9MQC1mcZobKGt_cZ5ivDPjU3zwRBmj7DAUCsA@mail.gmail.com>
 <f105a63d-6b51-3afb-83e0-e899ea40813e@suse.com>
 <20201116130413.GC3121392@hirez.programming.kicks-ass.net>
 <e1ca6c8c-e32d-879a-1972-5605f0892176@suse.com>
 <20201118082254.GH3121378@hirez.programming.kicks-ass.net>
 <20201119115059.dns4hvull3l3dwx3@shindev.dhcp.fujisawa.hgst.com>
 <20201119120122.GJ3121392@hirez.programming.kicks-ass.net>
In-Reply-To: <20201119120122.GJ3121392@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8248d38b-4a71-445c-fe84-08d88c897b55
x-ms-traffictypediagnostic: SJ0PR04MB7583:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB75838F7E662D790D0BEF3249EDE00@SJ0PR04MB7583.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BPtTJqragxkH17l3imL9q3NjQE+SxCHIVdSGWuu59Fh7r7IjNbPW06h00mkRbRBrdeI5PkrwyF0ntUuGp1o2fMjzcz09GZCYnM2Zc/YGMtbnkRx51epAwXyvtRZa4qHYD8nihRVmDE5wxN7v40LS3NUAz0b6mOEmgrILWkr9SxlSpEfI4oIUVw+71p34H4WkL/0a08Uzoxs1Y4KG3XHjzM8rEl5GxrmVTHOfS7lt4LMWx1IAHMQRP/WzUXpONUYqHuGFT710CR6RUkgri+10Ling8MQz5NOMXrIsK0XzHh/KQea85gyiPtDQc7kS4hNe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(83380400001)(186003)(6916009)(3716004)(4744005)(5660300002)(4326008)(6506007)(54906003)(6512007)(8676002)(9686003)(478600001)(26005)(1076003)(8936002)(86362001)(2906002)(44832011)(66476007)(316002)(6486002)(91956017)(64756008)(76116006)(66556008)(71200400001)(66946007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OuPEFPNWyVSq8swQOCLTof6V2Y9DM3sNrWGmQQKaLYD1jnqqwy2A5gE5bf/ef5qUmt21W3p32fNQDpqvnGyWN8ThlO4JqOj5eJ+nODoAbvdZ6zvYlH6pVh3TYWGPyU2VEi7b993cTQyhLuNGwf0BYwHiAU0DZNBoQD/2OmXFIEktPj3u+aUAbt8e5h1bHgWCE+eYW77pFcR26tzaH8t/UKQtrM5HqZNdbx0K2jTfjIA8RQE+dhz+NrtXzZjRTe/7ihLR1dbH71FnMu4aeuf7Wm8Vx5GfdU7XLaxhM5i4q6waGy3Fgal01mb68LfEYo3cbLdkkQ/NOPfv/iMM3d4TW3uP1+PUSuvjmGnQZvY5XKRFULfsuJh0GVb1o9umg7tRZjzKPKHUkSOZDCak9bArDqq4NpDYWkfrvbB9DDe8fe7ENUTk2Pt4YUG4TlaRY74+omPCEupNOAWbo07mpeat8UO4+9lUwDG9SfDvfZS/Rr12cdx3BcnPqNnH5yBZHZbm5K7+h98w4nh0AVzxohpytdbQtd3RhBqx6FBP3xnY9DrtuoeA6ZWaYdrlE0uAwGDN9XXkJFxC9/iyqv7XKr1OaBPgsIHDaY7pu7nDhV0IOlpd0vWDoI+ZbzhDdy23DVP+5mUpHUp1T3sAEx/Sh2EH6xfMNrJlzT0WYSZ9ibyS9FcSoYBCClewRFDeqKyrz+hP/ZQ0LYx61hXz6J4R6Wow2Pv9xV63Vzip20To3Oe2DrmqnVQg59bjkuKo0OApWwxtAgKn15j5lSqJJPklPlO0HLlm6I8U4wKnxucCwE0TPbynVftY/N9iCbfT1hNQc0EOVkmB/t4PCn3eiqBSHeTqLG8qGuvfzhTp/0BqdKfO5FuFgW7sLCT94OZo1FQTKU9uD+LJws3CmDD6Geok1RalGQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F957B247B4AF654F8940DE8D0635A8A6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB3800.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8248d38b-4a71-445c-fe84-08d88c897b55
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 12:48:57.9767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWIV9MwtiAvYSwG+D+BL+4oGwykghJbQpnJH9mIoQkJCx+Jh3xpy4XBf2kGSaYQPCueTU5XT/602ymZ5odZRdQQAutLVGkYw/kO12asbhUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7583
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 19, 2020 / 13:01, Peter Zijlstra wrote:
> On Thu, Nov 19, 2020 at 11:51:00AM +0000, Shinichiro Kawasaki wrote:
> > I tried Peter's patch in my test system and result looks good. The warn=
ing is
> > still observed with 5.10-rc4. With the patch on top of 5.10-rc4, the wa=
rning
> > disappeared.
>=20
> The patch on its own is not sufficient to fix things; there needs to be
> an accompanying objtool patch to generate the correct unwind
> information.
>=20
> This patch only ensures objtool has enough information to be able to
> dtrt, but as it stands it shouldn't even compile, it should complain
> about an alternative trying to modify the stack and bail.

Thanks for the clarification. It was too early to try out... When it gets r=
eady
to try and test, please let me know.

--=20
Best Regards,
Shin'ichiro Kawasaki=
