Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1B62E1F87
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 17:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgLWQgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 11:36:41 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10874 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725811AbgLWQgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 11:36:41 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BNGQTJ2022875;
        Wed, 23 Dec 2020 08:35:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=Wmm59bGHRnsMiSVMwT2GsqUblY64zHM1IzS9WUzlqas=;
 b=VZwaQdKJS7Eg4790LvumFrliZaEjDmEBq8E3KhMh1Zx812vcSb7QruK6Qz9r8DLDoIjB
 Gkyt2dyj6mSRnbFywx6sJLjP8zVKxVaJ6t+XxPj43F4p+DxiuN7SDaKch14sVc/OToAT
 PmK/Yeos7eSU1Tr9Azpp3Yvl5XZYSLrtC3U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35k0e8a5js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 23 Dec 2020 08:35:50 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 23 Dec 2020 08:35:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lmxaxeox8ORgRprZ2QkxDB5KXzjYcnoVgThK00MQTOC37Vv1JdVX8snpZho8p89F03c5KPZzYIvQgcStzNN3hAzuBhgBT8LWMk45qRHh65M0iIqRHRjZI1J6nKu3IgSc1LvgHPz6VNdnDxv4b6JsiGzzDS5eweUkKhfzWD84175H3rU61PES2ZtlPdMiP9IyhL2wCjl/1JfS3ae0H2SzUToe5pIScCYgKjKryHkbos0mlgsGGkYiaAn+TSPyfQhuOxfdX9srL3dgau7F9HVCFyjNGvG/wE2ul7bEPq9kDlzY9GHmSz3K+lQG/X4dVQmYnJwVCCb6Yw+VIxjyupQrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wmm59bGHRnsMiSVMwT2GsqUblY64zHM1IzS9WUzlqas=;
 b=SfRY00RnthtRx92/QL5xz1FDAeYqifydhLd+5bi1NlnxtqLrKeUmtEsBpN22EadDEVeTDRyre/rg5dDcXubjYi0yMQBuRJJFU8enaQX4+AjRVzIiDstgsW3c+aJpdxTQ1VbYCfSBca5K8E90mzc1WyxpWNia8qXFZweHAwf+LbdNqTuPcPKrQ4MYe2MnOUHFys2qBSQW29NXEckOJAupKkuna0ZGajl0fvhZ075Kv60pa7T5RBQpQUfvJblKBrF73s0PAfdi7Mgnff+uITGZap2lZ7b5gWottoRLUnsr1V50gPSCNz6eUimq3m3T546nFdxZnyWB2ym/JqI3dDDmKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wmm59bGHRnsMiSVMwT2GsqUblY64zHM1IzS9WUzlqas=;
 b=HvQBb84rAszlEJw2N7bcTln3ObTK8U17Orzy5qlYNLnP+DzDgYP5Q9uoPFyxRFYyjHgiuykvbd9125zRgGZnF6ryYVW0MeVM0ZWlUfLgdzDF1XuVyc0YxwEdSlZF02KkZC2LGB1pBXZCiFBPEHY25PWfrndSky1l61ADX5FWrqk=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3351.namprd15.prod.outlook.com (2603:10b6:a03:10c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Wed, 23 Dec
 2020 16:35:42 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::ed8c:29c3:6ebf:3e66]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::ed8c:29c3:6ebf:3e66%5]) with mapi id 15.20.3700.026; Wed, 23 Dec 2020
 16:35:42 +0000
Date:   Wed, 23 Dec 2020 08:35:37 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH v2 1/2] mm: cma: allocate cma areas bottom-up
Message-ID: <20201223163537.GA4011967@carbon.DHCP.thefacebook.com>
References: <20201217201214.3414100-1-guro@fb.com>
 <20201220064848.GA392325@kernel.org>
 <20201221170551.GB3428478@carbon.DHCP.thefacebook.com>
 <20201222200606.fe4444f1f0ba008ee9fda091@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201222200606.fe4444f1f0ba008ee9fda091@linux-foundation.org>
X-Originating-IP: [2620:10d:c090:400::5:c41]
X-ClientProxiedBy: MWHPR1601CA0014.namprd16.prod.outlook.com
 (2603:10b6:300:da::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:c41) by MWHPR1601CA0014.namprd16.prod.outlook.com (2603:10b6:300:da::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Wed, 23 Dec 2020 16:35:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8964ba4a-7110-46ab-472e-08d8a760ca5a
X-MS-TrafficTypeDiagnostic: BYAPR15MB3351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB33512704D58090479C50E15CBEDE0@BYAPR15MB3351.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWbQ6LuMoXTSm22XhdiC1a/MfQJXM8+79uolLkATT1bReEkP0Ze2ZQydh8IbK7mEhevLTSMj2kzY2I1EV1MbEaEESCERGxu9Oe4dPATqKZlmwqABDmdTYRggT/M3/4Mbxqa66h8AmGhdjQX6bBv5zm+gdA/wKbIhNoTqwRepTeKV245Vfe8lJonCwBJ/DiOLAw7o5DBdR+WJs/epraeHIen1A8NoRoYzGI/3DuNl0RjTqQxq9rAS+fM0s2ULbCGjo1fCKTNJOKIds8ga6CPNksklEAVtyeVsCZejGmlYp1i7tO1Qs6wcD2M2kzLETaudbl5Sv+whrzHEwHjqwzWEvkY0XwGsfa9GAhBDMH7jIbcA8qlWTzVhbJSDHTNe/ekVzfLW2q349349kwVh9BLg2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(376002)(346002)(396003)(52116002)(7696005)(186003)(478600001)(2906002)(8676002)(16526019)(55016002)(6666004)(5660300002)(33656002)(66556008)(86362001)(66476007)(66946007)(6506007)(9686003)(316002)(54906003)(1076003)(83380400001)(6916009)(8936002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a3BGYS9zMHRvQ3Bxb1c5L0d1S2xyYzNlZGJhZ3RYTnowUkptSE84cU4xd3R2?=
 =?utf-8?B?cXEvRjJBbDg2eldzUVBiZEptWTZFZjJVRXpzQXZSdTlmK0N6ellQaTVRc1Zi?=
 =?utf-8?B?UDhQSC91NlAxRytDUnRmZWZPSk92MHRaWlNCUUdpNWxtazQ4SlZBZ3FZUC9K?=
 =?utf-8?B?Z3hhWHQ4bHVaUUFHT1E0LzRGUG93ckRib0VwaWgwV1owcVJzM2tsNm1rVDlP?=
 =?utf-8?B?RkFkOTN1SnpIS2ZSRURLVXBGRkN6U2FnSk5YVWhMUGI0UzhIMS9LTUtCUXNF?=
 =?utf-8?B?Ty9rOVpYZFZWT2hpTFJzanRQVXJVbHpaLzJGditENkc2c1FRc29sNS8xV3lJ?=
 =?utf-8?B?K3pzOTFLZmVNU3YvNEF5d2wwRXVoN2hBNVdlNkorQy9LR2lvdUlTOHVLQSts?=
 =?utf-8?B?cStCZER3aDVtcTVzTVByR2d0QkJwbDRCbi9yY3Q0UmRiWXE0L2tTdTJPT3RG?=
 =?utf-8?B?Rk5Wbi9NeXZ3Vm4wNkxmSjI1Z2M4VjZORklLa3h4UGZSY3J0ak1IZXBvV3VG?=
 =?utf-8?B?amJPMUtJdkV3YUErWkJ5NHZWUmVuSUhUQlQ1bUUyTVlYb1pwa3ZMZ2hRMHdB?=
 =?utf-8?B?eEZMV3NtczVPWkF1c21qRkJ2YmptTHVvUzI0Q1ptVGhZZlhwRmwwdFRMYXUy?=
 =?utf-8?B?MEJyZXpUOEhNRHdWM2lvcERLMW5qNUhiZEszeGtiQzhNUG04Ym9FdDY0NHRy?=
 =?utf-8?B?R1lJSnl5SGY0cGV2RlF4cFVDa09yV1Y0eXJTanpoejZ5RFg4dE8xN1UyeTRj?=
 =?utf-8?B?NGgyRzdPUC9NSVZFcXl1ajIyVUx6UEFaNFNaZjlQWmlXUEZjQS9ZeStJSUls?=
 =?utf-8?B?d21ONGwxZzQ3L3dkRk05UlRRMzMxQ1o4ZWJRVmNKSS9MY1llWW5QNEZHb1Bn?=
 =?utf-8?B?TU5zQXRYek9haDFNam1qRjdUcEg5NUp3OW03MGNEL0xDWnY3NGQ4ZUtiMDVx?=
 =?utf-8?B?M0kvMWZxczZwMDhqanhPMXByeFlVUm1oaFZoYis4NXVuNy84cnNjZS9LSkZM?=
 =?utf-8?B?SGM2OERsT3BGMUFuMit6YmJsbEczUEh1Y1NUOGtROFE0OVI3bTJCVHY1N3ZP?=
 =?utf-8?B?WXZqNU9kbTJiNFcrejVLR1FZQjgyZDYvMkF6amIycFg0Q1dZVHJ2WEVHRjA5?=
 =?utf-8?B?N3FHdmZ6eUYrR0xBcVB4VXR3eUdUclJJblRyNEZ0cnNXbjZsU2hqY3ZIeFMy?=
 =?utf-8?B?RGNuR3lXamtVU0JFcjM3WFppUXVTTGRhOXBUZjhiU243elpqaVJMY2JwR2Iy?=
 =?utf-8?B?OU9GL1NDZHRibHhORlRzSjZPbXpWbStTTit5c1dWcGZkZEs3UnJIVjJCcWZh?=
 =?utf-8?B?R2tST00wckU4OVRVa1VnUG8zMGhVRkRIOHBkejhLUm1kelJBRGhkSjVVKzZ6?=
 =?utf-8?B?cDIybVEweTdzRkE9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2020 16:35:42.5498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 8964ba4a-7110-46ab-472e-08d8a760ca5a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaKnXUl1GAz3EtOUwfxJriqr3jeZvBb9O7JbeDagug1QEJeQEHLeBRrhmPuRVI/3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3351
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-23_07:2020-12-23,2020-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 mlxscore=0 phishscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012230121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 08:06:06PM -0800, Andrew Morton wrote:
> On Mon, 21 Dec 2020 09:05:51 -0800 Roman Gushchin <guro@fb.com> wrote:
> 
> > Subject: [PATCH v3 1/2] mm: cma: allocate cma areas bottom-up
> 
> i386 allmodconfig:
> 
> In file included from ./include/vdso/const.h:5,
>                  from ./include/linux/const.h:4,
>                  from ./include/linux/bits.h:5,
>                  from ./include/linux/bitops.h:6,
>                  from ./include/linux/kernel.h:11,
>                  from ./include/asm-generic/bug.h:20,
>                  from ./arch/x86/include/asm/bug.h:93,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/mmdebug.h:5,
>                  from ./include/linux/mm.h:9,
>                  from ./include/linux/memblock.h:13,
>                  from mm/cma.c:24:
> mm/cma.c: In function ‘cma_declare_contiguous_nid’:
> ./include/uapi/linux/const.h:20:19: warning: conversion from ‘long long unsigned int’ to ‘phys_addr_t’ {aka ‘unsigned int’} changes value from ‘4294967296’ to ‘0’ [-Woverflow]
>  #define __AC(X,Y) (X##Y)
>                    ^~~~~~
> ./include/uapi/linux/const.h:21:18: note: in expansion of macro ‘__AC’
>  #define _AC(X,Y) __AC(X,Y)
>                   ^~~~
> ./include/linux/sizes.h:46:18: note: in expansion of macro ‘_AC’
>  #define SZ_4G    _AC(0x100000000, ULL)
>                   ^~~
> mm/cma.c:349:53: note: in expansion of macro ‘SZ_4G’
>     addr = memblock_alloc_range_nid(size, alignment, SZ_4G,
>                                                      ^~~~~
> 

I thought that (!memblock_bottom_up() && memblock_end >= SZ_4G + size)
can't be true on a 32-bit platform, so the whole if clause can be compiled out.
Maybe it's because memblock_end can be equal to SZ_4G and if the size == 0...

I have no better idea than wrapping everything into
#if BITS_PER_LONG > 32
#endif.

Thanks!

--

diff --git a/mm/cma.c b/mm/cma.c
index 4fe74c9d83b0..5d69b498603a 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -344,12 +344,14 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
                 * Avoid using first 4GB to not interfere with constrained zones
                 * like DMA/DMA32.
                 */
+#if BITS_PER_LONG > 32
                if (!memblock_bottom_up() && memblock_end >= SZ_4G + size) {
                        memblock_set_bottom_up(true);
                        addr = memblock_alloc_range_nid(size, alignment, SZ_4G,
                                                        limit, nid, true);
                        memblock_set_bottom_up(false);
                }
+#endif
 
                if (!addr) {
                        addr = memblock_alloc_range_nid(size, alignment, base,
