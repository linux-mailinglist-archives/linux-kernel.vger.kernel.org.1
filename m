Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C60298A81
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 11:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769875AbgJZKdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 06:33:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31269 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1769870AbgJZKch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 06:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603708356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FOPq4ZW3z2PfNiN4EUeWCvjk9nboDdJXFexkIu/a4SE=;
        b=NoU2eAcpREN2jf39a1zyQW/LvrFn0kt2TLq0rY/n5V2uEqoEm70qOOUhuJa/xMThY1ineE
        uQe5NxLgWfeaEJ1ZOgwzK755TPuEj/8wr0cY9qYODgeaLpiRI7vGrbV2tFkABfYZch10aJ
        eMIOqC2nhDA2T6hRxmCZcyhBE6shkMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-umQcQKU6PAWVIwQ5WdcD5g-1; Mon, 26 Oct 2020 06:32:33 -0400
X-MC-Unique: umQcQKU6PAWVIwQ5WdcD5g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4844B1084D64;
        Mon, 26 Oct 2020 10:32:31 +0000 (UTC)
Received: from krava (unknown [10.40.194.69])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6506A5B4B1;
        Mon, 26 Oct 2020 10:32:28 +0000 (UTC)
Date:   Mon, 26 Oct 2020 11:32:27 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Budankov <budankov.lore@gmail.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/15] perf record: write trace data into mmap trace
 files
Message-ID: <20201026103227.GB2726983@krava>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <1202e665-6321-28d4-eca3-b21693364467@linux.intel.com>
 <20201024154423.GG2589351@krava>
 <adc90ef5-58cc-8578-13f7-cbce895f1a28@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adc90ef5-58cc-8578-13f7-cbce895f1a28@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 11:52:21AM +0300, Alexei Budankov wrote:
> 
> On 24.10.2020 18:44, Jiri Olsa wrote:
> > On Wed, Oct 21, 2020 at 07:02:56PM +0300, Alexey Budankov wrote:
> > 
> > SNIP
> > 
> >>  
> >>  	record__synthesize(rec, true);
> >> -	/* this will be recalculated during process_buildids() */
> >> -	rec->samples = 0;
> >>  
> >>  	if (!err) {
> >>  		if (!rec->timestamp_filename) {
> >> @@ -2680,9 +2709,12 @@ int cmd_record(int argc, const char **argv)
> >>  
> >>  	}
> >>  
> >> -	if (rec->opts.kcore)
> >> +	if (rec->opts.kcore || record__threads_enabled(rec))
> >>  		rec->data.is_dir = true;
> >>  
> >> +	if (record__threads_enabled(rec))
> >> +		rec->opts.affinity = PERF_AFFINITY_CPU;
> > 
> > so all the threads will pin to cpu and back before reading?
> 
> No, they will not back. Thread mask compares to mmap mask before
> read and the thread migrates if masks don't match. This happens
> once on the first mmap read. So explicit pinning can be avoided.

hum, is that right? the check in record__adjust_affinity
is checking global 'rec->affinity_mask', at lest I assume
it's still global ;-)

        if (rec->opts.affinity != PERF_AFFINITY_SYS &&
            !bitmap_equal(rec->affinity_mask.bits, map->affinity_mask.bits,
                          rec->affinity_mask.nbits)) {

I think this can never be equal if you have more than one map

when I check on sched_setaffinity syscalls:

  # perf trace -e syscalls:sys_enter_sched_setaffinity

while running record --threads, I see sched_setaffinity
calls all the time

jirka

