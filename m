Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675632C12F0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 19:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388484AbgKWSNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729604AbgKWSNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:13:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8DBC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 10:13:18 -0800 (PST)
Date:   Mon, 23 Nov 2020 19:13:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606155195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y/pax/wRpdkYr/q18caVWEhC/F4r9vx7MszFRO+dchU=;
        b=lrwAinrKVyFepDaCeUlmYB3jS0UIlv5veb4oCR+1jAyQ8vfJw7RIl4EtlMHneuvUKzDbDv
        Mia/zqnCDei+tyTz19sheYrDPBxJN0KWrcF9foVubnPqc0yfx0f5qlHhRYkE7HOsIO1lZn
        M6cdZiBEYVb+oc3REMMrhkb4oIvT5Bq3kMgP7LPNOALbBuI1m117AxDDXsf/px0muPN8uV
        O/TLlDm7n2RdYIkAOmWNv2Otnr8QDTVp2U1Y9X++oZVRWURr+LA0D2TbaMW9vFekL7WXjb
        eH8KBNG4eYiR6FXCednHO8iQ0Rrfq1cS/Q5X4IglxUaA9cmTg24qdXbAwppXWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606155195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y/pax/wRpdkYr/q18caVWEhC/F4r9vx7MszFRO+dchU=;
        b=TmJkd9rjx7r9b9NRsPAWjC8wZDk5VlTyE7Cu2v6WrtX1FQXld6EgYBvhB/AvwwXkI4+zG+
        p02OZ6nZ+WDyNuCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Qian Cai <cai@redhat.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: Re: [PATCH v4 11/19] sched/core: Make migrate disable and CPU
 hotplug cooperative
Message-ID: <20201123181313.ug4fwjcqnmbvo3f2@linutronix.de>
References: <20201023101158.088940906@infradead.org>
 <20201023102347.067278757@infradead.org>
 <ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com>
 <jhjpn4bwznx.mognet@arm.com>
 <dda3b8f67a23dd60d36e5325dbb0c406be18e1db.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dda3b8f67a23dd60d36e5325dbb0c406be18e1db.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-18 09:44:34 [-0500], Qian Cai wrote:
> On Tue, 2020-11-17 at 19:28 +0000, Valentin Schneider wrote:
> > We did have some breakage in that area, but all the holes I was aware of
> > have been plugged. What would help here is to see which tasks are still
> > queued on that outgoing CPU, and their recent activity.
> > 
> > Something like
> > - ftrace_dump_on_oops on your kernel cmdline
> > - trace-cmd start -e 'sched:*'
> >  <start the test here>
> > 
> > ought to do it. Then you can paste the (tail of the) ftrace dump.
> > 
> > I also had this laying around, which may or may not be of some help:
> 
> Once I have found a reliable reproducer, I'll report back.

any update?

Sebastian
