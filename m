Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA532B7D51
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 13:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgKRMF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 07:05:27 -0500
Received: from mail-eopbgr70112.outbound.protection.outlook.com ([40.107.7.112]:52806
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728012AbgKRMF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:05:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKMIWHIu8dvgV4MNhqltjez6sXhxKy3Kqzw17kChbDZJBdL3lApTqcR73Bt3EEOrswXnPIxRUXqnGBAOi3CPzyOfh6lSSOyV13MBm3O/T0GbRiI1bKYuRm4oTfXDiRCyc5FbfDnGNvPCOGjGveK31Ouw3BC2JygJG5Kp2BxrDbjAuteWwUrS+4NsG2M2A9GlMVxiyVnCjQrKRHGZgSBvs7+wm13f/vm0sc9+LX19qWCGmTkuYcgpZC/z1JJ9JE1KHZclx06zhKJukip95E3c8cbI1FWLiM73pE1gAGL7K2K80ct2zOxdPvT2o26gICE91prdQnhjm3joU3/PtA3M7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWYEHG1kge3EUqWoZ37vRnzGOfTLUovRcHFsT4awTNI=;
 b=ejSvhdurftIpt+9BRXxfclv8ff+7zNpxivif03Zm5EPZ4ZU4fiyb4ZU9wF098jlRNMm61iM3JWiA17CFpSaVnZHSGSd77HdJ64Tgzzqz0R1KMR/4g/kZDakdwFwSM0OW12qUApPx5JfU8aeRHuWC7AKZdIQ1EQ9ghFmx85gwJQ8suKTY8zpHwQCNtPMSbWhsJ8fCpUq+1sdsA5HnBnu4Y1egKYPRxA6CS7uNRehRSRJWjQwEXMaJaNz1jZAx9auzy8tyPWezny0vaq0GntsBCjATfDdiJXa3xjDXq74vGzD2wxD2lnGpT5FSkbYRY4zOefpBMPFbTbKOrgiiyKsY9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWYEHG1kge3EUqWoZ37vRnzGOfTLUovRcHFsT4awTNI=;
 b=c4DS5486mYA37vkejYMj3cbLEl/OedCZlOJ3Mm7BsiFC6DyTNd4olpx/C3lWLgO4KTvPkvOQFwGtuerDgj5bvU1IBDPzFnCd1UWe0aCbs6PZw9lojTbga6FyxxT3WyHbwzAJEcJAHwSvYWwPUE5trY5xuHQQfoDSzmJWUpLMSJA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from VI1PR0801MB1678.eurprd08.prod.outlook.com
 (2603:10a6:800:51::23) by VI1PR0802MB2190.eurprd08.prod.outlook.com
 (2603:10a6:800:9f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Wed, 18 Nov
 2020 12:05:22 +0000
Received: from VI1PR0801MB1678.eurprd08.prod.outlook.com
 ([fe80::b18d:c047:56c0:e0d3]) by VI1PR0801MB1678.eurprd08.prod.outlook.com
 ([fe80::b18d:c047:56c0:e0d3%9]) with mapi id 15.20.3564.032; Wed, 18 Nov 2020
 12:05:22 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] tracing: remove WARN_ON in start_thread()
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <bd4d3e70-400d-9c82-7b73-a2d695e86b58@virtuozzo.com>
Date:   Wed, 18 Nov 2020 15:05:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM3PR03CA0064.eurprd03.prod.outlook.com
 (2603:10a6:207:5::22) To VI1PR0801MB1678.eurprd08.prod.outlook.com
 (2603:10a6:800:51::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM3PR03CA0064.eurprd03.prod.outlook.com (2603:10a6:207:5::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Wed, 18 Nov 2020 12:05:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a03fd63-8ce1-4bdc-a0a8-08d88bba39a7
X-MS-TrafficTypeDiagnostic: VI1PR0802MB2190:
X-Microsoft-Antispam-PRVS: <VI1PR0802MB21905AD9073FC5631FA8391AAAE10@VI1PR0802MB2190.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQUKn3u+WP9vnBdaFsokIRvsponN2X28U8w7D7ulrvKrryK4VI0ShOpN8k+ScO/EvRHbUnre15WBKkw9lNmKizP/qX5bcecMdFvTnoN4WZOeM9DZMFeObYxZgdXmA8FrRKEaeNyFJ7aZ5/a4DoqS1dpI1Kcjse5RCUKjHXg0ZheBsfhxcp6cgKTSujOLNyLoarMTtlXHq1K0z0aZr3ctU6c8moHXYMu7eA5vdRGRaZaIJY5O/Lo/JAN2PvRhp8rTnUacwbBZJ/xIr3xSgZyINP2KLBgZoiaS4seKV6wBr59PB2rwnMTOBT4MDPB9QLwID7E9npYjYV1cegnbvfowIhQsx/5/WTF9zzhdzUhAcI3mB1ONxULrWtgS1dDUsFwQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0801MB1678.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39840400004)(376002)(346002)(26005)(4326008)(8676002)(956004)(2906002)(110136005)(316002)(2616005)(66556008)(66946007)(66476007)(83380400001)(16526019)(31696002)(52116002)(36756003)(31686004)(186003)(5660300002)(8936002)(16576012)(86362001)(478600001)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: CAlfcos3V0vZAhRZRX0NOhQFpsdaY7oT5pzafJa+jgf9q/6TBXkyKybKTXoGrREoahGKohLxdFmySQBqShZqLgWoXXfdXVqtibVhYFakKTJr7MZwf8y5eOHAkEFmLRLBlm/qa6BEl41UV1gmnbwq8sYcgI4J/RObSJKW++6r+C+kV63DbBjesdNlgeqepqdoRjhYfb/nZYrNBEdYW+0uByAPT4kpgtDPrxsHJksJpeEZ78SnW2ywPozVtjdXchIxlce1pNZf9IRaqzY632rdiEUf9us+lMQAAIp/V+OQPG3nTetqfS9b6wmHdKm3QMxKQsig+ki79fuE2gjS3AshYOwN+mbFSVjKnkX47ac5FN3gs01Zm9FTomsDmFCMKc8LrQHSF59bxn/PeJRnxRWQhWeNox+k819OTrjvI0bBaIAzRJKSLQD0Y4Lhw+kHA6DVERNkzBFJti0DfRrXi6luMTXSwi7Se5VwmEVz45igqQ+nXm7tVuZXNGTMKdqOen++PsMa9t5ZYN70KR+FQamKlrTVXaI1gazGuCEEK9ZLwt3kL0XOiKc65/SUUHwRoYdDCrMy+pygzTpLT09jdaTAt+I5WFGvQxyr7fKE5K7f3ns+zKT7MkghUmOVe+NoB8ItHOuu4NmmszyiuhrpyWlLXQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a03fd63-8ce1-4bdc-a0a8-08d88bba39a7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0801MB1678.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 12:05:22.2039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IS3NvzyQda7vwcP19MURnUgVYP9xbGzBfvHyGSK1Gv2me2xHXJ3+rfHi7gWbJJBBBHjTmmDdHWls3xGHwfnJyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2190
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reverts commit 978defee11a5 ("tracing: Do a WARN_ON()
 if start_thread() in hwlat is called when thread exists")

.start hook can be legally called several times if according
tracer is stopped

screen window 1
[root@localhost ~]# echo 1 > /sys/kernel/tracing/events/kmem/kfree/enable
[root@localhost ~]# echo 1 > /sys/kernel/tracing/options/pause-on-trace
[root@localhost ~]# less -F /sys/kernel/tracing/trace

screen window 2
[root@localhost ~]# cat /sys/kernel/debug/tracing/tracing_on
0
[root@localhost ~]# echo hwlat >  /sys/kernel/debug/tracing/current_tracer
[root@localhost ~]# echo 1 > /sys/kernel/debug/tracing/tracing_on
[root@localhost ~]# cat /sys/kernel/debug/tracing/tracing_on
0
[root@localhost ~]# echo 2 > /sys/kernel/debug/tracing/tracing_on

triggers warning in dmesg:
WARNING: CPU: 3 PID: 1403 at kernel/trace/trace_hwlat.c:371 hwlat_tracer_start+0xc9/0xd0

Fixes: 978defee11a5 ("tracing: Do a WARN_ON() if start_thread() in hwlat is called when thread exists")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 kernel/trace/trace_hwlat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index c9ad5c6..d071fc2 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -368,7 +368,7 @@ static int start_kthread(struct trace_array *tr)
 	struct task_struct *kthread;
 	int next_cpu;
 
-	if (WARN_ON(hwlat_kthread))
+	if (hwlat_kthread)
 		return 0;
 
 	/* Just pick the first CPU on first iteration */
-- 
1.8.3.1

