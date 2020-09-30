Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3646527EB0F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 16:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbgI3Ogi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 10:36:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:33502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgI3Ogi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:36:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601476596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IMnEwH4qwUtlTeoSuJZEhw8eHfqnUGzyAby7J37Hf8I=;
        b=DSyp2QU5v2cfHgBykj6NqjdSidfhBR+PCTIssukv44AiUoKLu2elQG7VdBDTJ2n9gN4VMf
        TRdrN/2CRyAgaKtGNxcldr3e8FpMm4AM+o3Y2P8T8gKNM05kbhNL3kTAGIEUhA/gdAyAtr
        JGZfQXz5OnIZuOLs3Pye2Kx4xTBFNGs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2871DAB8F;
        Wed, 30 Sep 2020 14:36:36 +0000 (UTC)
Date:   Wed, 30 Sep 2020 16:36:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     psodagud@codeaurora.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        tkjos@google.com, Mohammed Khajapasha <mkhaja@codeaurora.org>
Subject: Re: [PATCH 2/2] printk: Make the console flush configurable in
 hotplug path
Message-ID: <20200930143635.GJ29288@alley>
References: <1600906112-126722-1-git-send-email-psodagud@codeaurora.org>
 <1600906112-126722-2-git-send-email-psodagud@codeaurora.org>
 <20200924063352.GB592892@kroah.com>
 <87wo0j6nos.fsf@nanos.tec.linutronix.de>
 <4c4a2534824eb69d41753d2e3b2773de@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c4a2534824eb69d41753d2e3b2773de@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2020-09-27 19:05:34, psodagud@codeaurora.org wrote:
> Yes. I agree with you that there are other conditions, which could delay the
> hotplug operation. But this console
> flushing is not needed in the hotplug path.  In the hotplug path, a core is
> trying printing messages
> from other core(by design of printk), delays the whole hotplug operation and
> timers migration.  As timers
> migration gets delayed, it would impact the systems stability in device
> stability testing.
> To avoid timers delay in the timer migration in  debug builds has to choose
> this option.

Again, just from the printk() point of view. The current printk()
design is that it tries to flush the messages to the console
immediately. It increases the chance to see them. The price is
that printk() might delay the code a lot.

Console handled in a dedicated kthread might make printk() fast. But
there might be another problem. Messages might get lost when they
generated faster than they might be shown on slow consoles.

In both cases, you need to think twice whether you really want to
print the messages at all or if you really want to show them on
slow consoles, see console_loglevel.

Also keep in mind that testing is not real life. I believe that
kernel messages are not shown on slow consoles on production devices.

That said, it seems that printk() is not the real problem here. As
others suggest, CPU hotplug is not the right solution for the usecase.

Best Regards,
Petr
