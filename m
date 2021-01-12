Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13D22F3D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbhALVfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:35:10 -0500
Received: from mail-m971.mail.163.com ([123.126.97.1]:35744 "EHLO
        mail-m971.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437105AbhALVFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=UeJBc
        nkMuPyglPAiCYbAKAqv1CSOHndFYhJXJkdGJfM=; b=R3ahkkdJNZFCJWTlfOFPe
        ioia40C6WJSaqO3nQICxGyvr8s6DsXITXjeVFtjVraqtl7FCTHFgFsAGFu5gTMgQ
        5n5//L+UQybdF5s1we6OTd4GOgKTKnnFUAuQLSOl9UElCCih4sq6bmfLjsEdiuR0
        DIGBu7MDx89lZCsGPMusao=
Received: from [128.224.155.93] (unknown [60.247.85.82])
        by smtp1 (Coremail) with SMTP id GdxpCgB3FTmNsf1fs52rCA--.8120S2;
        Tue, 12 Jan 2021 22:26:40 +0800 (CST)
Subject: Re: [PATCH 1/2] init/main.c: fix strings split across lines
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20201230060424.29097-1-liupeibao@163.com>
 <20201230060424.29097-2-liupeibao@163.com>
 <20210111190235.3e81770f@gandalf.local.home>
From:   Liu Peibao <liupeibao@163.com>
Message-ID: <7a7886b2-c3bd-5adc-5d94-67343e554759@163.com>
Date:   Tue, 12 Jan 2021 22:26:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210111190235.3e81770f@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GdxpCgB3FTmNsf1fs52rCA--.8120S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFyrZry8Xw4DAF15Kr1xZrb_yoW8GrW8pF
        4DKFWruF1vqa17A3yxXF12qFyavasFyay09F1Dtr18JFn8Ar18t3yIgr4Y9F1DtrWfW3WI
        qF42qFZ3tF1qvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jWE__UUUUU=
X-Originating-IP: [60.247.85.82]
X-CM-SenderInfo: xolx1vpled0qqrwthudrp/xtbBzRkYbF0CPBdVXQABsd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/21 8:02 AM, Steven Rostedt wrote:
> On Wed, 30 Dec 2020 14:04:23 +0800
> Liu Peibao <liupeibao@163.com> wrote:
> 
>> Fix warning found by checkpatch.pl.
>>
>> Signed-off-by: Liu Peibao <liupeibao@163.com>
>> ---
>>   init/main.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/init/main.c b/init/main.c
>> index 6feee7f11eaf..1e492de770c8 100644
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -1470,8 +1470,7 @@ static int __ref kernel_init(void *unused)
>>   	    !try_to_run_init_process("/bin/sh"))
>>   		return 0;
>>   
>> -	panic("No working init found.  Try passing init= option to kernel. "
>> -	      "See Linux Documentation/admin-guide/init.rst for guidance.");
>> +	panic("No working init found. Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.");
> 
> Sorry, we don't add changes to the kernel that checkpatch warns about.
> checkpatch should only be run on new code. Please do not submit any patches
> on existing code because checkpatch warns about it.
> 
> -- Steve
> 
Thanks for your replay! I get it.
But I still feel a little confused that we use different standard to 
measure the existing code and the new code. I also checked some commits, 
there are similar patches too.

BR,
Peibao
> 
>>   }
>>   
>>   /* Open /dev/console, for stdin/stdout/stderr, this should never fail */

