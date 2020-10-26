Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA61298895
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772003AbgJZIjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:39:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:32808 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1771988AbgJZIjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:39:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id l2so10698353lfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 01:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EQe56czIfemY9qJuY6cAWZwBsft/xNx1ohsPZZHSA1I=;
        b=Ch84vfBUUjs6jAtSMIxwKlq3vVKao5zmLNRQqZwzG/+QHQ4tFYQm/iSeezTHK4Fiu5
         kNNrSVr6JFxCQSIQdJQV2FWOoBLyuYD2wyzm0F7OI7xizb/yMWCfRNXsYoRvmJ8Sf6JK
         kYX/nNhxTl2yllfOeE/VQ6BugUO4R7nRCmSGZm4HhVtbzIu9X9aU4hNHsTDB+IBud+o5
         L535lgus/DlQvqm4O8MUNwMT9TNM9oROnZvl+oQaDwetHUhFy4iVGI7YSup7h//VLRT1
         ys3zZYd/cqf85XuqTCMA6xbrDtSWzBqaOg3OjJ9Ths40oSTgSqlEFY9cL9a3k/BHrPan
         ZUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EQe56czIfemY9qJuY6cAWZwBsft/xNx1ohsPZZHSA1I=;
        b=UyLHsImnw6Mw5bzxT1I2kzzpNpeL0DS5NIm3Lr4Gy4HtGfJAITBbM5gbwqi/g8a21p
         vw55Kww0Q2AFhTPuuT7VKDcVNFTMDEkX26Em5nONodRmrOe2JAMuUUjKqM32i8XvU/0h
         /019SxPqB2jMTxoXEG1Pwo3e6GIo7AlESkwq1vfLzhdj4VELHWAtHqNHzFvYPXQI/Nwg
         RlDee+U3TiBEssH9msLwUxpbTq4p1AyVPbk6Ga1Wt9CpewhWV0tSQ3hlslCPATpXHIF2
         32OeQJMH1LC17QPzGpFUhzVu234iOIVu7ajSZfdKKy6cST0J5lBXZqON5wy86CPU5U6u
         6ASw==
X-Gm-Message-State: AOAM531/EBL4nNcA9WY/ATKnQDMww+6hA3zb+1kh3hIQHvcYsRBoYOpS
        GlT9XeuCIh5ODQK74d1+G04=
X-Google-Smtp-Source: ABdhPJw2vhPtfJRhLV8dduoOeaV04QuSaOiwyUihXW9P26VYn+w5lscSZ+KC2EchtFeW/8u6UFwtdg==
X-Received: by 2002:a19:c50e:: with SMTP id w14mr1805928lfe.589.1603701584964;
        Mon, 26 Oct 2020 01:39:44 -0700 (PDT)
Received: from [192.168.0.10] (89-109-58-109.dynamic.mts-nn.ru. [89.109.58.109])
        by smtp.gmail.com with ESMTPSA id l8sm970195lfk.203.2020.10.26.01.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 01:39:44 -0700 (PDT)
Subject: Re: [PATCH v2 14/15] perf record: start threads in the beginning of
 trace streaming
To:     Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        budankov.lore@gmail.com
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <0584888b-17b3-7a62-e585-8582d8a2d439@linux.intel.com>
 <20201024154416.GF2589351@krava>
From:   Alexei Budankov <budankov.lore@gmail.com>
Organization: Intel Corp.
Message-ID: <18730616-8e60-70df-9624-d1fbc0a0893e@gmail.com>
Date:   Mon, 26 Oct 2020 11:39:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201024154416.GF2589351@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24.10.2020 18:44, Jiri Olsa wrote:
> On Wed, Oct 21, 2020 at 07:10:09PM +0300, Alexey Budankov wrote:
>>
>> Start threads in detached state because its management is possible
>> via messaging. Block signals prior the threads start so only main
>> tool thread would be notified on external async signals during data
>> collection. Streaming threads connect one-to-one to mapped data
>> buffers and write into per-CPU trace files located at data directory.
>> Data buffers and threads are affined to local NUMA nodes and monitored
>> CPUs according to system topology. --cpu option can be used to specify
>> CPUs to be monitored.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/builtin-record.c | 128 +++++++++++++++++++++++++++++++++---
>>  1 file changed, 120 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index a15642656066..1d41e996a994 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -56,6 +56,7 @@
>>  #include <poll.h>
>>  #include <pthread.h>
>>  #include <unistd.h>
>> +#include <sys/syscall.h>
>>  #include <sched.h>
>>  #include <signal.h>
>>  #ifdef HAVE_EVENTFD_SUPPORT
>> @@ -1377,6 +1378,62 @@ static void record__thread_munmap_filtered(struct fdarray *fda, int fd,
>>  		perf_mmap__put(map);
>>  }
>>  
>> +static void *record__thread(void *arg)
>> +{
>> +	enum thread_msg msg = THREAD_MSG__READY;
>> +	bool terminate = false;
>> +	struct fdarray *pollfd;
>> +	int err, ctlfd_pos;
>> +
>> +	thread = arg;
>> +	thread->tid = syscall(SYS_gettid);
>> +
>> +	err = write(thread->comm.ack[1], &msg, sizeof(msg));
>> +	if (err == -1)
>> +		pr_err("threads: %d failed to notify on start. Error %m", thread->tid);
>> +
>> +	pollfd = &(thread->pollfd);
> 
> I don't think braces are necessary in here

Corrected in v3.

Alexei
