Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FB029888B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771932AbgJZIjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:39:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33375 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1771910AbgJZIjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:39:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id c21so8875275ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 01:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SJVJbhoKz4aaFtSEJlka8Wv0MoyyH2FHuoqyqaBoZFQ=;
        b=AKKImwjmjw86TnzIlMStxL8lw/MAXYOq7yOS9qi1dZWjWiLHHVo+x0E+9RRxBaeEhV
         lMWDvzCQIhItP8LU1vG1rgQoi4XF+p+a3uo1pTOsPvJP+SE5hpO7Co7yRgJozputGi+r
         w8ZRoKPAm5djhjut86drs7VD6VSBR1XTR4QMkaKRxlxL5oyvcV1GK01cn6PwCcur2LoW
         bBpuvoCKuDG9n5hLCccAoQAztSKH85X2KiqzbuBXL7/HUtWv7sV/oQYJevQ7SVnmkU5J
         wRKesMPTr5QEj8kl1FV/GtwchgMiQyoyFrB/OPnVU6yP1Ie/bpCOoLxWLgyq7PDFe/eq
         RZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SJVJbhoKz4aaFtSEJlka8Wv0MoyyH2FHuoqyqaBoZFQ=;
        b=qJ1eW4I0celIiKy+uxSJxvOV0pVdflgNmzk2z+H7Jm/LxzSDMysV/nESdKY6K+4ZY0
         f8MAB+Uu3diIvAqA744Pp4E+vNhJXUtV9G6VJMBJG4u3MQpeOdLyzP84HPwimPtDc0FZ
         3L1RIG87efONbG1uNQ6lgmvgyP7Z78vrDE/jOEYgZCwdnExmLXNU4VwIiKiO5Hh2tN0N
         TWB9NFiH6uCTxYX2qzIuPfCmg6gPG5t6mPo+2hiXsy1RBxwFWoKvYibBfnSC6Ko4J/T6
         KRByRL/Q2RroCxSaBwINCzw87BCIiYKrIldSUGc3PgDRU9KJbeYBHIZa3Wdzg48binOA
         kAfA==
X-Gm-Message-State: AOAM533+QVEP6MyNNPj8k6uILOkttbTuFEum4zr6LDKEl9NYW5YJwPnI
        rSsf0UYLOt7DAKYF5u6WV9vyj+PDOsQY5g==
X-Google-Smtp-Source: ABdhPJxc0we/RHjmmmSsY+l2S3MkoOk6CZgDU/3gm3kKPhURg3OSXG4tMGYjqu67qjs7lHmcQHSdEw==
X-Received: by 2002:a2e:8108:: with SMTP id d8mr5518100ljg.96.1603701547203;
        Mon, 26 Oct 2020 01:39:07 -0700 (PDT)
Received: from [192.168.0.10] (89-109-58-109.dynamic.mts-nn.ru. [89.109.58.109])
        by smtp.gmail.com with ESMTPSA id p5sm1006937lfj.0.2020.10.26.01.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 01:39:06 -0700 (PDT)
Subject: Re: [PATCH v2 10/15] perf record: manage thread specific data array
To:     Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <06b6c1bb-9875-83f8-2b1d-601e186ea80a@linux.intel.com>
 <20201024154408.GE2589351@krava>
From:   Alexei Budankov <budankov.lore@gmail.com>
Organization: Intel Corp.
Message-ID: <2a32cb3c-fc22-10cc-8ae2-b62781f48194@gmail.com>
Date:   Mon, 26 Oct 2020 11:39:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201024154408.GE2589351@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24.10.2020 18:44, Jiri Olsa wrote:
> On Wed, Oct 21, 2020 at 07:04:26PM +0300, Alexey Budankov wrote:
>>
>> Provide allocation, initialization, finalization and releasing of
>> thread specific objects at thread specific data array. Allocate
>> thread specific object for every data buffer making one-to-one
>> relation between data buffer and a thread processing the buffer.
>> Deliver event fd related signals to thread's pollfd object.
>> Deliver thread control commands to ctlfd_pos fd of thread 1+.
>> Deliver tool external control commands via ctlfd_pos fd of thread 0.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/builtin-record.c | 101 ++++++++++++++++++++++++++++++++++--
>>  1 file changed, 98 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 8e512096a060..89cb8e913fb3 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -884,6 +884,94 @@ static int record__kcore_copy(struct machine *machine, struct perf_data *data)
>>  	return kcore_copy(from_dir, kcore_dir);
>>  }
>>  
>> +static int record__alloc_thread_data(struct record *rec, struct mmap *mmaps, int nr_mmaps,
>> +				     struct fdarray *evlist_pollfd, int ctlfd_pos)
>> +{
>> +	int i, j, k, nr_thread_data;
>> +	struct thread_data *thread_data;
>> +
>> +	rec->nr_thread_data = nr_thread_data = nr_mmaps;
>> +	rec->thread_data = thread_data = zalloc(rec->nr_thread_data * sizeof(*(rec->thread_data)));
>> +	if (!thread_data) {
>> +		pr_err("Failed to allocate thread data\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	for (i = 0; i < nr_thread_data; i++) {
>> +		short revents;
>> +		int pos, fd;
>> +
>> +		thread_data[i].tid = -1;
>> +
>> +		if (pipe(thread_data[i].comm.msg) ||
>> +		    pipe(thread_data[i].comm.ack)) {
>> +			pr_err("Failed to create thread comm pipes, errno %d\n", errno);
>> +			return -ENOMEM;
>> +		}
> 
> the original code was using state flag and pthread_cond,
> which I think is more readable
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=perf/record_threads&id=a7da527ff8be69572c6d17525c03c6fe394503c8
> https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=perf/record_threads&id=eb85ce4da64a885fdb6c77cfc5bd71312fe02e2a

Yes, right, but messaging scales better and that critical section
to just increment global counter in memory looked as over complication.

> 
>> +
>> +		thread_data[i].maps = &mmaps[i];
>> +		thread_data[i].nr_mmaps = 1;
>> +
>> +		thread_data[i].rec = rec;
>> +
>> +		fdarray__init(&(thread_data[i].pollfd), 64);
>> +
>> +		for (j = 0; j < thread_data[i].nr_mmaps; j++) {
>> +			struct mmap *map = &(thread_data[i].maps[j]);
>> +
>> +			for (k = 0; k < evlist_pollfd->nr; k++) {
>> +				if (evlist_pollfd->priv[k].ptr != map)
>> +					continue;
>> +
>> +				fd = evlist_pollfd->entries[k].fd;
>> +				revents = evlist_pollfd->entries[k].events;
>> +				pos = fdarray__add(&(thread_data[i].pollfd),
>> +						fd, revents | POLLERR | POLLHUP,
>> +						fdarray_flag__default);
>> +				if (pos >= 0)
>> +					thread_data[i].pollfd.priv[pos].ptr = map;
>> +				else
>> +					return -ENOMEM;
> 
> I added function for that:
>   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=perf/record_threads&id=8aa6e68a7471b9d25af1a9eebfa9321433366a17

Ok, but it is not clone operation it is more like ordinary adding of
fd into another pollfd object. It could be wrapped into a function
e.g. fdarray__dup(pollfd_dst, fd_src, fd_revents)

Alexei
