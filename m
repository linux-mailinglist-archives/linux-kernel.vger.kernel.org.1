Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68071298836
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771552AbgJZIVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:21:33 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42449 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1769297AbgJZIVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:21:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id h20so8812427lji.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 01:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r6LXcxUBFULLz9MajPuPGZldQp5EFd4JcICdU+XliWA=;
        b=cKUvRpw74n4m6xMHyyRmm6ZAkVenzokix5npG5c2OIZjGN1JJYN+H6mjYGmDi0+dAc
         clKFDYG+g0NLxygz0iHEZRXOh6rdOkjosujsEp9H40mHHrS+yplz5YJpdABE/J2XkviS
         sUEuobrk/dU1GwNRRoLrjbJXU6fn58yKXP1fMSMMiDOks/frHcAOC6xmKjAVPmRfNfZU
         9PXaYveOs6hrmOntKb7jEscH8Wu/mYGQ8dqNxvku1pyPWzBK+lGLQyPYLqhUFhLALpmz
         VhFh3nut+YNLfiPq3vNqmjdNvd9D3jVecECItccAjc7xlh3e5lsH23yK2WhNBkyyDJ9N
         a9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=r6LXcxUBFULLz9MajPuPGZldQp5EFd4JcICdU+XliWA=;
        b=kDCODAjM0KhnbGU2cv/LZRjZ5sFTnTiLnjrwzMp0MDUVbMacP1vPyTxIyU9o+hJ5+R
         wKKtbmvmuCUYnG6224eNsyH9hjTP6/m99jsvWvtH179lXdFx1V/IrgK5BSlaMgaSTuYR
         BH3JPyf1BxKI8+qQci4Y5hy3Mlr6amqZ5VO7KhU769oq09zRBzhIZX28xfAwed099+mr
         nMCsiq+Qbwk1Qo6ksVrGZf4Inevdmt8BBLtZw0nihJIWeRWugGBFxQvGO+nTh1Q3KxdT
         1pB1JfsB1Q5ftasD8NGZnf6tPfTUZE8oE138XgOnkyUExiwl8LV83tLw2cntLVnlRWNv
         naQg==
X-Gm-Message-State: AOAM530g6ttwfoKjBIKlR5xzJsJlsjvqrxK5qITJstdaxa7HyWwqoKXE
        hnPC+yDuB5Fy/7tprLTfW6k=
X-Google-Smtp-Source: ABdhPJwYwd8XycOmnhHs61RFx8JbPGF7AhXd6Kk3xN4t2DKuX3wANha4ESglwu17auYerKoNNFAGNw==
X-Received: by 2002:a2e:b015:: with SMTP id y21mr5656138ljk.367.1603700490083;
        Mon, 26 Oct 2020 01:21:30 -0700 (PDT)
Received: from [192.168.0.10] (89-109-58-109.dynamic.mts-nn.ru. [89.109.58.109])
        by smtp.gmail.com with ESMTPSA id y3sm1092748ljn.6.2020.10.26.01.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 01:21:29 -0700 (PDT)
Subject: Re: [PATCH v2 12/15] perf record: introduce thread local variable for
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
 <b1a2fc8c-1106-63d6-40f1-376165490a59@linux.intel.com>
 <20201024154357.GD2589351@krava>
From:   Alexei Budankov <budankov.lore@gmail.com>
Organization: Intel Corp.
Message-ID: <6eb97205-4d13-6487-8e15-a85f63d3f0cc@gmail.com>
Date:   Mon, 26 Oct 2020 11:21:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201024154357.GD2589351@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24.10.2020 18:43, Jiri Olsa wrote:
> On Wed, Oct 21, 2020 at 07:07:00PM +0300, Alexey Budankov wrote:
>>
>> Introduce thread local variable and use it for threaded trace streaming.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/builtin-record.c | 71 ++++++++++++++++++++++++++++++++-----
>>  1 file changed, 62 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 89cb8e913fb3..3b7e9026f25b 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -101,6 +101,8 @@ struct thread_data {
>>  	u64		   bytes_written;
>>  };
>>  
>> +static __thread struct thread_data *thread;
>> +
>>  struct record {
>>  	struct perf_tool	tool;
>>  	struct record_opts	opts;
>> @@ -587,7 +589,11 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
>>  		}
>>  	}
>>  
>> -	rec->samples++;
>> +	if (thread)
>> +		thread->samples++;
>> +	else
>> +		rec->samples++;
> 
> this is really wrong, let's keep just single samples counter
> ditto for all the other places in this patch

This does look like data parallelism [1] which is very true for
threaded trace streaming so your prototype design looks optimal.

For this specific place incrementing global counter in memory is
less performant and faces scalability limitations as a number of
cores grow.

Not sure why you have changed your mind.

Alexei

[1] https://en.wikipedia.org/wiki/Data_parallelism#:~:text=Data%20parallelism%20is%20parallelization%20across,on%20each%20element%20in%20parallel.
