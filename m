Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F7D2E7276
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 17:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgL2Q5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 11:57:40 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44464 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726114AbgL2Q5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 11:57:39 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 0BTGsvNS020537;
        Tue, 29 Dec 2020 08:56:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=k681P6ClbPZeY/wfNU1C3/hQCx10ELjweru58B57CDM=;
 b=iS5UYhNwysPg/q1NtC4DUvsuYMQcDcUYQZR900ci/mYhQ+zZ5+nYMWyiwflI6f8XvuAs
 V/0xtAmvOtcNthMpyobs5rKEEqq4uin9NfZSGDdR/Ugx5ToeA6Ghu9adAnEGrzca6I4H
 iMxmFV9KxnjkEqCe6CFUE3AUFt53cQRKJ/g= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 35p1j62h0s-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 29 Dec 2020 08:56:51 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Dec 2020 08:56:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/87rbx3jZozXHJvwJeTGCS3IOz+QmI0lDcuzcJtBKWNF34JYuzjYt1pFeLcgE/jIwxQ8/QWjeHwkM9qUI8di1lWoaZ2/oXxGqYMn1ZQAoG+8mOKGr8ew1LE+pxtRZdzkdONXA3znqMUPAue2Cqpuw92xzxdCLjAWTxRML75h0uOk6qXdIqiF6wxO+JbFjXrmNRJ8Jyys2LgtNGxfc+iWUkHFFg4adIvay1wOJHAOCxJkTQLHEmEYnvGv1OSEOQyAafU8B0Y4g+i4dvw/YM0Bp+MJJsAOKxgGnqa8JiMXrHV9ZNb29C0hr7gyZfCApPZukQD1Kg/L26II4sFN1VZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k681P6ClbPZeY/wfNU1C3/hQCx10ELjweru58B57CDM=;
 b=e0J99nJK/6Ez7L/7CWKxI/wrT94eVjTkPB66tUAMrIpS9+HfVlfWPfje0RybydOdEvQoNaFcc2WDtYSzEt4snevE9qD9CEw9YvTHeZ0gOFpGN1AMJUq/fxh/mY0zHP62X5AqLhOUYVTmcaRUBHvjpL9S8iwd831Jb16GRUGfXpZrG7pSkVz3B99dU0oWkBov6x8Ym6hkib019aL8IqACU+rTtUsEqb1tqNT2E5+jlyzi+ZcowfcfrIJSp3D775O5EODJqMP9a4cvmkwjaGYOJR3Cj1nIaX/jEa+iTMisaIE3dlRi/BSp8IkfGVst/F6+6yefQWR51ScdcKiB6rHoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k681P6ClbPZeY/wfNU1C3/hQCx10ELjweru58B57CDM=;
 b=dKKQtlssG128y2TIzqZFELY4uFvT9+KyayHxrJH7vx0iKMUhNdw1VDR8/M3HyOFUDoqMYiHNc42pOkKb3kXp3tHwYgCk+Yd/4vd7UWYTBRn3L9ivQQcyNf8UbqfX+JnibanNURUwme3hByNl2j3RsfpJv2/d5AKTimfpCZia2OY=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4155.namprd15.prod.outlook.com (2603:10b6:a03:2ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Tue, 29 Dec
 2020 16:56:47 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::ed8c:29c3:6ebf:3e66]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::ed8c:29c3:6ebf:3e66%5]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 16:56:47 +0000
Date:   Tue, 29 Dec 2020 08:56:42 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Feng Tang <feng.tang@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <andi.kleen@intel.com>, <tim.c.chen@intel.com>,
        <dave.hansen@intel.com>, <ying.huang@intel.com>
Subject: Re: [PATCH 1/2] mm: page_counter: relayout structure to reduce false
 sharing
Message-ID: <20201229165642.GA371241@carbon.dhcp.thefacebook.com>
References: <1609252514-27795-1-git-send-email-feng.tang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609252514-27795-1-git-send-email-feng.tang@intel.com>
X-Originating-IP: [2620:10d:c090:400::5:8832]
X-ClientProxiedBy: MW2PR16CA0048.namprd16.prod.outlook.com
 (2603:10b6:907:1::25) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:8832) by MW2PR16CA0048.namprd16.prod.outlook.com (2603:10b6:907:1::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Tue, 29 Dec 2020 16:56:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d57cd671-dd0f-4842-6bc2-08d8ac1aba8b
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4155:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB41552C2CBF3416A3105FD747BED80@SJ0PR15MB4155.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VO50K1VngBPjkrWrodUg6P8I9hkKEIHTcHPeNxXq3ABgWsPL4lC/AV+gHpDk8Eac7d6E+DWat2v+nxJcGZTsemcrACyBTZCVb9N+ta1rlXpbLEKiH3g6YZwfbZDwJqzAVV9zhsHZhrv63s+dALGNXzFId80Kf5jFwimJg5KFKhf6HFf8c5jPCAFXw74UYZIXY6bwsxwfTlLPC5HgsaLrLWJn1vchiVHRrpVYDmvPFqx8HiInFgguKD87bszDt2gkRTc1q3IzheGj7zxAvNicZuE47LFUchX5Z1oiRNqk+CkDHmdf1BkjsWXmcQTY8erdmy6EtxsZzErNK/j5DnvD5jKIPfbgXTdBMhyyidcuTZCrzGjYAmTHXJyLV975vUFh4TFuROiKQxECeLvMbXLea6dmvpRTY0bE1Iau3UjRwCViD+BkqzRoqgyu1dxNRBkIulGLQTDF1fsTIaAGV5BFfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(396003)(39860400002)(346002)(6916009)(6506007)(7416002)(478600001)(54906003)(7696005)(8936002)(66556008)(66476007)(8676002)(66946007)(4326008)(52116002)(16526019)(55016002)(86362001)(83380400001)(6666004)(2906002)(186003)(316002)(1076003)(9686003)(33656002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eLfsp3aYuc4Iz2HDnRcXZ/GMUP/Ae0t2KI8OP3Da/qbbCKZG476ZDu6DBSDi?=
 =?us-ascii?Q?UVs0Ljn3MaiP5S/p2qlgchS2SW5D3YjnWDJXdR906vHSqiuQ8Ph320paqkav?=
 =?us-ascii?Q?BEC3hPI1ox+nbBYsiA8vnessYKotYX8Ksf/0CiNDU3voZXWJrH5CqcMmwqC8?=
 =?us-ascii?Q?AsH18//qwb1ghD1T+jMS7J032nvmRlkkT4dTLHIPS0jWb3Kqzwad2heTTIuB?=
 =?us-ascii?Q?/sYRKVxv0VoG71zkihTFyxpSp7vkjvBhtpr2g5AWTc/slNqXAW2lxyuqsu44?=
 =?us-ascii?Q?VOhB4pK58uggCNcWzkDqTovYMcS2h5H40FNukCxDewsmKaOL0t4JnYFiUXoH?=
 =?us-ascii?Q?/zqOmKXG16QclqdDRGysXutU+MJ/lciDEXHQoU0zWDXDiSR5Gdaxc0dwovT0?=
 =?us-ascii?Q?JaqYzqEW/+ZqNlyjEmBeu0Rj0Ygf+/ZItzJBw025gsJ78AeX6eCvhQSVyzpb?=
 =?us-ascii?Q?RrwjY2wuLa8ifCeKhlKUo7h3HO0jlooZ+308WDHmTvFAebtMIxpMWlDFop9N?=
 =?us-ascii?Q?VpZUvxYhCWeh8Y5xPfBNHlCBxpL9x4RUYLkWkUv7nCXxLA5B0gqULDd+lZ1j?=
 =?us-ascii?Q?Y5GmvaPa5k7uxepo2Gh+RyoicqtHINyLMyDyTJ43u102H+roeBteJi3indA2?=
 =?us-ascii?Q?8rSyHgetIxKEGQbcLgI3Vil52JFnhuDRuObXlBnnzAZ8IfUVmdg8XtGsAHYG?=
 =?us-ascii?Q?/gE4ynizS15oJSq6fzowXwwLJHcOroOc1H8Xqad/0xEYC/BSk7ZDEXYLTOWg?=
 =?us-ascii?Q?PHujco6jzwz/nSz5TlLNgEx3MZYBkkZGn7mZeTlJ8+Uapsio+MjhlV3DZLSi?=
 =?us-ascii?Q?AHU1OoHFp15PvTP4TuYquyc8bnzicilj6uhSujliF0uBm1usArdKL28E/z5v?=
 =?us-ascii?Q?EAyip2f5T1DAAC8kzbJsbHknOV9B029ufpzOlKTXiOhGYv9lTPkxRmAnhAVA?=
 =?us-ascii?Q?iqqMuqjKpDfp0XgcKypLD/BzLmK1fNRQTqTkIzTVoQe2pLvUxUgJZwAfYKsB?=
 =?us-ascii?Q?YFbD2FKZZWvKNF58IJzcLNMHWA=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2020 16:56:47.1002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: d57cd671-dd0f-4842-6bc2-08d8ac1aba8b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLjpHSMehhqBkFu3vzAYRC/HGdsvkV58QPEdbbkz/WOEJ7kLoJxu/zPw6/f5AImv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4155
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-29_13:2020-12-28,2020-12-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012290107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 10:35:13PM +0800, Feng Tang wrote:
> When checking a memory cgroup related performance regression [1],
> from the perf c2c profiling data, we found high false sharing for
> accessing 'usage' and 'parent'.
> 
> On 64 bit system, the 'usage' and 'parent' are close to each other,
> and easy to be in one cacheline (for cacheline size == 64+ B). 'usage'
> is usally written, while 'parent' is usually read as the cgroup's
> hierarchical counting nature.
> 
> So move the 'parent' to the end of the structure to make sure they
> are in different cache lines.
> 
> Following are some performance data with the patch, against
> v5.11-rc1, on several generations of Xeon platforms. Most of the
> results are improvements, with only one malloc case on one platform
> shows a -4.0% regression. Each category below has several subcases
> run on different platform, and only the worst and best scores are
> listed:
> 
> fio:				 +1.8% ~  +8.3%
> will-it-scale/malloc1:		 -4.0% ~  +8.9%
> will-it-scale/page_fault1:	 no change
> will-it-scale/page_fault2:	 +2.4% ~  +20.2%
> 
> [1].https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/page_counter.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> index 85bd413..6795913 100644
> --- a/include/linux/page_counter.h
> +++ b/include/linux/page_counter.h
> @@ -12,7 +12,6 @@ struct page_counter {
>  	unsigned long low;
>  	unsigned long high;
>  	unsigned long max;
> -	struct page_counter *parent;
>  
>  	/* effective memory.min and memory.min usage tracking */
>  	unsigned long emin;
> @@ -27,6 +26,14 @@ struct page_counter {
>  	/* legacy */
>  	unsigned long watermark;
>  	unsigned long failcnt;
> +
> +	/*
> +	 * 'parent' is placed here to be far from 'usage' to reduce
> +	 * cache false sharing, as 'usage' is written mostly while
> +	 * parent is frequently read for cgroup's hierarchical
> +	 * counting nature.
> +	 */
> +	struct page_counter *parent;
>  };

LGTM!

Reviewed-by: Roman Gushchin <guro@fb.com>

I wonder if we have the same problem with min/low/high/max?
Maybe try to group all mostly-read-only fields (min, low, high,
max and parent) and separate them with some padding?

Thank you!
