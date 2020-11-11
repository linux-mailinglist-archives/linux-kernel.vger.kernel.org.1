Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3542AFC59
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgKLBfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgKKXQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 18:16:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B5DC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 15:16:53 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605136611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZBC1a6+oJdZ9ZhegVBbSXHq4ymUdKp4wpPY9WVvD+4U=;
        b=OOLLK61iYru4uJUTQBw5YiR2s/geKPg0svNv9uNW5zGWYP6EG1MT5u4GcNWrZs/SrOpt41
        I2wxIJl+MYMpsUH54rDPtPeJkGkQ8UrZ1cT35ottJnXEi7vQn2uqq3c7V6n19S5lj5zeZy
        xM1qEkjPFFHTr3stetkYGAemQNeMetqm2hZDPkqtMOTiCnDtxpIzB4hELqYWp0NN6Opptp
        2JeCs+5wOGyZoNvCRDu5vj6G+IWxeASKi1T7HUjrAXhXzsKmm9ScnpX0LfWgWJVjFC+u/d
        AgVsbzYUXnN/NsX1EdYRqChJ3AhKjmZ/kelNMJQjB1hLJiX+a8p6fq9sC5JyLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605136611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZBC1a6+oJdZ9ZhegVBbSXHq4ymUdKp4wpPY9WVvD+4U=;
        b=Mq86teNZY0ss8LzRve+zEkGiFTpJ0SrNz+jQFtcnaD3JVmOB1kvIKM3eg4OBOJh8ZUXBBj
        1uZdCUNe7azcWYDg==
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, alexander.levin@microsoft.com,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com
Subject: Re: [RFC] Are you good with Lockdep?
In-Reply-To: <20201111093609.1bd2b637@gandalf.local.home>
References: <20201111050559.GA24438@X58A-UD3R> <20201111105441.GA78848@gmail.com> <20201111093609.1bd2b637@gandalf.local.home>
Date:   Thu, 12 Nov 2020 00:16:50 +0100
Message-ID: <87d00jo55p.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11 2020 at 09:36, Steven Rostedt wrote:
> Ingo Molnar <mingo@kernel.org> wrote:
>> Not sure I understand the "problem 2)" outlined here, but I'm looking 
>> forward to your patchset!
>> 
> I think I understand it. For things like completions and other "wait for
> events" we have lockdep annotation, but it is rather awkward to implement.
> Having something that says "lockdep_wait_event()" and
> "lockdep_exec_event()" wrappers would be useful.

Wrappers which make things simpler are always useful, but the lack of
wrappers does not justify a wholesale replacement.

We all know that lockdep has limitations but I yet have to see a proper
argument why this can't be solved incrementaly on top of the existing
infrastructure.

That said, I'm not at all interested in a wholesale replacement of
lockdep which will take exactly the same amount of time to stabilize and
weed out the shortcomings again.

Thanks,

        tglx

