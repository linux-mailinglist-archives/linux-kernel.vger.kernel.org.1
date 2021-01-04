Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834DB2E9CD4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 19:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbhADSKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 13:10:41 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11256 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727786AbhADSKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 13:10:40 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 104I1CK4015268;
        Mon, 4 Jan 2021 10:09:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=mh6I+OzRHH337fPqDCtOLNMYlHN0zBNq1bYamUFm8JU=;
 b=pmF1HmErgEIr6o6Njkgg0aOob9Zid2t8SQPN0PmpTYWKSjDmV2vvsEae9V5GvTZCVaK1
 CbmiSfNnJNTuBYPP1hNLg9doAt0Dh11vAZ5kIpWC1G+uAs84KQaxI042za6MSKk84BNP
 epWjqGrfU7BxemxDUGkYUGzIzk3UCY+TiPI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35u9ydmyab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 04 Jan 2021 10:09:43 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 4 Jan 2021 10:09:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D90WB5jhtGPmyw56QhCQhkea2AG+ypj3CcGuLGnvM1rYKT4A47Bs4ePwPmCr412zQ7BUdgcN5nZVJ2/380yIihFwEX53Bb36Xnzaqwazr3Gw4y+rgY+l+M7ITcwBNHpNnIYhtwLX1xCaMZ2XzWnF91BZmhaeP45bWkYSW4BDeSJyjfuzg4rFJxwIySu5af6Bwu05nMEPhdLAJN3/3XyZjXzn+/WQzZCYGeefuwvbqhesmxehQuTTY9PuMGR/VECMhhhGvVtf+7s5ZJ7WpGoY58ImXrgf39a232M/ryKSbNyAYn4XA6/8p2wHCp/rZlt8ZyakYKKxQYfRrVXrET+LrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mh6I+OzRHH337fPqDCtOLNMYlHN0zBNq1bYamUFm8JU=;
 b=YefuS+FFYMrHXid+zyptCu5btIlesvPVkf5u4kwiIm/sitstj0YEzIt8+OtmmEDNNSoP/0uH3oGHZyRdvCvW1ACg6x6bOj/yvcPa2G4rqSRpRoPt59DqLiIt+MHft61fywEPnlDUjTChJ0kmuVQMovnQQDaVLcby7GVrjZjxoYFSUSy165R70F7xlapOWjUwj7X8+k51P/2txwoSRrXw5nd09tboPoXYGN67zzMEdB6zil4xPYyvLf+UlUreFyvdj+uz40Rc/meyP29YM6s1IGlUSoT/0BFNhQHcH445XdOM/VkKI6ZsLWuhJVJxK6HxEDoitvM50jPc42J0j4ngeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mh6I+OzRHH337fPqDCtOLNMYlHN0zBNq1bYamUFm8JU=;
 b=Hb4QT6TtzXaZ6I6UYuX+17+puR9eo5XlEGw0GbR/Dpkcmukg96Is57O2BPbDO+IOcvYZC+70rE2VXNnYwbU4EAZS+BGKoIoi7yR3CLAqQoXxO+wflD36ch58t2TlLxceC4iLg3VERWYsiC+9eEoQPFWeCkncTlKYhFEfZaOjQA4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3159.namprd15.prod.outlook.com (2603:10b6:a03:101::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Mon, 4 Jan
 2021 18:09:41 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c%6]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 18:09:41 +0000
Date:   Mon, 4 Jan 2021 10:09:35 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Hui Su <sh_def@163.com>, Alex Shi <alex.shi@linux.alibaba.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/memcontrol: fix warning in mem_cgroup_page_lruvec()
Message-ID: <20210104180935.GC371241@carbon.dhcp.thefacebook.com>
References: <alpine.LSU.2.11.2101032107230.1158@eggly.anvils>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2101032107230.1158@eggly.anvils>
X-Originating-IP: [2620:10d:c090:400::5:5daa]
X-ClientProxiedBy: MWHPR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:300:6c::11) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:5daa) by MWHPR04CA0049.namprd04.prod.outlook.com (2603:10b6:300:6c::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend Transport; Mon, 4 Jan 2021 18:09:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e7d2260-6a39-4960-c56c-08d8b0dbe862
X-MS-TrafficTypeDiagnostic: BYAPR15MB3159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB315937C56738D08A509FB676BED20@BYAPR15MB3159.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMF91Wa/wPa1+Z629HTdjo201M/l2HI8y39Px7M1a4Z+CzpK1inonHASm3PmriiYvc9o5EsnTIy5edK+fNoL18JbcbgRd+1sCHLESPyyRpeXQ8NoVm3NG1sLgd64G81lyQ37Mv/Wz9N87TmVjoY0cTVPF8cXcL7ENWUCGwtSyo38c/IgrojvwcoFtICdVSegW2nv0CVaZeL+8Y1Cs36i61ijyizhALVZTpFdRhLJHRxB2Fz7mDu/nyD0Ua8OhInMF4/7q4Tu8ngSZwpHbTAm1meFZMkhsDRN2rOauLAqcOdw9XkHYksJZ2htuuYeCgIECI7DhzXR9K+0jAU4gvTa3i7KJ+0DuJKMJP9nunILilBHJVDNZG2xMTJtUCsiTh41wIRB++7Mz7TW7lq1kI0AZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(366004)(346002)(136003)(54906003)(4001150100001)(7696005)(52116002)(5660300002)(316002)(4326008)(8936002)(478600001)(33656002)(55016002)(6506007)(6916009)(1076003)(9686003)(83380400001)(186003)(16526019)(66476007)(66556008)(66946007)(8676002)(2906002)(6666004)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qC9vJHKZr5RK6eUftBrpY418D66knCsRPOlZRG7l8d+wj5Lq7DEgM/8UtBZr?=
 =?us-ascii?Q?6HR6cjagB7/axEt3NnjazJIx0GU2dtrLntKCVIaZCAg4sDcm8LX/NP+iYdcC?=
 =?us-ascii?Q?KqiusFzPgA6FCFwjZjgBQKXquHE+zb3/C94qs6QADVueybW+ylWaNAP2JhWt?=
 =?us-ascii?Q?iR0nt89IEq1S/dado2HhYNpaivKgtCF9jfP3FV2y6AnKG2Wi1YhOOJII/2pK?=
 =?us-ascii?Q?wn9fZpSHEMF0JFxkNssoP8ZuxJAhGAM+vmE6YakuOeGtgXEm4GaPI/Yr//6S?=
 =?us-ascii?Q?+CCwVancOL5r88PZdiG+lbJ35aRLSycKg65NUqhsioUCeFzvLVxY/g+g1VOJ?=
 =?us-ascii?Q?MCzUYb10m8WYb4c+Abqn8v0eEZPcgKTYU0ZM7VuXAJTTOLNB8z78Iwyyxdj5?=
 =?us-ascii?Q?n1R+T6AQq80f6jHPFydc9tsfZavUzcqOizd6hNzZgt06gTFvcw9izQ/jGWXy?=
 =?us-ascii?Q?Em5BXt4z2WZ1o84N6qAd5q40QUs4EmDVORkvOeDfd7NLcFwZ3gTDhnkpwhaB?=
 =?us-ascii?Q?wNm44LmGYmIA7jahyEC7HXsI6Ovm+pWA/jn6GgE7BnsHBbCxNA2Tc0uGts8m?=
 =?us-ascii?Q?tZri8+4+vtGJ6RNJB7vdE47Db1EIBNK8IFggyi2Sou9nslyzr+Heeq10aGlS?=
 =?us-ascii?Q?IFnK813DazX6ayZI2vgdVCiZf8OA7GZuwTnb5LV2sl7r/Lj9Vhp0VxV3jmlY?=
 =?us-ascii?Q?Z8de52VD2FSB+Bu2KTCx8Xfg4PEwk48ZoHLblgK9aDfQ8x7EgAjbfwfs5vz+?=
 =?us-ascii?Q?BNs1TD1IJq1lVymCfoYf8bs2hfqvN3XD6ZXeg6fa8vvbFpX3MI7DGdfVXOoy?=
 =?us-ascii?Q?l1nfHOGnkMb+Px4VGJVHZZH/hYitRqK02BF8VWZwO5Xy/T9jOJgCQwn5y4g0?=
 =?us-ascii?Q?JtPpX5g+iAaIV/QxUxbG2lDJgFzjZwErQ4ngm2E3hO1jK58g9ebV2dQSifBD?=
 =?us-ascii?Q?AlUUbGWbTumzARBDV/hhoUE1sQzVIeVqvPtb/Q69tsIWL3tWylGmF8MFlvDp?=
 =?us-ascii?Q?hZkbL4y/TWwtV0SZZj+txlPd0Q=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2021 18:09:41.5169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7d2260-6a39-4960-c56c-08d8b0dbe862
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBX4KJUmVk1FjqSdar96d4KW1PokUstgDsgL5EA089KjO0GLfYwgsTllQcWS8gG5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3159
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-04_11:2021-01-04,2021-01-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 mlxlogscore=584 clxscore=1011
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101040118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Boot a CONFIG_MEMCG=y kernel with "cgroup_disabled=memory" and you are
> met by a series of warnings from the VM_WARN_ON_ONCE_PAGE(!memcg, page)
> recently added to the inline mem_cgroup_page_lruvec().
> 
> An earlier attempt to place that warning, in mem_cgroup_lruvec(), had
> been careful to do so after weeding out the mem_cgroup_disabled() case;
> but was itself invalid because of the mem_cgroup_lruvec(NULL, pgdat) in
> clear_pgdat_congested() and age_active_anon().
> 
> Warning in mem_cgroup_page_lruvec() was once useful in detecting a KSM
> charge bug, so may be worth keeping: but skip if mem_cgroup_disabled().
> 
> Fixes: 9a1ac2288cf1 ("mm/memcontrol:rewrite mem_cgroup_page_lruvec()")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
> 
>  include/linux/memcontrol.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 5.11-rc2/include/linux/memcontrol.h	2020-12-27 20:39:36.751923135 -0800
> +++ linux/include/linux/memcontrol.h	2021-01-03 19:38:24.822978559 -0800
> @@ -665,7 +665,7 @@ static inline struct lruvec *mem_cgroup_
>  {
>  	struct mem_cgroup *memcg = page_memcg(page);
>  
> -	VM_WARN_ON_ONCE_PAGE(!memcg, page);
> +	VM_WARN_ON_ONCE_PAGE(!memcg && !mem_cgroup_disabled(), page);
>  	return mem_cgroup_lruvec(memcg, pgdat);
>  }
>  
