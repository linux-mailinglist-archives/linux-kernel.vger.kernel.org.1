Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0556D2988C5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772247AbgJZIw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:52:26 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43680 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1772240AbgJZIw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:52:26 -0400
Received: by mail-lf1-f67.google.com with SMTP id l28so10709362lfp.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 01:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d5qVxbniITl5BClK9FgemM6r+Xx7WYyuIWPQHG6BtwM=;
        b=lvVo449gu4vdByaPAB6NkFU9vyV9eJN6Hr/r1oZ/p+raLCfTgxLBZxo17PU/eoKKaT
         RtKJCJg/dC5id/se/yOoUKSa6gazdoJGCnYVj8jH3fRitFuIqf+H3w7r5gd5JPD/jn5p
         iYjohxf0tW7m6T+wmAUDd6Ds43jNJCdSxu/5TIfMQNlVidARkfqXXUNSg3HQa3bL7MP8
         3pFe4YpMKlWeL4dwpqJTQRaS+CNyCXGlYaRTtz8qGXiputOtsAIx0fD9/39cET7K+LHB
         +rL1uhSkR7Txkf8nSlzjz3RLSFL4b0nZhTu1e+Oaz+S0ASSqQSDU3jvkbg2P+I6lmv8h
         3gMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=d5qVxbniITl5BClK9FgemM6r+Xx7WYyuIWPQHG6BtwM=;
        b=DmSJ00F7+tTy4AZTiCirYkC8/Kf+9+BLgECdn8GTOWMwOaC54tC2bxAY9/8SaMrYBx
         Qr0PRhHQYGypdLNtfVxI3jpUX1rWPNXoTBAWTbgB05xJZio9aEORsqsSrQoLCGXggfbl
         w7zrQk4lEILx7IETM3iHeR5NjXKxMGHWRdh79fTDcYm+GExQeFHzjUcfHugqF9dPnWHH
         77pb9LID3pXo5nVDuRwVUB1qEY1TdlmjYTKoz6ifPqxfmMmHDG5D3Fku1tcD6GYpM13e
         18PBmOBhm5DE2qVQeiLmgnCkqGLmJZYfHu5ICqiWWU27Q/e7d/gGmn1CSSgtf08FuTYR
         G88A==
X-Gm-Message-State: AOAM530p9f9j8RE4tPN625/6S52r52zBRuVD8tnP/VwCEwrArIOAlgXe
        ii51FbOgoVB2mazJ5pjHnVU=
X-Google-Smtp-Source: ABdhPJw3cD8S9qHjWPYWbL1GWxpYiy9r7I1VzRfN+YWUP6Cw8mjOBlNjSbXVcvkLnjzogYLSUg6ffg==
X-Received: by 2002:a19:9150:: with SMTP id y16mr5021511lfj.190.1603702343575;
        Mon, 26 Oct 2020 01:52:23 -0700 (PDT)
Received: from [192.168.0.10] (89-109-58-109.dynamic.mts-nn.ru. [89.109.58.109])
        by smtp.gmail.com with ESMTPSA id t10sm385871lfc.258.2020.10.26.01.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 01:52:22 -0700 (PDT)
Subject: Re: [PATCH v2 08/15] perf record: write trace data into mmap trace
 files
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
 <1202e665-6321-28d4-eca3-b21693364467@linux.intel.com>
 <20201024154423.GG2589351@krava>
From:   Alexei Budankov <budankov.lore@gmail.com>
Organization: Intel Corp.
Message-ID: <adc90ef5-58cc-8578-13f7-cbce895f1a28@gmail.com>
Date:   Mon, 26 Oct 2020 11:52:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201024154423.GG2589351@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24.10.2020 18:44, Jiri Olsa wrote:
> On Wed, Oct 21, 2020 at 07:02:56PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>  
>>  	record__synthesize(rec, true);
>> -	/* this will be recalculated during process_buildids() */
>> -	rec->samples = 0;
>>  
>>  	if (!err) {
>>  		if (!rec->timestamp_filename) {
>> @@ -2680,9 +2709,12 @@ int cmd_record(int argc, const char **argv)
>>  
>>  	}
>>  
>> -	if (rec->opts.kcore)
>> +	if (rec->opts.kcore || record__threads_enabled(rec))
>>  		rec->data.is_dir = true;
>>  
>> +	if (record__threads_enabled(rec))
>> +		rec->opts.affinity = PERF_AFFINITY_CPU;
> 
> so all the threads will pin to cpu and back before reading?

No, they will not back. Thread mask compares to mmap mask before
read and the thread migrates if masks don't match. This happens
once on the first mmap read. So explicit pinning can be avoided.

Alexei
