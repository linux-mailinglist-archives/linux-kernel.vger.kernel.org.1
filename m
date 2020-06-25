Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EBD20A0A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 16:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405356AbgFYOOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 10:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405286AbgFYON7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:13:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913CAC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 07:13:59 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=vostro)
        by Galois.linutronix.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1joSdW-0000GD-HJ; Thu, 25 Jun 2020 16:13:54 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Paul McKenney <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 0/3] printk: replace ringbuffer
References: <20200618144919.9806-1-john.ogness@linutronix.de>
        <20200625071959.GA18744@dhcp-128-65.nay.redhat.com>
Date:   Thu, 25 Jun 2020 16:13:52 +0200
In-Reply-To: <20200625071959.GA18744@dhcp-128-65.nay.redhat.com> (Dave Young's
        message of "Thu, 25 Jun 2020 15:19:59 +0800")
Message-ID: <87wo3vi673.fsf@jogness.linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 2020-06-25, Dave Young <dyoung@redhat.com> wrote:
> On 06/18/20 at 04:55pm, John Ogness wrote:
>> Here is a v3 for the first series to rework the printk
>> subsystem. The v2 and history are here [0]. This first series
>> only replaces the existing ringbuffer implementation. No locking
>> is removed. No semantics/behavior of printk are changed.
>> 
>> Reviews on the ringbuffer are still ongoing, but I was asked to
>> post this new version since several changes from v2 have been
>> already agreed upon.
>> 
>> The series is based on v5.8-rc1.
>
> Do you have the kdump userspace part link so that people can try
> and do some testing?
>
> Eg. some makedumpfile/crash tool git branch etc.

I have set up github forks, each with the RFC patch on top in their
respective "printk" branch:

    https://github.com/Linutronix/crash.git

    https://github.com/Linutronix/makedumpfile.git

Note that for crash, only the "log" command (using debug symbols) is
implemented. The --log argument (using VMCOREINFO) is not implemented.

For makedumpfile both symbol and VMCOREINFO variants are implemented.

The VMCOREINFO implementation in makedumpfile shows that there is enough
VMCOREINFO exported. So it will not be a problem to implement that for
crash as well.

John Ogness
