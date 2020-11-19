Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148AD2B8B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgKSG0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgKSG0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:26:06 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C55C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 22:26:04 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id u2so2385550pls.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 22:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cc5MbQguF0A1mSYKNGa0I3MBDb08Ww0fT/Ym4w8ZyHE=;
        b=jWWcX1EPzsIXJmgikwNnT2StegkIujBmwKI3Y7KQXiRtDc/VXsRALf1PPtcXd7YPHw
         zt7IxMQuC88RC/JdcQbUSJD2dRZiMaABhBZo4G1fK7q8aFOmJyuUpVFCdajwsbmsqXMi
         mslUflWzosHMLYvhQXpYGfXQYD6SwiaCH4dT7x5x+GDhUfGvsKijUYT3VPdKJ+tso/mW
         tCO4hW8y0Y6RrV4uz2vOQUq8povH4Ihb/bA6rp4H/IjbEWiai73V/fuH4cui6N3XJx3c
         t5DOXUUft+G3XA7ek0XOxOFZdbxAJ0QmSn7rLtITfdg0Xm498YlljYfiiI83CSDsVFiv
         rQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cc5MbQguF0A1mSYKNGa0I3MBDb08Ww0fT/Ym4w8ZyHE=;
        b=Kz/T65FhXU1WEDeMMiWkeKSuPb6vzTie/3v4fv7NC5Pw4DR5+lSNRqGAgnbFm1wpMR
         CnBu3dqpE4gSgYzvtl3iDBZzcTA8xzgKBHudjCTfOVfhkVcFso0a9OO2ZaNxdDo7E0kp
         FgIx4eMmDvEybDioJVOcnZAp4s4FKb6KnNC1YlfLZBgVo1yAnWGiOMkE2Pcs7zVueSZ/
         4veShTiJjFdAU5uCCdCT/O/SbuQJ/h0qJudnUsYBOyxag/omeT6D540SAqRDyTtag79h
         PnzC8o+yBGf4KhcSnrEmpm6gdT9rYb8K4ka9+mX3EFSljT0HQqHYH57dOhCh9eKKrXJ6
         +e0A==
X-Gm-Message-State: AOAM532hqgAsKaP8Q3s1tOOnffwVnKpoS9p62lAQyYev5l0MREeHo5Lo
        UrkouQgWWHQIFsdFNdnK0tjR3Q==
X-Google-Smtp-Source: ABdhPJxjCLM1G0DYXcKMmWtfuXFoKxxLjfinjQW2ViOY9KabDCMi34FP2gSD3sXT8HZVK9qsZ5hGRQ==
X-Received: by 2002:a17:902:aa83:b029:d8:c97d:9c2e with SMTP id d3-20020a170902aa83b02900d8c97d9c2emr8085630plr.44.1605767164326;
        Wed, 18 Nov 2020 22:26:04 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.127.239.100])
        by smtp.gmail.com with ESMTPSA id y16sm28835149pfl.144.2020.11.18.22.26.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Nov 2020 22:26:03 -0800 (PST)
Date:   Thu, 19 Nov 2020 14:25:58 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [RFC PATCH] perf session: Fixup timestamp for ordered events
Message-ID: <20201119062558.GA15885@leoy-ThinkPad-X240s>
References: <20201118105534.27828-1-leo.yan@linaro.org>
 <4163fdc6-fe27-7c9b-294c-123d7746058b@intel.com>
 <20201118114323.GB21177@leoy-ThinkPad-X240s>
 <5a080981-3da3-7d5e-822e-0d61c6529a81@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a080981-3da3-7d5e-822e-0d61c6529a81@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Wed, Nov 18, 2020 at 05:57:09PM +0200, Adrian Hunter wrote:

[...]

> >>> The follow diagram depicts the flow for how the AUX event is arriving
> >>> ahead than MMAP2 event:
> >>>
> >>>        T1:          T3:                  T4:
> >>>   perf process   Open PMU device    Perf is scheduled out;
> >>>                                     invoke perf_aux_output_end()
> >>> 	                            and generate AUX event
> >>>        ^            ^                    ^
> >>>        |            |                    |
> >>>  CPU0 ---------------------------------------------------> (T)
> >>>        \
> >>>         \  Forked process is placed on another CPU
> >>>          V
> >>>  CPU1 ---------------------------------------------------> (T)
> >>>               |                                |
> >>>               V                                V
> >>>               T2:                              T5:
> >>>         Invoke execvp() for profiled       Record MMAP2 event
> >>>       	program
> >>
> >> I don't understand.  An MMAP at T5 cannot affect data recorded before T5
> >> (e.g. T4).
> >> Are you saying the timestamps from different CPUs are not in time order?  Ot
> >> are you saying the data is actually recorded after T5?
> > 
> > Here refers to the later one.
> > 
> > I observed the PMU device is opened and closed for multiple times, so
> > the AUX events and MMAP2 events are interleave with each other.  Below
> > is the dumping with debugging option "--debug ordered-events=1" (and I
> > added code for printing out event type value).
> > 
> > When perf tool starts to decode the trace data for the first AUX event
> > (its timestamp is 160.767623) and try to synthesize samples, it doesn't
> > give chance for handling the sequential MMAP2 events (ts: 160.770223,
> > 160.770451, 160.773111).
> > 
> > [          160.765623] queue_event nr_events 1
> > [          160.765623] new event on queue: type=12
> > [          160.765714] queue_event nr_events 2
> > [          160.765714] new event on queue: type=3
> > [          160.765822] queue_event nr_events 3
> > [          160.765822] new event on queue: type=10  ==> MMAP2 event
> > [          160.766180] queue_event nr_events 4
> > [          160.766180] new event on queue: type=14
> > [          160.767623] queue_event nr_events 5
> > [          160.767623] new event on queue: type=11  ==> AUX event
> > [          160.769710] queue_event nr_events 6
> > [          160.769710] new event on queue: type=12
> > [          160.769762] queue_event nr_events 7
> > [          160.769762] new event on queue: type=14
> > [          160.769810] queue_event nr_events 8
> > [          160.769810] new event on queue: type=14
> > [          160.769943] queue_event nr_events 9
> > [          160.769943] new event on queue: type=11  ==> AUX event
> > [          160.770028] queue_event nr_events 10
> > [          160.770028] new event on queue: type=12
> > [          160.770073] queue_event nr_events 11
> > [          160.770073] new event on queue: type=14
> > [          160.770223] queue_event nr_events 12
> > [          160.770223] new event on queue: type=10  ==> MMAP2 event
> > [          160.770451] queue_event nr_events 13
> > [          160.770451] new event on queue: type=10  ==> MMAP2 event
> > [          160.770628] queue_event nr_events 14
> > [          160.770628] new event on queue: type=14
> > [          160.771650] queue_event nr_events 15
> > [          160.771650] new event on queue: type=11  ==> AUX event
> > [          160.771752] queue_event nr_events 16
> > [          160.771752] new event on queue: type=12
> > [          160.771798] queue_event nr_events 17
> > [          160.771798] new event on queue: type=14
> > [          160.773111] queue_event nr_events 18
> > [          160.773111] new event on queue: type=10  ==> MMAP2 event
> > [          160.782613] queue_event nr_events 19
> > [          160.782613] new event on queue: type=14
> > 
> > Thanks for the reviewing,
> > 
> > Leo
> > 
> 
> When you say AUX event, do you mean PERF_RECORD_AUX or PERF_RECORD_AUXTRACE?

The AUX event is PERF_RECORD_AUX.

> The kernel creates PERF_RECORD_AUX and the data range aux_offset/aux_size
> should be for things prior to the sample time.
> 
> perf tool creates PERF_RECORD_AUXTRACE when copying data out of the aux
> area. PERF_RECORD_AUXTRACE does not have a timestamp and can contain data
> corresponding to several PERF_RECORD_AUX.  Data is queued based on
> PERF_RECORD_AUXTRACE because that is what the data is attached to i.e. one
> buffer can contain data from several PERF_RECORD_AUX events.
> 
> If you are processing data based on PERF_RECORD_AUX timestamp then you need
> to pay attention to the offset.  PERF_RECORD_AUX gives you
> aux_offset/aux_size and auxtrace_buffer (which may contain data from several
> PERF_RECORD_AUX) gives you offset/size.

Yeah, as you suggested, in this case the key point is for the first
PERF_RECORD_AUX event handling, in theory it should contain very short
trace data and exit the decoding quickly.  The issue is the first
PERF_RECORD_AUX event will decode all AUX trace data; and near the end
of events handling, the tool finally has chance to process MMAP2 events.

So this RFC patch is not the right way, I will dig more for
PERF_RECORD_AUX event handling for cs-etm.

Thanks for the detailed explanation and suggetions.

Leo
