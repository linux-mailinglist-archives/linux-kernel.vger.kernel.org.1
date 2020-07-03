Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71773213DBE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 18:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgGCQvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 12:51:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56433 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726147AbgGCQvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 12:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593795108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=K41RwyHIydU6qmwjScGmq28Lh7mWIXkEeRHuEE+wuaE=;
        b=BARYOUiZ/E8fMLHN0KWZJTRCpXmK9XFd39/ELBNEzV6PKW6+ZhvtvzNVeRWbLBQkgqkrl0
        0cj55B2OpBz+pi/9tfO3dihSvbIBfvrkT3Iv6z6glryqmBqvaiWOpryFvDNKRdVS72GBhv
        KfbO1LO2Z/aD8k9C4Py6uAoMaPutTmQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-TVkFfB3sMo-idMOC4jqbaQ-1; Fri, 03 Jul 2020 12:51:41 -0400
X-MC-Unique: TVkFfB3sMo-idMOC4jqbaQ-1
Received: by mail-qt1-f197.google.com with SMTP id e6so21189631qtb.19
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 09:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=K41RwyHIydU6qmwjScGmq28Lh7mWIXkEeRHuEE+wuaE=;
        b=Kzdt9mCWkdSSwWURI39DCfy8Yr6+GkohsebCfMySGsA/f52oFwr5HOUfq7UL5uvk0S
         jhFP1FoDaIswoNs/8sEPTvxXPwlPgD8iaKOaUUcSYKGZe3yOrMjTON7styKMCckxJ7zZ
         oJ9DHLeLGgOdvaR6U++0PlIL1xe9o0d3AAruhv1olK5g+4KPTxP/ICjF1cJau2IMkKCY
         KPHa68hSc+irfuDWq3gI2zmmuK6FZHQgGTwI/Bq1kWb6aVB3b4nFyVV29QDQaqo22yu3
         ymGsm/UZivlo002z9OuGULbXo5yz2xOb7pi3WazuPeqmceVoI1iCA/10M2KOLB7SCxAi
         p0Vg==
X-Gm-Message-State: AOAM53311kcik22pULwu02GWkHSANfgMhwoyXyn9gmYs9t7MvFTd3vEW
        0Ncf85Pvr3v+15T2Jmh98h9a3n9oaxBnMuPK6uiu2eA+bBBwO4sqvxsB2/lVgQqKn/zj6mIbOCu
        HBGblBuqHa0JLIvZX1FGY+dyb
X-Received: by 2002:a37:2c41:: with SMTP id s62mr29769863qkh.165.1593795100715;
        Fri, 03 Jul 2020 09:51:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1RP7VET+D3eXC8Ok2q/QrrPziPN8VOU/hxcUrPvcZJEBzLh6UL49H1rZSn59ozW+6dyUVBQ==
X-Received: by 2002:a37:2c41:: with SMTP id s62mr29769830qkh.165.1593795100436;
        Fri, 03 Jul 2020 09:51:40 -0700 (PDT)
Received: from x1.bristot.me (host-87-16-204-193.retail.telecomitalia.it. [87.16.204.193])
        by smtp.gmail.com with ESMTPSA id m4sm12860911qtf.43.2020.07.03.09.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 09:51:39 -0700 (PDT)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [ANNOUNCE][CFP] Real-Time Micro Conference at LPC 2020
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        =?UTF-8?Q?Luis_Claudio_R=2e_Gon=c3=a7alves?= <lclaudio@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Tom Rix <trix@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Christian Brauner <christian.brauner@canonical.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <72353caf-c2aa-f2e4-fe2d-778f04625b70@redhat.com>
Date:   Fri, 3 Jul 2020 18:51:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the call for proposals for the Real-Time Micro Conference (RT-MC) at the
Linux Plumbers Conference 2020. It will take place online during the Linux
Plumbers Conference on August 24th-28th, 2020.

The real-time micro-conference targets discussions about new features or open
problems related to real-time Linux ecosystem. Each accepted topic will receive
a 30 minutes slot. The presenter - or mediator - will introduce the problem in
the first 10 minutes with a short presentation and then promote the discussion
in the next 20 minutes.

We encourage submissions that do not present a final solution. Instead, that
serves to get feedback from the community, to point to action items for future
development, and that can result in patches for the real-time Linux ecosystem in
the future.

Please submit your proposals on the LPC website at:

https://www.linuxplumbersconf.org/event/7/abstracts/#submit-abstract

And be sure to select "Real-time MC" in the Track pulldown menu.

Proposals must be submitted by August 2nd, and submitters will be notified of
acceptance by August 9th.

About the real-time MC:

Since 2004 a project has improved the Real-time and low-latency features for
Linux. This project has become know as PREEMPT_RT, formally the real-time patch.
Over the past decade, many parts of the PREEMPT RT became part of the official
Linux codebase. Examples of what came from PREEMPT_RT include: Mutexes,
high-resolution timers, lockdep, ftrace, RT scheduling, SCHED_DEADLINE,
RCU_PREEMPT, generic interrupts, priority inheritance futexes, threaded
interrupt handlers and more. The number of patches that needs integration has
been reduced in the last years, and the pieces left are now mature enough to
make its way into mainline Linux. For real, this year could possibly be the year
PREEMPT_RT is merged™!

In the final lap of this race, the last patches are on the way to be merged, but
there are still some very few pieces missing. When the merge occurs, the
PREEMPT_RT will start to follow a new pace: the Linus one. So, it is possible to
raise the following discussions:

	- The status of the merge, and how can we resolve the last issues that
	  block the merge
	- How can we improve the testing of the -rt, to follow the problems
	  raised as Linus tree advances
	- What’s next?

Other possible topics:

	- Merge – what is missing and who can help?
	- New tools for PREEMPT_RT analysis
	- How do we teach the rest of the kernel developers how not to break
	  PREEMPT_RT?
	- Stable maintainers tools discussion & improvements
	- The usage of PREEMPT_RT on safety critical-systems: what do we need to
	  do?
	- Interrupt threads are RT and are not protected by the RT Throttling
	- How can we prevent interrupt thread starvation from a rogue RT task?

If your topic is not listed here, it is a good sign that you need to propose
your talk! This micro-conference is about new things, not things that people
already know, so go ahead and fill a proposal!

If you have any further doubt, feel free to contact me.

Thanks!
-- Daniel

