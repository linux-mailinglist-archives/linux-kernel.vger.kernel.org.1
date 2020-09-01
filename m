Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EBE258854
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 08:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIAGhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 02:37:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:26764 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgIAGhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 02:37:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598942270; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=WRmS2DGejnFGcKOvgONuKgpaTUuih6UvD8aJmFjpSAQ=; b=X4GdSdJxpbhylys2MeiCGyZd5OdvXR8Bf7Z8NCFHUB2Sqy2MfkbQuUnhHMdhUmvMU6HQPp81
 5rIROGrPJZ2Q4PiNr92cnIODzdhu924JTSS390TPjzMMQfd/KEgHLigjMZsdaMwQTTPM0huD
 W1Y68u7XU9NfrVl0P389Eo71CRQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f4dec3ecc683673f93eda6b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Sep 2020 06:37:50
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CDF73C43387; Tue,  1 Sep 2020 06:37:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5271BC433CB;
        Tue,  1 Sep 2020 06:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5271BC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingweiz@codeaurora.org
Date:   Tue, 1 Sep 2020 14:37:40 +0800
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org
Subject: Re: [PATCH v3 0/6] tracing: export event trace and trace_marker
Message-ID: <20200901063740.GB13784@codeaurora.org>
References: <20200813014552.23539-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813014552.23539-1-tingwei@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

May I know your comments for this patch set?

Thanks,
Tingwei

On Thu, Aug 13, 2020 at 09:45:46AM +0800, Tingwei Zhang wrote:
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
