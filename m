Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50302294112
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 19:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395134AbgJTRHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 13:07:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22216 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389534AbgJTRHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:07:52 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09KH0Cce027153;
        Tue, 20 Oct 2020 10:07:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=aOug9L2PY1geTP5x0no1Joayj3ek0GwafW1LZSea/UE=;
 b=pLX6XUxhMnuEDCdiM/aEbvk+QMzHaS1orNOlQNhJizHlgG0Af6FFxNIAFhNnXpG/lCXo
 9zb1uv+7pqYcc6CXwMOnOF1ya1kNuuEUF6tGi0tYyLkwrZX2qJBGrb+FDSLuXx2Ze9ku
 v/OIvQ/Ed0DEFVijrc8XOeQ7y3kRHICE12c= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34a1s2ruae-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 20 Oct 2020 10:07:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 20 Oct 2020 10:07:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bssAY+aCTlQ15E5nFhh2+ZFfxIAbWKKYEskZKsmWrIW3pCd7jSy7u10cZ8WAtailVdAfbVQLjIaRJX+lqrt6T1JqgyMxDWJRpztKpMgdCcZaWhTf9wbXlF2k2NG/RjLIZiF6BO/HcltCSOxv8HLjENU4snf1mfYYo9GsxEbJ680MWVr83TWz4rdQ5myd1nzUsA9BAI3EZbzSfj81gj34qWbTp+rRp8MWHs7kML0XEIsl/doKhwtD+PCnw5GJR7UEhxX/d7KTVhVOx17spjOb7/2wUc7GeRwnO/8B26OKdieuRStBbDS4BBnyEWnYOVb44Lm3oyU+i0K7UBDKJ4sUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOug9L2PY1geTP5x0no1Joayj3ek0GwafW1LZSea/UE=;
 b=JQy0g7PHIoxbE5wGEVwKiC4oq8JlDqW0QVrAjVWH2AsnJq2K9DePoYDB9qR6f0BA4GfSppsaRxker8RpgLuOYVUf/Mcl4q1ytITWOkFzd4vWsjCsdk4js4YAG54MX7VcBz1AialMpMlikQwkux1MvpReLnTk15gq/a3LdCD2x0UuoIiqIR6LWVXnMGThVH4YgOFz780IhECOWZ8+y8XWe2g3S5r9a70ntjd8Mw50O1gZWnVzGpMH6izaky22Md+tqZYPAcY74DwvJvR+bQcssziEZ+IXMWBdx6hJXHjsEJ+hiRFIj773dbAP7/IyUQmZwxupTAYxh44CPbuV/LYt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOug9L2PY1geTP5x0no1Joayj3ek0GwafW1LZSea/UE=;
 b=BIhLcvzcdl5n18w3qOi3MxF1h+imIR9EO88RDQk5h3D4atSC400ibs9Qz4mwfOG8DabgAjYPgXdwpbXFh14OTtJeh1onJ1JjRZQHICMJcXI2mbuRZw5/2hyTFwlISDKYDcSX2dum1GPhiW/HGdVxFIyyLsmuoyU5UvcWmT+d00k=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3524.namprd15.prod.outlook.com (2603:10b6:a03:1f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Tue, 20 Oct
 2020 17:07:22 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 17:07:22 +0000
Date:   Tue, 20 Oct 2020 10:07:17 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        <ltp@lists.linux.it>, Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Message-ID: <20201020170717.GA153102@carbon.DHCP.thefacebook.com>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook>
 <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
 <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
 <20201020162714.GC46039@blackbook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020162714.GC46039@blackbook>
X-Originating-IP: [2620:10d:c090:400::5:41b5]
X-ClientProxiedBy: MWHPR21CA0026.namprd21.prod.outlook.com
 (2603:10b6:300:129::12) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:41b5) by MWHPR21CA0026.namprd21.prod.outlook.com (2603:10b6:300:129::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.17 via Frontend Transport; Tue, 20 Oct 2020 17:07:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8d90ae6-0594-4f09-5aaf-08d8751a9be1
X-MS-TrafficTypeDiagnostic: BY5PR15MB3524:
X-Microsoft-Antispam-PRVS: <BY5PR15MB352457A2778CC98C41A2EB2EBE1F0@BY5PR15MB3524.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNLPcpAPVkFMCGfQRsoKg8Yex9X3lNGuOHgQsF18w86bNErwWImz+oAcjFp/9HE5eNDKK4TfHGjyBUD22RBFxogA+AP1Q7YzHA8DC7mgwz6kwt7M3C6pawHRDVrkmHAvk/GkHAKpb3kurQ9sgF8NWcU4xAnk3g6EnR+N0Si8mcatyYhRUQqWYukxVEiyFk8cqBVOW0sZI9ANbl0VWlXiR6vYZeDs4DINYTzzJzPsQUeGLdXJzafBKWLznkJOB64D6ZE9kOSbROxYy6DosBQvN4vU6blGc/Vh/h0HSrXQZyHx5XGBxXaDL/bFDll/UfNVM2sJ3O9wtFKVuFazNC2Bew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(346002)(376002)(39860400002)(83380400001)(66556008)(9686003)(186003)(8936002)(5660300002)(55016002)(478600001)(1076003)(7416002)(33656002)(16526019)(316002)(6506007)(6666004)(7696005)(4326008)(66946007)(8676002)(6916009)(86362001)(2906002)(52116002)(54906003)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: NnYZwT/pLRT8/pYXLaUacnr6AIgdG/Db7mi6us0NzEIx9sIJ6KGG4miOkpbr/V9nEC/tdJvUsT05MAkVH9CydgnDXcBKDYQ8rkWsOFC7aixyUMWIoR2u3QV5wiyv9HTrSNuzib3FWiQ+fx6JTGJ5XrAqRttUlIHD8GEB0JNdFl+UeP/9WrBDEcEpAJEr9mqFN/MYCrfV7uY+p30nCv6MuGqwcXUmyDC03Xhxh7oYuwwElzgw7fFs3YDCc3A+FcnI7xbqVysAl11WUPYOr0yRavl+lDDnxmAG9dbjUPdnzzpB5bh9POiTGRKjnO/qpZgrM9BfTdH+Xl2fpayhxEYLQhBLr6ArZgwLvB7l0ZAu9GnGqo8cXbX84WS84mntPNKNHk5VaT4a9jxrFgpXJoflyi9L3SWQgC+gBVUarBUv787lgWoxXpYHpYxS6lq6kmtI+cke3xYr0vXWpZIjjedyfVuFqCjZHhQH46OHjtIzyW2IDdWQIYxh0vRL7ZYVfSv45Md398STiixG19wC1XSEU2XOpm/k0wkzPhopZMHeoSwrQd8Ju/TuNOeJTJu/jOKXGMuj60mHoK7W/Hj5rrBEFcZWJZKku/skwe/JCgZ/ECvOmDERbPIzF21+eESuLR6oixXJIYwlLokTowmVfbS+RWWSIadN2YCIOMYhhV8hp0JAFVwyT+mnKLxRaNGO+X23
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d90ae6-0594-4f09-5aaf-08d8751a9be1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 17:07:21.9311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r47qdsfVyB1JlNSuJVQot2eUaesvl/GofIpjDVjiG4aYP+ZDHfRORhioZAkIH1vJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3524
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-20_10:2020-10-20,2020-10-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=1
 mlxlogscore=937 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010200116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 06:27:14PM +0200, Michal Koutny wrote:
> Hi.
> 
> On Mon, Oct 19, 2020 at 03:28:45PM -0700, Roman Gushchin <guro@fb.com> wrote:
> > Currently the root memory cgroup is never charged directly, but
> > if an ancestor cgroup is charged, the charge is propagated up to the
> s/ancestor/descendant/

Oops, will fix, thanks!

> 
> > The root memory cgroup doesn't show the charge to a user, neither it
> > does allow to set any limits/protections.
> An appealing claim, I'd like this to be true...
> 
> > Please, note, that cgroup v1 provides root level memory.usage_in_bytes.
> > However, it's not based on page counters (refer to mem_cgroup_usage()).
> ...and it almost is. But there are still exposed kmem and tcpmem counters.

Hm, I wonder what do they show given that we never set sk->sk_memcg
to the root_mem_cgroup (see mem_cgroup_sk_alloc()) and we never charge
the root_mem_cgroup for !slab kmem allocations (see __memcg_kmem_charge_page()).

So yeah, it's quite a mess now, and it looks like it has been broken
in multiple places and for a while.

If we want these counter to function properly, then we should go into the opposite
direction and remove the special handling of the root memory cgroup in many places.

> > To avoid multiple identical checks over the page counters
> > code, for_each_nonroot_ancestor() macro is introduced.
> If the assumptions behind this patch's idea were true, I think the
> implementation would be simpler by merely (not)connecting the root
> counters and keep the traversal as is.

We use some fields in root page counters to calculate protections:
see propagate_protected_usage().

Thanks!
