Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DD42DB1B7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgLOQow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:44:52 -0500
Received: from mail-mw2nam10on2054.outbound.protection.outlook.com ([40.107.94.54]:41439
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728269AbgLOQnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:43:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mg4H+tstImb70ksX7+c/5nR+TcePTkyPoMlCFqjZLS8TWM2Zr0opVK0wIXo3++Yjk64CMKBEf5PDFNg69XJBfWDTcUXwEQUt8n47wxjH3c+UVNxY7dxQpm+whZEtD30HlyAmJVoIBbzX8gmlNBwQsE8iNAOse+2883iBY8gkX1FM2Mkav7NmSyGMNjDQIOaBylsOmWst/KgyVJ3EvLnzri64OBX5HrK9TH02tEE/ReOmcUiCC2/orAVFWQ3lSftz9BNqw+4wrja/WWkht6hjF6CRwHa+kB29/EkHSzc+ov6Ev35Dm1ylkGSKoRvXrfomv4YDfFPIL1WN4HC6VbZiEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtPk1XvYxNgScrTSXx0eA73I4wZeupGisGGvqjDEy3g=;
 b=Mc/jna/S2Qpj/duvPljWQ2Fj0QFFl+T84oIb+LrHUTCgEVjKKTHzT3rUBkQleau7MWpykOTwT7oyU7wsozHvNeZeH/sFPJZoOYUY/d5jhFS6YWlrMpKs/MQzAYjme1D6GnAr9LoJVvR4KAAojXp+01W+0xpz7MmoiNGbbCKJYhSYpySpMAm8DPMH3k6sEBeyrdQfEkqOWTze2NFTAhLuy/ZOW/nY0RF0NlfEuBIK2siDGUzpdgaPPIpMPiN+mR6TPuoxB1yb2FpKXUuDNOpxXucWsUe6CxlR/Fe3aok4f6JODqFAMAYadRTVm6rylgzkMYEKttKiFcMkGmjZOECg/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtPk1XvYxNgScrTSXx0eA73I4wZeupGisGGvqjDEy3g=;
 b=WWZ3rluVCx+qcug+fgqw5vh2tRySEdqDLDiMElhgUg4uEHu69d/THnfv2BPocAJ0MtTk6DpOIttL3gsBqKBVRiy2JEhwVtBqXyzmIwzkX8J5dFq8Of395BtsND4jUXFdRun3I0N4iCDCP0GI8rR0FBXgKgZyyjnr61QkfrPUBqk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.21; Tue, 15 Dec
 2020 16:42:40 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::3d69:e706:b212:e31f]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::3d69:e706:b212:e31f%7]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 16:42:40 +0000
Date:   Tue, 15 Dec 2020 11:42:34 -0500
From:   Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Chiawen Huang <chiawen.huang@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: 8353d30e747f ("drm/amd/display: disable stream if pixel clock
 changed with link active")
Message-ID: <20201215164234.ywgesdqup6zdjxw4@outlook.office365.com>
References: <20201211155553.GC25974@zn.tnic>
 <20201215154703.6gwm2ew337pqysq4@outlook.office365.com>
 <20201215155622.GC9817@zn.tnic>
 <20201215160720.ewce4usgb53pzt2j@outlook.office365.com>
 <CADnq5_MSJdrmxNW9jhdQPOZLUdkJtZMyA6FmqjyZsgGHBWoXVg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3ukcfc6c2hzpn4yj"
Content-Disposition: inline
In-Reply-To: <CADnq5_MSJdrmxNW9jhdQPOZLUdkJtZMyA6FmqjyZsgGHBWoXVg@mail.gmail.com>
X-Originating-IP: [2607:fea8:56e0:6d60::bef5]
X-ClientProxiedBy: YTXPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::17) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60::bef5) by YTXPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 16:42:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb90117b-5973-48c8-c720-08d8a1187047
X-MS-TrafficTypeDiagnostic: CH2PR12MB4037:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4037338492FEAC18BD39602398C60@CH2PR12MB4037.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7nBYAqovo7bt1yQ5U3trl+0y/VwcGA1HjEatUCl2L7NikS1g50cXJ0tU4OQWuWCf4kSKR/Qa8m5Nw1qqheHKnbKwf8vDaRCXBrBa1gukiLPiuZXf1HT5MrPLbf9iNi7Fhhv3aPRLFqJyAnRtACmLnpdCvEOrY/RCF0oek+/19BMUoeb/BF5xq+S39B8lr5YeAToI6xsBgA4E2xmMsBnIHJ3t0bEGHEmTVxBdWnagm2fI23Mu+BdMlHo9GgPeNpBHgo5W/NDsqqgk8TkINZ4RpqTo2j3B9bukT47ce58JihetvscDNvn1Q2W/rKeBH82FJ6gy/8oZXyjxr5+x/r5wov81EVgqh97loCNpJQYJkV02hMpDNkcTh7qSOg+ARRKgz/p/4Y2uivdlxuDU5xVPR8cFP9GBGsImUbQDLjkJc9H211xSxJWsfkSTu7WOBaw96pfIubLLikloWbPCK94CvzrsJQnKkNhhHh8y3GAcI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3781.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(66946007)(66556008)(66476007)(21480400003)(83380400001)(53546011)(8676002)(6506007)(966005)(9686003)(55016002)(45080400002)(34490700003)(44144004)(86362001)(8936002)(4326008)(7696005)(6666004)(508600001)(1076003)(6916009)(52116002)(16526019)(5660300002)(54906003)(186003)(2906002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cGyqFd4N3QsdN7i8bnEeAdb7Z5MEMSzpbCPqRen/9l8WnsWqZlWp04xcZYJl?=
 =?us-ascii?Q?ReWPvuyY0jNIHX2wHHXAykUGM35M2/vV8q+LyQBiEZBGlehxjEEWldSGXYIT?=
 =?us-ascii?Q?arJHomx3E/u6EVG77SiluNGP0RfJWC19NYFD6W1foP26hIVKc6K7/+iAzdRZ?=
 =?us-ascii?Q?LNWgYhi15Z6FBCJXIh2JvTMB4maVAYMq91RppbWmD3W+GsW7CIhqwgTzv+sI?=
 =?us-ascii?Q?oiJVISDB/LVXHFBHM8ZQrsJg8RQqzveThfcwzymcArbUuzmxiRTB7/W8VCe6?=
 =?us-ascii?Q?hNIiGATbyjOeelTaIvCzW5EfrTASSJBa+iZqVVWmfFvZmhTy0NSXfC9efNLN?=
 =?us-ascii?Q?AO1SRmxQOcUtJEuZgW/AHLJK/1MSGmwJdrxQz15PqEh1/7FMyyBEa/za0A0Z?=
 =?us-ascii?Q?OAuhKFYAZ+bGk2TaqhUu91HrBLeUrXYMOhuDHFsDxKZBG2ZNbAkz6DNpAhjJ?=
 =?us-ascii?Q?sNeQjNEhj79aB6QwTmWlOsPizHvwGXmeOTi9jnQQl/agTpazc4APBAMfx/sk?=
 =?us-ascii?Q?MlINyjvbhD/7f6sFlaIauFlyOd3KZzZAsVdh96M2DZ7opcVHeYOqTvIBEVp9?=
 =?us-ascii?Q?xebbSYWFfADNVEUvP5cx7sZl+1uB18U4JmJdGbamIEZDM5W+4CaWZkSkOu1E?=
 =?us-ascii?Q?3821OL+whPy3R1hvfxY1iDzAyhXP5o3fOxLSFQg9ULZEklrGuT6iv5Bq0Kqy?=
 =?us-ascii?Q?VC3gVkVrpDsvUeLr7DhEEUMfy1UnI+fZNQJfi4/+i5l6GSL7B5XP31/OP1Yz?=
 =?us-ascii?Q?qrF/phoeDOBnNgYH69vZoyiB0my3+FJ8j2AZqhEvPQoWql6IPQdK1XuDQLnZ?=
 =?us-ascii?Q?2KuvihED6rkTC3ySoueTNx/g0N9bUqrC0ihCSoCMzvdjaokcBKZNgz6HmWql?=
 =?us-ascii?Q?H+g/0CeuvPqBE+8RT5ilDnN+0blp039hvho3gXu23NAZ+CtDfYhiNHU6TKTP?=
 =?us-ascii?Q?o6/8qFsG2ZduD74KEgBHxG62VD3Dtv2xfWaYk9rhSPjjlgrePeM224DtyAK6?=
 =?us-ascii?Q?V2ZhHmduZUvsQGe+sZhzsxK8Yw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 16:42:40.6555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: cb90117b-5973-48c8-c720-08d8a1187047
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdUdVHLTQ3AqtgCYUIXdCmoo8X8Qg4t6yexlj+OvHm9UGIDEWYL4Gra9beC6EBBHCjt7DfrRLLJO41fkvESTlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--3ukcfc6c2hzpn4yj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12/15, Alex Deucher wrote:
> On Tue, Dec 15, 2020 at 11:07 AM Rodrigo Siqueira
> <Rodrigo.Siqueira@amd.com> wrote:
> >
> > Hi,
> >
> > Could you try on Alex's repo?
> >
> >  git://people.freedesktop.org/~agd5f/linux
> >  branch: amd-staging-drm-next
> >
> > My patch should apply without any issue on top of this branch.
>=20
> Can you help me identify what patches we need to backport to 5.10?

If we have this patch in 5.10:

 drm/amd/display: disable stream if pixel clock changed with link active

We need to backport:

 1. drm/amd/display: Fix module load hangs when connected to an eDP (for
DCN)
 2. drm/amd/display: Add get_dig_frontend implementation for DCEx (for
DCEx - we still need Boris feedback)


> Depending on the patches, it might be easier to just revert this for
> 5.10 and apply the proper fix for 5.11.

I like this approach; we can apply the proper fix on 5.11.

Thanks
=20
> Alex
>=20
>=20
> >
> > Thanks
> >
> > On 12/15, Borislav Petkov wrote:
> > > On Tue, Dec 15, 2020 at 10:47:03AM -0500, Rodrigo Siqueira wrote:
> > > > Hi Boris,
> > > >
> > > > Could you check if your branch has this commit:
> > > >
> > > >  drm/amd/display: Fix module load hangs when connected to an eDP
> > > >
> > > > If so, could you try this patch:
> > > >
> > > >  https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fpatchwork.freedesktop.org%2Fseries%2F84965%2F&amp;data=3D04%7C01%7CRodrig=
o.Siqueira%40amd.com%7C3b8b84a3815d4a3cc67e08d8a1152189%7C3dd8961fe4884e608=
e11a82d994e183d%7C0%7C0%7C637436459421073301%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda=
ta=3DmcdJ1E3tJc%2FK%2Bnf2phU2CFDQ2wp5zrMcRbxdLxQdo3I%3D&amp;reserved=3D0
> > >
> > > So I did a bisection between
> > >
> > > git bisect start
> > > # bad: [3650b228f83adda7e5ee532e2b90429c03f7b9ec] Linux 5.10-rc1
> > > git bisect bad 3650b228f83adda7e5ee532e2b90429c03f7b9ec
> > > # good: [bbf5c979011a099af5dc76498918ed7df445635b] Linux 5.9
> > >
> > > and the patch in $Subject came in in 5.10-rc1.
> > >
> > > I can test any tree you want me to so just tell me on which tree to
> > > apply this patch and I'll run it.
> > >
> > > In any case, it doesn't apply on v5.10 though:
> > >
> > > $ test-apply.sh /tmp/rodrigo.siqueira
> > > checking file drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> > > Hunk #1 FAILED at 120
> > >
> > > You can push a tree of yours somewhere which I can try directly,
> > > alternatively.
> > >
> > > Lemme know.
> > >
> > > Thx.
> > >
> > > --
> > > Regards/Gruss,
> > >     Boris.
> > >
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fp=
eople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=3D04%7C01%7CRodri=
go.Siqueira%40amd.com%7C3b8b84a3815d4a3cc67e08d8a1152189%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637436459421073301%7CUnknown%7CTWFpbGZsb3d8eyJWI=
joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sd=
ata=3DbHJQuQqFRTA2SU6Va9gt4lvnogZUeYRujeQj4fIXBsE%3D&amp;reserved=3D0
> >
> > --
> > Rodrigo Siqueira
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsiq=
ueira.tech%2F&amp;data=3D04%7C01%7CRodrigo.Siqueira%40amd.com%7C3b8b84a3815=
d4a3cc67e08d8a1152189%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63743645=
9421073301%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB=
TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DbZvusCFfCrWSitpFa%2BmWyg%2BAb=
J04ybnlUMQiEB3m5OY%3D&amp;reserved=3D0
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis=
ts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CRodr=
igo.Siqueira%40amd.com%7C3b8b84a3815d4a3cc67e08d8a1152189%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637436459421083297%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s=
data=3D3K1EuoePhkVVVT7JvPUeKuJW5RIGiHC9LNoqI9ZiTHc%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--3ukcfc6c2hzpn4yj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl/Y53kACgkQWJzP/com
vP/Sog/9F/xZZXC48at6FeIa8D2EJWLjKvqUQu4pPocC611YdAM5Wh1TYq9mCZmL
2OTe+F7WZXlhgssbseKdpUYWQnrkIHjB8eAAWYyXfU1jDijV6QpQ4K3q78FnmX7b
BYSX730PwEJyMbRb0YGKzcuePGosBFOtbf6vfsOAvYS2+c9jZUgh1iqs73kd4mqS
WngcsoXL7uR6EEf89a69Y3FveR/Vcv4zneOi6eVJdZUtYRzscil3SmXycHwMIrCo
nvQ8BWlUIzsely0lwvZl1W8k+2Kq/sBwEEdZ8g4aAH3YaLfVO9FZsXRDamNGrX0C
6L05Pa2e35EgBBmg3J/7DdUtToWJ2H0gWfbk241b39t9mBKp+V1Lrf7fmKFqDDvm
EhdaY3be2nAXvVY76r5TJbwYJXkJVG6Sp2yKKd8ieu2twRLbdL99T4Qkemn9O40S
Zaj5n4ByQ7fp/dlFRsVke3fTjk9yEF/vEtZREmzazH4cAl1R1cIgexSHmO6nR+AM
91+wPCxyhGsyLkUKYinA60wGSfL35fpgQlR1xKqQPa3rzJJL/GXmmPvkmurhDa1O
EqL3hClzMpSOz4txLaxpJwsaII5LMrMY/skMa3eHsaP8nKgYp+A+Xj0KVnJbunRS
7+8gKU1Omp2HmNX2K7k16z5z04a2jUAIMsvyi2YsoKfc/WIraq4=
=r23W
-----END PGP SIGNATURE-----

--3ukcfc6c2hzpn4yj--
