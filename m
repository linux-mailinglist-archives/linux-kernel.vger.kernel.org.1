Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B6A2979C5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 01:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755026AbgJWXts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 19:49:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36794 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754980AbgJWXtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 19:49:47 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09NNnJUI030816;
        Fri, 23 Oct 2020 16:49:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=y+XrKZ9DyNVLWu0oVLfVcQMMQS4hKkUKkUPB24f6GpI=;
 b=lej7kmHfF286pqDaEO3+Q5YMn9aEdjvk2s9f+cKay0J/Pq3zu27yZuwXs88V2s/mEmls
 tW4/FrH2+KydNL/7zke9C4wKDZ34dSlenLMWHIcBrfCw6GUe/ik0WSn1gQtL04xEO0dg
 xhJU1u7SflVkUr50bWIuPboVdEzeri+1RZs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34c2p8javb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Oct 2020 16:49:36 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 23 Oct 2020 16:49:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gy5TUAM17XMqqj6lPCZCfvKVxgz7iO5z9ZDuwTBY7qRj9FvOT5SgPg4yRrub5/pfjkIBCHu152wdzwNBu52jAWk383O/EGr5dFWG1VM6lmjrlhG8p7PCCZ03SYWZX5UEBjORUgLS9lI/B/dy2Ot9e30zyt6vePBGq0Sx/ZxeDcbTGeMtZkGlkih6E58Ss8w/NbImf43Hp/uzqj0+3OxsZXBH38/YU13JjcUqbohgCQVoSg1g8pE3Kxs2FdSYztsnFFbwfuCIJzrR3f+vZl+ZlNp1eT2Mpv/N+bwzU0ZAQ2VVLGzmQeC4pVz8m3xO7iPE04Zkqvhu5l3cZ7MvNk34nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+XrKZ9DyNVLWu0oVLfVcQMMQS4hKkUKkUPB24f6GpI=;
 b=iFETbuwO8Pqe58VohQsXJqXilczsrG5xxYXpmP1CjhOYMPNXMP7TpiJsvPwLGrkD/mMILtM9Bda/XIolkXHc6Jn/FZazAv9bfbSeF0FJMO0pC2uV6yaqKYjn/wDq2SptEkJm12N7gvtidqzW38fB+I6LNQbdSkXhsUpNPQ/pVUrPNuKDLrQ8Uw96hJHQ1hqQTwlHcIsgqNDzt+u1zga/Kwu/lyPR20Vw9LuSpdeAGMKg1cCpgfSrWspKgxy8qh095ofilzeZBiQLlMRoJJYKSDCKSGiBA1PAerD2b+E/e9e+qxT8jVZQcNbUHfbJfR4qroO4wqV1ZG07Xx3eWZHYtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+XrKZ9DyNVLWu0oVLfVcQMMQS4hKkUKkUPB24f6GpI=;
 b=Px93UOb7LaeZj94q7RUPeJSERDGQr5JuuP1dZSWwg5UyrMJpIkhvo+1tswM3N8qZ7K9twhBgHnWpS8A3027JLXV07rKxFSLyj3ygagUSBNfsLC94mFVplUDN2492ETUqirDJ+fCRYIwSqoYkquEYag9AouDZwfrG3HGzGv/XYC0=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from MN2PR15MB2878.namprd15.prod.outlook.com (2603:10b6:208:e9::12)
 by MN2PR15MB3024.namprd15.prod.outlook.com (2603:10b6:208:f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 23 Oct
 2020 23:49:34 +0000
Received: from MN2PR15MB2878.namprd15.prod.outlook.com
 ([fe80::38aa:c2b:59bf:1d7]) by MN2PR15MB2878.namprd15.prod.outlook.com
 ([fe80::38aa:c2b:59bf:1d7%6]) with mapi id 15.20.3477.029; Fri, 23 Oct 2020
 23:49:33 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix scheduler regression from "sched/fair: Rework
 load_balance()"
Date:   Fri, 23 Oct 2020 19:49:28 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <DB4481A8-FD4E-4879-9CD2-275ABAFC09CF@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-Originating-IP: [2620:10d:c091:480::1:232a]
X-ClientProxiedBy: MN2PR14CA0014.namprd14.prod.outlook.com
 (2603:10b6:208:23e::19) To MN2PR15MB2878.namprd15.prod.outlook.com
 (2603:10b6:208:e9::12)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [100.109.117.188] (2620:10d:c091:480::1:232a) by MN2PR14CA0014.namprd14.prod.outlook.com (2603:10b6:208:23e::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 23:49:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71efaf90-17da-456e-f488-08d877ae4aad
X-MS-TrafficTypeDiagnostic: MN2PR15MB3024:
X-Microsoft-Antispam-PRVS: <MN2PR15MB30240FD90600B16929791481D31A0@MN2PR15MB3024.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:215;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ihw+Zvo/c2MexsP+1G3oNyNjokGJFgOc9Lq7zdskF/z4OmiHeuFiUI3jTOI1XBunY0TszjO0uheN+gygKLsjAcgsXodK2WmTdWlFHU/tZyNF46H2al3U7MZhRmfTNYiB+kbHVDnyyvGcDF94WxS9NwN9j7pyCOAf/iFy+cFQPOyda2ygynD/ZTrKD6CWPo2LNpNjtwobVhMmvcrsgR/UZe9TTLFwDduq5qBQUmyVrFzndlQFG8ZJgNpc7aNonl15Z9GGbX1iZLrQRGrq6+TxbRhYnKzWQvIwtHIjk0xr5atQmcpaTTci4LfL7rrpBw4nRCpgjT8G/8NC75NH6kS6ZsbEoGKwsq0R5khvTM5I+efdr7jgdc9BWmWV8NiYN3OpLXwS489K9g08kiJbilZAMSIRR3zv0tnLO5bz6z5QevmrPho/25mScoJJGqVv0Cj2xPZkeuWMKWU+2W5Z9rKzCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB2878.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(396003)(366004)(346002)(8936002)(110136005)(36756003)(956004)(33656002)(2616005)(316002)(83380400001)(6666004)(8676002)(16526019)(966005)(478600001)(52116002)(5660300002)(66556008)(66476007)(6486002)(186003)(2906002)(86362001)(66946007)(78286007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: J4GXmUO5NMw0X6Dh+SxfzBgdPQuGy1VnhnQKHvgYXBu3xnJhMzIDVaOhpMV0udYn2kWydEZ8B9Oj3sh79qlrKrJXqYoysGynFa1D6VicD1p6PaQV3zRSLfXMErL30JJuJEuaEvenmnaPKwS/AOqhlevirGPYm3glJIuxyp1R1zO+sRtAATOuBjkr5iT7bJQ390vPNskyNztBCQh/hi0WnwqhVyRaFVDQzqagis0MrhZUIf2tIqHUPdwszLNlWi2CWXjcLkeCkuEPur71kHD+33EnyJ9PWl6RqcpTfg2c1aJjVeVDc/b3HetJoUloklR4S+kZH4zvneOJr+jq5+k4f4RiWeNkHDVmUE+NwYstg7OoDa+wZiGCFJ+z094GCuL0KoOUBHqWSXx248vDTosmjOQBSuRJsTEItLSTzt7gO2cbqh34XagVwlCf41YM5GvV2OHHE+6kkYfsVCgXxFbVernYQZVQXphQVWBBQwq9D8bmqfQwisvyV3ZuOvTKqpNMAWkmf+xwknWQjYwxZ7zB+3xgI7zX2f6pfuFIVPh8KvjjIVRU18ijnVSMZ8atlRXIO1cH/Jd+xNaBOlXuU+UsNzJw2LkUtPHv/7HSqnlinal3aBQqndA1+67EVXKsfQvr+dSPd4Egn4uZ4ID64KU/hbLQdKanCILB+mlI0zx0zIdtPdUb0RGUcvEbIOil+/rN
X-MS-Exchange-CrossTenant-Network-Message-Id: 71efaf90-17da-456e-f488-08d877ae4aad
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB2878.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 23:49:33.7532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e66tIj/fOtRAIWYO+54IHlMO3xkSk1aOGN70SuvN7upm/TVPUiRCdOOl4UMA0IEc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3024
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-23_18:2020-10-23,2020-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010230148
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

We’re validating a new kernel in the fleet, and compared with v5.2, 
performance is ~2-3% lower for some of our workloads.  After some 
digging, Johannes found that our involuntary context switch rate was ~2x 
higher, and we were leaving a CPU idle a higher percentage of the time, 
even though the workload was trying to saturate the system.

We were able to reproduce the problem with schbench, and Johannes 
bisected down to:

commit 0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912
Author: Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri Oct 18 15:26:31 2019 +0200

     sched/fair: Rework load_balance()

Our working theory is the load balancing changes are leaving processes 
behind busy CPUs instead of moving them onto idle ones.  I made a few 
schbench modifications to make this easier to demonstrate:

https://git.kernel.org/pub/scm/linux/kernel/git/mason/schbench.git/

My VM has 40 cpus (20 cores, 2 threads per core), and my schbench 
command line is:

schbench -t 20 -r 0 -c 1000000 -s 1000 -i 30 -z 120

This has two message threads, and 20 workers per message thread.  Once 
woken up, the workers think for a full second, which means you’ll have 
some long latencies if you’re stuck behind one of these workers in the 
runqueue.  The message thread does a little bit of work and then sleeps, 
so we end up with 40 threads hammering full blast on the CPU and 2 
threads popping in and out of idle.

schbench times the delay from when a message thread wakes a worker to 
when the worker runs.  On a good kernel, the output looks like this:

Latency percentiles (usec) runtime 1290 (s) (3280 total samples)
         50.0th: 155 (1653 samples)
         75.0th: 189 (808 samples)
         90.0th: 216 (501 samples)
         95.0th: 227 (163 samples)
         *99.0th: 256 (123 samples)
         99.5th: 1510 (16 samples)
         99.9th: 3132 (13 samples)
         min=21, max=3286

With 0b0695f2b34a, we get this:

Latency percentiles (usec) runtime 1440 (s) (4480 total samples)
         50.0th: 147 (2261 samples)
         75.0th: 182 (1116 samples)
         90.0th: 205 (671 samples)
         95.0th: 224 (215 samples)
         *99.0th: 12240 (173 samples) <—— much higher p99 and up
         99.5th: 12752 (22 samples)
         99.9th: 13104 (18 samples)
         min=21, max=13172

Since the idea is to fully load the machine with schbench, use schbench 
-t <your_num_cpus/2>, and make sure the box doesn’t have other stuff 
running in the background.  I used a VM because it ended up giving more 
consistent results on our kernel test machines, which have some periodic 
noise running in the background.

We’ve tried a few different approaches, but don’t quite have a solid 
fix yet.  I thought I’d kick off the discussion with my most useful 
hunks so far:

diff a/kernel/sched/fair.c b/kernel/sched/fair.c
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c

-chris
