Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8437828DF05
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 12:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgJNKje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 06:39:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:39285 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgJNKje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 06:39:34 -0400
IronPort-SDR: ZqlN3Z0KSCtJmSPnd56dL2iJcnMv1YpCIYas0NCAfzbZiYd+BQOk7j3p51j3ARxpNHUnQzhaOc
 x3+/zl22ZGyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="153910086"
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; 
   d="scan'208";a="153910086"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 03:39:33 -0700
IronPort-SDR: LgfrHCXrqq99qMtsGS8sO8KUou+dfwcJ2zCSqW0YXGTsQt180qYJhBOL1SwvSwmMzDDbCNTR5a
 Qz6yh4aSx51Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; 
   d="scan'208";a="420800748"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 14 Oct 2020 03:39:32 -0700
Received: from [10.249.230.73] (abudanko-mobl.ccr.corp.intel.com [10.249.230.73])
        by linux.intel.com (Postfix) with ESMTP id 899BA580784;
        Wed, 14 Oct 2020 03:39:29 -0700 (PDT)
Subject: Re: [PATCH v1 03/15] perf data: open data directory in read access
 mode
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
 <9ac7f12e-f5a4-dd91-a19a-bb7e5be27636@linux.intel.com>
 <20201012160339.GB466880@tassilo.jf.intel.com>
 <49bfe810-f1cc-b1c6-67d3-b0a746552fd6@linux.intel.com>
 <20201013162220.GK1063281@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <3120394e-833a-f96e-9133-c9b8ddd751b5@linux.intel.com>
Date:   Wed, 14 Oct 2020 13:39:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201013162220.GK1063281@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13.10.2020 19:22, Arnaldo Carvalho de Melo wrote:
> Em Mon, Oct 12, 2020 at 07:52:33PM +0300, Alexey Budankov escreveu:
>>
>> On 12.10.2020 19:03, Andi Kleen wrote:
>>> On Mon, Oct 12, 2020 at 11:55:07AM +0300, Alexey Budankov wrote:
>>>>
>>>> Open files located at data directory in case of read access mode.
>>>
>>> Need some rationale. Is this a bug fix? Did the case not matter
>>> before?
>>
>> This is not a bug fix. The case didn't matter before.
> 
> In such cases can you please write a paragraph explaining why it didn't
> matter before and now it is required?

Sure. Will do. Already in v2.

Alexei
