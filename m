Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4FC26EA6A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 03:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgIRBWf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Sep 2020 21:22:35 -0400
Received: from smtp.h3c.com ([60.191.123.56]:17903 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgIRBWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 21:22:34 -0400
Received: from DAG2EX01-BASE.srv.huawei-3com.com ([10.8.0.64])
        by h3cspam01-ex.h3c.com with ESMTPS id 08I1Lb7C092671
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 09:21:37 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX01-BASE.srv.huawei-3com.com (10.8.0.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 18 Sep 2020 09:21:38 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.1713.004; Fri, 18 Sep 2020 09:21:37 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tracing: use __this_cpu_read() in
 trace_buffered_event_enable()
Thread-Topic: [PATCH] tracing: use __this_cpu_read() in
 trace_buffered_event_enable()
Thread-Index: AQHWcWW/lUMuTErgSEmeCDizYMhoyqltPS+AgACT0gA=
Date:   Fri, 18 Sep 2020 01:21:37 +0000
Message-ID: <87803c1d960c4b17b59eb39346fdb028@h3c.com>
References: <20200813112803.12256-1-tian.xianting@h3c.com>
 <20200917203127.091e23f2@rorschach.local.home>
In-Reply-To: <20200917203127.091e23f2@rorschach.local.home>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 08I1Lb7C092671
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,
Thanks for your reply:)

-----Original Message-----
From: Steven Rostedt [mailto:rostedt@goodmis.org] 
Sent: Friday, September 18, 2020 8:31 AM
To: tianxianting (RD) <tian.xianting@h3c.com>
Cc: mingo@redhat.com; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: use __this_cpu_read() in trace_buffered_event_enable()

Sorry for the late reply (been busy with Linux Plumbers, took a vacation, and then trying to catch up on all my email for the last two
months!)

But I just wanted to let you know that I added this to my queue.

Thanks!

-- Steve


On Thu, 13 Aug 2020 19:28:03 +0800
Xianting Tian <tian.xianting@h3c.com> wrote:

> The code is executed with preemption disabled, so it's safe to use 
> __this_cpu_read().
> 
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c index 
> bb6226972..7d0d71ce9 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2514,7 +2514,7 @@ void trace_buffered_event_enable(void)
>  
>  		preempt_disable();
>  		if (cpu == smp_processor_id() &&
> -		    this_cpu_read(trace_buffered_event) !=
> +		    __this_cpu_read(trace_buffered_event) !=
>  		    per_cpu(trace_buffered_event, cpu))
>  			WARN_ON_ONCE(1);
>  		preempt_enable();

