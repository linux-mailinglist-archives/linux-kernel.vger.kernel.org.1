Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8C22B1A76
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgKMMCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:02:20 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46622 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgKMLum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:50:42 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ADBhwch166348;
        Fri, 13 Nov 2020 11:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=muXrtzj9BScEpKavcErOWQE9+hSJhxolBmUIzcYZqBs=;
 b=ep4kXLzG2L/VT5IDiVnwdDIGVdimXsX072zaxOSZWGBPbMcXWzQodPDvyZ6IHWhPdn3M
 8KdQv2Ehmz32Ww6aUBzQ/a0GgWs6XWhE3Dl6OflxR6CPYM9c1P4kUpMAkQTvR3jO/r1W
 15IrUpGPUTf6kwoAh007itUmg7ElkEMglqDvBp5XBSm6dd20L2hyLDZMKU6moV/2BQn3
 HV/6mwxSTZ5XQyxgwfKOxpxliVJX4EczhSgctFYYiEJ6bmsF0jWMjrIb5EszE8d16NX6
 nsIAsxIVomz6IusCxZuCxPkM04Gvrdy+tLs0EgjNe7/aGRiuYJMuyZk8gKlrN/XO4jCZ VA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34nkhma1wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 11:50:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ADBjFSI086272;
        Fri, 13 Nov 2020 11:50:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34rt57ragb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Nov 2020 11:50:08 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0ADBo6iC012772;
        Fri, 13 Nov 2020 11:50:06 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Nov 2020 03:50:05 -0800
Date:   Fri, 13 Nov 2020 14:49:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [bug report] sched/fair: Prefer prev cpu in asymmetric wakeup
 path
Message-ID: <20201113114959.GY18329@kadam>
References: <20201113084657.GA86197@mwanda>
 <20201113085637.GA31601@vingu-book>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201113085637.GA31601@vingu-book>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 09:56:37AM +0100, Vincent Guittot wrote:
> Hi Dan,
> 
> Le vendredi 13 nov. 2020 à 11:46:57 (+0300), Dan Carpenter a écrit :
> > Hello Vincent Guittot,
> > 
> > The patch b4c9c9f15649: "sched/fair: Prefer prev cpu in asymmetric
> > wakeup path" from Oct 29, 2020, leads to the following static checker
> > warning:
> > 
> > 	kernel/sched/fair.c:6249 select_idle_sibling()
> > 	error: uninitialized symbol 'task_util'.
> > 
> > kernel/sched/fair.c
> >   6233  static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >   6234  {
> >   6235          struct sched_domain *sd;
> >   6236          unsigned long task_util;
> >   6237          int i, recent_used_cpu;
> >   6238  
> >   6239          /*
> >   6240           * On asymmetric system, update task utilization because we will check
> >   6241           * that the task fits with cpu's capacity.
> >   6242           */
> > 
> > The original comment was a bit more clear...  Perhaps "On asymmetric
> > system[s], [record the] task utilization because we will check that the
> > task [can be done within] the cpu's capacity."
> 
> The comment "update task utilization because we will check ..." refers to
> sync_entity_load_avg()
> 
> > 
> >   6243          if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> >   6244                  sync_entity_load_avg(&p->se);
> >   6245                  task_util = uclamp_task_util(p);
> >   6246          }
> > 
> > "task_util" is not initialized on the else path.
> 
> no need because it will not be used
> 
> > 
> >   6247  
> >   6248          if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
> >   6249              asym_fits_capacity(task_util, target))
> >                                        ^^^^^^^^^
> > Uninitialized variable warning.
> 
> asym_fits_capacity includes the same condition as above when we set task_util
> so task_util can't be used unintialize
> 
> static inline bool asym_fits_capacity(int task_util, int cpu)
> {
> 	if (static_branch_unlikely(&sched_asym_cpucapacity))
> 		return fits_capacity(task_util, capacity_of(cpu));
> 
> 	return true;

It's an interesting question, because unless the compiler makes this
inline, then it will lead to a KASan/syzbot warning at runtime.  The
function is, of course, marked as inline but the compiler, also of
course,  generally ignores those hints (use __always_inline if you want
the compiler to pay attention).  On the other hand, the compiler will
still probably inline it...  So this is *probably* not going to
lead to a runtime warning.

regards,
dan carpenter

