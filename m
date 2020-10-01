Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53F428088B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbgJAUjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:39:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45520 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726515AbgJAUjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:39:51 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 091Kb47F021201;
        Thu, 1 Oct 2020 13:39:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=HFdgRWGNcPKxQahNK3xvqfg/J8HzVC1Fsa23yZJHT7Q=;
 b=eJ+eATwLFc/M0PdEkAoZahGBSm5o8I8U7SP1bjbCRfoaDQDvT2xm5PqgL57ruobqYCPd
 DgJGDHLZ2EziyFdqmOhJwu6Ojve2fgMuosIIvTdtIPLwX8D7Kj/ah6CroEaeuNfmdq2E
 BId7MlIuSI6LYatkUX4X3tXcMDZ+lQ0a5vA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33v3vu79q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 01 Oct 2020 13:39:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 13:39:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVtK+Uz0tGmB0E3G+XThEk2HCSGWoAUZeaS3cZFDSAuExKbIEcmtpldbjZw8ExmeP84N3kg/jUGBE53Bo/vGkVsjN/Ef/VVdSTKmxsibBxi94BCF7Jbo/WMA7qFBI7EtPsjABFkT4dJ0BKVUsuBSYsqwXSmdk+xqrEhg8SKZXWOqzyqfYmui7A7PSyWrinZHkuKmdNcY7rai33M1CXMjm0Io7dlLX3Qgd2s9G08FBNMaJOA5b3Y5NxbcevMycBhJiiVY2Idwg1ZlO6De62QbJTCQKhpHEQ/Tv07l69+DVGb8IiwYhyK3SqgpSoaVj3x4WcTdaR2ksnc14n7cy6Uw9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFdgRWGNcPKxQahNK3xvqfg/J8HzVC1Fsa23yZJHT7Q=;
 b=NHcr6+CiVDBSCZUQy3HbWAV2GcLJHrvK/ea6WSjSuJTPOrF9j7WV1VPVzq63bCWTq/w3QoHdBTOtXyVrb/3+ai/Ri3nXLBZokJsR2787flw5WxIvVwp56+njnwfw0oLVfQBAqp31UZdlQiXcB9oCOLidlRtW3wX5DVGLiVIvSoEaPl5WsVNcx6F8POLmrVobMqTXX0Haey16VvSKc7ekvLOFDb7sTIEbWBn0KpoTV0QZGIl1zdLl57jO5NkZpgWy0a2aHQxOP/aPog7chVcQlLusACpszo9NIcgDDkmkwONL0DvP3ieqFiEMyzMJf6/5JcjR6ZBFoFQauyifM+ZoHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFdgRWGNcPKxQahNK3xvqfg/J8HzVC1Fsa23yZJHT7Q=;
 b=DDcRLS2HnWXk8YAKC036kouDszj5jkGrjqejHb8acJRKeevhqTUa00ltjQfmEOA7Y8dnOK5a6s8aB2S+es88yxNwG1EBEtyDV+68QaiRQjPH4X4ha+kvIvtQt6Ow4ocq1CegBSY/Ck40Zf8R8fblzr7xu5BGslGNmyDzfWsaFxQ=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SA0PR15MB4063.namprd15.prod.outlook.com
 (2603:10b6:806:86::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Thu, 1 Oct
 2020 20:39:36 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a%7]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 20:39:36 +0000
Date:   Thu, 1 Oct 2020 13:39:31 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Bastian Bittorf <bb@npl.de>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: Linux 5.9-rc7 / VmallocTotal wrongly reported
Message-ID: <20201001203931.GD2706729@carbon.DHCP.thefacebook.com>
References: <20201001065104.apevlkqrs6nid3r5@hp-nas.internet>
 <CAHk-=wixd9kUup4o1d1y9Wg9WoRt6_mN7kM5sPX=_nrgrkZzFg@mail.gmail.com>
 <20201001195610.GC2706729@carbon.DHCP.thefacebook.com>
 <CAHk-=whwbrbZbdqpXVd9LOG=J04BEVZcT+vT=nXry=XP1JWqYA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whwbrbZbdqpXVd9LOG=J04BEVZcT+vT=nXry=XP1JWqYA@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:9525]
X-ClientProxiedBy: MWHPR22CA0066.namprd22.prod.outlook.com
 (2603:10b6:300:12a::28) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:9525) by MWHPR22CA0066.namprd22.prod.outlook.com (2603:10b6:300:12a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Thu, 1 Oct 2020 20:39:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 956ed190-e3c2-48e6-1ae6-08d8664a1c63
X-MS-TrafficTypeDiagnostic: SA0PR15MB4063:
X-Microsoft-Antispam-PRVS: <SA0PR15MB4063FF34FAC01D063637521EBE300@SA0PR15MB4063.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ErHKm3HB0YH4J+wWhuvXba5qc6ZRs1yGxQK4kQnIDiIC+GsIOKBIXQ6KtzT+V0RkLQbvuOb35m/6QUPk4//Ln6HJudZdRoLpE4F2gmV5m4YGrtmRdaIW+Mwn/KmF6ZLYZhGyzJ5ENMitpJrQPJU2vV5xUZyUo6vx46sh7NSolALEQAXgUVPoN9VO+X9xYR5VxMpO9CRWiCRbGKVs1CqRu06nAej/yOqGtEy91y1y+LK+LJHtOMYbi01dkPm+7gOq5FB5O9o+3PFYkqAcCY0XT7uF/8CVlt9o59YdazkDoR/0v3dtf4YaggEJ7pqfrybs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(346002)(39860400002)(136003)(1076003)(66946007)(33656002)(478600001)(53546011)(6666004)(66556008)(66476007)(2906002)(54906003)(6916009)(186003)(7696005)(4326008)(52116002)(16526019)(55016002)(86362001)(6506007)(9686003)(5660300002)(8676002)(8936002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: PNQUdeLuC2vQYUDL0tqAywEAujZeFN2waQTRk4i7ZeaJfKOtWa4Llkj71v+GKsW23iCgOM85gORO89/2SLaC+1IfRvXPB0jqlz7d5Q5L9BuWRQEnNHJNSSHlvIB2z68XutcGO2WCL+DqyUDYHl3nMvwQvMO99AZ/1d2Kl8oy9LfksH7hXoe/37ysIa96eh+JAnzbRgOVinpgxyfttvzXd6Qob3BngjY+TBXNQKUk0xRXQFHAaQHCkFLk17iHypELOZcGkDSnHynIwXDcmBayGF9DRvQnnIJtUXlbD/RVgoYachJvK/vs1E/khL6rA0Qob/q+/5O8+G2R8hUarZVodvjgAeljFKVg1bnbNhOG2jNKdcr1XCVcRgiT+b7saQSXv+JGFn5Fyu2ktY1uVjIzAzHSWX4zVpHxZWi1zyukQOnrSXpSTMwZQnD3HK8DmakFyqI1+a+9htpNyDrYolK2dplWVllFkC/kCPxfvJ+Ae7myJ5ihbyc0orAqRagYyIaHJTPW9hS9OCwGNS4o9WcqbKeMnh+uVa0dGoi/2AhVjfSZ0rDJdZiK8+PdnQkQ895xnB3UxSycmbFGnc7XgG24DrQMG8Ny6vxh7yoylNdH9hr+qoZ38yHdmX/hqKvPXYvHzfWvHY0kbjK1EJ28CM2Hh5H7oyldo2AY7+F/1JQNw9I=
X-MS-Exchange-CrossTenant-Network-Message-Id: 956ed190-e3c2-48e6-1ae6-08d8664a1c63
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 20:39:36.3904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HoKcPIUHFLq3g5fp9sMel2o44YVq8+eKvrxTSSH+n6gt3U3BBPdJZQHqTNJrxf2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4063
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_10:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=1 phishscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010167
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 12:58:36PM -0700, Linus Torvalds wrote:
> On Thu, Oct 1, 2020 at 12:56 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > Bastian, can you, please, share your config?
> 
> Bastian actually did that in the original email, but that was only
> sent to me and Andrew in private.
> 
> Here's that config replicated for your pleasure,

Thank you!

> 
> #
> # Processor type and features
> #
> # CONFIG_ZONE_DMA is not set
> # CONFIG_SMP is not set

Yes, here is the deal.

The SMP-version of __mod_node_page_state() converts a passed value from bytes
to pages, but the non-SMP doesn't.

Thanks!


--

From 3d0233b37340c78012b991d3570b92f91cf5ebd2 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Thu, 1 Oct 2020 13:07:49 -0700
Subject: [PATCH] mm: memcg/slab: fix slab statistics in !SMP configuration

Since ea426c2a7de8 ("mm: memcg: prepare for byte-sized vmstat items")
the write side of slab counters accepts a value in bytes and converts
it to pages. It happens in __mod_node_page_state().

However a non-SMP version of __mod_node_page_state() doesn't perform
this conversion. It leads to incorrect (unrealistically high) slab
counters values. Fix this by adding a similar conversion to the
non-SMP version of __mod_node_page_state().

Signed-off-by: Roman Gushchin <guro@fb.com>
Reported-by: Bastian Bittorf <bb@npl.de>
Fixes: ea426c2a7de8 ("mm: memcg: prepare for byte-sized vmstat items")
---
 include/linux/vmstat.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index d5431c1bf6e5..322dcbfcc933 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -312,6 +312,11 @@ static inline void __mod_zone_page_state(struct zone *zone,
 static inline void __mod_node_page_state(struct pglist_data *pgdat,
 			enum node_stat_item item, int delta)
 {
+	if (vmstat_item_in_bytes(item)) {
+		VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
+		delta >>= PAGE_SHIFT;
+	}
+
 	node_page_state_add(delta, pgdat, item);
 }
 
-- 
2.26.2

