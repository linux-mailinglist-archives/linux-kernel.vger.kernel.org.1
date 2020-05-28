Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86F51E6372
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 16:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390902AbgE1OOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 10:14:12 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56730 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390727AbgE1OOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:14:10 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04SEDMvX012553;
        Thu, 28 May 2020 23:13:22 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp);
 Thu, 28 May 2020 23:13:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04SEDLiC012550
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 28 May 2020 23:13:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] twist: allow converting pr_devel()/pr_debug() into
 printk(KERN_DEBUG)
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200525084218.GC5300@linux-b0ei>
 <20200525091157.GF755@jagdpanzerIV.localdomain>
 <f02a71bc-0867-be60-182b-10d7377b2b04@i-love.sakura.ne.jp>
 <20200527083747.GA27273@linux-b0ei>
 <35d76737-8d23-9fb2-8e55-507109317f44@i-love.sakura.ne.jp>
 <20200527155504.GD3529@linux-b0ei>
 <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
 <20200528105942.GB11286@linux-b0ei>
 <945213f4-a2c3-b25e-35e4-7c55f836e11c@i-love.sakura.ne.jp>
 <20200528121455.GD11286@linux-b0ei>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <2818b93e-3ebb-72ce-feb9-b0768ccb60d8@i-love.sakura.ne.jp>
Date:   Thu, 28 May 2020 23:13:17 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200528121455.GD11286@linux-b0ei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/28 21:14, Petr Mladek wrote:
>> how to handle
>>
>>>>   #define no_printk(fmt, ...)                             \
>>>>   ({                                                      \
>>>>           if (0)                                          \
>>>>                   printk(fmt, ##__VA_ARGS__);             \
>>>>           0;                                              \
>>>>   })
>>
>> part used by e.g. pr_devel() ? Since this macro is not using dynamic debug
>> interface, vprintk_store() will not be called from the beginning. Are you
>> suggesting that we should convert no_printk() to use dynamic debug interface ?
> 
> OK, this is one more path that would need special handling. Two paths
> are much better than 15.

OK. That can avoid needlessly increasing dynamic debug locations.
But I believe that your suggestion is much worse than 15. ;-(

Let's go back to "Add twist into vprintk_store().". The condition is not as simple as

  #if TWIST
    return text_len;
  #endif

because we need to check whether the caller wants to print this message or not.
Since we need to print all messages that the caller asked to print, the condition
needs to be

  #if TWIST
    if (!this_message_should_be_stored_into_logbuf(arg))
      return text_len;
  #endif

and where does the "arg" come? It is not as simple as loglevel. Like you said

  It might get more complicated if you would actually want to see
  pr_debug() messages for a selected module in the fuzzer.

, we want to conditionally store KERN_DEBUG messages into logbuf.

We sometimes don't want to store into logbuf due to ratelimit, due to
dynamic debug. But we DO want to evaluate arguments passed to printk().

Oh, if we try to add twist into vprintk_store(), we will have to modify
all printk() callers in order to pass "arg" only for telling whether we
want to store that messages into logbuf. What a nightmare!

