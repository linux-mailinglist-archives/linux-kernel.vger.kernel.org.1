Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA81280BCA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 02:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbgJBA4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 20:56:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17390 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733275AbgJBA4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 20:56:32 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0920oG6T025221;
        Thu, 1 Oct 2020 17:56:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=FNU5CxVpO+oMvi1i5oJLUpw0R8r9z64qhitpk1exnN8=;
 b=qpG+GRKaXxgK29caHD/7tgevyOlJBhJNy4IfiBmrvGYYxR5AniRxBN8JaPXlKTV8WSo1
 a1y0x0wqw7PKRzjPtfhvWm7decxvI9BRvs2CmgElSo5CQAyjflk/94p6Gon1lvkBL9lt
 JrAXks8JMpni3mq5hUCHuL2B6yrAWYn5wfY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 33w01t7q4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 01 Oct 2020 17:56:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 17:56:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhM/Cw2XE+0Zne82nDw6EUKfYswEMSzTt55yf0mAOPo4O272bUZ27da9Knu7AecItoiD01ipXSNo9hJxcRasw2ZwU5gemf7X3FV7uYvUA6IcVzhRstRJzwlM1Ef5PL6cuoltnYLQqsA6SFmcWgtJ55o36sDaN8meyhbqsSDSFDbbDtHCo6BZCGaWz0Ylel+pslhRrjCekSkM9ASF1yeP0cdFS+fHz2HQ3WZ5/uAkqvYTaacqR9gs0Cjy54o39cfrn3f4h+Uq+JE3/TIZruWhFGHHRs8w7pkrAgNQDOdgo4nw5FP8/Tt2Lhrgi7mwo8KdxMFSQqmCuMnHgcvg3dIV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNU5CxVpO+oMvi1i5oJLUpw0R8r9z64qhitpk1exnN8=;
 b=hFlXMk0/5Awo+hP/PNcgn98sQ3nZQYiCsIOzLErBERSp90GcIPFni7mN0OR7SuaQuMZ9BllI7htGnEdlN6wRIghsHpshmxy1/3NjNTrCR6kwLp1F13Y3/yCUbBZ/5YTnnqjRSHUS+NJWszYtO9S2jdmOtFOpu1SWh2XQyZq1bxaUcKEOPuvIlPQDhssXhmjbn+SutkR75iBgN9FS4BhUxz54kzpDnvNvsuxQXddGBb1WEepnA6Z3W+o1mt8PWrHp/AGNcVctDHASAijOIupBld1BKG7UCNSG1Wo/FeHH4Y6vd9i0f/Hx3Vnhrago/VtgKdz6ZUaJRC9nB7qjdV9XQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNU5CxVpO+oMvi1i5oJLUpw0R8r9z64qhitpk1exnN8=;
 b=Ie2KkeGnNAJuQANaMxX7dlRkO6obf43Nsi1qp66GRtiYZLrpP8pjxjIQ6o/UGlKKNXg9E0zgG0Imrb9xH9FU/nzFJ+gkACLxEfzLdxyFbr7MBwx5/0Cckb0NDa9j08j3E3oid8vl/Yicnx141men3HXUVPr8Q9KoXHsOJGGg4RQ=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SN6PR15MB2351.namprd15.prod.outlook.com
 (2603:10b6:805:19::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Fri, 2 Oct
 2020 00:56:04 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a%7]) with mapi id 15.20.3433.032; Fri, 2 Oct 2020
 00:56:04 +0000
Date:   Thu, 1 Oct 2020 17:55:59 -0700
From:   Roman Gushchin <guro@fb.com>
To:     kernel test robot <lkp@intel.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        <kbuild-all@lists.01.org>, LKML <linux-kernel@vger.kernel.org>,
        Bastian Bittorf <bb@npl.de>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] mm: memcg/slab: fix slab statistics in !SMP configuration
Message-ID: <20201002005559.GF2706729@carbon.DHCP.thefacebook.com>
References: <20201001203931.GD2706729@carbon.DHCP.thefacebook.com>
 <202010020814.M5nb692Y-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010020814.M5nb692Y-lkp@intel.com>
X-Originating-IP: [2620:10d:c090:400::5:78e0]
X-ClientProxiedBy: MWHPR17CA0060.namprd17.prod.outlook.com
 (2603:10b6:300:93::22) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:78e0) by MWHPR17CA0060.namprd17.prod.outlook.com (2603:10b6:300:93::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Fri, 2 Oct 2020 00:56:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af7b3e9c-27d5-41b4-9d22-08d8666df075
X-MS-TrafficTypeDiagnostic: SN6PR15MB2351:
X-Microsoft-Antispam-PRVS: <SN6PR15MB235131C66227345FA396F4BABE310@SN6PR15MB2351.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U765WMXDHZpz+szd4awTFxO/MHV/qc3LSYGpEOcbBx/QG1CwhOK+EQaM2av3jAHTHsF+EKdQZEWqOKqY96YtyReiPIUdfuFyW0CZ3GBtW4vf6h9M2Hsop4miL3kE4N10ylpd4vg23c4/mrjZrjaN5eP+N32W5nXfwLGRMILDyLYBAZ9J0UvIgeKHvJmA+CzKIJ/nj0rk8ERWz/8mWgWaUr+Qs0BHRd6STNw+AjV1XHcicpK/qWb8MUC/u7Yk2OHirJyc+o56BjWvecs4rAEyki3TepZ2N9A/UXh33ck0fOLxGNdS8nKKVcgiwS5zqVqmEUxCbUYAplAa6b9mfUSYqQgEOniiASdpDRRjHYOcFqnEexv4VvQW6+kOs26h0Dj3Kd5w34qcAH5yxsXSZvE2sQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(376002)(396003)(39860400002)(86362001)(66556008)(186003)(4326008)(55016002)(6506007)(66476007)(16526019)(8676002)(7696005)(52116002)(83380400001)(6666004)(5660300002)(66946007)(33656002)(8936002)(1076003)(966005)(54906003)(6916009)(83080400001)(2906002)(478600001)(316002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Dh34N8LiU66CyreMvSZlVwkgQmMyOYtWpRK59QbNer/4nUt9jfXGg5GJ8xw0Izgfaztwun7GzA5cNov0fckA4aEuOP5ztKl5j7nIxY0+Hda5OrHjrwjeFkcTgoREfzqRaluCRTKdAs74EVveXS3Ap/RnHgO7p1qZ/BJu8GNKxGrR5CPeZnBMfY0pp3OHX/4yfU+XOctC6/dFG3ARP2otjHiRGe8Q38sIUsTOX8L1KyKiIwE90GSSGH3gyGkF76RitOEO8W0oPQbBfOmYQQA3BtS8wODYqU07HdBstw3xS1DNmAC3TgvUTdzyysU67KwbBCJ2udsJq0ZjCjXsA8v+htaPcH9kNzOORIxiyxvryHJgEFZA3civBRljtRAQsZKjCctSUIE9qYRi4q5fWyNg8l1ARDiZMDuCnbRh2KnfDFLuekV1wK8kCZ4x8IUTdBnX4j2s7zivpZfdQkKf/n/0afac+sok50/aRBr3WNRNwdA3GDrgqHIn8EcQuZj1zQQcZYT4nXoVyvCj4PHuePWD/hChnffXZ+P5g4OSRITeeZ6NUxgxRry0ziuLJZ697ArSii7JWDRq1PAuYse+jLkeY2M/Csex2MLRCDPq7VbTa3tQb7bRhHeKqd45vde3XWqlYlkmwodh7kpOpT2SAZD15ELImaXoDKAygG5gL968Ihs=
X-MS-Exchange-CrossTenant-Network-Message-Id: af7b3e9c-27d5-41b4-9d22-08d8666df075
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 00:56:04.7721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VcIxb3NvXZZ+edAEfL21UeNlrmOGewVxf6N9jt75ZEnPOjrasSR0IXZ4t2ruDipU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2351
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_10:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020002
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 08:08:40AM +0800, kbuild test robot wrote:
> Hi Roman,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on mmotm/master]

It's a bogus error, the patch was applied onto mmotm/master, which doesn't
contain necessary slab controller patches.

Thanks!

> 
> url:    https://github.com/0day-ci/linux/commits/Roman-Gushchin/mm-memcg-slab-fix-slab-statistics-in-SMP-configuration/20201002-044114
> base:   git://git.cmpxchg.org/linux-mmotm.git master
> config: i386-randconfig-s002-20200930 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.2-201-g24bdaac6-dirty
>         # https://github.com/0day-ci/linux/commit/3e4248734433fea1624e4971258042af2f231e02
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Roman-Gushchin/mm-memcg-slab-fix-slab-statistics-in-SMP-configuration/20201002-044114
>         git checkout 3e4248734433fea1624e4971258042af2f231e02
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/mm.h:1317,
>                     from include/linux/memcontrol.h:20,
>                     from include/linux/swap.h:9,
>                     from include/linux/suspend.h:5,
>                     from arch/x86/kernel/asm-offsets.c:13:
>    include/linux/vmstat.h: In function '__mod_node_page_state':
> >> include/linux/vmstat.h:295:6: error: implicit declaration of function 'vmstat_item_in_bytes' [-Werror=implicit-function-declaration]
>      295 |  if (vmstat_item_in_bytes(item)) {
>          |      ^~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
>    make[2]: *** [scripts/Makefile.build:99: arch/x86/kernel/asm-offsets.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [Makefile:1139: prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:179: sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
> 
> vim +/vmstat_item_in_bytes +295 include/linux/vmstat.h
> 
>    291	
>    292	static inline void __mod_node_page_state(struct pglist_data *pgdat,
>    293				enum node_stat_item item, int delta)
>    294	{
>  > 295		if (vmstat_item_in_bytes(item)) {
>    296			VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
>    297			delta >>= PAGE_SHIFT;
>    298		}
>    299	
>    300		node_page_state_add(delta, pgdat, item);
>    301	}
>    302	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.01.org_hyperkitty_list_kbuild-2Dall-40lists.01.org&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=a91mqnAqjcA0iLpnhkpBXCmVqE_BuOIny-YmkB8jp2U&s=4EiiISKLS8YORtIb2rqP7oxVeqhBmKzMHqJzWhDAuMw&e= 


