Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516462B91E1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgKSLvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:51:04 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:39638 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgKSLvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:51:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605786661; x=1637322661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f7bEskYex3tIqW67ZK3Ib0BrDbTZ+2WcuxW8qN8YwR4=;
  b=j5p/dHDxYK9CRbYVLJDlJX6IugMYgDHWP0xv7NutLYsKzNiBr+xmHGvg
   95nWLy+Y+sr7t4DGPQovC+46NVNE7T7oO8ML9Lr6jJCcWpTn/nd3JalwT
   khmYLq19OwzySGUB1rpl2h5BYmmmS84Szjk+AOtF7wqPjpBrePAkoweoN
   kbbnjzEeBEv483+pUVgeSjKsaYVZMoWEEyxcQ1TobABy4CuzZCtMUwJHf
   n2KD5uLz1NedY5uwNhdVTViaw7euY1kGKapAzb20r56WWsMfkgV9QYBj5
   U18F7LIcYgzJjNvLGLYGbUnRCP8CntA8eSn5x7LDx03QbfHsGpoIQ38Xn
   Q==;
IronPort-SDR: oMwTSppddbq62ZYTsZgH0fqPWwN26fFPfs844FuhX3j6qqI8diLcCEFSE2hVqq5gFNnDKgIe+x
 YWsLGb1TleARL/2b0Kr8xUtdWoOBJH+ECp4m3fMMcylLJPAx10a6wSYv2VMwrLDM4CMQYmZVPX
 9zXdHv4pi5qepqd+4ctLKpuy6V5wAf/BTPVgj7i7WAtxpCrasfimIMc5+mDxiz4BgcOM7YvE8P
 MsFePZs2xOfyY6ReF/Uvih9THSmbrj2OitmDTTzq6up82vb9i+Y1JjzXW9EJSrwxD+1ys3qE0R
 Us8=
X-IronPort-AV: E=Sophos;i="5.77,490,1596470400"; 
   d="scan'208";a="263020949"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2020 19:51:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrIRzANUmn0+aG9GM6ro282mlhA3JKqUWgRjCZTcmgerThgLNFkmjwJU4WOTyKSmqKklyEjI1AtsQG0+Vei1iVyqOh+KRJUKJvyxTuo+3Z7kJw4bWtt4lBib8Be1N6sx78xzCtimYt6gmMn1chNoNc8GbYx1wwK/UB6mp7aGOKsmk50uAgnIyh40zeOtGKQyOcMbFYK6A18l0qL8WG5f4WHC9v72wGSGQzOOl6fbQ6WSJixqrVj9u7CuHBlckW4CQPPPoGI8NCYFUWZaHfN4bN//Re7n79Xu/X0icSzEA1hDH1snDw4pZc10ZXyi13J9YQQ46BCtRUeLbM4kaYXuiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GWkSEd9Mj2VpIQ4heRY+rrusUhwhP02Gsxlxszr9oU=;
 b=Aib/qIPnlazdOXo2iyRoNaRpunVX3q2g5rFKZOFG2H9LqHSYhZb6KAV02U2oAAK40bdlMtioC7KYYU5I2z3dNa+dvHmb2ZuPsrHOpuv3CpI/WdC2yCNf4XI3asi5Taob9YzYEyMh6PxAr+oM9x3h69KukBibvHOBsBGNHiETk8fEoRFL/8x60+9s1g5SvheXn4YHbvQn9HV4fRNvvaRYMaE6mM5X9cAU3KO6mZRdH4UXEhKyA4afdC8wHoRlhu+Rc644E2+nZBXJN3jPY+ouvGTm/B0FXBP19TC0oWy9IKbsrwHCS1z7qM2CklggN3pCLrvlklP/EkJ0Twp6ppUiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GWkSEd9Mj2VpIQ4heRY+rrusUhwhP02Gsxlxszr9oU=;
 b=R89elDQwQDhbnv5nMhWJB66OvmpDSZVe0Amy147kDNL6Qywuyjvt7ORrPA5XX748b3k+mfHdvUD79GE7eOxkp6MmZXzB/O4ieUnPZ0DodCoDiKko9z9GMljnU34984Fj921nP07sy7ApXCrNijFZrcEcKEcZOI2L56oVKlFpdAs=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by SJ0PR04MB7199.namprd04.prod.outlook.com (2603:10b6:a03:29c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Thu, 19 Nov
 2020 11:51:00 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::5154:e14a:2e36:bc95]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::5154:e14a:2e36:bc95%3]) with mapi id 15.20.3541.029; Thu, 19 Nov 2020
 11:51:00 +0000
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
Thread-Index: AQHWtAKoC1N6UC8gbUaAN5Wk5A+R6KnDMbkAgAALvACAAAc6AIAACUOAgAAPgQCAAAS5AIAAAmAAgAACHwCAAALvAIAC9PyAgARYcQCAABLpgIACu3AAgAAaoACAAcx5gA==
Date:   Thu, 19 Nov 2020 11:51:00 +0000
Message-ID: <20201119115059.dns4hvull3l3dwx3@shindev.dhcp.fujisawa.hgst.com>
References: <20201111194206.GK2628@hirez.programming.kicks-ass.net>
 <20201111195900.2x7kfce2ejkmrzi3@treble>
 <20201111200730.GM2628@hirez.programming.kicks-ass.net>
 <20201111201506.bftpmx4svxn376tn@treble>
 <61b2538f-7be6-8f4a-9395-03071b5cc6f0@citrix.com>
 <CALCETrXcTKB_j9MQC1mcZobKGt_cZ5ivDPjU3zwRBmj7DAUCsA@mail.gmail.com>
 <f105a63d-6b51-3afb-83e0-e899ea40813e@suse.com>
 <20201116130413.GC3121392@hirez.programming.kicks-ass.net>
 <e1ca6c8c-e32d-879a-1972-5605f0892176@suse.com>
 <20201118082254.GH3121378@hirez.programming.kicks-ass.net>
In-Reply-To: <20201118082254.GH3121378@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3db7b1ca-b60e-4016-8521-08d88c8162a1
x-ms-traffictypediagnostic: SJ0PR04MB7199:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB719919B7C30BB41353A1DCFBEDE00@SJ0PR04MB7199.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:321;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gay4znIxC/PHvMiIO89jMwnvtnuehmPh3EWWCSQjJACpGZ1aFps2IAS4kD1z8656AvTtCzBUVm1bmWQiJFm3xPRA92ciFU5Die8tZBGMgfIT7gPOYFAz0Bnx8PMpbuWKaTlsgkV7Du2aMZsNCxhBH2RcoAO/nKzXzsz/OJ8xo1lCa/6VHhcfxOoCILPz1chkm26woz83G0mwfdqV+9VdHNU9RyfVKBcuie6IgYwKv5be/S7oHNQfNsqDZXJ7AP0vLQiIgO1fx2NOjnKVwowDvLFYQNgZBfwZ6dKZUr0lqxnNP4WX86wUTzzQNjY7+uX5cXVl5gOk0jrrfFKi46OXNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(6512007)(4326008)(66574015)(316002)(86362001)(53546011)(26005)(91956017)(9686003)(1076003)(6916009)(8936002)(76116006)(71200400001)(83380400001)(186003)(66556008)(66446008)(6506007)(64756008)(66476007)(2906002)(44832011)(66946007)(8676002)(5660300002)(6486002)(54906003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: XzDz2MuMyXkTWdlfFEX5+xP0pKQ9/M0mxsyOnVhAzFKo7reW0QwirJQp1WtvhNJlWSFQDSER0RJR39pMbyBw5iqw+aF37+3bp7KFObH9fdkZh5DdAnUj+KzSj9giwo1r+10Eg2i6qsRluH+dD+gQfAhFe+HUPx5/v2m1SaQDgsJC8eIgI0zkMaZF0MA7ITdkIrZmu+SKFCaN/nleeo3yvPNcjaR5uSPf7rxfwLadAhr+N/6R/7dpLcoBRHqLgQcERlIulkV0Q89ht2t6eNPCKpvwsFUHkDrKiGnsqrI8mI/kReAzpFeXZd2hQ+VU0UaHKb7AMFRxBxI5Gf3Rbkh1fdLPigq0p7/dF8L2rC/35ucySBkkMqsB8YpU4B4m+Rq89fYDskjGt5ENP5oNTYLmGLt0eKP3cg19ARd9nVtAjmu8Mxhb0A5A/4MroHeQEFfg8u+aCvCZVrDAYuWMoLAeQ8FOssECvOeM38W8GZOLdvhtAm3r6RApXJtUNwdqA1XB6taGhzdyeverD+4MUmoraUghCbDJU6aCMnOvvnRgExqce0NcrT0HFYbk1NYff3kOK96ScJx7vvoRkvLBste2lzBCBQN3VrGKWW43VWUwRheAX2+3XLztmGo7amCJLIcAfoyqqAvc+HfxlINFnyvuiw==
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <4B6BB79F6D67D046A438FB387101F759@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB3800.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db7b1ca-b60e-4016-8521-08d88c8162a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 11:51:00.5078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XzYmWbjMvpi1Lihm5msFjnh3133/dZT1tR0nDr7CRQO6kv1Uj7o5inhCj3j0zIJw+q5e7/tAsLboYgKfzU//TbFq2h9r4cnvGB5QistIzkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7199
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 18, 2020 / 09:22, Peter Zijlstra wrote:
> On Wed, Nov 18, 2020 at 07:47:36AM +0100, J=FCrgen Gro=DF wrote:
> > On 16.11.20 14:04, Peter Zijlstra wrote:
> > > On Mon, Nov 16, 2020 at 12:56:32PM +0100, J=FCrgen Gro=DF wrote:
> > > > > > > > > > static inline notrace unsigned long arch_local_save_fla=
gs(void)
> > > > > > > > > > {
> > > > > > > > > >      PVOP_CALL_ARGS;
> > > > > > > > > >      PVOP_TEST_NULL(irq.save_fl);
> > > > > > > > > >      asm_inline volatile(ALTERNATIVE(paravirt_alt(PARAV=
IRT_CALL),
> > > > > > > > > >                                      "PUSHF; POP _ASM_A=
X",
> > > > > > > > > >                                      X86_FEATURE_NATIVE=
)
> > > >=20
> > > > I am wondering whether we really want a new feature (basically "not
> > > > XENPV). We could use ~X86_FEATURE_XENPV and teach apply_alternative=
s()
> > > > to understand negated features (yes, this limits the number of feat=
ures
> > > > to 32767, but I don't think this is a real problem for quite some t=
ime).
> > > >=20
> > > > Thoughts?
> > >=20
> > > I went with the simple thing for now... If we ever want/need another
> > > negative alternative I suppose we can do as you suggest...
> > >=20
> > > I was still poking at objtool to actually dtrt though..
> >=20
> > I'd like to include this part in my series (with a different solution
> > for the restore_fl part, as suggested by Andy before).
> >=20
> > Peter, are you fine with me taking your patch and adding your SoB?
>=20
> Sure, note that I only compile tested it, as it was my test-bed for
> playing with objtool (which I still haven't managed to get back to and
> finish :/).
>=20
> So if it actually _works_ feel free to take it, otherwise you can have
> whatever bits and pieces remain after you've butchered it to do as you
> want.

All, thank you for the actions.

I tried Peter's patch in my test system and result looks good. The warning =
is
still observed with 5.10-rc4. With the patch on top of 5.10-rc4, the warnin=
g
disappeared.

Of note is that when I built kernel with the patch, objtool reported many
warnings, as follows:

arch/x86/events/intel/core.o: warning: objtool: .altinstr_replacement+0x0: =
alternative modifies stack
arch/x86/events/core.o: warning: objtool: .altinstr_replacement+0x0: altern=
ative modifies stack

--=20
Best Regards,
Shin'ichiro Kawasaki=
