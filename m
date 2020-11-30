Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B342C8F46
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbgK3UfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:35:24 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1310 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726716AbgK3UfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:35:23 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AUKTPbI011809;
        Mon, 30 Nov 2020 12:34:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=hvj6zC7x5mtb7EOZyTmPS3MG87tZdainT97R3npIOGM=;
 b=m93ISIK3jCXNVHkZaWBWNuSE9zBqfWCIlJ4+TJdQ6ratPTgN0mDpU2xquYyrxJcdj19j
 nRPmUOat9ltcp0lTv5hs+rmT9tx1ZPVu2mcLhHNpvfI2RxX9Kz0rS2nyLfzdcrsXzYSi
 5M0o/fEQ739iFZMrJ/ojJNWSYNQW/UjkMFk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3542bnfupq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Nov 2020 12:34:34 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 30 Nov 2020 12:34:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSY07CN7XN6+5TlL4a1HLaFtmaltipjUPOODLboILflCSkM7GfZzr2PdESmg4E0GaEjONK0RhZ1rVfEmsh9aC1fDLefJrbyEg1+2saQZqKsSvmlxH4qmjOxurGI9auuqZzdXHNS15T/ra1/1aMf6bHY/UZmWCO5BKuKMvFfDWD2xsJlFfJok9y33T+jvI76Z/l3XCiFKNo+tHm3UQPi3C3046tfKj9Rin4h9lsXx7NUonFUH5SvfiASW3RaGZlUhjAiW8WzPCqFoanRcqFCB2SyHfSwWRi809EGmgNDEmwxK436OC74ELT8oT1YXEdkabnGiEhTQ1z9fPLWlpNqmWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvj6zC7x5mtb7EOZyTmPS3MG87tZdainT97R3npIOGM=;
 b=kV5IsxNeU5f7uIGWLqfGDV0M87mlv30qoqr6XhdIxbiS6EZfI07Gxtbty2AV09Ct+7W1m0/676dUsFOyIyEF6I0WVd5OpeNUSu7DGR4UwBdd97PLCl15JJqGMUJ4c+LRn3YiAgseI+3k6g+iYT8yejIhirNWzXofITkJ9+ME56g4ptP36mHYcJmrSGUWuJYNm0zKVZs8M9U+cJj4c7Q6EaaBE/wsmTKWQaFFoyKotBs/y8e19XTJuyeRQ/po5TKt5ukTah5uaxVB7UlqqoluvNJZseTr0/L7WKl9tr96mj9gbOIj8rfUF9WjF2Rjs/VQjfh+Aim5SIFJX/9TLP8YSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvj6zC7x5mtb7EOZyTmPS3MG87tZdainT97R3npIOGM=;
 b=JJOg2IYSsB5gBtGmkcKRt/qZZ0ELmaJKrfeSCbCMY/bd0EhzADUqYdYHZyzY3IRl3OzcPEUd8hl8m0dI7aZPkY2fbE2MzRWL4qmB45hnP12GcseyIWtq3IczYS1axw9j1UCyyXHmq+RuU5vQzEJIVBN6Ri0UR+NNlQNin++uJcQ=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2599.namprd15.prod.outlook.com (2603:10b6:a03:15a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 20:34:30 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 20:34:30 +0000
Date:   Mon, 30 Nov 2020 12:34:25 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] memcg: add pagetable comsumption to memory.stat
Message-ID: <20201130203425.GA1360286@carbon.DHCP.thefacebook.com>
References: <20201126005603.1293012-1-shakeelb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126005603.1293012-1-shakeelb@google.com>
X-Originating-IP: [2620:10d:c090:400::5:1c7a]
X-ClientProxiedBy: CO2PR04CA0138.namprd04.prod.outlook.com (2603:10b6:104::16)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:1c7a) by CO2PR04CA0138.namprd04.prod.outlook.com (2603:10b6:104::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend Transport; Mon, 30 Nov 2020 20:34:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02b8d0ea-8fae-4ce9-5f74-08d8956f562c
X-MS-TrafficTypeDiagnostic: BYAPR15MB2599:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2599B728A326ED2B514BDDC9BEF50@BYAPR15MB2599.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mn5a6uRZ+sYCFvBoCnOt5EEi0mECjAYslFtIZbsHa5qoKzyoXEJoT4y6wNC0KW3slekjlyrspv68+tNuTPODlOD0PTWbwl6zlbpInq7ezFyrcZpRC++I/XkOomLVNapFcTCJRA5mt84Btj3GwsUfYHhHETQZVh0iH4KADcT3EfVW0RM9P/BNaASWWZ2zbhr75xtppJ+G5rSNTm3PTCVtKaIUI7hNZy7zSFruMYEMrKUgjU7knbSMTU9fYXOZVk3EuR0TuZq5WG88aqImJSzYEjqq/8jsqjcnezNJEOqCwtgxsFdfVrKZ3vfcymZB88tCgH1UifxBl4+QFvfSj9M13Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(136003)(346002)(376002)(316002)(54906003)(66476007)(478600001)(16526019)(66556008)(5660300002)(66946007)(186003)(4326008)(52116002)(9686003)(8676002)(7696005)(8936002)(33656002)(1076003)(6916009)(55016002)(86362001)(2906002)(6666004)(83380400001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xCw+HC7DGco47n+d2eAZmcjR7S2Vzi33A2QE1mveCd3FGU2eDwPlATpR+ogT?=
 =?us-ascii?Q?JN1sScGyj8f9Vu8lJyTslaKXNMddKqxpi3WV9LgwiOOcB/c68Om2CZlqBrSi?=
 =?us-ascii?Q?Qqsssv5hhpKTMJLShVtiIyBXF2RAHLE96zF4JfhkTmVha/elJ08IH+Rx/NEW?=
 =?us-ascii?Q?54ifVu5xU7B5qBYLjZic1mvANrG/cK7rb74MUUhFRR8PAt/5CsTsClc9Wbut?=
 =?us-ascii?Q?zSVsPrjL/bUc6rxPN+Qe37O5ttmA3vzmv/jndmtA3Wj6OfOW1Zs4JjWrwje0?=
 =?us-ascii?Q?sPknd1MBTJIQDaRWJ7utdGKduc9xCJGCUbfkUPLa3lkartDzXnfYixsHilb3?=
 =?us-ascii?Q?1oRT87UiYARYdZn2FPlUDptAj1c78fZbAcSBVXKGMxGACSHGKOfsgowcjZ0L?=
 =?us-ascii?Q?Qm6pWMtqOJWxL2vo9/ufAoQoUD5pB9dQT599paC1Nng9S3I12TCb/cTySZCw?=
 =?us-ascii?Q?EKZ9wDu3ElDf2sLR19stIgN0xuVoY7LYI5GKk9u7qfCWZgBB1B3gUXBg1Mdi?=
 =?us-ascii?Q?PIhs/T05958R7U/WtsWVMM1GdUxiZksotaG0t9L/7mXcXsPUmMJg0RW25L8N?=
 =?us-ascii?Q?f59pae18rT+Y+XXKlJ2rKMy3zkJd5WosBAnEIzG/EsaevS3U8+ARXe2/kkAc?=
 =?us-ascii?Q?ZlTq6smWcKhK+1zDaboiKfrjZkakCHoVw6Wgks7WvK69HkdTSpXM4uOBjAfp?=
 =?us-ascii?Q?S6okmAkdhf39IcsBY38Ni2nMWLQNxqdD5sQKzDU1qjZMUeRPQXXpUzZc9vB6?=
 =?us-ascii?Q?//IL4zYkU5jegBFCi4dxgS759+YvYqpP7zzuVD82Vvj0xmDX7ibm3aFoh6O6?=
 =?us-ascii?Q?j2Sg/LLbGOVLSkm+fx6cNiOHjy5QENKSta2AsKRD3vihCtQe7vd/3/nauslq?=
 =?us-ascii?Q?TEIZ2vdphvvHak6dTsrv+qMK5BMOeAus4sP19071R0waBm/ldzdBecMt23Hi?=
 =?us-ascii?Q?qFCM7goG6bDQky/taLqqctfpv8P9qgnHZZtuuwHq5kL22epY5E3nUY6FwGS7?=
 =?us-ascii?Q?N2Jc+duPQlN88F9TkNVebSaAvA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b8d0ea-8fae-4ce9-5f74-08d8956f562c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 20:34:30.1277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKEM5LKLRHlHdCCqibIQKB0yj5MihO4QHLxvkTTZuG7J6I5EUCgSPzpSFt5gR6DR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2599
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_11:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=990 malwarescore=0 suspectscore=1
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 04:56:01PM -0800, Shakeel Butt wrote:
> Many workloads consumes significant amount of memory in pagetables. This
> patch series exposes the pagetable comsumption for each memory cgroup.

Hi Shakeel!

The code looks good to me. However I'm not sure I understand what's the
use case for the new statistics? Can you, please, elaborate a bit more here?

From a very first glance, the size of pagetables should be _roughly_ equal
to the size_of(pte)/PAGE_SIZE*(size of a cgroup) and should not exceed 1%
of the cgroup size. So for all but very large cgroups the value will be
in the noise of per-cpu counters. Perhaps I'm missing some important cases?

Thanks!

> 
> Shakeel Butt (2):
>   mm: move lruvec stats update functions to vmstat.h
>   mm: memcontrol: account pagetables per node
> 
>  Documentation/admin-guide/cgroup-v2.rst |   3 +
>  arch/nds32/mm/mm-nds32.c                |   6 +-
>  drivers/base/node.c                     |   2 +-
>  fs/proc/meminfo.c                       |   2 +-
>  include/linux/memcontrol.h              | 112 ------------------------
>  include/linux/mm.h                      |  11 ++-
>  include/linux/mmzone.h                  |   2 +-
>  include/linux/vmstat.h                  | 104 ++++++++++++++++++++++
>  mm/memcontrol.c                         |  19 ++++
>  mm/page_alloc.c                         |   6 +-
>  10 files changed, 142 insertions(+), 125 deletions(-)
> 
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
