Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7447E2F0D33
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 08:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbhAKH3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 02:29:55 -0500
Received: from foss.arm.com ([217.140.110.172]:48438 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbhAKH3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 02:29:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFB1131B;
        Sun, 10 Jan 2021 23:29:08 -0800 (PST)
Received: from [10.57.39.145] (unknown [10.57.39.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50EC63F66E;
        Sun, 10 Jan 2021 23:29:05 -0800 (PST)
Subject: Re: [PATCH v1 3/7] perf cs-etm: Calculate per CPU metadata array size
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210109074435.626855-1-leo.yan@linaro.org>
 <20210109074435.626855-4-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <96ec434e-4103-02ac-a05a-761a9ca8cb0d@arm.com>
Date:   Mon, 11 Jan 2021 07:28:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210109074435.626855-4-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/21 7:44 AM, Leo Yan wrote:
> The metadata array can be extended over time and the tool, if using the
> predefined macro (like CS_ETMV4_PRIV_MAX for ETMv4) as metadata array
> size to copy data, it can cause compatible issue within different
> versions of perf tool.
> 
> E.g. we recorded a data file with an old version tool, afterwards if
> use the new version perf tool to parse the file, since the metadata
> array has been extended and the macro CS_ETMV4_PRIV_MAX has been
> altered, if use it to parse the perf data with old format, this will
> lead to mismatch.
> 
> To maintain backward compatibility, this patch calculates per CPU
> metadata array size on the runtime, the calculation is based on the
> info stored in the data file so that it's reliable.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Looks good to me.

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

