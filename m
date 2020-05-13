Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7044E1D1090
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 13:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732649AbgEMLEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 07:04:35 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57397 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbgEMLEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:04:33 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04DB3rMs016231;
        Wed, 13 May 2020 20:03:53 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp);
 Wed, 13 May 2020 20:03:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04DB3qtu016227
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 13 May 2020 20:03:53 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <20200427062117.GC486@jagdpanzerIV.localdomain>
 <4dae86af-1d9a-f5a8-cff6-aa91ec038a79@i-love.sakura.ne.jp>
 <20200428121828.GP28637@dhcp22.suse.cz>
 <b4d74234-8009-9ffd-011f-bd5d1a4b85f6@i-love.sakura.ne.jp>
 <20200428154532.GU28637@dhcp22.suse.cz>
 <b1d507b1-dae7-f526-c74a-d465ddecea6a@i-love.sakura.ne.jp>
 <20200429142106.GG28637@dhcp22.suse.cz>
 <a59271f1-b3fc-26d1-f0a2-5ec351d0095e@i-love.sakura.ne.jp>
 <20200513062652.GM413@jagdpanzerIV.localdomain>
 <a75d6560-ad99-5b02-3648-247c27c3a398@i-love.sakura.ne.jp>
 <20200513100413.GH17734@linux-b0ei>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <20564555-7b84-f716-5dcd-978f76ad459a@i-love.sakura.ne.jp>
Date:   Wed, 13 May 2020 20:03:53 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513100413.GH17734@linux-b0ei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/13 19:04, Petr Mladek wrote:
>> What is wrong with adding NO_CONSOLES ?
> 
> How does it differ from KERN_DEBUG? The debug messages:
> 
>   + can be disabled via sysfs
>   + might reach console when this loglevel is enabled

KERN_NO_CONSOLES is different from KERN_DEBUG in that KERN_NO_CONSOLES
itself does not affect userspace daemon's judgement (whether to filter
KERN_$LOGLEVEL messages).

> What is so special about  OOM dump task so that it would deserve such
> complications?

OOM dump task is special in that it can generate thousands of KERN_INFO
messages. If such messages are printed to consoles, it defers solving OOM
situation.

But setting /proc/sys/vm/oom_dump_tasks to 0 causes such messages being
not delivered to userspace daemon for later analysis. Therefore, we can not
set /proc/sys/vm/oom_dump_tasks to 0 if we want to save such messages for
later analysis.

Changing console loglevel (e.g. setting "quiet" kernel command line option)
in order to hide such messages also prevents all other KERN_INFO messages from
being printed to consoles. Since some KERN_INFO messages are worth printing to
consoles while other KERN_INFO messages are worth printing to consoles,
controlling with

>   + loglevel assigned to each message

is inevitable.

I think that basically only oops (e.g. WARN()/BUG()/panic()) messages worth
printing to consoles and the rest messages do not worth printing to consoles.
Existing KERN_$LOGLEVEL is too rough-grained.

