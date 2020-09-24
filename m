Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCEE2776D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgIXQho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:37:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:35899 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgIXQho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:37:44 -0400
IronPort-SDR: 7YGs3SZBXbVdcfMM8f0c9KTuKqpFHecLv9q9rJTfa5PUcXSZSXx9zET/mfYfW1SyL8i35xLbd8
 H99Tt3w2PnyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="161329336"
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="161329336"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 09:37:43 -0700
IronPort-SDR: y4ozkSmUoKFsjLWUM+TiqrRgqDPo4Cf/YYkIkwUT5TJAvnJOj6ZrzJFtSTO3SvSyZ5+9Ji4cNK
 QcdBVWTj+/Nw==
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="336054758"
Received: from schen9-mobl.amr.corp.intel.com ([10.254.89.92])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 09:37:42 -0700
Subject: Re: [RFC PATCH v2] sched/fair: select idle cpu from idle cpumask in
 sched domain
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Jiang Biao <benbjiang@gmail.com>
References: <20200916043103.606132-1-aubrey.li@linux.intel.com>
 <20200916110039.GG3117@suse.de>
 <78d608f2-b974-e940-da32-b37777bc405a@linux.intel.com>
 <CAKfTPtAVkg081VEGp3Hx3i7D+jxRJcyBi2=NJypvHH6HVJ8Nwg@mail.gmail.com>
 <CAKfTPtA2yE_sFfP5MFN=K+ph7rqpYUhapUdDBJ5hFLxnQPktJw@mail.gmail.com>
 <af0237e0-1451-9d11-2ee2-1468a8bb6180@linux.intel.com>
 <CAKfTPtD71z-n2dVTpZk5tLwy5OZjkju9v5vJ-3QNHhw8Grhc_Q@mail.gmail.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <40ee756f-1f27-b17e-6292-d8069a56e3c8@linux.intel.com>
Date:   Thu, 24 Sep 2020 09:37:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtD71z-n2dVTpZk5tLwy5OZjkju9v5vJ-3QNHhw8Grhc_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/20 12:14 AM, Vincent Guittot wrote:

>>
>>>>
>>>> And a quick test with hackbench on my octo cores arm64 gives for 12

Vincent,

Is it octo (=10) or octa (=8) cores on a single socket for your system?
The L2 is per core or there are multiple L2s shared among groups of cores?

Wonder if placing the threads within a L2 or not within
an L2 could cause differences seen with Aubrey's test.

Tim

