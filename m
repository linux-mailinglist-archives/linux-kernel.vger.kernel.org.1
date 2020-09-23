Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73046275007
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 06:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgIWEjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 00:39:20 -0400
Received: from z5.mailgun.us ([104.130.96.5]:26492 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgIWEjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 00:39:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600835959; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=62upVWs2yXzGE3gWPGzEaiN42HD4HHF9FHmkRd8LCPQ=; b=IrQgHVKNMtKpAEYPfAAxEpNMy69F5zxiO1uzq99vj46FRzCJKPsY4US02WmgxtzyT7m8LVdl
 N12Eg3KPj9ToW/dpXoxZGOS0aFfmiFFWnNDrRyqPDjvpjCuXkXWs+P/DnTuEJOJ2Qt9vp6B6
 D565MvbLsfeTzF3bSKHi4VYGGdo=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f6ad17751ea4325f30d56c9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Sep 2020 04:39:19
 GMT
Sender: tingweiz=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0EDACC43382; Wed, 23 Sep 2020 04:39:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 64634C433CA;
        Wed, 23 Sep 2020 04:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 64634C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingweiz@codeaurora.org
Date:   Wed, 23 Sep 2020 12:39:07 +0800
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 6/6] stm class: ftrace: use different channel
 accroding to CPU
Message-ID: <20200923043907.GA5146@codeaurora.org>
References: <20200903001706.28147-1-tingwei@codeaurora.org>
 <20200903001706.28147-7-tingwei@codeaurora.org>
 <87zh5nw8vz.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh5nw8vz.fsf@ashishki-desk.ger.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 08:45:52PM +0800, Alexander Shishkin wrote:
> Tingwei Zhang <tingwei@codeaurora.org> writes:
> 
> > @@ -63,6 +65,7 @@ static int __init stm_ftrace_init(void)
> >  {
> >  	int ret;
> >  
> > +	stm_ftrace.data.nr_chans = num_possible_cpus();
> 
> Not a problem with this patch necesarily, but this made me realize that
> .nr_chans may be larger than:
> 
>  (1) what the policy permits,
>  (2) what the stm device can handle.
> 
> While (1) the user can fix in the policy, they won't be able to fix (2),
> in which case they won't be able to use stm_ftrace at all. I'm thinking
> if a link-time callback would be good enough.
>

Hi Alex,

I'm not sure if I understand this correct. If the nr_chans requested by
stm_ftrace is larger than policy permits or stm device can handle,
stm_assign_first_policy() returns with error so stm_source_link_add()
will fail. User would notice that when link happens.  There's not much
we can do if resource is not enough.
 
> Another thing is that .nr_chans needs to be a power of 2 at the moment.
> 
I'll change to below.
stm_ftrace.data.nr_chans = roundup_pow_of_two(num_possible_cpus());
> Regards,
> --
> Alex
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
