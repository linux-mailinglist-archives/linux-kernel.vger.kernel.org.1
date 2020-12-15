Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17612DA589
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 02:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgLOB0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 20:26:52 -0500
Received: from mail.loongson.cn ([114.242.206.163]:36310 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbgLOB0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 20:26:41 -0500
Received: from [10.130.0.80] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxecmWENhfTmwAAA--.1002S3;
        Tue, 15 Dec 2020 09:25:43 +0800 (CST)
Subject: Re: [PATCH] perf callchain: Return directly when use '--call-graph
 dwarf' under !CONFIG_DWARF
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
References: <1607950615-11825-1-git-send-email-yangtiezhu@loongson.cn>
 <20201214133950.GE238399@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <4f2b3923-576b-c72d-2caa-2bdc6141f825@loongson.cn>
Date:   Tue, 15 Dec 2020 09:25:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20201214133950.GE238399@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9AxecmWENhfTmwAAA--.1002S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1rXr1UAFWUZF13Gr4rXwb_yoW5KFWUpF
        4DCF4ftwsIqr1Y9wnFvFWFgFZ5urykJr1Y9ryjyw15urs2grn7JFWxt3Wag345Xwn8Kw40
        vrn0gF1rCwn5AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07Al
        zVAYIcxG8wCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjfUOMKZDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/2020 09:39 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Dec 14, 2020 at 08:56:55PM +0800, Tiezhu Yang escreveu:
>> DWARF register mappings have not been defined for some architectures,
>> at least for mips, so we can print an error message and then return
>> directly when use '--call-graph dwarf'.
>>
>> E.g. without this patch:
>>
>> [root@linux perf]# ./perf record --call-graph dwarf cd
>> Error:
>> The sys_perf_event_open() syscall returned with 89 (Function not implemented) for event (cycles).
>> /bin/dmesg | grep -i perf may provide additional information.
>>
>> With this patch:
>>
>> [root@linux perf]# ./perf record --call-graph dwarf cd
>> DWARF is not supported for architecture mips64
> Good improvement on the message! But that .config-detected file isn't
> available at run time, take a look if this isn't a better alternative:

Hi Arnaldo,

Thank you very much, the following code with #ifdef HAVE_DWARF_SUPPORT
looks good and it works well on the x86 and mips arch.

So I will send a v2 patch as soon as possible.

Thanks,
Tiezhu

>
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 1b60985690bba313..125178fd17482513 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -276,6 +276,7 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
>   
>   		/* Dwarf style */
>   		} else if (!strncmp(name, "dwarf", sizeof("dwarf"))) {
> +#ifdef HAVE_DWARF_SUPPORT
>   			const unsigned long default_stack_dump_size = 8192;
>   
>   			ret = 0;
> @@ -290,6 +291,15 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
>   				ret = get_stack_size(tok, &size);
>   				param->dump_size = size;
>   			}
> +#else
> +			struct utsname uts;
> +
> +			ret = uname(&uts);
> +			pr_err("DWARF is not supported for architecture %s\n",
> +				ret ? "unknown" : uts.machine);
> +
> +			return -ENOTSUP;
> +#endif
>   		} else if (!strncmp(name, "lbr", sizeof("lbr"))) {
>   			if (!strtok_r(NULL, ",", &saveptr)) {
>   				param->record_mode = CALLCHAIN_LBR;
>
>   
>>   Usage: perf record [<options>] [<command>]
>>      or: perf record [<options>] -- <command> [<options>]
>>
>>          --call-graph <record_mode[,record_size]>
>>                            setup and enables call-graph (stack chain/backtrace):
>>
>> 				record_mode:	call graph recording mode (fp|dwarf|lbr)
>> 				record_size:	if record_mode is 'dwarf', max size of stack recording (<bytes>)
>> 						default: 8192 (bytes)
>>
>> 				Default: fp
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   tools/perf/util/callchain.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
>> index 1b60985..a8cf456 100644
>> --- a/tools/perf/util/callchain.c
>> +++ b/tools/perf/util/callchain.c
>> @@ -18,6 +18,7 @@
>>   #include <math.h>
>>   #include <linux/string.h>
>>   #include <linux/zalloc.h>
>> +#include <sys/utsname.h>
>>   
>>   #include "asm/bug.h"
>>   
>> @@ -278,6 +279,16 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
>>   		} else if (!strncmp(name, "dwarf", sizeof("dwarf"))) {
>>   			const unsigned long default_stack_dump_size = 8192;
>>   
>> +			if (system("grep -q 'CONFIG_DWARF=y' .config-detected") != 0) {
>> +				struct utsname uts;
>> +
>> +				ret = uname(&uts);
>> +				pr_err("DWARF is not supported for architecture %s\n",
>> +					ret ? "unknown" : uts.machine);
>> +
>> +				return -ENOTSUP;
>> +			}
>> +
>>   			ret = 0;
>>   			param->record_mode = CALLCHAIN_DWARF;
>>   			param->dump_size = default_stack_dump_size;
>> -- 
>> 2.1.0
>>

