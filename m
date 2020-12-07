Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AAD2D1742
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgLGRNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:13:10 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2216 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGRNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:13:09 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CqVCY1f5Cz67MXj;
        Tue,  8 Dec 2020 01:09:13 +0800 (CST)
Received: from lhreml741-chm.china.huawei.com (10.201.108.191) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 7 Dec 2020 18:12:27 +0100
Received: from [10.47.199.254] (10.47.199.254) by
 lhreml741-chm.china.huawei.com (10.201.108.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 7 Dec 2020 17:12:21 +0000
Subject: Re: [PATCH 1/3] perf tools: Add
 evlist__disable_evsel/evlist__enable_evsel
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
References: <20201206170519.4010606-1-jolsa@kernel.org>
 <20201206170519.4010606-2-jolsa@kernel.org>
From:   Alexei Budankov <abudankov@huawei.com>
Message-ID: <22f91662-7522-f981-54ff-95c7765b6ee0@huawei.com>
Date:   Mon, 7 Dec 2020 20:12:15 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201206170519.4010606-2-jolsa@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.199.254]
X-ClientProxiedBy: braeml704-chm.china.huawei.com (10.226.71.60) To
 lhreml741-chm.china.huawei.com (10.201.108.191)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06.12.2020 20:05, Jiri Olsa wrote:
> Adding interface to enable/disable single event in the
> evlist based on its name. It will be used later in new
> control enable/disable interface.
> 
> Keeping the evlist::enabled true when one or more events
> are enabled so the toggle can work properly and toggle
> evlist to disabled state.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/evlist.c | 69 ++++++++++++++++++++++++++++++++++++++--
>  tools/perf/util/evlist.h |  2 ++
>  2 files changed, 68 insertions(+), 3 deletions(-)

Acked-by: Alexei Budankov <abudankov@huawei.com>

Regards,
Alexei
