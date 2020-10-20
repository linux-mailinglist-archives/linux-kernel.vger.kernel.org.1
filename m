Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D04293F89
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 17:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbgJTP03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 11:26:29 -0400
Received: from mail-bn7nam10on2081.outbound.protection.outlook.com ([40.107.92.81]:34784
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729450AbgJTP03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:26:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9WhZTZcVqs+6b5gLkHzXRCg/6bSF1fDSGHhTsTkM1vRvMpSbALJbMvJ3HuvDm5G92Z0Tp7z4BbJKp/OTSQC77o6DkafUZW3ATK/Q/icPEr0L1dx6y8sc69J8jgU9jnxxOOvoI7mLdwYixLCe6tko+eaiwnDNnSVEFFnTd3HwhD/72Mm55ulClPuRjoJtdPVHoPj4VfxfYq+GvQH8Iy7Lf2USN2k0dANOsdBdhad/dUiNmilXl0aTJK8xrVppXu/EHyFBBh6WcmNKS64Yakp83Ol/XRi7H/U4K+0glkw7uDhgwecAGla/GiQuXZQJX6/Mww7l6fxWoFXhkZTx0gJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Z7es8hs12hOa/f3g7dEjuNDCHRy2shg3D4WTyvbp6w=;
 b=MWkl7sjkRcQDDuYgVDnwhCCmrywX06l5yD4ZlT0+fcnY6muAWQtw1Ltnu6QzucXrbWIlOhEeOXjXj5qcFRrv6+eFLDD0twlrkGMNLeFshi8hziqmYxvjAPFBTjtwynL2qygmzY/ChwqnyKEQAkXKIHkwANybPMMlVODR3rjb9AcFeDgqBmObUAhOWYhPXQAY/c47ERZBB9tSm7H4P1tZAAM2ypLTgiiRl1tPGXzNHxbO0+puEQ+UK8ZKD5CWMjRJ0JRv2vyOWQFVMn/f9FmSmVLcis7ZEM0+ODH6qdtQpmQe1P8/x/s0MJ5+4K8BIxAiwuqIQA+vxtxfmAgZyH676g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Z7es8hs12hOa/f3g7dEjuNDCHRy2shg3D4WTyvbp6w=;
 b=khFnPQnJrcSEa/qKkm9HArKz9bZ6zKk8NRKmkTuV73peqp7cdvXWGF6a3PBKCg9kkg6r/YVpnJVpW8m9TFuy1IJBVR39BWLulMPNuuCbC1+NdTbKceIeDTwE/3/xcOn9m1CuHorKfyd944ObPWiwqB2emnkEeMwTVSyRdOEPrvo=
Received: from DM6PR05MB5292.namprd05.prod.outlook.com (2603:10b6:5:5a::30) by
 DM6PR05MB3994.namprd05.prod.outlook.com (2603:10b6:5:8c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.7; Tue, 20 Oct 2020 15:26:23 +0000
Received: from DM6PR05MB5292.namprd05.prod.outlook.com
 ([fe80::fc60:3dd5:354e:e146]) by DM6PR05MB5292.namprd05.prod.outlook.com
 ([fe80::fc60:3dd5:354e:e146%7]) with mapi id 15.20.3499.015; Tue, 20 Oct 2020
 15:26:23 +0000
From:   Rahul Gopakumar <gopakumarr@vmware.com>
To:     "bhe@redhat.com" <bhe@redhat.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Rajender M <manir@vmware.com>,
        Yiu Cho Lau <lauyiuch@vmware.com>,
        Peter Jonasson <pjonasson@vmware.com>,
        Venkatesh Rajaram <rajaramv@vmware.com>
Subject: Re: Performance regressions in "boot_time" tests in Linux 5.8 Kernel
Thread-Topic: Performance regressions in "boot_time" tests in Linux 5.8 Kernel
Thread-Index: AQHWnjk5ihPzOwsVE02I7/jG5KTBz6mQW+kAgAPEkzyAAWl/gIALAETTgAAhwwCAAAD7Tw==
Date:   Tue, 20 Oct 2020 15:26:23 +0000
Message-ID: <DM6PR05MB529293AC2B077B5170FFE625A41F0@DM6PR05MB5292.namprd05.prod.outlook.com>
References: <DM6PR05MB52921FF90FA01CC337DD23A1A4080@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201010061124.GE25604@MiWiFi-R3L-srv>
 <DM6PR05MB529281F914953691E0F52D1CA4070@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201013131735.GL25604@MiWiFi-R3L-srv>
 <DM6PR05MB52926FDAB0E58F5CFA2E892DA41F0@DM6PR05MB5292.namprd05.prod.outlook.com>,<20201020151814.GU25604@MiWiFi-R3L-srv>
In-Reply-To: <20201020151814.GU25604@MiWiFi-R3L-srv>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [103.224.33.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4595ebfd-e8cf-40c2-ea34-08d8750c80f1
x-ms-traffictypediagnostic: DM6PR05MB3994:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR05MB3994578080DE2C62F57629CEA41F0@DM6PR05MB3994.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pGaeU3UGbwXcMJpovoEhGJHOGeI/6FuAoNaVa6WtnCCq8aC6fPa7cc9D3BnhRqeRxw4IYtYjdsc7A36cy1y9wNxFf4/Umo8rfEggqr4nDXspEDaWcTCEt8hqokn08eMbUiQRn+a8jxtT0nomy6WaeEli114CfMsAPeyu3fj5tVGF8PU48pG/o91ThovjqfghqjPcs5hEW7mL5LXhewtxpl8I8bEzn54OGS/LI/kp3ZlJkNjD/7Dhi72tLAaZP1nG6lLor0pCD+iDyFc7oCjI7t/Ix7qK5pGOlEfJKA7jGaCd0/CemauFhEmmXoV+P6PxKUxZZD50L329FPUT6pZ/7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB5292.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(66446008)(316002)(55016002)(86362001)(478600001)(2906002)(66476007)(76116006)(53546011)(186003)(64756008)(8936002)(66556008)(33656002)(4326008)(66946007)(91956017)(6916009)(7696005)(54906003)(71200400001)(5660300002)(26005)(8676002)(83380400001)(6506007)(107886003)(9686003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: c3Pa+rAEU/kYZ+SooBq7iWWdTnOlClFuAgglvc32JY6jhqCUZxixC/IX7AuMcGhBaYPpYU0pTc5HrM/WGFnsfGnGq+4kSqPE0yHfWlvpa+XcRILwqKN6hjc38ZLbtD1X6AGwJW0a59I7oYRPtxstkM1M6XTGVFWrshtNb8BfSoxXvjF6nIDXXse8v5JqqXJpXDP9IfzlNLV+NluKwctfSgRs7ty9YdYI0DkAo7ggzeGS+4HXGl4XRQFSZXk2oE7nj2iQGChI72HHc74CF6ELAmT98LaXrsZWs1+Ds02J132yczNs14N+PPyLnt/VJ+0xMsw6oG6P5zoh0jdNuLZAmHDywXw9yKl3Q/V/256m5w0Q9nlLqVjsrBnGqd0gUAW7Qz0sCZJNShi+P9gVImj/rW66M44Zvdvl4vVH3KE1qxf+fUYw0LND155n4/fAwkGpLWuohxegtSPiFUCc4FQ4RBQz+n08j8AuI+zi6SudMfREvhhvkilRmqr3+5rt+8c9P+UwLEfWC2Rbdh4jV7I6DzfbXzcVOiR8KZCQh2XC70NyGZOMkQDHxVhXXdoGb9L6RxAFxvQSg80c7Uy0B5WpPKFSEmWEjgsUuyxKGCCSzLzDGtYzOazJymq/EhL41NyokNQz9IMgU9KDzvDo6R3glQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR05MB5292.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4595ebfd-e8cf-40c2-ea34-08d8750c80f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 15:26:23.4201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoNtWnC/rk9esnXY7nVDSPcI5dJiSjHX7LJ8HJ26/caaQzKDCLUdP0O+wLMT2LeUqGPs0TiexqRCVHQzt3Ry3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB3994
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Here, do you mean it even cost more time with the patch applied?=0A=
=0A=
Yes, we ran it multiple times and it looks like there is a =0A=
very minor increase with the patch.=0A=
=0A=
=0A=
From: bhe@redhat.com <bhe@redhat.com>=0A=
Sent: 20 October 2020 8:48 PM=0A=
To: Rahul Gopakumar <gopakumarr@vmware.com>=0A=
Cc: linux-mm@kvack.org <linux-mm@kvack.org>; linux-kernel@vger.kernel.org <=
linux-kernel@vger.kernel.org>; akpm@linux-foundation.org <akpm@linux-founda=
tion.org>; natechancellor@gmail.com <natechancellor@gmail.com>; ndesaulnier=
s@google.com <ndesaulniers@google.com>; clang-built-linux@googlegroups.com =
<clang-built-linux@googlegroups.com>; rostedt@goodmis.org <rostedt@goodmis.=
org>; Rajender M <manir@vmware.com>; Yiu Cho Lau <lauyiuch@vmware.com>; Pet=
er Jonasson <pjonasson@vmware.com>; Venkatesh Rajaram <rajaramv@vmware.com>=
=0A=
Subject: Re: Performance regressions in "boot_time" tests in Linux 5.8 Kern=
el =0A=
=A0=0A=
On 10/20/20 at 01:45pm, Rahul Gopakumar wrote:=0A=
> Hi Baoquan,=0A=
> =0A=
> We had some trouble applying the patch to problem commit and the latest u=
pstream commit. Steven (CC'ed) helped us by providing the updated draft pat=
ch. We applied it on the latest commit (3e4fb4346c781068610d03c12b16c0cfb0f=
d24a3), and it doesn't look like improving the performance numbers.=0A=
=0A=
Thanks for your feedback. From the code, I am sure what the problem is,=0A=
but I didn't test it on system with huge memory. Forget mentioning my=0A=
draft patch is based on akpm/master branch since it's a mm issue, it=0A=
might be a little different with linus's mainline kernel, sorry for the=0A=
inconvenience.=0A=
=0A=
I will test and debug this on a server with 4T memory in our lab, and=0A=
update if any progress.=0A=
=0A=
> =0A=
> Patch on latest commit - 20.161 secs=0A=
> Vanilla latest commit - 19.50 secs=0A=
=0A=
Here, do you mean it even cost more time with the patch applied?=0A=
=0A=
> =0A=
> Here is the draft patch we tried=0A=
> =0A=
> ------------------------=0A=
> =0A=
> diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c=0A=
> index 8e7b8c6c576e..ff5fa4c3889e 100644=0A=
> --- a/arch/ia64/mm/init.c=0A=
> +++ b/arch/ia64/mm/init.c=0A=
> @@ -537,7 +537,7 @@ virtual_memmap_init(u64 start, u64 end, void *arg)=0A=
> =A0=0A=
> =A0 =A0 =A0 =A0 =A0if (map_start < map_end)=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memmap_init_zone((unsigned long)(map_e=
nd - map_start),=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0args->ni=
d, args->zone, page_to_pfn(map_start),=0A=
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0args->ni=
d, args->zone, page_to_pfn(map_start), page_to_pfn(map_end),=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MEMIN=
IT_EARLY, NULL);=0A=
> =A0 =A0 =A0 =A0 =A0return 0;=0A=
> =A0}=0A=
> @@ -547,7 +547,7 @@ memmap_init (unsigned long size, int nid, unsigned lo=
ng zone,=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long start_pfn)=0A=
> =A0{=0A=
> =A0 =A0 =A0 =A0 =A0if (!vmem_map) {=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 memmap_init_zone(size, nid, zone, start_pfn=
,=0A=
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memmap_init_zone(size, nid, zone, start_pfn=
, start_pfn + size,=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MEMIN=
IT_EARLY, NULL);=0A=
> =A0 =A0 =A0 =A0 =A0} else {=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct page *start;=0A=
> diff --git a/include/linux/mm.h b/include/linux/mm.h=0A=
> index 16b799a0522c..65e34b370e33 100644=0A=
> --- a/include/linux/mm.h=0A=
> +++ b/include/linux/mm.h=0A=
> @@ -2416,7 +2416,7 @@ extern int __meminit __early_pfn_to_nid(unsigned lo=
ng pfn,=0A=
> =A0=0A=
> =A0extern void set_dma_reserve(unsigned long new_dma_reserve);=0A=
> =A0extern void memmap_init_zone(unsigned long, int, unsigned long, unsign=
ed long,=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum meminit_context, struct vmem_altmap *)=
;=0A=
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long, enum meminit_context, struct=
 vmem_altmap *);=0A=
> =A0extern void setup_per_zone_wmarks(void);=0A=
> =A0extern int __meminit init_per_zone_wmark_min(void);=0A=
> =A0extern void mem_init(void);=0A=
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c=0A=
> index ce3e73e3a5c1..03fddd8f4b11 100644=0A=
> --- a/mm/memory_hotplug.c=0A=
> +++ b/mm/memory_hotplug.c=0A=
> @@ -728,7 +728,7 @@ void __ref move_pfn_range_to_zone(struct zone *zone, =
unsigned long start_pfn,=0A=
> =A0 =A0 =A0 =A0 =A0 * expects the zone spans the pfn range. All the pages=
 in the range=0A=
> =A0 =A0 =A0 =A0 =A0 * are reserved so nobody should be touching them so w=
e should be safe=0A=
> =A0 =A0 =A0 =A0 =A0 */=0A=
> - =A0 =A0 =A0 memmap_init_zone(nr_pages, nid, zone_idx(zone), start_pfn,=
=0A=
> + =A0 =A0 =A0 memmap_init_zone(nr_pages, nid, zone_idx(zone), start_pfn, =
0,=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MEMINIT_HOTPLUG, altm=
ap);=0A=
> =A0=0A=
> =A0 =A0 =A0 =A0 =A0set_zone_contiguous(zone);=0A=
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c=0A=
> index 780c8f023b28..fe80055ea59c 100644=0A=
> --- a/mm/page_alloc.c=0A=
> +++ b/mm/page_alloc.c=0A=
> @@ -5989,8 +5989,8 @@ overlap_memmap_init(unsigned long zone, unsigned lo=
ng *pfn)=0A=
> =A0 * done. Non-atomic initialization, single-pass.=0A=
> =A0 */=0A=
> =A0void __meminit memmap_init_zone(unsigned long size, int nid, unsigned =
long zone,=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long start_pfn, enum meminit_conte=
xt context,=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct vmem_altmap *altmap)=0A=
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long start_pfn, unsigned long zone=
_end_pfn,=0A=
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum meminit_context context, struct vmem_a=
ltmap *altmap)=0A=
> =A0{=0A=
> =A0 =A0 =A0 =A0 =A0unsigned long pfn, end_pfn =3D start_pfn + size;=0A=
> =A0 =A0 =A0 =A0 =A0struct page *page;=0A=
> @@ -6024,7 +6024,7 @@ void __meminit memmap_init_zone(unsigned long size,=
 int nid, unsigned long zone,=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (context =3D=3D MEMINIT_EARLY) {=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (overlap_memmap_ini=
t(zone, &pfn))=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0contin=
ue;=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (defer_init(nid, pfn, en=
d_pfn))=0A=
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (defer_init(nid, pfn, zo=
ne_end_pfn))=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;=
=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}=0A=
> =A0=0A=
> @@ -6150,7 +6150,7 @@ void __meminit __weak memmap_init(unsigned long siz=
e, int nid,=0A=
> =A0=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (end_pfn > start_pfn) {=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size =3D end_pfn - sta=
rt_pfn;=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memmap_init_zone(size, nid,=
 zone, start_pfn,=0A=
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memmap_init_zone(size, nid,=
 zone, start_pfn, range_end_pfn,=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 MEMINIT_EARLY, NULL);=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}=0A=
> =A0 =A0 =A0 =A0 =A0}=0A=
> =0A=
> =0A=
> ------------------------=0A=
> =0A=
> We have attached default dmesg logs and also dmesg logs collected with me=
mblock=3Ddebug kernel cmdline for both vanilla and patched kernels. Let me =
know if you need more info.=0A=
> =0A=
> =0A=
> =0A=
> From: bhe@redhat.com <bhe@redhat.com>=0A=
> Sent: 13 October 2020 6:47 PM=0A=
> To: Rahul Gopakumar <gopakumarr@vmware.com>=0A=
> Cc: linux-mm@kvack.org <linux-mm@kvack.org>; linux-kernel@vger.kernel.org=
 <linux-kernel@vger.kernel.org>; akpm@linux-foundation.org <akpm@linux-foun=
dation.org>; natechancellor@gmail.com <natechancellor@gmail.com>; ndesaulni=
ers@google.com <ndesaulniers@google.com>; clang-built-linux@googlegroups.co=
m <clang-built-linux@googlegroups.com>; rostedt@goodmis.org <rostedt@goodmi=
s.org>; Rajender M <manir@vmware.com>; Yiu Cho Lau <lauyiuch@vmware.com>; P=
eter Jonasson <pjonasson@vmware.com>; Venkatesh Rajaram <rajaramv@vmware.co=
m>=0A=
> Subject: Re: Performance regressions in "boot_time" tests in Linux 5.8 Ke=
rnel =0A=
> =A0=0A=
> Hi Rahul,=0A=
> =0A=
> On 10/12/20 at 05:21pm, Rahul Gopakumar wrote:=0A=
> > Hi Baoquan,=0A=
> > =0A=
> > Attached collected dmesg logs for with and without=0A=
> > commit after adding memblock=3Ddebug to kernel cmdline.=0A=
> =0A=
> Can you test below draft patch and see if it works for you? =0A=
> =0A=
> From a2ea6caef3c73ad9efb2dd2b48039065fe430bb2 Mon Sep 17 00:00:00 2001=0A=
> From: Baoquan He <bhe@redhat.com>=0A=
> Date: Tue, 13 Oct 2020 20:05:30 +0800=0A=
> Subject: [PATCH] mm: make memmap defer init only take effect per zone=0A=
> =0A=
> Deferred struct page init is designed to work per zone. However since=0A=
> commit 73a6e474cb376 ("mm: memmap_init: iterate over memblock regions=0A=
> rather that check each PFN"), the handling is mistakenly done in all memo=
ry=0A=
> ranges inside one zone. Especially in those unmovable zones of multiple n=
odes,=0A=
> memblock reservation split them into many memory ranges. This makes=0A=
> initialized struct page more than expected in early stage, then increases=
=0A=
> much boot time.=0A=
> =0A=
> Let's fix it to make the memmap defer init handled in zone wide, but not =
in=0A=
> memory range of one zone.=0A=
> =0A=
> Signed-off-by: Baoquan He <bhe@redhat.com>=0A=
> ---=0A=
> =A0arch/ia64/mm/init.c | 4 ++--=0A=
> =A0include/linux/mm.h=A0 | 5 +++--=0A=
> =A0mm/memory_hotplug.c | 2 +-=0A=
> =A0mm/page_alloc.c=A0=A0=A0=A0 | 6 +++---=0A=
> =A04 files changed, 9 insertions(+), 8 deletions(-)=0A=
> =0A=
> diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c=0A=
> index ef12e097f318..27ca549ff47e 100644=0A=
> --- a/arch/ia64/mm/init.c=0A=
> +++ b/arch/ia64/mm/init.c=0A=
> @@ -536,7 +536,7 @@ virtual_memmap_init(u64 start, u64 end, void *arg)=0A=
> =A0=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (map_start < map_end)=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memmap_init_zone((unsign=
ed long)(map_end - map_start),=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 args->nid, args->zone, page_to_pfn(map_start),=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 args->nid, args->zone, page_to_pfn(map_start), page_t=
o_pfn(map_end),=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
> =A0}=0A=
> @@ -546,7 +546,7 @@ memmap_init (unsigned long size, int nid, unsigned lo=
ng zone,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long start_pfn)=0A=
> =A0{=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (!vmem_map) {=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memmap_init_zone(size, nid, z=
one, start_pfn,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memmap_init_zone(size, nid, z=
one, start_pfn, start_pfn + size,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct page *start;=0A=
> diff --git a/include/linux/mm.h b/include/linux/mm.h=0A=
> index ef360fe70aaf..5f9fc61d5be2 100644=0A=
> --- a/include/linux/mm.h=0A=
> +++ b/include/linux/mm.h=0A=
> @@ -2439,8 +2439,9 @@ extern int __meminit __early_pfn_to_nid(unsigned lo=
ng pfn,=0A=
> =A0#endif=0A=
> =A0=0A=
> =A0extern void set_dma_reserve(unsigned long new_dma_reserve);=0A=
> -extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned=
 long,=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum meminit_context, struct =
vmem_altmap *, int migratetype);=0A=
> +extern void memmap_init_zone(unsigned long, int, unsigned long,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long, unsigned long,=
 enum meminit_context,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct vmem_altmap *, int mig=
ratetype);=0A=
> =A0extern void setup_per_zone_wmarks(void);=0A=
> =A0extern int __meminit init_per_zone_wmark_min(void);=0A=
> =A0extern void mem_init(void);=0A=
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c=0A=
> index b44d4c7ba73b..f9a37e6abc1c 100644=0A=
> --- a/mm/memory_hotplug.c=0A=
> +++ b/mm/memory_hotplug.c=0A=
> @@ -732,7 +732,7 @@ void __ref move_pfn_range_to_zone(struct zone *zone, =
unsigned long start_pfn,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 * expects the zone spans the pfn range. All t=
he pages in the range=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 * are reserved so nobody should be touching t=
hem so we should be safe=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
> -=A0=A0=A0=A0=A0=A0 memmap_init_zone(nr_pages, nid, zone_idx(zone), start=
_pfn,=0A=
> +=A0=A0=A0=A0=A0=A0 memmap_init_zone(nr_pages, nid, zone_idx(zone), start=
_pfn, 0,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 MEMINIT_HOTPLUG, altmap, migratetype);=0A=
> =A0=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 set_zone_contiguous(zone);=0A=
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c=0A=
> index 2ebf9ddafa3a..e8b19fdd18ec 100644=0A=
> --- a/mm/page_alloc.c=0A=
> +++ b/mm/page_alloc.c=0A=
> @@ -6044,7 +6044,7 @@ overlap_memmap_init(unsigned long zone, unsigned lo=
ng *pfn)=0A=
> =A0 * zone stats (e.g., nr_isolate_pageblock) are touched.=0A=
> =A0 */=0A=
> =A0void __meminit memmap_init_zone(unsigned long size, int nid, unsigned =
long zone,=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long start_pfn,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long start_pfn, unsi=
gned long zone_end_pfn,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum meminit_context con=
text,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct vmem_altmap *altm=
ap, int migratetype)=0A=
> =A0{=0A=
> @@ -6080,7 +6080,7 @@ void __meminit memmap_init_zone(unsigned long size,=
 int nid, unsigned long zone,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (context =3D=3D MEMIN=
IT_EARLY) {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
if (overlap_memmap_init(zone, &pfn))=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 continue;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (d=
efer_init(nid, pfn, end_pfn))=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (d=
efer_init(nid, pfn, zone_end_pfn))=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> =A0=0A=
> @@ -6194,7 +6194,7 @@ void __meminit __weak memmap_init(unsigned long siz=
e, int nid,=0A=
> =A0=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (end_pfn > start_pfn)=
 {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
size =3D end_pfn - start_pfn;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memma=
p_init_zone(size, nid, zone, start_pfn,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memma=
p_init_zone(size, nid, zone, start_pfn, range_end_pfn,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MEMINIT_EARLY, NULL, MI=
GRATE_MOVABLE);=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> -- =0A=
> 2.17.2=0A=
=0A=
=0A=
=0A=
=0A=
