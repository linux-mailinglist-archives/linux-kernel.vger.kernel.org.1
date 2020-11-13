Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1732B177E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgKMIrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:47:18 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57910 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgKMIrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:47:18 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AD8kP6b018007;
        Fri, 13 Nov 2020 08:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=H6prYzEHOrgj3P3botawJPYnJcmkKQ+TOPnvsh8lNl8=;
 b=j4Dcidspuzk1elHJH31VUYOc4i93QU8RA6sROr0L3JuBxhw3UupZsS7baZ7hvg/GWBJY
 rLLmXNNc0wbYwTkKELWg8nNxbIHfjqZ+6L58Tv871GZ7UZNlcxT7wQ35GTcnsX+CmVOw
 op7a29M0S+3fan/nvOkj+jv8J0aw68fHUWTB0H113oGfHc70iAohQBvQA1yJOdBv2oN5
 6X7NMlRs5MmTu61aH6UgmKtcQDJdoodYk76ABYUwgnNXtnaYui9IRXYGkHHFtIXuOvjD
 RYU6s9LmRNBMAVZiaddnvzIXhkeSMo4CyTxs+9y4Tj2C0bYTzTNKX0lG5tzhhwk9cAaE wQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34p72eyhyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 08:47:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AD8jMhK041719;
        Fri, 13 Nov 2020 08:47:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34p55spsxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Nov 2020 08:47:06 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AD8l3no029527;
        Fri, 13 Nov 2020 08:47:05 GMT
Received: from mwanda (/10.175.206.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Nov 2020 00:47:02 -0800
Date:   Fri, 13 Nov 2020 11:46:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     vincent.guittot@linaro.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [bug report] sched/fair: Prefer prev cpu in asymmetric wakeup path
Message-ID: <20201113084657.GA86197@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=3 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vincent Guittot,

The patch b4c9c9f15649: "sched/fair: Prefer prev cpu in asymmetric
wakeup path" from Oct 29, 2020, leads to the following static checker
warning:

	kernel/sched/fair.c:6249 select_idle_sibling()
	error: uninitialized symbol 'task_util'.

kernel/sched/fair.c
  6233  static int select_idle_sibling(struct task_struct *p, int prev, int target)
  6234  {
  6235          struct sched_domain *sd;
  6236          unsigned long task_util;
  6237          int i, recent_used_cpu;
  6238  
  6239          /*
  6240           * On asymmetric system, update task utilization because we will check
  6241           * that the task fits with cpu's capacity.
  6242           */

The original comment was a bit more clear...  Perhaps "On asymmetric
system[s], [record the] task utilization because we will check that the
task [can be done within] the cpu's capacity."

  6243          if (static_branch_unlikely(&sched_asym_cpucapacity)) {
  6244                  sync_entity_load_avg(&p->se);
  6245                  task_util = uclamp_task_util(p);
  6246          }

"task_util" is not initialized on the else path.

  6247  
  6248          if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
  6249              asym_fits_capacity(task_util, target))
                                       ^^^^^^^^^
Uninitialized variable warning.

  6250                  return target;
  6251  
  6252          /*
  6253           * If the previous CPU is cache affine and idle, don't be stupid:
  6254           */
  6255          if (prev != target && cpus_share_cache(prev, target) &&
  6256              (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
  6257              asym_fits_capacity(task_util, prev))
  6258                  return prev;
  6259  
  6260          /*
  6261           * Allow a per-cpu kthread to stack with the wakee if the

regards,
dan carpenter
