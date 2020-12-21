Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1425B2DFEBF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 18:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgLURGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 12:06:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33770 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgLURGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 12:06:50 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BLH0O5I002025;
        Mon, 21 Dec 2020 09:05:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=J5hYPK9H9ybeGFcvb6rISL/M5TcdMOo1GE87HMrk8Ks=;
 b=rRZ11wcbkf1NbLfxC+28OHkScRjwzFMzUgeB9aMs0AAaCPTtbmtnrvStQFk+hblDnc2J
 L1N9pngDjWvILvVYv4KdLvGeCUgXyhbOPOCm/lxjq6YAnjFyIEH7vcM/fWODJIaILUG0
 M1q8oQiwQYlHe3//tdrQoOOw2HISVSeqmM4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35js2s1t1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 21 Dec 2020 09:05:59 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 21 Dec 2020 09:05:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mq4aE5wAoPRxrl+1G37+wdLMIywhr7x1FvnUMOOFg3ZauTkISF47cgLcvXF7hV7aewl1x2Bex+Uwn86f6cNcsSr3dWMV4flVSnO9yyfSobtD9KKJCc7djUNXFFshly5hefLMUfhkFceeRkwUxc7wFsVTAJzeKRm4dieGPoqDKUV91+q+MIY42EFwiRBG5xg9ZgbEONuX1pJuFrXhfZlQI4mBeuqtrxShCtTCcGCKW3hAVT/kFHlSXAFgDLEWBIPnWq89lhVdaocAGgHPtXoG2OfkAZEuAarrJI9PdumhYDq5cru17qXfPkYIhI9810O/KVZyxbQewVF8tGnlq6ttZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5hYPK9H9ybeGFcvb6rISL/M5TcdMOo1GE87HMrk8Ks=;
 b=gRw38n2Sv93btfA2ZHRlkMA9JjPPBbvFaEK3Cu/77w+aaxaG6mnpJTrIcmUDGwnpgeTJo9/9E+xTDWIhjy0UOFUueK+MrbGLmFTRCd+X0UTe/GdgpcA22kOsGNTpISXzfgxGUDi5RJATyOpdKa7vGafdzf70IQWT2YnBJuTV/TGHDWgnY6RP+3USPzvd/gP5wv2Gxz1vdzg637/LwK28Wbb8qJlim5Wva28uh45vk8ojGoBT20d4gyYw2MUwfms+sYJClxvEBfPIpLNtk49MQ6b/YJOpPQXGI/hAVvU0jFvKHwGZTLNrgop+peEr21g5/YqdMYN1M2/+0879hkCGjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5hYPK9H9ybeGFcvb6rISL/M5TcdMOo1GE87HMrk8Ks=;
 b=DZyOLLl/v3nU3cHYr8sqWBLIRzarX3pMDROMpkjrtQF1qdtm0Bitz0+IbK7Z+0RJTy8ybhCWiCz4a7JFXwoGurgMxwimde4IS6d1J3TPV+8BxqHH6BJMF4492XUy5oAFl/YjF/Sl+V9A8J7eqRNviUw+ZaoWBW+eLCl/kaTHcxw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2981.namprd15.prod.outlook.com (2603:10b6:a03:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.31; Mon, 21 Dec
 2020 17:05:57 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 17:05:57 +0000
Date:   Mon, 21 Dec 2020 09:05:51 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH v2 1/2] mm: cma: allocate cma areas bottom-up
Message-ID: <20201221170551.GB3428478@carbon.DHCP.thefacebook.com>
References: <20201217201214.3414100-1-guro@fb.com>
 <20201220064848.GA392325@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201220064848.GA392325@kernel.org>
X-Originating-IP: [2620:10d:c090:400::5:7f89]
X-ClientProxiedBy: MWHPR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:300:116::34) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:7f89) by MWHPR07CA0024.namprd07.prod.outlook.com (2603:10b6:300:116::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.28 via Frontend Transport; Mon, 21 Dec 2020 17:05:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c723110-9b1c-49f9-4971-08d8a5d2af66
X-MS-TrafficTypeDiagnostic: BYAPR15MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB298196B197BE65C45DA458AFBEC00@BYAPR15MB2981.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rx5m8J6mqZ5Ok+O5k3M1GPpDDR6dHwaDe3Sd9Xg53ETZ+Z5t907vbMSB3+TX3bM7eFoXKvyRxALylRRfujNCQ3c9U7cJZzHDNX/ha8Pvyhhw8MxF/dDl5/vL2Br8lnXdvQepSGAo4EbiSG5wc79tX9V0ptKRu9iVf6VqH1u9hQxbhDUWnkPHQ9FNCUC+YRlvoUDLrj+CNqvhCKTuqQs/D8dhNGLJ/C82jAUGbUaBMLeYAT1S1R3A4KjrAJ3qqjX0MUhaj/eDB7+ytIjKXQcbPAc8n6vLAK5EgtNSgPC0H9gAQ+SQb/bVsZ7yb3evCNnFsevGSgzbPVtM4Jl77CA9FDhWtu+x3Hr2WLHr58TFk0c8jtVZzxKQkuc5TxQ1yxDj8DycM7WjYr9lLkNQ5RCA6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(396003)(366004)(39860400002)(83380400001)(1076003)(53546011)(7696005)(55016002)(52116002)(5660300002)(9686003)(6506007)(316002)(6666004)(16526019)(478600001)(66476007)(8936002)(66946007)(66556008)(86362001)(6916009)(33656002)(54906003)(2906002)(4326008)(186003)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?y9L+mvkI83t+gsHP9BTnDoeOu7p0xKK2kXqbRlnnp8AK9TYJ4ZG5MVIm0nKX?=
 =?us-ascii?Q?PFYlhu1x/hcJXlsjT5l7ef4rPZu1h+qwtfJwoJ/b1Uwhy0iHrm/A1bZX3tkT?=
 =?us-ascii?Q?XOt2uQBWYl/eC8bPPSQi7l2IuEwhRNLKoOqKNVbGwrfS62wCSHTHlcDzJMVh?=
 =?us-ascii?Q?SyiJqNAY+z88yYPTyJrhmKvjdnKK/BLQ4mOGV1kvx6/E+J3qFoMDW0ksh3Dk?=
 =?us-ascii?Q?e7xNedydbIfR6oxc8aV3RtqBb5F20sC6Nr87uYuHQS8BOeDNgqxCHrsDbLZT?=
 =?us-ascii?Q?/SqG7iV5kRlsaU0oz7Yrs59U8NtRFB7+t6UMuSZwy2s62cawxiSslnRmeQxJ?=
 =?us-ascii?Q?KZXck08tZM/g/RgkwRZ+nXtaZKoC2kNteIEFKsjoNPP8Dsod0XBXto9ygf5g?=
 =?us-ascii?Q?IPJaFYfmnYvq57PT/7Lny/IeulZwOz6TlN8KYwOFuTTxgEqHDYAIz7kjocDw?=
 =?us-ascii?Q?bbym60JxvYcOzrMEXbgZINJzOJvr9jHooDtxeVrGaD5GiGTX/EmgNZrGxBfK?=
 =?us-ascii?Q?EjHfbKFppNB56BYZ9VBFpyMuOLagJVp4RZQAGY1xvjlaXTfUFgY6sp5QLVtG?=
 =?us-ascii?Q?988hhXs1kAVZvPFKeXynMl56SBCKNJ1r/1kRYdm6gY7z23zI/iI8Gs4RVE/P?=
 =?us-ascii?Q?bpeNXfQzTmQZRxF8t6cDOiFqNcgJ7g9G9WI/CBERgCLLl4ir8e0BJjQlJftY?=
 =?us-ascii?Q?f2hETLlxLzGhYJgYb6oaCAnV6yOn+koOgeUV6cQFRVVVvLTBSHY9dbr+Uew3?=
 =?us-ascii?Q?ZBfZ592phhWnMtPttli6wtstuby8RMcPW4lx4I0/IRuvlCn5QJaLCRSnL/zw?=
 =?us-ascii?Q?8tUgyAN9/e3B26oK1Y5uChm/v/lSR0cGlBxMMZc8SujXIFN3AWWyJY75Bcp7?=
 =?us-ascii?Q?KbFEIoBgs9UXIKtZrbht5z3MAi31Cqgpjyu1aAaG2+GcMiTbZAAhqnS/4ajU?=
 =?us-ascii?Q?vx89YKjvqgwNBXqNzLUZma6zVE1Gn7zM6D+BDXLM7QCX56fX6u5qWm96+ifE?=
 =?us-ascii?Q?ufUQUbtEDGuVGgR1iWul2z3/PA=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2020 17:05:57.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c723110-9b1c-49f9-4971-08d8a5d2af66
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVJLo1AlZG9+T7a8gm9M7AQZKgp6fIJ1q69klXIp+ECv09yZNuEpI8qUk0flym/J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2981
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-21_09:2020-12-21,2020-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012210122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 08:48:48AM +0200, Mike Rapoport wrote:
> On Thu, Dec 17, 2020 at 12:12:13PM -0800, Roman Gushchin wrote:
> > Currently cma areas without a fixed base are allocated close to the
> > end of the node. This placement is sub-optimal because of compaction:
> > it brings pages into the cma area. In particular, it can bring in hot
> > executable pages, even if there is a plenty of free memory on the
> > machine. This results in cma allocation failures.
> > 
> > Instead let's place cma areas close to the beginning of a node.
> > In this case the compaction will help to free cma areas, resulting
> > in better cma allocation success rates.
> > 
> > If there is enough memory let's try to allocate bottom-up starting
> > with 4GB to exclude any possible interference with DMA32. On smaller
> > machines or in a case of a failure, stick with the old behavior.
> > 
> > 16GB vm, 2GB cma area:
> > With this patch:
> > [    0.000000] Command line: root=/dev/vda3 rootflags=subvol=/root systemd.unified_cgroup_hierarchy=1 enforcing=0 console=ttyS0,115200 hugetlb_cma=2G
> > [    0.002928] hugetlb_cma: reserve 2048 MiB, up to 2048 MiB per node
> > [    0.002930] cma: Reserved 2048 MiB at 0x0000000100000000
> > [    0.002931] hugetlb_cma: reserved 2048 MiB on node 0
> > 
> > Without this patch:
> > [    0.000000] Command line: root=/dev/vda3 rootflags=subvol=/root systemd.unified_cgroup_hierarchy=1 enforcing=0 console=ttyS0,115200 hugetlb_cma=2G
> > [    0.002930] hugetlb_cma: reserve 2048 MiB, up to 2048 MiB per node
> > [    0.002933] cma: Reserved 2048 MiB at 0x00000003c0000000
> > [    0.002934] hugetlb_cma: reserved 2048 MiB on node 0
> > 
> > v2:
> >   - switched to memblock_set_bottom_up(true), by Mike
> >   - start with 4GB, by Mike
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> With one nit below 
> 
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> > ---
> >  mm/cma.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/mm/cma.c b/mm/cma.c
> > index 7f415d7cda9f..21fd40c092f0 100644
> > --- a/mm/cma.c
> > +++ b/mm/cma.c
> > @@ -337,6 +337,22 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
> >  			limit = highmem_start;
> >  		}
> >  
> > +		/*
> > +		 * If there is enough memory, try a bottom-up allocation first.
> > +		 * It will place the new cma area close to the start of the node
> > +		 * and guarantee that the compaction is moving pages out of the
> > +		 * cma area and not into it.
> > +		 * Avoid using first 4GB to not interfere with constrained zones
> > +		 * like DMA/DMA32.
> > +		 */
> > +		if (!memblock_bottom_up() &&
> > +		    memblock_end >= SZ_4G + size) {
>

Hi Mike!

> This seems short enough to fit a single line

Indeed. An updated version below.

Thank you for the review of the series!

I assume it's simpler to route both patches through the mm tree.
What do you think?

Thanks!

--

From f88bd0a425c7181bd26a4cf900e6924a7b521419 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Mon, 14 Dec 2020 20:20:52 -0800
Subject: [PATCH v3 1/2] mm: cma: allocate cma areas bottom-up

Currently cma areas without a fixed base are allocated close to the
end of the node. This placement is sub-optimal because of compaction:
it brings pages into the cma area. In particular, it can bring in hot
executable pages, even if there is a plenty of free memory on the
machine. This results in cma allocation failures.

Instead let's place cma areas close to the beginning of a node.
In this case the compaction will help to free cma areas, resulting
in better cma allocation success rates.

If there is enough memory let's try to allocate bottom-up starting
with 4GB to exclude any possible interference with DMA32. On smaller
machines or in a case of a failure, stick with the old behavior.

16GB vm, 2GB cma area:
With this patch:
[    0.000000] Command line: root=/dev/vda3 rootflags=subvol=/root systemd.unified_cgroup_hierarchy=1 enforcing=0 console=ttyS0,115200 hugetlb_cma=2G
[    0.002928] hugetlb_cma: reserve 2048 MiB, up to 2048 MiB per node
[    0.002930] cma: Reserved 2048 MiB at 0x0000000100000000
[    0.002931] hugetlb_cma: reserved 2048 MiB on node 0

Without this patch:
[    0.000000] Command line: root=/dev/vda3 rootflags=subvol=/root systemd.unified_cgroup_hierarchy=1 enforcing=0 console=ttyS0,115200 hugetlb_cma=2G
[    0.002930] hugetlb_cma: reserve 2048 MiB, up to 2048 MiB per node
[    0.002933] cma: Reserved 2048 MiB at 0x00000003c0000000
[    0.002934] hugetlb_cma: reserved 2048 MiB on node 0

v3:
  - code alignment fix, by Mike
v2:
  - switched to memblock_set_bottom_up(true), by Mike
  - start with 4GB, by Mike

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/cma.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index 20c4f6f40037..4fe74c9d83b0 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -336,6 +336,21 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 			limit = highmem_start;
 		}
 
+		/*
+		 * If there is enough memory, try a bottom-up allocation first.
+		 * It will place the new cma area close to the start of the node
+		 * and guarantee that the compaction is moving pages out of the
+		 * cma area and not into it.
+		 * Avoid using first 4GB to not interfere with constrained zones
+		 * like DMA/DMA32.
+		 */
+		if (!memblock_bottom_up() && memblock_end >= SZ_4G + size) {
+			memblock_set_bottom_up(true);
+			addr = memblock_alloc_range_nid(size, alignment, SZ_4G,
+							limit, nid, true);
+			memblock_set_bottom_up(false);
+		}
+
 		if (!addr) {
 			addr = memblock_alloc_range_nid(size, alignment, base,
 					limit, nid, true);
-- 
2.26.2

