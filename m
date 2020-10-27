Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39A429CB99
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 22:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374664AbgJ0Vzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 17:55:36 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:38013 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374656AbgJ0Vzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 17:55:35 -0400
Received: by mail-il1-f195.google.com with SMTP id x7so1470536ili.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 14:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lgKSCb5c9tdTkF5QdAPCpCA9DpL5KH988jr8fE7us3c=;
        b=fXEsD4d3KHbwjy0Hy7AOYfmlTutjASNHaqDSuDAP/mkXXgOS7eZ0sgGYNtvvD0nLSn
         1v2NL+sdlQ5mD7k5IkU6gS3f2ETZo3ZQgS+3MfCv5HkyYidCUGtZusRzrYBnXO19GDkD
         +cood94qqgOzQw57psef08614etVetRd4PM9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lgKSCb5c9tdTkF5QdAPCpCA9DpL5KH988jr8fE7us3c=;
        b=G2qkkVMMJ5Ofa624vwXMrkDo05jY5wOFLceOa1ZLjlKrp8yBqAUZ+uh+gX4+FEfSZb
         KJplR+xhXQ+HbuCL4Wbotvx4sW8uHXTXkBSCPF2vD0C211DCYZYa6oVq4c3z9g6mnQTX
         1N+aGYLM1rJ5uLpnHUCr0UmQpR2HO7R8GFiVFfvH8+8UxkDnLceVyyqHHrIptCjJetpg
         BPZdp7viZdDyQwzqCsaFY5Furwuw0IfCu6EOOj3MyRvByvfpRsLJNHxujghEsmuUrj+N
         LCzLLsVq815728dPLV/pOdrDtjSuiV0b/7pLQ6On3DGwISQkOmBZPOeoDKG39mGsX3ZD
         7UOg==
X-Gm-Message-State: AOAM530dYuKHxC/sI0k3LPJTgi8F/q0PzRIj28MIumSZ5Z9GXAED0q8L
        PqEZf2jmNLlAYtYLae4YTQlWZA==
X-Google-Smtp-Source: ABdhPJzmC1cbguyZPZtlPtoJsAGQaNltsHYTu67efw7/gCtEowygE8ptitCW3/02DXT/NydkLPM70A==
X-Received: by 2002:a92:41c6:: with SMTP id o189mr3745351ila.261.1603835733784;
        Tue, 27 Oct 2020 14:55:33 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p17sm1498718ilh.34.2020.10.27.14.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 14:55:32 -0700 (PDT)
Subject: Re: [PATCH] selftests/ftrace: remove _do_fork() leftovers
To:     Steven Rostedt <rostedt@goodmis.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1603443123-17457-1-git-send-email-agordeev@linux.ibm.com>
 <20201023093523.65c495f8@gandalf.local.home>
 <20201023151243.GA1537@oc3871087118.ibm.com>
 <20201023114948.6900aa68@gandalf.local.home>
 <20201023115111.1c0e8768@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <cedad9bf-ba6b-78ad-644f-ce5074f2fbed@linuxfoundation.org>
Date:   Tue, 27 Oct 2020 15:55:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201023115111.1c0e8768@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/20 9:51 AM, Steven Rostedt wrote:
> On Fri, 23 Oct 2020 11:49:48 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Fri, 23 Oct 2020 17:12:44 +0200
>> Alexander Gordeev <agordeev@linux.ibm.com> wrote:
>>
>>>> Perhaps we should have:
>>>>
>>>> 	# older kernels have do_fork, but newer kernels have kernel_clone
>>>> 	echo kernel_clone >> set_ftrace_filter || echo *do_fork >> set_ftrace_filter
>>>
>>> Would you suggest to do the same with all occurences in
>>> eea11285dab3 ("tracing: switch to kernel_clone()")?
>>> Otherwise it does not really make sense to just fix couple
>>> of tests out of dozens.
>>
>> Yes. I haven't pulled in the updated tests, so I haven't hit the errors yet
>> (nor have I merged my work with the switch to the new name yet). So those
>> will most definitely break my tests.
>>
>> But because it's a more generic issue, we should have a way to find what to
>> use. Perhaps add to the test.d/functions, something like:
>>
>> FUNCTION_FORK=`(if grep '\bkernel_clone\b' /proc/kallsyms > /dev/null; then
>>                  echo kernel_clone; else echo '_do_fork'; fi)`
>>
>> and use $FUNCTION_FORK everywhere that references it.
>>
>>
> 
> Let me pull in the latest changes, and whip up a patch that works on both
> the older kernels as well as the newer ones.
> 
> -- Steve
> 

Assume this is handled by

selftests/ftrace: Use $FUNCTION_FORK to reference kernel fork function
https://patchwork.kernel.org/project/linux-kselftest/patch/20201026162032.124c728d@gandalf.local.home/

Just making sure.

thanks,
-- Shuah

