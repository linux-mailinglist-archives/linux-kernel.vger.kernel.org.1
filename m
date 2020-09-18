Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D25026FD16
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgIRMqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:46:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:59770 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgIRMp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:45:58 -0400
IronPort-SDR: yPryd+gVYnOgcW9uqXKhir4xp6UT5/4gOmgH3P/LXPaAFRRvjqP5jGWKfhe198fakJJiYzsrUP
 GfXFV3UGb2yA==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="147606658"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="147606658"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 05:45:57 -0700
IronPort-SDR: g8txEcJO0ulTSqG4U6y6lFjZr6I732JoqmIF3ujvyzswstXN00cJme4NYMxtnUgUWBa5X9TZtz
 nX66g3jf6GSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="332595129"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga004.fm.intel.com with ESMTP; 18 Sep 2020 05:45:53 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Tingwei Zhang <tingwei@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v3 6/6] stm class: ftrace: use different channel accroding to CPU
In-Reply-To: <20200903001706.28147-7-tingwei@codeaurora.org>
References: <20200903001706.28147-1-tingwei@codeaurora.org> <20200903001706.28147-7-tingwei@codeaurora.org>
Date:   Fri, 18 Sep 2020 15:45:52 +0300
Message-ID: <87zh5nw8vz.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tingwei Zhang <tingwei@codeaurora.org> writes:

> @@ -63,6 +65,7 @@ static int __init stm_ftrace_init(void)
>  {
>  	int ret;
>  
> +	stm_ftrace.data.nr_chans = num_possible_cpus();

Not a problem with this patch necesarily, but this made me realize that
.nr_chans may be larger than:

 (1) what the policy permits,
 (2) what the stm device can handle.

While (1) the user can fix in the policy, they won't be able to fix (2),
in which case they won't be able to use stm_ftrace at all. I'm thinking
if a link-time callback would be good enough.

Another thing is that .nr_chans needs to be a power of 2 at the moment.

Regards,
--
Alex
