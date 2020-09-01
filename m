Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35506259941
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 18:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbgIAQhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 12:37:04 -0400
Received: from foss.arm.com ([217.140.110.172]:45740 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732085AbgIAQg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:36:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C71D1045;
        Tue,  1 Sep 2020 09:36:55 -0700 (PDT)
Received: from [10.57.45.104] (unknown [10.57.45.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CAAB3F71F;
        Tue,  1 Sep 2020 09:36:52 -0700 (PDT)
Subject: Re: [PATCH RESEND v1 00/11] perf mem: Support AUX trace and Arm SPE
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Grant <Al.Grant@arm.com>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
References: <20200806030727.30267-1-leo.yan@linaro.org>
Cc:     nd <nd@arm.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <df08fad6-eec9-12a2-3d88-0d863fb42325@arm.com>
Date:   Tue, 1 Sep 2020 17:36:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806030727.30267-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2020 04:07, Leo Yan wrote:
> This patch set is to support AUX trace and Arm SPE as the first enabled
> hardware tracing for Perf memory tool.
> 

Hi Leo,

I've tested this patchset with "./perf mem record -e spe-store ./a.out" on N1 and it's working for me.
Thanks for submitting this!

James
