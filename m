Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614AB2F28DD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 08:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbhALHYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 02:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbhALHYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 02:24:45 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F8BC061575
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 23:24:05 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n7so873221pgg.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 23:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BmNrhRwXaP7Fl1hxyY/Hcin3Ss6jvS62GrnEWJySDvs=;
        b=gr7vVWsNPFQQdJUUyN+OEd+qV3UweWE9RIyzVHQEIMY4kI+iwPNP16haEyoEpxm2G/
         AnqQXUWbT/UVVcSH12CmSc9Aj5/kZUNl/a7gVzySO/LNPF0DiN3xQMHOIcOt0Qu8vc9R
         mpvRy4vyZQSillVXvlA4aUaiiYfsl6AwBhB3F4fBmbl09xTj3eHyTRkpbMCoE1izBvYH
         vnlc49pOuWmoCLFff9768BSpmxBRzT0p5c5Mbji32x8CYGdjYqBz92sADYONB35BPLwq
         hvKorwulEAc/YpBTL93/SEd8wiylcuAg0aFv5jPbB+qY9NJrBoLkKQlhY/nwfOGxg+5o
         ystQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BmNrhRwXaP7Fl1hxyY/Hcin3Ss6jvS62GrnEWJySDvs=;
        b=dB9u5mtpxcwPFu4H3fh3yRkzG0Ko7l700MD7oOCXxocvk6cMPEtJ3PxY8b/4RNfGCH
         uKpMznE6EC+UhNQ2WsceJSuWcCgVVUlS7VH+jXTQ9vG3y+5tZBgAJZblVmjU5yj+yAyo
         CTsLEPgwUYXIl+Z1AB9gEKzd4WPsXnOTrqZvnT4wyii4DK4KGdM/x/gs2XrIi0Vax1s/
         hoOZ7NTYTMNl9tCE9pePcs/cD5ofKHeO+53mwtBJAvkSxIwrUROpRuwyiF5bWaubz3CH
         q5r8G/PHglcVqipwlqgqsH30AohRUjHgutDUdek1zt51o5tysQ/FYJ2p+QnbekG95b3j
         XoUQ==
X-Gm-Message-State: AOAM533QVCSkpDtsF2GIK4eL/+Re1fFPDdidT887wqAWhbtFOPMHA95M
        MTMTXR1bxQY30z79hpfT+GWBag==
X-Google-Smtp-Source: ABdhPJw/x/BTWU4FooBq+kmMRCG4cnNnXDth1096lNhe3PphbDgw0VWESAOANU9jrvB3MpzE59EZyg==
X-Received: by 2002:a63:cc05:: with SMTP id x5mr3477142pgf.254.1610436244915;
        Mon, 11 Jan 2021 23:24:04 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([202.131.71.236])
        by smtp.gmail.com with ESMTPSA id o193sm1968236pfg.27.2021.01.11.23.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 23:24:04 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:23:59 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
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
Message-ID: <20210112072359.GB18965@leoy-ThinkPad-X240s>
References: <20210109074435.626855-1-leo.yan@linaro.org>
 <20210111181646.GB144935@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111181646.GB144935@xps15>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 11:16:46AM -0700, Mathieu Poirier wrote:
> Hi Leo,
> 
> Suzuki and Mike have pointed out a few things to modify and there was a couple
> of kernel bot warnings to address as well.  As such I will wait for your next
> revision before looking at this set.

Yeah, this is fine for me.

> Thanks,
> Mathieu
> 
> On Sat, Jan 09, 2021 at 03:44:28PM +0800, Leo Yan wrote:
> > This patch series is a following up for the previous version which was
> > delivered by Suzuki [1].  Below gives the background info for why we
> > need this patch series, directly quotes the description in the cover
> > letter of the previous version:
> > 
> > "With the Virtualization Host Extensions, the kernel can run at EL2.
> > In this case the pid is written to CONTEXTIDR_EL2 instead of the
> > CONTEXTIDR_EL1. Thus the normal coresight tracing will be unable
> > to detect the PID of the thread generating the trace by looking
> > at the CONTEXTIDR_EL1. Thus, depending on the kernel EL, we must
> > switch to tracing the correct CONTEXTIDR register.
> > 
> > With VHE, we must set the TRCCONFIGR.VMID and TRCCONFIGR.VMID_OPT
> > to include the CONTEXTIDR_EL2 as the VMID in the trace. This
> > requires the perf tool to detect the changes in the TRCCONFIGR and
> > use the VMID / CID field for the PID. The challenge here is for
> > the perf tool to detect the kernel behavior.
> > 
> > Instead of the previously proposed invasive approaches, this set
> > implements a less intrusive mechanism, by playing with the
> > perf_event.attribute.config bits."
> > 
> > Same as the previous series, this series keeps the same implementation
> > for two introduced format bits:
> > 
> > - contextid_in_vmid -> Is only supported when the VMID tracing
> >   and CONTEXTIDR_EL2 both are supported. When requested the perf
> >   etm4x backend sets (TRCCONFIGR.VMID | TRCCONFIGR.VMID_OPT).
> >   As per ETMv4.4 TRM, when the core supports VHE, the CONTEXTIDR_EL2
> >   tracing is mandatory. (See the field TRCID2.VMIDOPT)
> > 
> > - pid -> Is an alias for the correct config to enable PID tracing
> >   on any kernel.
> >   i.e, in EL1 kernel -> pid == contextid
> >           EL2 kernel -> pid == contextid_in_vmid
> > 
> > With this, the perf tool is also updated to request the "pid"
> > tracing whenever available, falling back to "contextid" if it
> > is unavailable.
> > 
> > Comparing against the old version, this patch series uses the metadata
> > to save PID format; after add new item into metadata, it introduces
> > backward compatibility issue.  To allow backward compatibility, this
> > series calculates per CPU metadata array size and avoid to use the
> > defined macro, so can always know the correct array size based on the
> > info stored in perf data file.  Finally, the PID format stored in
> > metadata is passed to decoder and guide the decoder to set PID from
> > CONTEXTIDR_EL1 or VMID.
> > 
> > This patch series has been tested on Arm Juno-r2 board, with testing
> > two perf data files: one data file is recorded by the latest perf tool
> > after applied this patch series, and another data file is recorded by
> > old perf tool without this patch series, so this can prove the tool is
> > backward compatible.
> > 
> > Changes from RFC:
> > * Added comments to clarify cases requested (Leo);
> > * Explain the change to generic flags for cs_etm_set_option() in the
> >   commit description;
> > * Stored PID format in metadata and passed it to decoder (Leo);
> > * Enhanced cs-etm for backward compatibility (Denis Nikitin).
> > 
> > [1] https://archive.armlinux.org.uk/lurker/message/20201110.183310.24406f33.en.html
> > 
> > 
> > Leo Yan (4):
> >   perf cs-etm: Calculate per CPU metadata array size
> >   perf cs-etm: Add PID format into metadata
> >   perf cs-etm: Fixup PID_FMT when it is zero
> >   perf cs-etm: Add helper cs_etm__get_pid_fmt()
> > 
> > Suzuki K Poulose (3):
> >   coresight: etm-perf: Add support for PID tracing for kernel at EL2
> >   perf cs_etm: Use pid tracing explicitly instead of contextid
> >   perf cs-etm: Detect pid in VMID for kernel running at EL2
> > 
> >  .../hwtracing/coresight/coresight-etm-perf.c  | 14 +++
> >  .../coresight/coresight-etm4x-core.c          |  9 ++
> >  include/linux/coresight-pmu.h                 | 11 ++-
> >  tools/include/linux/coresight-pmu.h           | 11 ++-
> >  tools/perf/arch/arm/util/cs-etm.c             | 89 +++++++++++++++----
> >  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 32 ++++++-
> >  tools/perf/util/cs-etm.c                      | 61 ++++++++++++-
> >  tools/perf/util/cs-etm.h                      |  3 +
> >  8 files changed, 198 insertions(+), 32 deletions(-)
> > 
> > -- 
> > 2.25.1
> > 
