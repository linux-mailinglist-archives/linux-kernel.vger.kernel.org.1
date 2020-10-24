Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC06D297D2D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 17:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762024AbgJXPoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 11:44:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761996AbgJXPoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 11:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603554254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/g/H91o/pxXl7AM0l0MUieFaGOGgGANNHpr9CZflGaw=;
        b=CqR/IYasZlsLf+7M1RbuuMcuZq7BWVb3n6p70weB2NjKVD0ayezARBiLAP6REfbDMvMS0z
        2EOuLqNXnUzgyXXDzfSdOboCiCNqLwxVEaefjI6p/tUupHKUC24UOoCZn2/hP2l7RwT2CF
        JG1EwQTV5UCO9mYGo9xa+QIcvoW5aX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-JdfPLLO1OBqq-aeJiozurA-1; Sat, 24 Oct 2020 11:44:12 -0400
X-MC-Unique: JdfPLLO1OBqq-aeJiozurA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00CC7803F78;
        Sat, 24 Oct 2020 15:44:11 +0000 (UTC)
Received: from krava (unknown [10.40.192.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1AEC460C84;
        Sat, 24 Oct 2020 15:44:08 +0000 (UTC)
Date:   Sat, 24 Oct 2020 17:44:08 +0200
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
Subject: Re: [PATCH v2 10/15] perf record: manage thread specific data array
Message-ID: <20201024154408.GE2589351@krava>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <06b6c1bb-9875-83f8-2b1d-601e186ea80a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06b6c1bb-9875-83f8-2b1d-601e186ea80a@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 07:04:26PM +0300, Alexey Budankov wrote:
> 
> Provide allocation, initialization, finalization and releasing of
> thread specific objects at thread specific data array. Allocate
> thread specific object for every data buffer making one-to-one
> relation between data buffer and a thread processing the buffer.
> Deliver event fd related signals to thread's pollfd object.
> Deliver thread control commands to ctlfd_pos fd of thread 1+.
> Deliver tool external control commands via ctlfd_pos fd of thread 0.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 101 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 98 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 8e512096a060..89cb8e913fb3 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -884,6 +884,94 @@ static int record__kcore_copy(struct machine *machine, struct perf_data *data)
>  	return kcore_copy(from_dir, kcore_dir);
>  }
>  
> +static int record__alloc_thread_data(struct record *rec, struct mmap *mmaps, int nr_mmaps,
> +				     struct fdarray *evlist_pollfd, int ctlfd_pos)
> +{
> +	int i, j, k, nr_thread_data;
> +	struct thread_data *thread_data;
> +
> +	rec->nr_thread_data = nr_thread_data = nr_mmaps;
> +	rec->thread_data = thread_data = zalloc(rec->nr_thread_data * sizeof(*(rec->thread_data)));
> +	if (!thread_data) {
> +		pr_err("Failed to allocate thread data\n");
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < nr_thread_data; i++) {
> +		short revents;
> +		int pos, fd;
> +
> +		thread_data[i].tid = -1;
> +
> +		if (pipe(thread_data[i].comm.msg) ||
> +		    pipe(thread_data[i].comm.ack)) {
> +			pr_err("Failed to create thread comm pipes, errno %d\n", errno);
> +			return -ENOMEM;
> +		}

the original code was using state flag and pthread_cond,
which I think is more readable

https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=perf/record_threads&id=a7da527ff8be69572c6d17525c03c6fe394503c8
https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=perf/record_threads&id=eb85ce4da64a885fdb6c77cfc5bd71312fe02e2a

> +
> +		thread_data[i].maps = &mmaps[i];
> +		thread_data[i].nr_mmaps = 1;
> +
> +		thread_data[i].rec = rec;
> +
> +		fdarray__init(&(thread_data[i].pollfd), 64);
> +
> +		for (j = 0; j < thread_data[i].nr_mmaps; j++) {
> +			struct mmap *map = &(thread_data[i].maps[j]);
> +
> +			for (k = 0; k < evlist_pollfd->nr; k++) {
> +				if (evlist_pollfd->priv[k].ptr != map)
> +					continue;
> +
> +				fd = evlist_pollfd->entries[k].fd;
> +				revents = evlist_pollfd->entries[k].events;
> +				pos = fdarray__add(&(thread_data[i].pollfd),
> +						fd, revents | POLLERR | POLLHUP,
> +						fdarray_flag__default);
> +				if (pos >= 0)
> +					thread_data[i].pollfd.priv[pos].ptr = map;
> +				else
> +					return -ENOMEM;

I added function for that:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=perf/record_threads&id=8aa6e68a7471b9d25af1a9eebfa9321433366a17

jirka

> +			}
> +		}
> +
> +		if (i) {
> +			fd = thread_data[i].comm.msg[0];
> +			revents = POLLIN | POLLERR | POLLHUP;
> +		} else {
> +			if (ctlfd_pos == -1)
> +				continue;
> +			fd = evlist_pollfd->entries[ctlfd_pos].fd;
> +			revents = evlist_pollfd->entries[ctlfd_pos].events;
> +		}
> +		thread_data[i].ctlfd_pos =
> +				fdarray__add(&(thread_data[i].pollfd),
> +					     fd, revents, fdarray_flag__nonfilterable);
> +		if (thread_data[i].ctlfd_pos < 0)
> +			return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int record__free_thread_data(struct record *rec)
> +{
> +	int i;
> +
> +	if (rec->thread_data) {
> +		for (i = 0; i < rec->nr_thread_data; i++) {
> +			close(rec->thread_data[i].comm.msg[0]);
> +			close(rec->thread_data[i].comm.msg[1]);
> +			close(rec->thread_data[i].comm.ack[0]);
> +			close(rec->thread_data[i].comm.ack[1]);
> +			fdarray__exit(&(rec->thread_data[i].pollfd));
> +		}
> +		zfree(&rec->thread_data);
> +	}
> +
> +	return 0;
> +}
> +
>  static int record__mmap_evlist(struct record *rec,
>  			       struct evlist *evlist)
>  {
> @@ -918,6 +1006,9 @@ static int record__mmap_evlist(struct record *rec,
>  		}
>  	}
>  
> +	if (evlist__initialize_ctlfd(evlist, opts->ctl_fd, opts->ctl_fd_ack))
> +		return -1;
> +
>  	if (record__threads_enabled(rec)) {
>  		int i, ret, nr = evlist->core.nr_mmaps;
>  		struct mmap *mmaps = rec->opts.overwrite ?
> @@ -929,6 +1020,12 @@ static int record__mmap_evlist(struct record *rec,
>  
>  		for (i = 0; i < nr; i++)
>  			mmaps[i].file = &rec->data.dir.files[i];
> +
> +		ret = record__alloc_thread_data(rec, mmaps, nr,
> +						&evlist->core.pollfd,
> +						evlist->ctl_fd.pos);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	return 0;
> @@ -1910,9 +2007,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		perf_evlist__start_workload(rec->evlist);
>  	}
>  
> -	if (evlist__initialize_ctlfd(rec->evlist, opts->ctl_fd, opts->ctl_fd_ack))
> -		goto out_child;
> -
>  	if (opts->initial_delay) {
>  		pr_info(EVLIST_DISABLED_MSG);
>  		if (opts->initial_delay > 0) {
> @@ -2063,6 +2157,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		record__synthesize_workload(rec, true);
>  
>  out_child:
> +	record__free_thread_data(rec);
>  	evlist__finalize_ctlfd(rec->evlist);
>  	record__mmap_read_all(rec, true);
>  	record__aio_mmap_read_sync(rec);
> -- 
> 2.24.1
> 

