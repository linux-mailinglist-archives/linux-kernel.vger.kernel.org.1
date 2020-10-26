Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4762988CA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772268AbgJZIx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:53:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39896 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1772252AbgJZIxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:53:25 -0400
Received: by mail-lf1-f68.google.com with SMTP id 184so10715771lfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 01:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C4bZm2eS2zgsQIGp/wEVKkAI+z4jJ4XW2OwJLttIGe0=;
        b=SbrC2mBiF9FkY6uAv3Er1XPIF0IcE+yPSs+OgVoxhb3h2HS+SXrd09PZkO9InXOix7
         Gb9ZnuO4GxDBphGnxGCOkaqnNMRnSTxZHLWv3QaUPus10yTbvsHCNIrTJtkde7PDZ5k4
         /wnv4/XstVXIevYQcf1Rsz8jUqDeO+ZbHcvwqefJXpIFGKrRlfS4aHl8387Q5/LCnPoj
         5gQlgY5/3c5G6hrpgl06BYZOY2QtLdRxU1+woIiBp9cKcIkAn5Rm4q2h7mLQCTjYn+Dc
         N+1z1coWCKz9qlkA8oP/dxCpG2ySLXxHrbHKhRGG5rCB3nlk65GZgXIO1P5UfK/6NLXh
         TxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=C4bZm2eS2zgsQIGp/wEVKkAI+z4jJ4XW2OwJLttIGe0=;
        b=h6gTPn0j/klkbGg57BiHaTcoU0UTwd+9RndGz6vnxQnJAu5NCLUwuGvddZQON2K0ef
         XrM+Iq8O0nBdBwbXfvT30HtXDLEPIRvHlzrRIL/7S/N47b0QSiIuB/Dzuc+BSTK49ljq
         xJJHoHGpMSOudbClwNOkt1XUBPD9BW2pvygs42Pv03i3XyVHPV7JXisQo034PfL+yVy2
         qsp4+0Z80I6H+/n/bBUqBAUl78sPZbvjPB7uB3YrNIbJdVgD/bA0hElVDGy8/6X1Meqh
         sM/Fz+58XutQvDflmE+xjPIsugSiIfwm5aOg38XjjWXKGUb5zUjxKmID03MPRho2sVX2
         15MQ==
X-Gm-Message-State: AOAM531Z1wQe76VZFoTgFSfWt8Kv9Ye41VgpIKbkVu3zDBrcx6QXlwlu
        hwtjl9h5eqDwjwOy9F1GKy0jBFa+ty6tIg==
X-Google-Smtp-Source: ABdhPJzDrY+LRGazqefpg0gDb49Mym0w+n2g0HHXb47Uk7MqsTBzqJaii+lifwlFtuXkvkrZtSlQgw==
X-Received: by 2002:a05:6512:2090:: with SMTP id t16mr4206617lfr.83.1603702402640;
        Mon, 26 Oct 2020 01:53:22 -0700 (PDT)
Received: from [192.168.0.10] (89-109-58-109.dynamic.mts-nn.ru. [89.109.58.109])
        by smtp.gmail.com with ESMTPSA id m9sm970722lfd.86.2020.10.26.01.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 01:53:22 -0700 (PDT)
Subject: Re: [PATCH v2 09/15] perf record: introduce thread specific objects
 for trace streaming
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
 <bede5b00-8419-c03f-8595-7011679d363a@linux.intel.com>
 <20201024154431.GH2589351@krava>
From:   Alexei Budankov <budankov.lore@gmail.com>
Organization: Intel Corp.
Message-ID: <04657d10-dd5c-1dc6-77b8-665265ea66b9@gmail.com>
Date:   Mon, 26 Oct 2020 11:53:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201024154431.GH2589351@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.10.2020 18:44, Jiri Olsa wrote:
> On Wed, Oct 21, 2020 at 07:03:48PM +0300, Alexey Budankov wrote:
>>
>> Introduce thread local data object and its array to be used for
>> threaded trace streaming.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/builtin-record.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index ba26d75c51d6..8e512096a060 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -85,11 +85,29 @@ struct switch_output {
>>  	int		 cur_file;
>>  };
>>  
>> +struct thread_data {
>> +	pid_t		   tid;
>> +	struct {
>> +		int	   msg[2];
>> +		int	   ack[2];
>> +	} comm;
>> +	struct fdarray	   pollfd;
>> +	int		   ctlfd_pos;
>> +	struct mmap	   *maps;
>> +	int		   nr_mmaps;
>> +	struct record	   *rec;
>> +	unsigned long long samples;
>> +	unsigned long	   waking;
>> +	u64		   bytes_written;
>> +};
> 
> please merge the struct with the code that's using it

Corrected in v3.

Thanks,
Alexei

> 
> jirka
> 
>> +
>>  struct record {
>>  	struct perf_tool	tool;
>>  	struct record_opts	opts;
>>  	u64			bytes_written;
>>  	struct perf_data	data;
>> +	struct thread_data	*thread_data;
>> +	int			nr_thread_data;
>>  	struct auxtrace_record	*itr;
>>  	struct evlist	*evlist;
>>  	struct perf_session	*session;
>> -- 
>> 2.24.1
>>
> 
