Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEBF29BCA0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1810201AbgJ0Qeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:34:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1810187AbgJ0Qed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:34:33 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B92EE21655;
        Tue, 27 Oct 2020 16:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603816472;
        bh=UJ6woYjE95T+vZGSHj5ferrV4srOC8ZRSElyGNBSpV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dXLbf8GDquZioNkOq7L5aMlhB5stCQI6wl0M4RQocdgBM0V4rLvAnZzbfqBEVFZHd
         bDIEPPNLe316Dll8Ny+p/FYtew0VznbfXe59EiEdmn3bjrvFpeiPTMxTmA2Y7EavLn
         arCplPsgVROzgx0mbkhPeEI5hyipaqYS20359w7U=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ABD27403C2; Tue, 27 Oct 2020 13:34:30 -0300 (-03)
Date:   Tue, 27 Oct 2020 13:34:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, kjain@linux.ibm.com, irogers@google.com,
        yao.jin@linux.intel.com, yeyunfeng@huawei.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v2 0/2] perf PMU events test: Add scenario for arch std
 events
Message-ID: <20201027163430.GJ2479604@kernel.org>
References: <1603364547-197086-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603364547-197086-1-git-send-email-john.garry@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 22, 2020 at 07:02:25PM +0800, John Garry escreveu:
> The small series covers the following:
> - Tidy error handling in jevents a bit
> - Expands on PMU events test to cover jevents arch std events support
> 
> Differences to v1:
> - Revert to original logic in jevents.c error path

Thanks, applied both together with Kajol's Reviewed-by tags.

- Arnaldo
 
> John Garry (2):
>   perf jevents: Tidy error handling
>   perf jevents: Add test for arch std events
> 
>  .../pmu-events/arch/test/arch-std-events.json |  8 ++
>  .../pmu-events/arch/test/test_cpu/cache.json  |  5 ++
>  tools/perf/pmu-events/jevents.c               | 87 +++++++++----------
>  tools/perf/tests/pmu-events.c                 | 14 +++
>  4 files changed, 66 insertions(+), 48 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/test/arch-std-events.json
>  create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/cache.json
> 
> -- 
> 2.26.2
> 

-- 

- Arnaldo
