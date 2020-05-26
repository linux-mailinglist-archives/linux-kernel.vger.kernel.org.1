Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352581D113B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 13:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgEMLZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 07:25:04 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57550 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgEMLZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:25:03 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04DBOOjo033442;
        Wed, 13 May 2020 20:24:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp);
 Wed, 13 May 2020 20:24:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04DBOOjV033412
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 13 May 2020 20:24:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
To:     Michal Hocko <mhocko@kernel.org>, Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <4dae86af-1d9a-f5a8-cff6-aa91ec038a79@i-love.sakura.ne.jp>
 <20200428121828.GP28637@dhcp22.suse.cz>
 <b4d74234-8009-9ffd-011f-bd5d1a4b85f6@i-love.sakura.ne.jp>
 <20200428154532.GU28637@dhcp22.suse.cz>
 <b1d507b1-dae7-f526-c74a-d465ddecea6a@i-love.sakura.ne.jp>
 <20200429142106.GG28637@dhcp22.suse.cz>
 <a59271f1-b3fc-26d1-f0a2-5ec351d0095e@i-love.sakura.ne.jp>
 <20200513062652.GM413@jagdpanzerIV.localdomain>
 <a75d6560-ad99-5b02-3648-247c27c3a398@i-love.sakura.ne.jp>
 <20200513100413.GH17734@linux-b0ei> <20200513104938.GW29153@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <d66c38d9-dd97-072d-e1a7-949e9573b38d@i-love.sakura.ne.jp>
Date:   Wed, 13 May 2020 20:24:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513104938.GW29153@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/13 19:49, Michal Hocko wrote:
> On Wed 13-05-20 12:04:13, Petr Mladek wrote:
>> What is so special about  OOM dump task so that it would deserve such
>> complications?
> 
> Nothing really. Except for the potential amount of the output.

"echo t > /proc/sysrq-trigger" from userspace program is another example.

> But as
> you've said there are two ways around that. Disable this output if you
> do not need it or make it a lower loglevel. 

Disable this output for syslog is not acceptable for me, but disable this
output for consoles is preferable for me.

> I simply cannot tell whether somebody considers
> dump_tasks an important information to be printed on consoles.

I don't think dump_tasks() is important information to be printed on consoles.
But since somebody might think dump_tasks() is important information to be
printed on consoles, I suggest switching KERN_NO_CONSOLES using e.g. sysctl.

> 
> If there is any need to control which messages should be routed to which
> backend then the proper solution would be to filter messages per log
> level per backend.

Possible backends will be "zero or more than zero" consoles + "zero or one"
syslog, and KERN_NO_CONSOLES is a method for force selecting "zero" console
backend.

>                    But I have no idea how feasible this is for the
> existing infrastructure - or maybe it already exists...

There is per-console loglevel proposal (which allows selecting "some" console
backends). But it is based on KERN_$LOGLEVEL which is too rough-grained.
