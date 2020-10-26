Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160C4298ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780934AbgJZOEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:04:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32818 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780184AbgJZOEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:04:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id c21so10292614ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 07:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LCu5NdXBK+BnODvbd1GTi0JZKwfTZXfo+pz+umxASK4=;
        b=tvwCOSX5EFJijvWw1JdH67BVPCYHm9suCIfuUI36ADhRfXqOLHZg5XTAOv6vs/3bKW
         13UsKz23cC5zgvvbum9dpShhqBTfIBAqMHxinwSasiy9eWCQ4TROxPO6zHRTR76THw7G
         bsOCXQ3cfTslJsKsCftuoxUkkCxROpdWDsqgsMlMYOUBvCIzNH/KVHMaydtvbgIPwnga
         S+G6GMZExad3WKPUSadyohbiZcrzos6yUGcMXixnf26YMxOx1DKvP+g1CKNffuM6/L/d
         YxOnrzPGoLvSxxBCJE1fnEzfjo5VWZ0NOMe3sKXTmkONnVNR82aPE5FuVhXq4zXwz5W4
         iwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LCu5NdXBK+BnODvbd1GTi0JZKwfTZXfo+pz+umxASK4=;
        b=bFYx0m5IMc6zj6XJp3E4rdo3OlXvgkYEYJh0jmq0j8C8ktU61ndJLKx1a2R2BrOYqf
         9eixv53h1LtRzeFj6izJfZaHmiH1tasLLsc0s9APj7Fq4GRNbqW+UxRJb0HwFTzwOIYb
         XcKE2/LqiSaTzIbS5JurrLWdpjWTpCCiyPtI81OWqmTO60BKHIxfq8DaJC3m7todsMca
         wgm+LWIIaHa61K3xCrc3GYvHPaU2dsZygUAykxneS/x0FJ4bxHhAxTaFa1idbxNvl5Q+
         nLetvs2V93hStk+r9g/TTZakLxuGGp4a2SjZyro3tSMJrSgm8tiyrBBd74soqexV6FQB
         Q7wQ==
X-Gm-Message-State: AOAM530ODMAtW6i9EwQRotwe6p0Duv6aFgdiY9j3HP3JNpPrgTcrZ59O
        sqmfbEk0eCe/p/+Srp+fHyo=
X-Google-Smtp-Source: ABdhPJxY97SmL0cjT9t2a/BRFAnk4TX4v/rtK06n18qOXY4GRJFVy8n+1oLXRxjQTwzMpoQ0VrzHqA==
X-Received: by 2002:a2e:9ccf:: with SMTP id g15mr6248166ljj.353.1603721073488;
        Mon, 26 Oct 2020 07:04:33 -0700 (PDT)
Received: from [192.168.0.10] (89-109-58-109.dynamic.mts-nn.ru. [89.109.58.109])
        by smtp.gmail.com with ESMTPSA id c202sm1045798lfg.133.2020.10.26.07.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:04:32 -0700 (PDT)
Subject: Re: [PATCH v2 08/15] perf record: write trace data into mmap trace
 files
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        budankov.lore@gmail.com
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <1202e665-6321-28d4-eca3-b21693364467@linux.intel.com>
 <20201024154423.GG2589351@krava>
 <adc90ef5-58cc-8578-13f7-cbce895f1a28@gmail.com>
 <20201026103227.GB2726983@krava>
From:   Alexei Budankov <budankov.lore@gmail.com>
Organization: Intel Corp.
Message-ID: <51d818e7-cee7-e826-5d1c-008e27e9fe68@gmail.com>
Date:   Mon, 26 Oct 2020 17:04:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201026103227.GB2726983@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26.10.2020 13:32, Jiri Olsa wrote:
> On Mon, Oct 26, 2020 at 11:52:21AM +0300, Alexei Budankov wrote:
>>
>> On 24.10.2020 18:44, Jiri Olsa wrote:
>>> On Wed, Oct 21, 2020 at 07:02:56PM +0300, Alexey Budankov wrote:
>>>
>>> SNIP
>>>
>>>>  
>>>>  	record__synthesize(rec, true);
>>>> -	/* this will be recalculated during process_buildids() */
>>>> -	rec->samples = 0;
>>>>  
>>>>  	if (!err) {
>>>>  		if (!rec->timestamp_filename) {
>>>> @@ -2680,9 +2709,12 @@ int cmd_record(int argc, const char **argv)
>>>>  
>>>>  	}
>>>>  
>>>> -	if (rec->opts.kcore)
>>>> +	if (rec->opts.kcore || record__threads_enabled(rec))
>>>>  		rec->data.is_dir = true;
>>>>  
>>>> +	if (record__threads_enabled(rec))
>>>> +		rec->opts.affinity = PERF_AFFINITY_CPU;
>>>
>>> so all the threads will pin to cpu and back before reading?
>>
>> No, they will not back. Thread mask compares to mmap mask before
>> read and the thread migrates if masks don't match. This happens
>> once on the first mmap read. So explicit pinning can be avoided.
> 
> hum, is that right? the check in record__adjust_affinity
> is checking global 'rec->affinity_mask', at lest I assume
> it's still global ;-)

Yes, rec->affinity_mask should also be per-thread. Good catch. Thanks!

Alexei

> 
>         if (rec->opts.affinity != PERF_AFFINITY_SYS &&
>             !bitmap_equal(rec->affinity_mask.bits, map->affinity_mask.bits,
>                           rec->affinity_mask.nbits)) {
> 
> I think this can never be equal if you have more than one map
> 
> when I check on sched_setaffinity syscalls:
> 
>   # perf trace -e syscalls:sys_enter_sched_setaffinity
> 
> while running record --threads, I see sched_setaffinity
> calls all the time
> 
> jirka
> 
