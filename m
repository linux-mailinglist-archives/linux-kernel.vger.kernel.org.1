Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157E02699A2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 01:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgINXZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 19:25:26 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:18528 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbgINXZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 19:25:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600125924; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=i0McWH3ChhVD51TjTlBQAsRufyXydsyKQ1IxlVdDtwk=; b=QRoGXamJqM4dRCHbLLahQWEIelJHp/mA3hx4dzNUhSAJnXIf/o34kCoVw2MHXa0bENWCSf+S
 /YFwYqTdlu95z+qJK1puWKmeT2tQgTNvRpuwIT7JTvwR9ejHQFtlAkUVpviVqQNlOhE5e2Xc
 Mz/wXFmXn5M1l5v/xx7ok42S11w=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f5ffbcb252c522440b80ecb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Sep 2020 23:24:59
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 41DFDC433F1; Mon, 14 Sep 2020 23:24:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A802EC433CA;
        Mon, 14 Sep 2020 23:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A802EC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingweiz@codeaurora.org
Date:   Tue, 15 Sep 2020 07:24:48 +0800
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org
Subject: Re: [PATCH v3 0/6] tracing: export event trace and trace_marker
Message-ID: <20200914232448.GA20431@codeaurora.org>
References: <20200813014552.23539-1-tingwei@codeaurora.org>
 <20200901232839.GB13346@codeaurora.org>
 <20200914184309.7a9de53a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914184309.7a9de53a@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 06:43:09AM +0800, Steven Rostedt wrote:
> On Wed, 2 Sep 2020 07:28:39 +0800
> Tingwei Zhang <tingweiz@codeaurora.org> wrote:
> 
> > Hi Alexander,
> > 
> > May I know your comments for this patch set?
> 
> I ran your patch set against get_maintainers.pl and it came up with this:
> 
> Alexander Shishkin <alexander.shishkin@linux.intel.com> (maintainer:SYSTEM
> TRACE MODULE CLASS)
> Maxime Coquelin <mcoquelin.stm32@gmail.com> (maintainer:ARM/STM32
> ARCHITECTURE)
> Alexandre Torgue <alexandre.torgue@st.com> (maintainer:ARM/STM32
> ARCHITECTURE)
> Steven Rostedt <rostedt@goodmis.org> (maintainer:TRACING)
> Ingo Molnar <mingo@redhat.com> (maintainer:TRACING)
> linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
> ARCHITECTURE)
> linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
> ARCHITECTURE)
> linux-kernel@vger.kernel.org (open list)
> 
> I would use that to know who to send to.
> 
> You have Alexander, myself, Ingo and LKML, but you should add the others
> in
> that list for this series, and then it may get noticed. Please use
> get_maintainers.pl for future patches if you don't know who to send them
> to.
> 
> -- Steve
> 
Thanks a lot for the detail instructions, Steve.  I noticed that after
senting previous mail to Alexander.

I sent the patchset to maintainers and mail list as you mentioned in
https://patchwork.kernel.org/cover/11752107/.

Thanks,
Tingwei

> > 
> > Thanks,
> > Tingwei
> > 
> > On Thu, Aug 13, 2020 at 09:45:46AM +0800, Tingwei Zhang wrote:
> > > Ftrace has ability to export trace packets to other destination.
> > > Currently, only function trace can be exported. This series extends
> the
> > > support to event trace and trace_maker. STM is one possible
> destination to
> > > export ftrace. Use separate channel for each CPU to avoid mixing up
> > > packets
> > > from different CPUs together.
> > > 
> > > Change from v2:
> > > Change flag definition to BIT(). (Steven)
> > > Add comment in stm_ftrace_write() to clarify it's safe to use 
> > > smp_processor_id() here since preempt is disabled. (Steven) 
> > > 
> > > Change from v1:
> > > All changes are suggested by Steven Rostedt.
> > > User separate flag to control function trace, event trace and trace
> mark.
> > > Allocate channels according to num_possible_cpu() dynamically.
> > > Move ftrace_exports routines up so all ftrace can use them.
> > > 
> > > Tingwei Zhang (6):
> > >   stm class: ftrace: change dependency to TRACING
> > >   tracing: add flag to control different traces
> > >   tracing: add trace_export support for event trace
> > >   tracing: add trace_export support for trace_marker
> > >   stm class: ftrace: enable supported trace export flag
> > >   stm class: ftrace: use different channel accroding to CPU
> > > 
> > >  drivers/hwtracing/stm/Kconfig  |   2 +-
> > >  drivers/hwtracing/stm/ftrace.c |   7 +-
> > >  include/linux/trace.h          |   7 +
> > >  kernel/trace/trace.c           | 270
> ++++++++++++++++++---------------
> > >  4 files changed, 159 insertions(+), 127 deletions(-)
> > > 
> > > -- 
> > > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum,
> > > a Linux Foundation Collaborative Project
> > >   
> 
