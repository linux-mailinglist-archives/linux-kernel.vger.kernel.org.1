Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C93D22C853
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 16:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgGXOqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 10:46:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:13307 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgGXOqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:46:33 -0400
IronPort-SDR: lTqf57rx6xxNOd0lTPhvw0TM7yXo3R96CdrKaUMZQrSH8ziH1UPJAXtK1zGpd7qwbQ3tS6HK/n
 RC49HYrlSOFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="138781009"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="138781009"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 07:46:32 -0700
IronPort-SDR: inne2HZTHM7FNS7USJHHh82vmPPMo1Ua6W8m7mWQW9EbAOdCxT4RUZJgtJAvLWwwreWdNtX1ih
 JxfI5lUkIBzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="363385926"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga001.jf.intel.com with ESMTP; 24 Jul 2020 07:46:32 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B496E301BF9; Fri, 24 Jul 2020 07:46:32 -0700 (PDT)
Date:   Fri, 24 Jul 2020 07:46:32 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, acme@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com,
        like.xu@linux.intel.com
Subject: Re: [PATCH V7 07/14] perf/core: Add a new PERF_EV_CAP_COEXIST event
 capability
Message-ID: <20200724144632.GE1180481@tassilo.jf.intel.com>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
 <20200723171117.9918-8-kan.liang@linux.intel.com>
 <20200724105543.GV119549@hirez.programming.kicks-ass.net>
 <20200724114628.GJ43129@hirez.programming.kicks-ass.net>
 <0d33a25c-cfe4-af7f-c915-a98dba17b53b@linux.intel.com>
 <20200724135412.GA10769@hirez.programming.kicks-ass.net>
 <e04f1708-e8c0-3787-1572-443f03ab73ca@linux.intel.com>
 <20200724143258.GB10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724143258.GB10769@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Something that seems to 'work' is:
> '{cycles,cpu/instructions,period=50000/}', so maybe you can make the
> group modifier :S use any sampling event if there is one, and otherwise
> designate the leader.
> 
> Then you can write things like:
> 
>   '{slots, metric1, metric2, cpu/cycles,freq=50000/}:S'
> 
> and then since cycles is specified as a sampling event, it will use
> that.

Okay possible, but it makes things more complicated
for the user to understand and requires special documentation.
Hopefully it's worth it the internal simplification.

-andi
