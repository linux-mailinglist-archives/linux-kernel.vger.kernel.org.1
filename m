Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274EE297D34
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 17:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762134AbgJXPos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 11:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1762128AbgJXPos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 11:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603554287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0wAda7TDqK/ulZz/rTqmSI7BdeMAlzw6CIJ0PXAH3Ys=;
        b=JuAjWTLDQ1T9KO1feRXIsT6q0rHQGK07rmFFyAKKugGnyjfDOokuzeZAI7PjGuAnKFoqGb
        oTruRS2UE9QMwihTEIy/kJETec5ETu7Z1QOaLo59gmfYt8xc6K5YKIHdVHcKRU1yqeLw0K
        y5SknCgA9363o6kua6pmc/fZO+GVgSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-pUbfwcDEM3yNtth9wlEs-g-1; Sat, 24 Oct 2020 11:44:43 -0400
X-MC-Unique: pUbfwcDEM3yNtth9wlEs-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4D4A805F0A;
        Sat, 24 Oct 2020 15:44:41 +0000 (UTC)
Received: from krava (unknown [10.40.192.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id BAF8855762;
        Sat, 24 Oct 2020 15:44:39 +0000 (UTC)
Date:   Sat, 24 Oct 2020 17:44:38 +0200
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
Subject: Re: [PATCH v2 05/15] perf session: introduce decompressor into trace
 reader object
Message-ID: <20201024154438.GI2589351@krava>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <b3c73389-7b4c-89cd-423c-68b00fcc61c9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3c73389-7b4c-89cd-423c-68b00fcc61c9@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 07:00:30PM +0300, Alexey Budankov wrote:
> 
> Introduce decompressor to trace reader object so that decompression
> could be executed on per trace file basis separately for every
> trace file located in trace directory.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/session.c | 4 +++-
>  tools/perf/util/session.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 911b2dbcd0ac..6afc670fdf0c 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -44,6 +44,8 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>  	u64 decomp_last_rem = 0;
>  	size_t mmap_len, decomp_len = session->header.env.comp_mmap_len;
>  	struct decomp *decomp, *decomp_last = session->decomp_last;
> +	struct zstd_data *zstd_data = session->reader ?
> +		&(session->reader->zstd_data) : &(session->zstd_data);

I don't think we're using braces in these cases, they are not necessary

jirka

>  
>  	if (decomp_last) {
>  		decomp_last_rem = decomp_last->size - decomp_last->head;
> @@ -71,7 +73,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>  	src = (void *)event + sizeof(struct perf_record_compressed);
>  	src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
>  
> -	decomp_size = zstd_decompress_stream(&(session->zstd_data), src, src_size,
> +	decomp_size = zstd_decompress_stream(zstd_data, src, src_size,
>  				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
>  	if (!decomp_size) {
>  		munmap(decomp, mmap_len);
> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index abdb8518a81f..4fc9ccdf7970 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -42,6 +42,7 @@ struct reader {
>  	u64		 data_size;
>  	u64		 data_offset;
>  	reader_cb_t	 process;
> +	struct zstd_data zstd_data;
>  };
>  
>  struct perf_session {
> -- 
> 2.24.1
> 
> 

