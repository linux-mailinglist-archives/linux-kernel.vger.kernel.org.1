Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C975297D32
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 17:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762096AbgJXPod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 11:44:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756857AbgJXPoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 11:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603554271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mI5GbpgU1NnbT11QNPGPODS/+cPzVZHr6APt9Y3KhDg=;
        b=eCNsbyUjTIuTlGMOZQ997GycZJ66fukQbD6nUUjpd6311ziaS0Gh6WBMTBjbZGudK81hK7
        vTvaUGL/tzsIbMkhjrAismkRj6CeihBwqgoexBCOgVjKzWtrr/obzgPbwAISrsMTaJAcu5
        h7SmxjIia5rBGOnqkHymtGzQIggnavw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-tKtnOXtrNjSuwb_Lp1DUuQ-1; Sat, 24 Oct 2020 11:44:27 -0400
X-MC-Unique: tKtnOXtrNjSuwb_Lp1DUuQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E693C804B6A;
        Sat, 24 Oct 2020 15:44:25 +0000 (UTC)
Received: from krava (unknown [10.40.192.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0DA4860CD0;
        Sat, 24 Oct 2020 15:44:23 +0000 (UTC)
Date:   Sat, 24 Oct 2020 17:44:23 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/15] perf record: write trace data into mmap trace
 files
Message-ID: <20201024154423.GG2589351@krava>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <1202e665-6321-28d4-eca3-b21693364467@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1202e665-6321-28d4-eca3-b21693364467@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 07:02:56PM +0300, Alexey Budankov wrote:

SNIP

>  
>  	record__synthesize(rec, true);
> -	/* this will be recalculated during process_buildids() */
> -	rec->samples = 0;
>  
>  	if (!err) {
>  		if (!rec->timestamp_filename) {
> @@ -2680,9 +2709,12 @@ int cmd_record(int argc, const char **argv)
>  
>  	}
>  
> -	if (rec->opts.kcore)
> +	if (rec->opts.kcore || record__threads_enabled(rec))
>  		rec->data.is_dir = true;
>  
> +	if (record__threads_enabled(rec))
> +		rec->opts.affinity = PERF_AFFINITY_CPU;

so all the threads will pin to cpu and back before reading?
it makes sense for one thread, but why not pin every thread
at the start?

jirka

