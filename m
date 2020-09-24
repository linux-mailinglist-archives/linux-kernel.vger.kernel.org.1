Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E538277865
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 20:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgIXSVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 14:21:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50532 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgIXSVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 14:21:09 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600971667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uzgV97V/Ymts0NDjE/y6wMMhSHVNUGYAlTR+wB6Dh1c=;
        b=lJkela30NXZKkMKGGas1OGRGkvkXmp5pdVXOT2m0pf/q8tOCzZW5ekNFc1Bv+o8om2nvx5
        uI9lGRp/Qwrw3zNURGHNYE+1xum+01yiOJT1XDGF1gvr5u2RPszRZhbyNq9Aum5g3dNans
        eSztTJK6e/p7IlufphrJGtiR+6JzDNJk5OmWfl3Z6NsuXk7PG91F1FXnNa+WiaNxMRjSF6
        Qo/v4Ppouu+HDkTSbyJo4yJmIRjguipdRJtotTrwK9zNrKqtSkdvMwCEiCicRr6fECyrBe
        hHeegKrEVav7FFEWAtHSoPuih5r1rzkqt7BYQguhgZRGdhKyctFPzhGPnP+27Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600971667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uzgV97V/Ymts0NDjE/y6wMMhSHVNUGYAlTR+wB6Dh1c=;
        b=DMZMQxhP6Jj8b/2Gmu8NYzUj3md5qNlc/BsNbiVpEqxnuQwSH1STDT2Tddk+aS/Ydg79XB
        F9lQPMxqSp+QubCQ==
To:     Greg KH <gregkh@linuxfoundation.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
Cc:     rostedt@goodmis.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        tkjos@google.com, Mohammed Khajapasha <mkhaja@codeaurora.org>
Subject: Re: [PATCH 2/2] printk: Make the console flush configurable in hotplug path
In-Reply-To: <20200924063352.GB592892@kroah.com>
References: <1600906112-126722-1-git-send-email-psodagud@codeaurora.org> <1600906112-126722-2-git-send-email-psodagud@codeaurora.org> <20200924063352.GB592892@kroah.com>
Date:   Thu, 24 Sep 2020 20:21:07 +0200
Message-ID: <87wo0j6nos.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24 2020 at 08:33, Greg KH wrote:
> On Wed, Sep 23, 2020 at 05:08:32PM -0700, Prasad Sodagudi wrote:
>> +config CONSOLE_FLUSH_ON_HOTPLUG
>> +	bool "Enable console flush configurable in hot plug code path"
>> +	depends on HOTPLUG_CPU
>> +	def_bool n
>
> n is the default, no need to list it.
>
>> +	help
>> +	In cpu hot plug path console lock acquire and release causes the
>> +	console to flush. If console lock is not free hot plug latency
>> +	increases. So make console flush configurable in hot plug path
>> +	and default disabled to help in cpu hot plug latencies.
>
> Why would you not want this option?
>
> Why isn't this just a bugfix?

Because it's the normal behaviour of console lock and there are
gazillion other ways to delay stuff in the hotplug path.

CPU hotplug is not meant to be a high speed operation and if people
think they need it to be fast then its pretty much guaranteed that they
want it for the completely wrong reasons.

This #ifdef tinkering is just digusting especially as it just tackles an
obvious way how to delay timer migration, but does not address the
underlying root cause.

>> +#ifdef CONFIG_CONSOLE_FLUSH_ON_HOTPLUG
>
> #ifdef in .c code is a mess to maintain.
>
>>  	ret = cpuhp_setup_state_nocalls(CPUHP_PRINTK_DEAD, "printk:dead", NULL,
>>  					console_cpu_notify);
>>  	WARN_ON(ret < 0);
>>  	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "printk:online",
>>  					console_cpu_notify, NULL);
>>  	WARN_ON(ret < 0);
>> -	return 0;
>> +#endif
>
> What happens if we don't make these calls entirely?  Why not just remove
> them as who wants extra latency for their system?

That's just wrong. If you don't want output, then adjust your loglevel,
but delaying printks up to the point where by chance another printk
happens is just silly.

CPU hotplug is not about latency. It's slow by design and again, the
timer migration is simply happening at the wrong place. But fixing that
needs more thoughts than modifying log levels and sprinkling a few
#ifdefs into the code.

Thanks,

        tglx
