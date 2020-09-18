Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB0926FFC6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 16:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgIRO0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 10:26:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:53278 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgIRO0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 10:26:45 -0400
IronPort-SDR: SzTza1oi7mYzbctmiIEoejlVfXEsV7BasUKRNdsl+ZQ26gpgXBummedwJN2G8mvdeAOWM3mCLx
 uoVgykb5wKiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="157336490"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="157336490"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 07:26:45 -0700
IronPort-SDR: zShKMULoi/s7nQSYOLpqL1AeJf5DgQmiQwEm6cdJbcL75exOQh3mGdJtAHMAmSyCz5G1EQXOJl
 3iZCzmw+JVCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="508894939"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga005.fm.intel.com with ESMTP; 18 Sep 2020 07:26:39 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Tingwei Zhang <tingweiz@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v3 0/6] tracing: export event trace and trace_marker
In-Reply-To: <20200914232729.GB20431@codeaurora.org>
References: <20200903001706.28147-1-tingwei@codeaurora.org> <20200914232729.GB20431@codeaurora.org>
Date:   Fri, 18 Sep 2020 17:26:38 +0300
Message-ID: <87wo0rw481.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tingwei Zhang <tingweiz@codeaurora.org> writes:

> Hi Alexander, Maxime, Aleandre,
>
> May I know your comments for this patch set?

Everything except the last patch is

Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

After that one is resolved either I can pick it up or Stephen. Either
way is fine with me.

Regards,
--
Alex
