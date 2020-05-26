Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C811AA487
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 15:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636121AbgDONeb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Apr 2020 09:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730130AbgDONe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:34:27 -0400
X-Greylist: delayed 8508 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Apr 2020 06:34:27 PDT
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F4BC061A0C;
        Wed, 15 Apr 2020 06:34:27 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jOiBL-0002uX-Tp; Wed, 15 Apr 2020 15:34:23 +0200
Date:   Wed, 15 Apr 2020 15:34:23 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 0087-rcu-Use-a-raw_spinlock_t-for-kfree-batching.patch
Message-ID: <20200415133423.7mohynwqanoiqzkx@linutronix.de>
References: <20200403170443.pzm24672qo4hufcm@linutronix.de>
 <1586062423.4816.15.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1586062423.4816.15.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-05 06:53:43 [+0200], Mike Galbraith wrote:
> Hi Sebastian,
Hi Mike,

> Just a heads up wrt $subject...
> 
> I had done the same in my 5.6 tree, but then 5.7 came along, and I had
> to revisit due to 34c881745549e adding an allocation under that lock
> with irqs disabled.  The same commit that added the lock added this.
> 
> 	local_irq_save(flags);  // For safely calling this_cpu_ptr().
> 
> Whacking that instead of converting the lock cures 5.6 and 5.7 woes.

So I think you are telling me that I made the lock raw and then they
added in v5.7 a __get_free_page() call in
kfree_call_rcu_add_ptr_to_bulk() which is invoked from the free path.

This is indeed not something that made me happy. Now let me think about
this for a moment…

> 	-Mike

Sebastian
