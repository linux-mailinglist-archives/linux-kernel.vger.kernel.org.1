Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60A91B7991
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 17:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgDXP3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 11:29:35 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49209 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgDXP3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:29:35 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03OFSuHd019852;
        Sat, 25 Apr 2020 00:28:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Sat, 25 Apr 2020 00:28:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03OFSucV019848
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 25 Apr 2020 00:28:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200424092816.62a61b1d@gandalf.local.home>
 <579fbe97-9aae-2b67-03ff-01291b9cbb7d@i-love.sakura.ne.jp>
 <20200424103131.7987f890@gandalf.local.home>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <7ec0b0a3-39ae-0f1c-b8c2-e1e9e60f1223@i-love.sakura.ne.jp>
Date:   Sat, 25 Apr 2020 00:28:53 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424103131.7987f890@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/04/24 23:31, Steven Rostedt wrote:
> On Fri, 24 Apr 2020 23:00:01 +0900
> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
> 
>> Since KERN_NO_CONSOLES is for -ENOMEM situations (GFP_KERNEL allocation which
>> can sleep needs to invoke the OOM killer, or GFP_ATOMIC allocation which cannot
>> sleep has failed), we can't create buffer on demand. For process context, it
>> would be possible to create buffer upon fork() time. But for atomic context,
>> it is so difficult to create buffer on demand. We could allocate shared buffer
>> like logbuf but it means that we have to replicate what printk() is doing (too
>> much code), for when atomic memory allocation happens resembles when printk()
>> is called. Borrowing printk()'s logbuf is simpler.
> 
> I would have a buffer allocated for this at start up.

Allocating global buffer itself is simple (except that it might waste a lot of
memory). Difficult part is how to use the buffer.

> 
> What exactly would you be "replicating" in printk?

Making it possible to store into global buffer from almost any context (not only
process context but also softirq/hardirq/NMI context (well, is memory allocation
 from NMI context not permitted? I don't know... but future KERN_NO_CONSOLES
users might want to call from NMI context)), notify userspace program of data
readiness, and manage the buffer.

KERN_NO_CONSOLES does not need to call call_console_drivers(). But basically
things what printk() is doing.

>                                                    The point of printk is
> to print to a console, not to be a generic ring buffer. This change is
> breaking printk's most useful feature.

For those who analyze log files (instead of console output), the point of
printk() is to save kernel messages into log files (via userspace syslog
daemon).

By the way, I think

  printk(KERN_NO_CONSOLES "hello\n")

is almost same with doing

  saved_loglevel = console_loglevel;
  console_loglevel = CONSOLE_LOGLEVEL_SILENT;
  printk("hello\n");
  console_loglevel = saved_loglevel;

used by vkdb_printf().

