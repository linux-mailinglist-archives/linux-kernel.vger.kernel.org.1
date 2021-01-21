Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41F22FEC39
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbhAUNrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:47:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbhAUNlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:41:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 205EE239EB;
        Thu, 21 Jan 2021 13:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611236421;
        bh=4AR6L7DGRamXUE2dnlWbtfsRdal/LOjzCiotvRPenVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=teki8pS1R7S4V77ieu1yb/dq2WfbeZFzRaGxH1IRfpaakU9UA14YzbuQ6rrVuB2qJ
         KUWHMtCf4/WXlxkrr3QZIpYzrfvqxok8QbI96T0p9X3Vke0UngiMJqkEQz+3nfUwb4
         50UmbdbZujJHKF8WFQ6T3IEsqsThOZCgjEmrMp94Jr8ywTD2IyZSptN7vzxTzl3uWk
         gKkaVY/Vyw4pV2pO0M4W0hMxNhC9UQGc3A7mPHSE89POI2/DmHpPLQKva1cNuRR2UA
         46P84l4qB7rxlaao+DRRHzlwKDM4x1fVpsjFtdYVRhyZmh1U81RD6spaSKCXfxIf9o
         yGoMv/UEUG/Fg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 01EF740513; Thu, 21 Jan 2021 10:40:18 -0300 (-03)
Date:   Thu, 21 Jan 2021 10:40:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>
Subject: Re: [PATCH] perf evlist: Fix id index for heterogeneous systems
Message-ID: <20210121134018.GC12699@kernel.org>
References: <20210121125446.11287-1-adrian.hunter@intel.com>
 <20210121131901.GA345740@kernel.org>
 <eb24747b-0b93-6373-cb84-52596ef3fc89@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb24747b-0b93-6373-cb84-52596ef3fc89@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 21, 2021 at 03:39:03PM +0200, Adrian Hunter escreveu:
> On 21/01/21 3:19 pm, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jan 21, 2021 at 02:54:46PM +0200, Adrian Hunter escreveu:
> >> perf_evlist__set_sid_idx() updates perf_sample_id with the evlist map
> >> index, cpu number and tid. It is passed indexes to the evsel's cpu and
> >> thread maps, but references the evlist's maps instead. That results in
> >> using incorrect cpu numbers on heterogeneous systems. Fix by using evsel
> >> maps.
> >>
> >> The id index (PERF_RECORD_ID_INDEX) is used by AUX area tracing when in
> >> sampling mode. Having an incorrect cpu number causes the trace data to
> >> be attributed to the wrong cpu, and can result in decoder errors because
> >> the trace data is then associated with the wrong process.
> > 
> > Can you please provide a Fixes: tag so that the stable@kernel.org guys
> > can apply where appropriate?
> 
> Oops sorry missed that.  Here it is:
> 
> Fixes: 3c659eedada2 ("perf tools: Add id index")


Thanks a lot!

- Arnaldo
