Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DA6298EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781058AbgJZOLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:11:35 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36998 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780172AbgJZOLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:11:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id j30so12273950lfp.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 07:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pZaTQSDvUfq8+yQY2ls2Yvt6o/6uXy1pFEkbWMw2KhA=;
        b=PlN5eydov/psik732K9iyNCGYRZxiinFNXTpSypR4jR9IYHtyprDjc9ZMgu4b5qN2M
         CPcEs6VETJrLlMHOfApyOjP2r5mrjsvGUSCfTA9C398BPa3CMJgUJdhVWov/qPl8+9m1
         3BhQitBklevuGtoryjwsL391VMu2gfMkBsJLBmokF+lxD7eZb/Aq6eGFCxGgbMoo95/g
         EKC7aDg2DiphUzDKoOyEqHbnhVUlUosJ3ukqT2tZBs6WK+1ObRiIrGfOm6xEja+87W5C
         vv56jcUdV+HMoZ5DlRI5ou1V6VQuD5bg/I/+dXkB0SIQCHKH+4Qbgb6CSd7cWnZ6xugI
         ohOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pZaTQSDvUfq8+yQY2ls2Yvt6o/6uXy1pFEkbWMw2KhA=;
        b=JQGVaLebLWNhMHTPSgFL9nGZ/jqXhx8kG2V4sZgbtEnEvQEBnN7YCaUkuf1Nom4Nbj
         V5DTt7LY30xHSUWnbliIAx7u/hJRYVyui26yKdFHhtJMjVvAbZi2ojeXEhlDvjLyEpHa
         vER3EEviqrNVrpzOU0QlVaKkWs7iihfzRNLkcMA6pejUchKoFen68vI9QFQS5dVU1hZ2
         clnU0zmXB3DpWTRBV97TaP666UVZjLyEHRtAOuzfhIaJGrUgZN9zKi3lt6aH7RLjJSej
         pW9sgJ3/hCSG4eFYhZTuiuf/7BFKHVJ/0Bow0Q/HfcYe/WA+P9EzhmJkSYpmVM4v3lDE
         LIkw==
X-Gm-Message-State: AOAM5324knxZQw3EzlRCptQnVfFzKBNrnRPIZQePQpn3ISEfqJMGE/3j
        HB2iE3lsUzJaQs4r+u4RGoY=
X-Google-Smtp-Source: ABdhPJwZgH+i6xpChG2knTgYvk5re9mkdlStY5ZM2Ca2fTZ8dM+QQ/mQX4udJGPVRf8FAcMJ6DWcJQ==
X-Received: by 2002:a19:8488:: with SMTP id g130mr5212791lfd.424.1603721491948;
        Mon, 26 Oct 2020 07:11:31 -0700 (PDT)
Received: from [192.168.0.10] (89-109-58-109.dynamic.mts-nn.ru. [89.109.58.109])
        by smtp.gmail.com with ESMTPSA id d23sm1055996lfm.141.2020.10.26.07.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:11:31 -0700 (PDT)
Subject: Re: [PATCH v2 12/15] perf record: introduce thread local variable for
 trace streaming
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
 <b1a2fc8c-1106-63d6-40f1-376165490a59@linux.intel.com>
 <20201024154357.GD2589351@krava>
 <6eb97205-4d13-6487-8e15-a85f63d3f0cc@gmail.com>
 <20201026103426.GC2726983@krava>
From:   Alexei Budankov <budankov.lore@gmail.com>
Organization: Intel Corp.
Message-ID: <78ca09c2-50da-3206-2dff-19523699d82b@gmail.com>
Date:   Mon, 26 Oct 2020 17:11:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201026103426.GC2726983@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26.10.2020 13:34, Jiri Olsa wrote:
> On Mon, Oct 26, 2020 at 11:21:28AM +0300, Alexei Budankov wrote:
>>
>> On 24.10.2020 18:43, Jiri Olsa wrote:
>>> On Wed, Oct 21, 2020 at 07:07:00PM +0300, Alexey Budankov wrote:
>>>>
>>>> Introduce thread local variable and use it for threaded trace streaming.
>>>>
>>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>>> ---
>>>>  tools/perf/builtin-record.c | 71 ++++++++++++++++++++++++++++++++-----
>>>>  1 file changed, 62 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>>> index 89cb8e913fb3..3b7e9026f25b 100644
>>>> --- a/tools/perf/builtin-record.c
>>>> +++ b/tools/perf/builtin-record.c
>>>> @@ -101,6 +101,8 @@ struct thread_data {
>>>>  	u64		   bytes_written;
>>>>  };
>>>>  
>>>> +static __thread struct thread_data *thread;
>>>> +
>>>>  struct record {
>>>>  	struct perf_tool	tool;
>>>>  	struct record_opts	opts;
>>>> @@ -587,7 +589,11 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
>>>>  		}
>>>>  	}
>>>>  
>>>> -	rec->samples++;
>>>> +	if (thread)
>>>> +		thread->samples++;
>>>> +	else
>>>> +		rec->samples++;
>>>
>>> this is really wrong, let's keep just single samples counter
>>> ditto for all the other places in this patch
>>
>> This does look like data parallelism [1] which is very true for
>> threaded trace streaming so your prototype design looks optimal.
>>
>> For this specific place incrementing global counter in memory is
>> less performant and faces scalability limitations as a number of
>> cores grow.
>>
>> Not sure why you have changed your mind.
> 
> I'm not sure I follow.. what I'm complaining about is to have
> 'samples' stat variable in separate locations for --threads
> and --no-threads mode

It is optimal to have samples variable as per thread one
and then sum up the total in the end of data collection.

Single global variable design has scalability and performance
drawbacks.

Why do you complain about per thread variable in this case?
It looks like ideally fits these specific needs.

Alexei

> 
> jirka
> 
>>
>> Alexei
>>
>> [1] https://en.wikipedia.org/wiki/Data_parallelism#:~:text=Data%20parallelism%20is%20parallelization%20across,on%20each%20element%20in%20parallel.
>>
> 
