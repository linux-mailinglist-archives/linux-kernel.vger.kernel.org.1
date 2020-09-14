Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3710F268891
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgINJgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgINJgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:36:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62512C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 02:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rFo3P/yVEyT/riHvD1+zwROozsgCZ0ZeAptyOa2H33c=; b=T9KZTDpWfoB57jBow3SI6kuA7g
        bd2gJINBMhS9DcpnlC24QPiXMjh4ndu42NvJvZCt0qQW4XErhdg9CxyUKOLjy0mz2Xoa7yRvtVocI
        VWnlXKgPGq7yoFebdCt9aM48eLlepjUVDt1ZJ8qhqPGScMD8ayI8e17U90u5LXXKxYRQjAKJKajt1
        wlFk02oHJEOqi2GL4H3Mjh7ADfonFV0OYdXXepN5F4MowWEgvBTCZFKAoSA8NwRgUvnC/Gn/aCTaJ
        aNTJtyLD/gfv1KsENa8kbns/F1/X0QTupv5hDXi6HdHXdY03KooduRqFrjmUixb3V5hY7WC7UAMim
        2+hYyHDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHku3-0007eb-As; Mon, 14 Sep 2020 09:36:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FEE73012C3;
        Mon, 14 Sep 2020 11:36:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D6192CA75AAC; Mon, 14 Sep 2020 11:36:02 +0200 (CEST)
Date:   Mon, 14 Sep 2020 11:36:02 +0200
From:   peterz@infradead.org
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 02/26] perf: Introduce mmap3 version of mmap event
Message-ID: <20200914093602.GN1362448@hirez.programming.kicks-ass.net>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913210313.1985612-3-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 11:02:49PM +0200, Jiri Olsa wrote:
> Add new version of mmap event. The MMAP3 record is an
> augmented version of MMAP2, it adds build id value to
> identify the exact binary object behind memory map:
> 
>   struct {
>     struct perf_event_header header;
> 
>     u32                      pid, tid;
>     u64                      addr;
>     u64                      len;
>     u64                      pgoff;
>     u32                      maj;
>     u32                      min;
>     u64                      ino;
>     u64                      ino_generation;
>     u32                      prot, flags;
>     u32                      reserved;
>     u8                       buildid[20];
>     char                     filename[];
>     struct sample_id         sample_id;
>   };
> 

So weren't there still open problems with mmap2 that also needed
addressing? I seem to have forgotten :/
