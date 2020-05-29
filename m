Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502D21E7E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 15:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgE2NO4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 May 2020 09:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgE2NO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:14:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C472C03E969;
        Fri, 29 May 2020 06:14:56 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jeeqa-0004pv-TF; Fri, 29 May 2020 15:14:52 +0200
Date:   Fri, 29 May 2020 15:14:52 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mark Marshall <markmarshall14@gmail.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Mark Marshall <mark.marshall@omicronenergy.com>,
        thomas.graziadei@omicronenergy.com,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: Kernel crash due to memory corruption with v5.4.26-rt17 and
 PowerPC e500
Message-ID: <20200529131452.pgj7mx7xaz7n4kz3@linutronix.de>
References: <CAD4b4WK9W+dNZZ_WPt-9ZNpSHvyxdwPW86Rtq4AKOONuvyR37A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAD4b4WK9W+dNZZ_WPt-9ZNpSHvyxdwPW86Rtq4AKOONuvyR37A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-04 11:40:08 [+0200], Mark Marshall wrote:
> The easiest way we have found to reproduce the crash is to repeatedly
> insert and then remove a module.  The crash then appears to be related
> to either paging in the module or in exiting the mdev process.  (The
> crash does also happen at other times, but it is hard to reproduce
> reliably then).  This simple script will almost always crash:
> 
>    for i in $(seq 1000) ; do echo $i ; modprobe crc7 ; rmmod crc7 ; done

So I tried that on 5.6.14-rt7 with the qemu version of e500 (the SMP and
UP version). No luck. I don't have anything with real hardware.
Could you share the .config in case this is related?

> (The crc7 module is chosen as it is small and simple.  Any module will
> work / crash).
> 
> We have tried kernels v5.0, v5.2 and v5.6.  The v5.0 and v5.2 kernels
> do not show the problem.  The v5.6 kernel does show the problem.
> Switching of RT fixes the problem.
> 
> I have reduced the functionality in the kernel to a bare minimum
> (removing networking, USB and PCI, as we have some out-of-tree patches
> in those areas) and we still get the crash.
…
> I have added some debugging code where the mm_struct and
> vma_area_struct have "poision" values at the start and the end, and
> this seems to show that the vma_area_struct is getting corrupted, but
> I'm not able to see where.

oh.

> We have switched on all of the debugging that we can, including
> KASAN, and this shows nothing.
> 
> 
> Can anyone help us?  What can we try next?  Is anyone using the e500
> with the RT kernel?  Does anyone have any idea how to debug problems
> related to the error message "Bad rss-counter state"?
> 
> Any help or advice would be most gratefully received.

I don't have any ideas. You could try to apply only a part of the RT
patch and see if it problem is still there. If you are lucky you find
the patch that introduces the problem. If not, the problem appears with
the RT switch…

> Many thanks,
> Mark Marshall and Thomas Graziadei

Sebastian
