Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43CC297D33
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 17:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762117AbgJXPom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 11:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32207 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761098AbgJXPol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 11:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603554280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=32NgTVPVkV+hTa4Fp4UdRpCuBFT6chXDih3qL8r3EJ4=;
        b=Q9kswszBQ2x+rSBjoF5zThz9IVuxSGp8ldfvbt9FeWnJkfksoHcoSQVj4ObvbsPyMpVg9O
        N9Awz7RInoX+pFOJ46GMvhKqXX9cjUt1l1EFG9SOBkhRo447rz38NoFMIlt5WVdseZfhv9
        UtvSqt9qW61qB7Wp6JMi4glsGCz/S0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-wxqpZYWnMPSSSnyVjilsJw-1; Sat, 24 Oct 2020 11:44:35 -0400
X-MC-Unique: wxqpZYWnMPSSSnyVjilsJw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A1F51868404;
        Sat, 24 Oct 2020 15:44:34 +0000 (UTC)
Received: from krava (unknown [10.40.192.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6389360C84;
        Sat, 24 Oct 2020 15:44:32 +0000 (UTC)
Date:   Sat, 24 Oct 2020 17:44:31 +0200
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
Subject: Re: [PATCH v2 09/15] perf record: introduce thread specific objects
 for trace streaming
Message-ID: <20201024154431.GH2589351@krava>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <bede5b00-8419-c03f-8595-7011679d363a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bede5b00-8419-c03f-8595-7011679d363a@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 07:03:48PM +0300, Alexey Budankov wrote:
> 
> Introduce thread local data object and its array to be used for
> threaded trace streaming.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index ba26d75c51d6..8e512096a060 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -85,11 +85,29 @@ struct switch_output {
>  	int		 cur_file;
>  };
>  
> +struct thread_data {
> +	pid_t		   tid;
> +	struct {
> +		int	   msg[2];
> +		int	   ack[2];
> +	} comm;
> +	struct fdarray	   pollfd;
> +	int		   ctlfd_pos;
> +	struct mmap	   *maps;
> +	int		   nr_mmaps;
> +	struct record	   *rec;
> +	unsigned long long samples;
> +	unsigned long	   waking;
> +	u64		   bytes_written;
> +};

please merge the struct with the code that's using it

jirka

> +
>  struct record {
>  	struct perf_tool	tool;
>  	struct record_opts	opts;
>  	u64			bytes_written;
>  	struct perf_data	data;
> +	struct thread_data	*thread_data;
> +	int			nr_thread_data;
>  	struct auxtrace_record	*itr;
>  	struct evlist	*evlist;
>  	struct perf_session	*session;
> -- 
> 2.24.1
> 

