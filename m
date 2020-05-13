Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1494E1D0F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 12:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbgEMKEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 06:04:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:53480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733245AbgEMKET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 06:04:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4C8B3B1EF;
        Wed, 13 May 2020 10:04:19 +0000 (UTC)
Date:   Wed, 13 May 2020 12:04:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
Message-ID: <20200513100413.GH17734@linux-b0ei>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a75d6560-ad99-5b02-3648-247c27c3a398@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-05-13 16:58:48, Tetsuo Handa wrote:
> On 2020/05/13 15:26, Sergey Senozhatsky wrote:
> > Yes, but this looks like it's the consumer of the messages who
> > decides what to filter and what not to. rsyslog, dmesg, etc.
> > will have different filtering policies. It's not like the kernel
> > decides what to hide and what to show. If would compare this to
> > NO_CONSOLES, then NO_CONSOLES does a different thing after all.
> 
> I just showed an example that changing dump_tasks() messages from
> KERN_INFO to KERN_DEBUG is not an option. If dump_tasks() were using
> KERN_DEBUG, the consumer of the messages will have to receive all
> KERN_DEBUG messages, which needlessly contains uninterested messages.
> If dump_tasks() allows use of NO_CONSOLES (via e.g. sysctl switch),
> the consumer does not need to receive KERN_DEBUG messages.
> 
> What is wrong with adding NO_CONSOLES ?

How does it differ from KERN_DEBUG? The debug messages:

  + can be disabled via sysfs
  + might reach console when this loglevel is enabled


The console loglevel handling is already very complicated. The
behavior is affected by:

  + four values in console_printk array:
      + console_loglevel
      + default_message_loglevel
      + minimum_console_loglevel
      + default_console_loglevel

  + ignore_loglevel variable

  + loglevel assigned to each message


I really do not see a reason for another loglevel, another sysfs
interface, and another special handling. It would just make it even
more complicated for both developers and users.

What is so special about  OOM dump task so that it would deserve such
complications?

The dump might already be enabled or disabled. If is not important
enough to reach the console then the messages should be printed
with a lower loglevel.

Best Regards,
Petr
