Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AEB2DE6B5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 16:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgLRPff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 10:35:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16496 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726581AbgLRPfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 10:35:34 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BIFWrbq154446;
        Fri, 18 Dec 2020 10:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Srtr7qwQQHkels5ZLJ6Y+5ScWqzwJp6Xx2JhGqHqj+Y=;
 b=QmJQwBiGIRpRN6FzdP/7Hb5VMbVCi7s2gKyYuYeq2ZEKaAqxC/s2vaZWzyhXgFbJImW4
 SfYl0PlpX+J4tefQdBG9cLQh9j3gIl9FEIr4gntYbc0TN1qnnaitrYkyZxWm2cknWLP5
 n8I1/m1T7X1k0wWL62DE8ENXrEKb0K3EDU+VPFkrsP0kCUbp4OheLaMm3XD7Em5F58cW
 SblMw2I4ULgQ46XuZ80/JfOdgskfnihujLkZJDvXJr7SS7Acoq8FcWuVPZlldUdRIv3t
 eyRikR47yAZfeiJG2PG4iDG3mIccUAKMWVKsBwJhjMsq3wtblDA6fuEIWVPh7JAEniZE jQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35gxv98nu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Dec 2020 10:34:02 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BIFWmQD018037;
        Fri, 18 Dec 2020 15:34:00 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 35fmywh2km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Dec 2020 15:34:00 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BIFXwfB45220238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Dec 2020 15:33:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64927A405B;
        Fri, 18 Dec 2020 15:33:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CA58A4054;
        Fri, 18 Dec 2020 15:33:58 +0000 (GMT)
Received: from osiris (unknown [9.171.24.198])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 18 Dec 2020 15:33:58 +0000 (GMT)
Date:   Fri, 18 Dec 2020 16:33:56 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: __local_bh_enable_ip() vs lockdep
Message-ID: <20201218153356.GA7932@osiris>
References: <20201215190152.GA22285@osiris>
 <20201215144724.40ab7612@gandalf.local.home>
 <20201216175259.GP3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216175259.GP3040@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-18_10:2020-12-18,2020-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=665 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180107
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
> 
> ---
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

FWIW,

Tested-by: Heiko Carstens <hca@linux.ibm.com>

Peter, will you make proper patch out of this?
