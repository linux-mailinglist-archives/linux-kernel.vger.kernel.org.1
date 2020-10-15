Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D8E28F41A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbgJON6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730026AbgJON6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:58:33 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F969C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 06:58:33 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l24so3180555edj.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 06:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=fdI4p7/qBCge3jJvrOu3tPdFl4GdC422zyVFBne/x64=;
        b=wGndaJZeMQMZ7xpt6wUQSTk2/7XyK1sH1Ms9SHkqKxnVfU15iN7hZbtbL+wGgcx+qS
         xH2vpi2rVgW+ApU3UoOJLkfdt+IZJpqiU0iVL2YAoWcdeogibrsUDTA6G0qVm6E7Nggz
         gVx4eKdWfgxoU1vAAgpuhK64pj9rsPZKwyPa40wWqrqeHQpm84/bM6qqKSK18RP5TUtN
         pf0EuPL3yT+VHRarVj999zns8ZRg1dajUgNTg8dJv79+aWgG1qv/r2nwPcbax4NJs5rq
         tIHze3iv4pLbB6Jl0oiDX/n0y9F5SSbbVd6kUG+oXy6iQAKzr59pGMlP7xyoCKraWurH
         Jgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=fdI4p7/qBCge3jJvrOu3tPdFl4GdC422zyVFBne/x64=;
        b=dhY2HHDf7oaIdn9wRhcvxCa69VzlEEuQtCQhbWfvw8sWTkFV6wzT9KQrERq+cQfhSI
         0ycrusj63HZcIDePLOTRLueQ7DYThawQJT+havPfSyCDsElbSGZIohtesN1zt+XzKQsL
         ifsI/hDEhpVWLw2z6Yh7wvn33NLonQVCriUMODoPrJehoLjl8AI4FBztgwt2c37764ue
         m6/4H/omRNbYQ7W7NZjrxv1mZt3SpNBYF0mX6YjGtW39u3dynj/LGOG+rpypodiDuxq+
         +CP6RsKqEsYJ8agw2Qa06jUUuNjG2oa7t1exQUq+jxdwwCecx9X0OkQbkipsex8gz35/
         cvBA==
X-Gm-Message-State: AOAM532pH+Bksjaf3e9E3LFlwhD0N9pU9LWczIzp0/XxZJl2LpblTp+2
        Aw9x3RNgiR7PRsRT8qD8ANneAg==
X-Google-Smtp-Source: ABdhPJzg5RRJptuf4pqD+ONJnaNKQhYotJmYLUu9ROO3dVHbpoQv/LZk+vNUK13COyz15v33hB2lHw==
X-Received: by 2002:a50:ef12:: with SMTP id m18mr4526219eds.313.1602770311832;
        Thu, 15 Oct 2020 06:58:31 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id y11sm1616685edu.85.2020.10.15.06.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 06:58:31 -0700 (PDT)
References: <20200923123916.1115962-1-jbrunet@baylibre.com> <20201015134628.GA11989@arm.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, Da Xue <da@libre.computer>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: cancel timer before starting it
In-reply-to: <20201015134628.GA11989@arm.com>
Date:   Thu, 15 Oct 2020 15:58:30 +0200
Message-ID: <1jlfg7k2ux.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 15 Oct 2020 at 15:46, Ionela Voinescu <ionela.voinescu@arm.com> wrote:

> Hi guys,
>
> On Wednesday 23 Sep 2020 at 14:39:16 (+0200), Jerome Brunet wrote:
>> If the txdone is done by polling, it is possible for msg_submit() to start
>> the timer while txdone_hrtimer() callback is running. If the timer needs
>> recheduling, it could already be enqueued by the time hrtimer_forward_now()
>> is called, leading hrtimer to loudly complain.
>> 
>> WARNING: CPU: 3 PID: 74 at kernel/time/hrtimer.c:932 hrtimer_forward+0xc4/0x110
>> CPU: 3 PID: 74 Comm: kworker/u8:1 Not tainted 5.9.0-rc2-00236-gd3520067d01c-dirty #5
>> Hardware name: Libre Computer AML-S805X-AC (DT)
>> Workqueue: events_freezable_power_ thermal_zone_device_check
>> pstate: 20000085 (nzCv daIf -PAN -UAO BTYPE=--)
>> pc : hrtimer_forward+0xc4/0x110
>> lr : txdone_hrtimer+0xf8/0x118
>> [...]
>> 
>> Canceling the timer before starting it ensure that the timer callback is
>> not running when the timer is started, solving this race condition.
>> 
>> Fixes: 0cc67945ea59 ("mailbox: switch to hrtimer for tx_complete polling")
>> Reported-by: Da Xue <da@libre.computer>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/mailbox/mailbox.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
>> index 0b821a5b2db8..34f9ab01caef 100644
>> --- a/drivers/mailbox/mailbox.c
>> +++ b/drivers/mailbox/mailbox.c
>> @@ -82,9 +82,13 @@ static void msg_submit(struct mbox_chan *chan)
>>  exit:
>>  	spin_unlock_irqrestore(&chan->lock, flags);
>>  
>> -	if (!err && (chan->txdone_method & TXDONE_BY_POLL))
>> -		/* kick start the timer immediately to avoid delays */
>> +	if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
>> +		/* Disable the timer if already active ... */
>> +		hrtimer_cancel(&chan->mbox->poll_hrt);
>> +
>> +		/* ... and kick start it immediately to avoid delays */
>>  		hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
>> +	}
>>  }
>>  
>>  static void tx_tick(struct mbox_chan *chan, int r)
>
> I've tracked a regression back to this commit. Details to reproduce:

Hi Ionela,

I don't have access to your platform and I don't get what is going on
from the log below.

Could you please give us a bit more details about what is going on ?

All this patch does is add hrtimer_cancel().
* It is needed if the timer had already been started, which is
  appropriate AFAIU
* It is a NO-OP is the timer is not active.

>
>
>  - HEAD: (linux-next)
>    * 62c04453381e  Jerome Brunet   3 weeks ago mailbox: cancel timer before starting it
>
>  - Platform: arm64 Juno R0 and Juno R2 [1]
>
>  - Partial log:
> 	[    0.000000] Booting Linux on physical CPU 0x0000000100 [0x410fd030]
> 	[    0.000000] Linux version 5.9.0-rc8-01722-g62c04453381e () (aarch64-none-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture 9.2-2019.12 (arm-9.10)) 9.2.1 20191025, GNU ld (GNU Toolchain for the A-profile Architecture 9.2-2019.12 (arm-9.10)) 2.33.1.20191209) #175 SMP PREEMPT Thu Oct 15 14:17:41 BST 2020
> 	[    0.000000] Machine model: ARM Juno development board (r0)
> 	[..]
> 	[    1.714340] mhu 2b1f0000.mhu: ARM MHU Mailbox registered
> 	[    1.722768] NET: Registered protocol family 17
> 	[    1.727364] 9pnet: Installing 9P2000 support
> 	[    1.731689] Key type dns_resolver registered
> 	[    1.735474] usb 1-1: new high-speed USB device number 2 using ehci-platform
> 	[    1.736407] registered taskstats version 1
> 	[    1.747061] Loading compiled-in X.509 certificates
> 	[    1.755885] scpi_protocol scpi: SCP Protocol 1.2 Firmware 1.21.0 version
> 	[    1.770484] cpu cpu0: EM: created perf domain
> 	[    1.778505] cpu cpu1: EM: created perf domain
> 	[    1.807449] scpi_clocks scpi:clocks: failed to register clock 'pxlclk'
> 	[    1.897593] hub 1-1:1.0: USB hub found
> 	[    1.901656] hub 1-1:1.0: 4 ports detected
> 	[    2.559453] atkbd serio0: keyboard reset failed on 1c060000.kmi
> 	[   22.787431] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> 	[   22.793536] rcu:     1-...0: (1 ticks this GP) idle=222/1/0x4000000000000002 softirq=63/64 fqs=2626
> 	[   22.802421]  (detected by 2, t=5255 jiffies, g=-991, q=9)
> 	[   22.807823] Task dump for CPU 1:
> 	[   22.811049] task:swapper/1       state:R  running task     stack:    0 pid:    0 ppid:     1 flags:0x0000002a
> 	[   22.820980] Call trace:
> 	[   22.823429]  __switch_to+0x138/0x198
> 	[   23.583444] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-... } 5443 jiffies s: 49 root: 0x2/.
> 	[   23.593995] rcu: blocking rcu_node structures:
> 	[   23.598449] Task dump for CPU 1:
> 	[   23.601680] task:swapper/1       state:R  running task     stack:    0 pid:    0 ppid:     1 flags:0x0000002a
> 	[   23.611619] Call trace:
> 	[   23.614064]  __switch_to+0x138/0x198
> 	[   85.807430] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> 	[   85.813534] rcu:     1-...0: (1 ticks this GP) idle=222/1/0x4000000000000002 softirq=63/64 fqs=10502
> 	[   85.822506]  (detected by 2, t=21009 jiffies, g=-991, q=9)
> 	[   85.827994] Task dump for CPU 1:
> 	[   85.831220] task:swapper/1       state:R  running task     stack:    0 pid:    0 ppid:     1 flags:0x0000002a
> 	[   85.841150] Call trace:
> 	[   85.843596]  __switch_to+0x138/0x198
> 	[   87.071446] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-... } 21315 jiffies s: 49 root: 0x2/.
> 	[   87.082088] rcu: blocking rcu_node structures:
> 	[   87.086540] Task dump for CPU 1:
> 	[   87.089773] task:swapper/1       state:R  running task     stack:    0 pid:    0 ppid:     1 flags:0x0000002a
> 	[   87.099708] Call trace:
> 	[   87.102155]  __switch_to+0x138/0x198
> 	[  148.827442] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> 	[  148.833565] rcu:     1-...0: (1 ticks this GP) idle=222/1/0x4000000000000002 softirq=63/64 fqs=18377
> 	[  148.842543]  (detected by 4, t=36762 jiffies, g=-991, q=9)
> 	[  148.848037] Task dump for CPU 1:
> 	[  148.851268] task:swapper/1       state:R  running task     stack:    0 pid:    0 ppid:     1 flags:0x0000002a
> 	[  148.861207] Call trace:
> 	[  148.863663]  __switch_to+0x138/0x198
> 	[  150.559443] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-... } 37187 jiffies s: 49 root: 0x2/.
> 	[  150.570082] rcu: blocking rcu_node structures:
> 	[  150.574535] Task dump for CPU 1:
> 	[  150.577767] task:swapper/1       state:R  running task     stack:    0 pid:    0 ppid:     1 flags:0x0000002a
> 	[  150.587705] Call trace:
> 	[  150.590151]  __switch_to+0x138/0x198
>
>  - Commit working as expected:
>    * 558e4c36ec9f  Krzysztof Kozlowski     7 weeks ago     maiblox: mediatek: Fix handling of platform_get_irq() error
>
>
> [1] https://developer.arm.com/tools-and-software/development-boards/juno-development-board
>
> Thank you,
> Ionela.
>
>> -- 
>> 2.25.4
>> 
>> 
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic

