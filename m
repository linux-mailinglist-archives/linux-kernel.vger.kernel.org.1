Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1477E2DC6A5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 19:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbgLPSiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 13:38:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727992AbgLPSiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:38:17 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BGIWwYh033401;
        Wed, 16 Dec 2020 13:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=z/EvkYWrRq94vvURrlO5qTnLAmj3+tT1mz2pOM4Sso0=;
 b=H1KXYhuyHUZiU2DzzCf45ZB3ixJLhLll9ymuecuvHzO6BOBMS1VirE4vGbjWfoEf5RHN
 FTOYMMC8JnfzNODYyqIlGUMpUQ5FwIbxvLsIiUPcIyCDxC3/Qngq4aT0LB6owye8/Xsl
 2vNi/hfJoph8Z7s28JG+ziZuZVl+DNpM2l25PrEIsEuDI7i6dP71B3OJWPcaMSrUQRlE
 DbcR1TYUh9LTArBiBMKcmH1+c/9vY5u25WS5OK/5j7kWcihzzJa4K7teIgvdA+fLvauw
 EPOa4mYEMs+/qhofIh3FtoLGEkV9uXHoINi9BJMw+T+XyoAK38cW8TDZ9PYrPb4/zwdM 8Q== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35fpv51hgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 13:36:54 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BGIX3Ww031231;
        Wed, 16 Dec 2020 18:36:51 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 35cng8esde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 18:36:51 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BGIZY6R33947924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 18:35:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6917EAE055;
        Wed, 16 Dec 2020 18:35:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21A6DAE057;
        Wed, 16 Dec 2020 18:35:34 +0000 (GMT)
Received: from osiris (unknown [9.171.70.243])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Dec 2020 18:35:34 +0000 (GMT)
Date:   Wed, 16 Dec 2020 19:35:32 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: __local_bh_enable_ip() vs lockdep
Message-ID: <20201216183532.GA7724@osiris>
References: <20201215190152.GA22285@osiris>
 <20201215144724.40ab7612@gandalf.local.home>
 <20201216175259.GP3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216175259.GP3040@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-16_07:2020-12-15,2020-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=747 suspectscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 06:52:59PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 15, 2020 at 02:47:24PM -0500, Steven Rostedt wrote:
> > On Tue, 15 Dec 2020 20:01:52 +0100
> > Heiko Carstens <hca@linux.ibm.com> wrote:
> > 
> > > Hello,
> > > 
> > > the ftrace stack tracer kernel selftest is able to trigger the warning
> > > below from time to time. This looks like there is an ordering problem
> > > in __local_bh_enable_ip():
> > > first there is a call to lockdep_softirqs_on() and afterwards
> > > preempt_count_sub() is ftraced before it was able to modify
> > > preempt_count:
> > 
> > Don't run ftrace stack tracer when debugging lockdep. ;-)
> > 
> >   /me runs!
> 
> Ha!, seriously though; that seems like something we've encountered
> before, but my google-fu is failing me.
> 
> Do you remember what, if anything, was the problem with this?

Actually this looks like:
1a63dcd8765b ("softirq: Reorder trace_softirqs_on to prevent lockdep splat")

I can give it a test, but it looks quite obvious that your patch will
make the problem go away.

> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index d5bfd5e661fc..9d71046ea247 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -186,7 +186,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
>  	 * Keep preemption disabled until we are done with
>  	 * softirq processing:
>  	 */
> -	preempt_count_sub(cnt - 1);
> +	__preempt_count_sub(cnt - 1);
>  
>  	if (unlikely(!in_interrupt() && local_softirq_pending())) {
>  		/*
> 
