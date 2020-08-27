Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320F6254246
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 11:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgH0J1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 05:27:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37490 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgH0J1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:27:46 -0400
Date:   Thu, 27 Aug 2020 11:27:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598520465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wX7KWwoex+q8OfppFzIKjxe/w30Jk2K0LVujBzK4Ztk=;
        b=xfhm66zdz7wEmAFzxHBRRy8aRiTsrAw+2VAtpg6LMfTSDGOsAdfZoQCsvE61GPSKvND4Wi
        55OwRtO8akTo304ShPim9vtgMdk9nhzu9/j3VKt1WvatMwi1WWx6mXvyYCBuYmx3k2nGOr
        cQWm/l8zPTIhs5o/HYUDJEL5MUtnQTqakiLHIQXTb1tZlIvtYkMcAusfynkEl+uQ3zx2L7
        927VCDFHkDfg8GtDjHjlUMQvYbTP+saGy4zGRQ9sHJrtXvRNv//a/SrMcOD8cwJkf65Ef1
        z5RYo0Gw38XhwgQw1AGhnB9PbndevutOpPO1HWrqOWipIyFsjpnMOYSC6z054Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598520465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wX7KWwoex+q8OfppFzIKjxe/w30Jk2K0LVujBzK4Ztk=;
        b=P4I8qck0atOGA6cc2e65hJJ6131GM6o4RpGAAmwwOPXONir63RcymI4gJbQwLnKFa2/Kz3
        Vubr9CounRwMKyDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9-rc2-rt1
Message-ID: <20200827092743.kjl6hkaephx3a64a@linutronix.de>
References: <20200824154605.v66t2rsxobt3r5jg@linutronix.de>
 <20200826080802.5lnnf5wh3kcwfykz@beryllium.lan>
 <20200826081211.bvk5kfuzh4vlbh5k@linutronix.de>
 <20200826090518.m6vblobggnfdjau5@beryllium.lan>
 <20200826104326.xfexkwovwbi2q4el@beryllium.lan>
 <20200827091910.ibuyr53qprb7qmju@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827091910.ibuyr53qprb7qmju@beryllium.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-27 11:19:10 [+0200], Daniel Wagner wrote:
> the the dtb file via ftp and then does a booti. For all non PREEMPT_RT
> kernels (PREEMPT, NONE, SMP=n, ...) everything works fine. For the
> PREEMPT_RT kernel uboot complains with
> 
>   U-Boot> booti 0x00080000 - 0x02600000
>   bootloader-commands: Wait for prompt Starting kernel (timeout 00:03:43)
>   booti 0x00080000 - 0x02600000
>   ERROR: Did not find a cmdline Flattened Device Tree
>   Starting kernel ...
> 
> It's the same dtb in all cases. Not totally sure what is upsetting uboot
> here, maybe the load addresses don't work anymore?

So v5.9-rc2-rt1 with PREEMPT_RT=y enabled leads to the problem and
v5.9-rc2-rt1 with PREEMPT_PREEMPT=y boots fine?

> In short, I can't really say if v5.9-rt for ARMv8 works for me.

Sebastian
