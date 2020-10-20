Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91582935B7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405108AbgJTH0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:26:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59054 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731225AbgJTH0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603178775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WCFAopo+cEFCy2X+ReJ+801uHfD9Q6flHYrpBpeHGik=;
        b=JOgtrOyXWkZpvtHCr637UF6TIK6hMaVeArDJGMW4jxuKrV8DQuCJAiHAbx2ukAE7BuJGzg
        cddooYRVpG9LVa4/p6hsZteSnblSLNZVX17o8ptxjMIaWa1utUQezJ/2ExysH29us3lbI/
        R9vIj1/ncoZrlhz8foTMau/hnHe4hj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-VfkAECRnPKSBrusFbIdktA-1; Tue, 20 Oct 2020 03:26:13 -0400
X-MC-Unique: VfkAECRnPKSBrusFbIdktA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E13D875060;
        Tue, 20 Oct 2020 07:26:11 +0000 (UTC)
Received: from krava (unknown [10.40.192.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE80860C13;
        Tue, 20 Oct 2020 07:26:04 +0000 (UTC)
Date:   Tue, 20 Oct 2020 09:26:03 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 7/8] perf c2c: Add option '-d llc' for sorting with
 LLC load
Message-ID: <20201020072603.GD2084117@krava>
References: <20201015145041.10953-1-leo.yan@linaro.org>
 <20201015145041.10953-8-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201015145041.10953-8-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 03:50:40PM +0100, Leo Yan wrote:
> Except the existed three display options 'tot', 'rmt', 'lcl', this patch
> adds option 'llc' so that can sort on LLC load metrics.  The new
> introduced option can work as a choice if the memory event doesn't
> contain HITM tags.
> 
> For the display with option 'llc', both the "Shared Data Cache Line
> Table" and "Shared Cache Line Distribution Pareto" have difference
> comparing to other three display options.
> 
> For the "Shared Data Cache Line Table", instead of sorting HITM metrics,
> it sorts with the LLC hit metrics "tot_llchit".  In this case, users
> should be interested in LLC related statistics, so the dimensions of
> total LLC hit is used to replace HITM related dimensions.
> 
> For Pareto, every single cache line shows the metrics "cl_llc_hit"
> instead of "cl_rmt_hitm", and the single cache line view is sorted by
> metrics "tot_llchit".

hi,
I'm getting compilation error on newer gcc:

  CC       builtin-c2c.o
builtin-c2c.c: In function ‘perf_c2c__report’:
builtin-c2c.c:1979:9: error: ‘sort_str’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
 1979 |  return hpp_list__parse(&c2c_hists->list, output, sort);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
builtin-c2c.c:2900:27: note: ‘sort_str’ was declared here
 2900 |  const char *output_str, *sort_str;
      |                           ^~~~~~~~


jirka

