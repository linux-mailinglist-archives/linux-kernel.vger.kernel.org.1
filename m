Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE022F1DCA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390301AbhAKSRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389401AbhAKSRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:17:30 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13142C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:16:50 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id s15so259422plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nEV8C1nlsYqBuB2QbtRzwv+lpRwUQnY3DYH3YsMZ4/0=;
        b=fDWCjvbF0Ayh99i+raxwZx6XQ6fKaUlClDTz8W6zlXiImisy5VQj/3+PDPaADYHA9q
         gf+GJrkq3kqKCRpCO0kgF5gaY4MGNAb3QwWY9zMvkrJgFP6XTdmz4wsOi9EGVGxAQaEZ
         GFec99GA4mXfevw+XZdFQyLYN7rkoDu8ZvrzCREVxsvZF5w5bPvi+OFc+BXsah1BCbNK
         CLNOfYKHBCpk//KtFEVd6pKfGoltR1QZ+0niLz91ibUp3FNGrTtdcd0Iowcl7w+g509E
         Vb67ONdwE/aWrrVW4wl0LCRyqMDPkpLyEuWAh9Y8HM5iZFegVbXz9KUFTUoApEnfm/eQ
         LTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nEV8C1nlsYqBuB2QbtRzwv+lpRwUQnY3DYH3YsMZ4/0=;
        b=eGJgFEPKq2kBK1tSGexs6EGWX/SSges8UZ6OENkeuwDdpB9sFvBOht7LeBjOrparBj
         Pb2M4OsGlaGpGSgyaV5lV0+G+HEBa1TCvSTbCNti322G8/gHsTJK1PyxUDpRxDscdszf
         1r5qA0wG50sOpqdRPMKMBeZppgVYVdCL+Bode4+3+GMLaVM4p6CHBo0fW5Hyf+PmSoGU
         eVSorKNrrH920MMFCJxspOj1LBNV2lYHEljLoNZnlVD4SXjdY2O2qxZPv08MCnJeHVP7
         E3eONJJY6+/LnAPeny1RmCMdWI9BjyTuWhehY1pr2xSG905N+Nv4Dm2spfDtRs/NUV1X
         Vn2Q==
X-Gm-Message-State: AOAM532AZflWEBylFw6kmLMYNQdLHMetGO7gzFvdzneOH8Zh6wI05dvm
        tsrBgR25Jt1B1+zTIU3xCu3sGw==
X-Google-Smtp-Source: ABdhPJzaej5tAnsSUJP86r2gIvZD2QVayeyVC69B9uN9xO2lOcCnf9waFq0amXkSwY8+z+be7xpVng==
X-Received: by 2002:a17:902:eb0c:b029:db:c0d6:6289 with SMTP id l12-20020a170902eb0cb02900dbc0d66289mr573056plb.12.1610389009427;
        Mon, 11 Jan 2021 10:16:49 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id x1sm289697pfj.95.2021.01.11.10.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 10:16:48 -0800 (PST)
Date:   Mon, 11 Jan 2021 11:16:46 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
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
Subject: Re: [PATCH v1 0/7] coresight: etm-perf: Fix pid tracing with VHE
Message-ID: <20210111181646.GB144935@xps15>
References: <20210109074435.626855-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109074435.626855-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

Suzuki and Mike have pointed out a few things to modify and there was a couple
of kernel bot warnings to address as well.  As such I will wait for your next
revision before looking at this set.

Thanks,
Mathieu

On Sat, Jan 09, 2021 at 03:44:28PM +0800, Leo Yan wrote:
> This patch series is a following up for the previous version which was
> delivered by Suzuki [1].  Below gives the background info for why we
> need this patch series, directly quotes the description in the cover
> letter of the previous version:
> 
> "With the Virtualization Host Extensions, the kernel can run at EL2.
> In this case the pid is written to CONTEXTIDR_EL2 instead of the
> CONTEXTIDR_EL1. Thus the normal coresight tracing will be unable
> to detect the PID of the thread generating the trace by looking
> at the CONTEXTIDR_EL1. Thus, depending on the kernel EL, we must
> switch to tracing the correct CONTEXTIDR register.
> 
> With VHE, we must set the TRCCONFIGR.VMID and TRCCONFIGR.VMID_OPT
> to include the CONTEXTIDR_EL2 as the VMID in the trace. This
> requires the perf tool to detect the changes in the TRCCONFIGR and
> use the VMID / CID field for the PID. The challenge here is for
> the perf tool to detect the kernel behavior.
> 
> Instead of the previously proposed invasive approaches, this set
> implements a less intrusive mechanism, by playing with the
> perf_event.attribute.config bits."
> 
> Same as the previous series, this series keeps the same implementation
> for two introduced format bits:
> 
> - contextid_in_vmid -> Is only supported when the VMID tracing
>   and CONTEXTIDR_EL2 both are supported. When requested the perf
>   etm4x backend sets (TRCCONFIGR.VMID | TRCCONFIGR.VMID_OPT).
>   As per ETMv4.4 TRM, when the core supports VHE, the CONTEXTIDR_EL2
>   tracing is mandatory. (See the field TRCID2.VMIDOPT)
> 
> - pid -> Is an alias for the correct config to enable PID tracing
>   on any kernel.
>   i.e, in EL1 kernel -> pid == contextid
>           EL2 kernel -> pid == contextid_in_vmid
> 
> With this, the perf tool is also updated to request the "pid"
> tracing whenever available, falling back to "contextid" if it
> is unavailable.
> 
> Comparing against the old version, this patch series uses the metadata
> to save PID format; after add new item into metadata, it introduces
> backward compatibility issue.  To allow backward compatibility, this
> series calculates per CPU metadata array size and avoid to use the
> defined macro, so can always know the correct array size based on the
> info stored in perf data file.  Finally, the PID format stored in
> metadata is passed to decoder and guide the decoder to set PID from
> CONTEXTIDR_EL1 or VMID.
> 
> This patch series has been tested on Arm Juno-r2 board, with testing
> two perf data files: one data file is recorded by the latest perf tool
> after applied this patch series, and another data file is recorded by
> old perf tool without this patch series, so this can prove the tool is
> backward compatible.
> 
> Changes from RFC:
> * Added comments to clarify cases requested (Leo);
> * Explain the change to generic flags for cs_etm_set_option() in the
>   commit description;
> * Stored PID format in metadata and passed it to decoder (Leo);
> * Enhanced cs-etm for backward compatibility (Denis Nikitin).
> 
> [1] https://archive.armlinux.org.uk/lurker/message/20201110.183310.24406f33.en.html
> 
> 
> Leo Yan (4):
>   perf cs-etm: Calculate per CPU metadata array size
>   perf cs-etm: Add PID format into metadata
>   perf cs-etm: Fixup PID_FMT when it is zero
>   perf cs-etm: Add helper cs_etm__get_pid_fmt()
> 
> Suzuki K Poulose (3):
>   coresight: etm-perf: Add support for PID tracing for kernel at EL2
>   perf cs_etm: Use pid tracing explicitly instead of contextid
>   perf cs-etm: Detect pid in VMID for kernel running at EL2
> 
>  .../hwtracing/coresight/coresight-etm-perf.c  | 14 +++
>  .../coresight/coresight-etm4x-core.c          |  9 ++
>  include/linux/coresight-pmu.h                 | 11 ++-
>  tools/include/linux/coresight-pmu.h           | 11 ++-
>  tools/perf/arch/arm/util/cs-etm.c             | 89 +++++++++++++++----
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 32 ++++++-
>  tools/perf/util/cs-etm.c                      | 61 ++++++++++++-
>  tools/perf/util/cs-etm.h                      |  3 +
>  8 files changed, 198 insertions(+), 32 deletions(-)
> 
> -- 
> 2.25.1
> 
