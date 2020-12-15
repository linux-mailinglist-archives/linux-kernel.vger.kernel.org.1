Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E887F2DB603
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 22:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgLOVrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 16:47:03 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25442 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730811AbgLOVol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 16:44:41 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BFLQN73005773;
        Tue, 15 Dec 2020 13:43:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=QGG1dKo+2XhlfsTOzMKyVVMp/TpUn8VyYE7g5vF+UFs=;
 b=M2N+6FLaUG86kCfQ8W/wSCUR8zkFf4bEOpFam0xARRik1ba7hfGnFVBjsrPtClSKVvYV
 kPE8EDlAZCei8WH1kVo7IgGxlKw9j3ZmnQbz6yROFQa2AQLa6APWW9eYKHr7XIoWZyK9
 WrWJe5FCdRq9hmy0lu0K7V9mn0NqiJnzycU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35eywbt8sy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Dec 2020 13:43:50 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 15 Dec 2020 13:43:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oqa61O6WOw7j2086l6Of4ehbG2jeZLw5U2eKrAnSafsgHvht2AnrOD6ESRtz4HiAOytWr/Qs1LLNIGksj5sE+YdWTv/UuE5g7vbOXHnhExB+cfrgeo0YhX3fp35NezpJ643H2PJIiq1RbBE8nVVzldx8y+r1T+f1vyOauk1uSTv/Kd1zDG3C5hi8RK7/fZpH9owE6ZrlgXtyGOx7gj2A79t01fgn+BakX5s6fTKbWoz40y5XQeK9jXbXQevm0lmHUNCdY5xJSuHXiODgfbC2sCGTyuerWwacep8DjH+TArJYu32ui9r+JkH1+hc/qj4bpYEY2iSI1CE1vN+mPkp6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGG1dKo+2XhlfsTOzMKyVVMp/TpUn8VyYE7g5vF+UFs=;
 b=bqQaKpPHdnNGVkVksZOP7snVXvrMAeCA631JkImt0rLCiJGtYV82Ns/aLPM6TiOC3wgmC96F36hzILH/Inork/cIFp9ZRUeGeriO+KLpDxn0O9sQYB4etZ6OM/zwwPkVNwLD/MZ5EZVL07SgdWJvesAyK6Rpl99Xz9STJvbc8VtB45A80JXHxOSLllUMGrB1JaX0w9CsiA1Y7/GgZBppy1Glv+//cs7OpReKLk4nj2TszpW2G8Lnw6yd+HHxxfdLd79t/7SxMjx29JDfnhPd/trVRsU0Sdbp1NjUYg4BUFfJUWgUTgvBpWywEF9hc+Dwh4jCr4gcl4RsNnt1BnWC4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGG1dKo+2XhlfsTOzMKyVVMp/TpUn8VyYE7g5vF+UFs=;
 b=ML3FYJ1ii5yrsIodqX6IV8iXpgEcQe6Eu6l6VC+EYJETCnDOxNkwruiyUU9wI00vXpKeWIxLRqXrcdvoffQQ8PoyjPvaPCCjOH1xMKiPxbtB0HcywJ6wrWZ2IsR495G0dXqZbNsOPOY0ea0pX3/+jPptoNyNH4xB6Jj9r9yRY7k=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2710.namprd15.prod.outlook.com (2603:10b6:a03:153::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.18; Tue, 15 Dec
 2020 21:43:44 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 21:43:44 +0000
Date:   Tue, 15 Dec 2020 13:43:41 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH] mm: cma: allocate cma areas bottom-up
Message-ID: <20201215214341.GA3178998@carbon.DHCP.thefacebook.com>
References: <20201215193615.1867115-1-guro@fb.com>
 <20201215213623.GB247200@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215213623.GB247200@kernel.org>
X-Originating-IP: [2620:10d:c090:400::5:7945]
X-ClientProxiedBy: BYAPR07CA0061.namprd07.prod.outlook.com
 (2603:10b6:a03:60::38) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:7945) by BYAPR07CA0061.namprd07.prod.outlook.com (2603:10b6:a03:60::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 21:43:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41484f7b-cd4c-4e35-f885-08d8a1427eed
X-MS-TrafficTypeDiagnostic: BYAPR15MB2710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2710CBFF83A8D0017BCE6C79BEC60@BYAPR15MB2710.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V24uwI5RVVKitzbGxuQeqeotMIeBhZu+BVcy7SMtkF18aPrnDoT2mIwDXn4sCIyjHhwIbiiYbfWDRm3ULLEDiig0My9RwPnHYj6rD8DOLAFy3XlKOP6JJiL/w3W3rqHwGkEh0bDMnkIyoXFfPsDmhRFLGNwJjhBs57RviF3Y/ckty1kA5c2zeBnF6n7uljIBzNTQBdvT2cLClQNvrMi4Qq88cOwGJ2Tkx4UDpvtJlMI8wqTprltc5yxwmRMolZ6ETF4xlw9RhvveDKi8Nnrgzdkn30af3u/Tdp6oEudomYZ9Zy6EjC3YGm2JQnJ/8M4zlZRYqC7LfUX7PZWDM1MvWUDCt4S3LUAAq1txD77Kl26xfW4vCcUozAfW/5hd6thD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(39860400002)(366004)(396003)(1076003)(5660300002)(66946007)(86362001)(316002)(7696005)(33656002)(66476007)(8676002)(66556008)(4326008)(83380400001)(8936002)(9686003)(54906003)(478600001)(52116002)(6506007)(6916009)(16526019)(55016002)(2906002)(186003)(134885004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?B/Jvqr5x3Sm8Wpj5fI6kmXEZp1f5K1094YaFVLx/Z6v8Ohs8MVTSLkiq15NH?=
 =?us-ascii?Q?ezL+VVG08wbeNqAxIxorHiuF65ZvqUTOPkqVMArqau7RExVabsI/ySJ2jP4e?=
 =?us-ascii?Q?+aiQ9xjsoFKxCFyBZGVDUxBrI+4e5GV5nS92k3prSpD4Dg4LATpuQT0wfxAF?=
 =?us-ascii?Q?q8kcwF9MxT0cP8pPMlFK2RIDnSyZclfubsxmGoEeM3g5ikInN3uVeVFolk1w?=
 =?us-ascii?Q?oATa4cQUGZFNkCuev0mqZs2TxrMHm4YyPrsyZs7F6L950NRVBpPJikl4rADN?=
 =?us-ascii?Q?mDkZiFR3wanmBp9h0XtwmDupm4AG8aujyIPNE9mxCXarZhAJ6a/6Kdt+bU1v?=
 =?us-ascii?Q?aQ55YSY72FmTTcV3LAcdr1OLJ/9NgjztaLXjHyr3JHM7soQtqMAPF85w0LGb?=
 =?us-ascii?Q?JmA+dgLKIrd+XfLMEv8hpsMwgx5XDge5EKBF8tcziEzX5/Qi7NhMQmUlv6qR?=
 =?us-ascii?Q?ZKYdbztBXkQ03sIg+sWcuJGIrdpa4PeQhL2HjsBwrx8UbgdudO/mWgxMigh7?=
 =?us-ascii?Q?MXwtiWajndcxkTu+PRiSJKO0F442u/uV6sbs5+gSTJIRWVXto42J68BuNB6J?=
 =?us-ascii?Q?uZOBTA2nnrb/p3mL54LZ+HxrpUi9QFKPqACEStW4twsa1lQzp/ciezSc3WU2?=
 =?us-ascii?Q?JDKadM9szSHpQBvRnMyv4iHs8FjTaVc58y4tp11B9jXSpq7S2XfLdd4/D60b?=
 =?us-ascii?Q?Bua1l0SP9Od6g14BrJvXlcYMfX9SpeMDZIWPSxoFQ3MuLHHJE6qM3PYYSAmD?=
 =?us-ascii?Q?YrGocLNgnra0mwEaQL2eemcwvVAuWJ4lOoYt1Iu6cjyZRbPEcntlTOKpnD4d?=
 =?us-ascii?Q?AxVxJMLZ4UqkrvQ/HUYz3EEJ/dKiZwLr4gTifkKQOX9el6lLnWUBNaaYZO85?=
 =?us-ascii?Q?oFACYR9mNFy6qLj9iLAe9UCGqwmO2t4dUEb0ao3XYgI02cLcpsb5DjWSujdT?=
 =?us-ascii?Q?J6OHsnBdYwfkOKhHvLfNiT3F7vQburO6wyajKB7JzT7yXrsL7IXHE7z3nmub?=
 =?us-ascii?Q?cgZe5y8Hd0Ya21SzhTW8Y3dQgw=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 21:43:44.1050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 41484f7b-cd4c-4e35-f885-08d8a1427eed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHGanm9ww0Np2D5egogitTxC+YAAf21pNGzFjXylzXQhKXSUNp8TfbxRt8nfMkvJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2710
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_12:2020-12-15,2020-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150145
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 11:36:23PM +0200, Mike Rapoport wrote:
> Hi Roman,
> 
> On Tue, Dec 15, 2020 at 11:36:15AM -0800, Roman Gushchin wrote:
> > Currently cma areas without a fixed base address are allocated
> > close to the end of the node. This placement is sub-optimal because
> > of how the compaction works: it effectively moves pages into
> > the cma area. In particular, it often brings in hot executable pages,
> > even if there is a plenty of free memory on the machine.
> > This results in more cma allocation failures.
> > 
> > Instead let's place cma areas close to the beginning of a node.
> > Cma first tries to start with highmem_start, so we shouldn't mess
> > up with DMA32. In this case the compaction will help to free cma
> > areas, resulting in better cma allocation success rates.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  include/linux/memblock.h |  5 +++--
> >  mm/cma.c                 |  4 ++--
> >  mm/memblock.c            | 26 +++++++++++++++-----------
> >  3 files changed, 20 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index 9c5cc95c7cee..698188066450 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -384,8 +384,9 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
> >  phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t align,
> >  				      phys_addr_t start, phys_addr_t end);
> >  phys_addr_t memblock_alloc_range_nid(phys_addr_t size,
> > -				      phys_addr_t align, phys_addr_t start,
> > -				      phys_addr_t end, int nid, bool exact_nid);
> > +				     phys_addr_t align, phys_addr_t start,
> > +				     phys_addr_t end, int nid, bool exact_nid,
> > +				     bool bottom_up);
> >  phys_addr_t memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid);
> >  
> >  static inline phys_addr_t memblock_phys_alloc(phys_addr_t size,
> > diff --git a/mm/cma.c b/mm/cma.c
> > index 20c4f6f40037..1b42be6d059b 100644
> > --- a/mm/cma.c
> > +++ b/mm/cma.c
> > @@ -332,13 +332,13 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
> >  		 */
> >  		if (base < highmem_start && limit > highmem_start) {
> >  			addr = memblock_alloc_range_nid(size, alignment,
> > -					highmem_start, limit, nid, true);
> > +					highmem_start, limit, nid, true, true);
> >  			limit = highmem_start;
> >  		}
> >  
> >  		if (!addr) {
> >  			addr = memblock_alloc_range_nid(size, alignment, base,
> > -					limit, nid, true);
> > +					limit, nid, true, true);
> >  			if (!addr) {
> >  				ret = -ENOMEM;
> >  				goto err;
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index b8b7be0561c4..c334b401fe16 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -272,6 +272,7 @@ __memblock_find_range_top_down(phys_addr_t start, phys_addr_t end,
> >   *       %MEMBLOCK_ALLOC_ACCESSIBLE
> >   * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
> >   * @flags: pick from blocks based on memory attributes
> > + * @bottom_up: force bottom-up allocation
> 
> Why wouldn't you use memblock_set_bottom_up() around the allocations in
> CMA, e.g.
> 
> 	bool bottom_up = memblock_bottom_up();
> 
> 	if (!bottom_up)
> 		memblock_set_bottom_up(true);
> 
> 	/* allocate memory */
> 
> 	memblock_set_bottom_up(bottom_up);

Hi Mike!

Wouldn't it open a possibility for a race? If somebody else is doing an allocation
in parallel, their allocation could become affected.

Thanks!
