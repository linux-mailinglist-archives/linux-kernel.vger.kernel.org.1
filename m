Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACB42F15C0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 14:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbhAKNLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 08:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730764AbhAKNK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 08:10:56 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F1FC06179F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 05:10:15 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id u4so8842630pjn.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 05:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yPCLa6FZjqK4D17lMqre5j2awEs5gnDDXh+r5vWQ68M=;
        b=XcGOC0tDejK2g+VJ42m5jhAZimTZauS9GkLVMP224pD0LlOJCB7skxgUk1n7Cs9KfK
         r3PoZGKfKQ04dqejCrtJdgg+xwuhaBgYds1n4Qi2zSmnGYU3rw//grbrkI8/yg2ioUlh
         MRPoyOiPZwMCPFfymg5WGy5jx1nyLxVcMuG0LiZ34SCRQSc0yaSer1aAcjpnETnFPeUR
         WnbUZNZ55HeUROOFhc4AZMGGMtJ5x0gnuocyfTDGZxXVeynvxD06I+dBdnWZfchBGmvd
         B/SZBAY171ygyFZ+A05KvUMpr3i/TwcJG5tarIVdmfhh9ntslkisXv+JmKhTfjpBR4gh
         MPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yPCLa6FZjqK4D17lMqre5j2awEs5gnDDXh+r5vWQ68M=;
        b=sjzXXgRJ9UGvtHC9szmkv3wmPMtzv3zzbWOyhU41Ehutdr5UTyhwhZ/Cnh7e4pl195
         tyIrKmPO18UXLiGzPT2kBOVve9nK/OWD9iDuCidvjTRNRTF7Ipl155txsJe47XXO1qNe
         j46JHcRHGng8mFM9PGS6/F0O6QXEj7Z1TniWCSYmdYG09kmDAsP7iMi6uTrgVr2Ht12/
         GjA+SXgBu2RMLemI3jCHFOnKabwk+dackL1k6vO/wegIJbujtSOqf2SbsGtdiM8IN4H6
         g1t/J+EjbCCs+3CUpvkrny8mllBhvIqcdu72jbu1bREx5lcI/Znz4UuuQPfLzitSzMiu
         VRDQ==
X-Gm-Message-State: AOAM531KYhuRqnvbD7E5AwJ81DQs9dQPKhg1SQt+35GXMK/SFdye28U1
        7phIW3+RIYj1w5uefAdPvQpO2w==
X-Google-Smtp-Source: ABdhPJy2XE4QraMGyMvItnMnUYzA9ToHqlvjoaRvAujliJ93tmmsZyrq0XX/dELem2s97VNVM1BO4w==
X-Received: by 2002:a17:902:9a97:b029:db:f96a:bb4d with SMTP id w23-20020a1709029a97b02900dbf96abb4dmr19262180plp.27.1610370615250;
        Mon, 11 Jan 2021 05:10:15 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id s5sm18951963pju.9.2021.01.11.05.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 05:10:14 -0800 (PST)
Date:   Mon, 11 Jan 2021 21:10:08 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Al Grant <al.grant@arm.com>
Subject: Re: [PATCH v1 7/7] perf cs-etm: Detect pid in VMID for kernel
 running at EL2
Message-ID: <20210111131008.GA222747@leoy-ThinkPad-X240s>
References: <20210109074435.626855-1-leo.yan@linaro.org>
 <20210109074435.626855-8-leo.yan@linaro.org>
 <19205bb1-369a-9274-d752-d94f33a909f8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19205bb1-369a-9274-d752-d94f33a909f8@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 10:07:03AM +0000, Suzuki Kuruppassery Poulose wrote:
> Hi Leo
> 
> On 1/9/21 7:44 AM, Leo Yan wrote:
> > From: Suzuki K Poulose <suzuki.poulose@arm.com>
> > 
> > The pid of the task could be traced as VMID when the kernel is
> > running at EL2. Teach the decoder to look for vmid when the
> > context_id is invalid but we have a valid VMID.
> 
> Thank you again for cleaning up this ! Please see one comment
> below.

Welcome!

> > Cc: Mike Leach <mike.leach@linaro.org>
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Al Grant <al.grant@arm.com>
> > Co-developed-by: Leo Yan <leo.yan@linaro.org>
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >   .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 32 ++++++++++++++++---
> >   1 file changed, 28 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > index cd007cc9c283..9e81169dfa76 100644
> > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > @@ -6,6 +6,7 @@
> >    * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
> >    */
> > +#include <linux/coresight-pmu.h>
> >   #include <linux/err.h>
> >   #include <linux/list.h>
> >   #include <linux/zalloc.h>
> > @@ -500,13 +501,36 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
> >   			const ocsd_generic_trace_elem *elem,
> >   			const uint8_t trace_chan_id)
> >   {
> > -	pid_t tid;
> > +	pid_t tid = -1;
> > +	u64 pid_fmt;
> > +	int ret;
> > -	/* Ignore PE_CONTEXT packets that don't have a valid contextID */
> > -	if (!elem->context.ctxt_id_valid)
> > +	ret = cs_etm__get_pid_fmt(trace_chan_id, &pid_fmt);
> > +	if (ret)
> > +		return OCSD_RESP_FATAL_SYS_ERR;
> 
> The patch looks fine to me. I am wondering if this can be cached somewhere in
> the etmq to avoid doing the search everytime we hit a CID ? Surely for a session,
> this woudn't change and thus for the decoder life time.

Good suggestion, will refine for this in next version.

Thanks,
Leo
