Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B47B292BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 18:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgJSQpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 12:45:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:42628 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729879AbgJSQpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 12:45:14 -0400
IronPort-SDR: sTRlu8KLoJhazWYTLv91SXwaoDLMZrLkpL1p71gBEs/giLRHjHF0RCjSwUlS+nLdB/vy5jQK9W
 rSrCYhFnmv+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="146358430"
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="146358430"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 09:45:13 -0700
IronPort-SDR: HRIQUStE5Rp6CJJSty2yOryDk6dt6KOmxLZXvfZ4OvkzpzCpriXLlg6SyIsXME9NFSjQxKfA9E
 a9kKFmmSMOxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="320335439"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 19 Oct 2020 09:45:13 -0700
Received: from [10.251.22.47] (kliang2-MOBL.ccr.corp.intel.com [10.251.22.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 35C05580127;
        Mon, 19 Oct 2020 09:45:13 -0700 (PDT)
Subject: Re: [PATCH] perf/x86/intel: Add event constraint for
 CYCLE_ACTIVITY.STALLS_MEM_ANY
To:     Andi Kleen <ak@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
References: <20201019150158.31635-1-kan.liang@linux.intel.com>
 <20201019160944.GK466880@tassilo.jf.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <3cb8ccc8-111f-fdb1-e049-c99a9f1cd658@linux.intel.com>
Date:   Mon, 19 Oct 2020 12:45:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201019160944.GK466880@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2020 12:09 PM, Andi Kleen wrote:
>> Reported-by: Andi Kleen<ak@linux.intel.com>
>> Signed-off-by: Kan Liang<kan.liang@linux.intel.com>
> I guess this should have a Fixes: tag and also be proposed for
> stable.

I will send V2 shortly to update the tag and Cc.

Thanks,
Kan
