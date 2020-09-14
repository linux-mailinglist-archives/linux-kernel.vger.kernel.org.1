Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50702699AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 01:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgINX2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 19:28:41 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:60530 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbgINX2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 19:28:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600126119; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=JcwD/uxtsoKa4SSZpuOrTon7fbX8C8oGUwA3IhAUSfg=; b=KwE/+VC0/bqVH5ChpmE5PvQ3lQp7dAnTGJWQnRRE9uVLuOrl7dtLZHRlotmzanVdr/R8ItYT
 4sW6LfJRGN97FIy+rixnzhPjgq4Y04XUx0SwYz8rGOjnh1sd0PQbISvZAWg28D/ElIkwn2s9
 r64Prd6YKqMv/MdgswaYnHVdnpI=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f5ffc697f21d51b309a87da (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Sep 2020 23:27:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3C697C4339C; Mon, 14 Sep 2020 23:27:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 688E7C433CA;
        Mon, 14 Sep 2020 23:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 688E7C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingweiz@codeaurora.org
Date:   Tue, 15 Sep 2020 07:27:29 +0800
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/6] tracing: export event trace and trace_marker
Message-ID: <20200914232729.GB20431@codeaurora.org>
References: <20200903001706.28147-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903001706.28147-1-tingwei@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander, Maxime, Aleandre,

May I know your comments for this patch set?

Thanks,
Tingwei

On Thu, Sep 03, 2020 at 08:17:00AM +0800, Tingwei Zhang wrote:
> Ftrace has ability to export trace packets to other destination.
> Currently, only function trace can be exported. This series extends the
> support to event trace and trace_maker. STM is one possible destination to
> export ftrace. Use separate channel for each CPU to avoid mixing up
> packets
> from different CPUs together.
> 
> Change from v2:
> Change flag definition to BIT(). (Steven)
> Add comment in stm_ftrace_write() to clarify it's safe to use 
> smp_processor_id() here since preempt is disabled. (Steven) 
> 
> Change from v1:
> All changes are suggested by Steven Rostedt.
> User separate flag to control function trace, event trace and trace mark.
> Allocate channels according to num_possible_cpu() dynamically.
> Move ftrace_exports routines up so all ftrace can use them.
> 
> Tingwei Zhang (6):
>   stm class: ftrace: change dependency to TRACING
>   tracing: add flag to control different traces
>   tracing: add trace_export support for event trace
>   tracing: add trace_export support for trace_marker
>   stm class: ftrace: enable supported trace export flag
>   stm class: ftrace: use different channel accroding to CPU
> 
>  drivers/hwtracing/stm/Kconfig  |   2 +-
>  drivers/hwtracing/stm/ftrace.c |   7 +-
>  include/linux/trace.h          |   7 +
>  kernel/trace/trace.c           | 270 ++++++++++++++++++---------------
>  4 files changed, 159 insertions(+), 127 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
