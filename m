Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD582CC94B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 23:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgLBWBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 17:01:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbgLBWBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606946416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xUGe+rDHdo1Ey22JIXtc3/BYf9lsKUsUkDP2aASmHF4=;
        b=gxMj7MB0MCOOQjRy+MH2lL97GpQlAyn+tdpeMOY8LvFsz2Qz2hLWgUM6FpMJosBPiUwpjn
        267DfB3HoNFk/vFN4ckA/NSvinf5gR7OMWFq39ipPMB4LiQPFA2EgbypJtXi6W5XVGT9LC
        u6ZEXyAyLPtJXb4JMzFwimtlH+/FJY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-dhN_EC5PM8C2n4Yjfs1Cnw-1; Wed, 02 Dec 2020 17:00:14 -0500
X-MC-Unique: dhN_EC5PM8C2n4Yjfs1Cnw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBB71100F341;
        Wed,  2 Dec 2020 22:00:11 +0000 (UTC)
Received: from ovpn-66-132.rdu2.redhat.com (unknown [10.10.67.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3899A60BFA;
        Wed,  2 Dec 2020 21:59:56 +0000 (UTC)
Message-ID: <f82cfe32b6f7c43c83da1552776de8aed6947840.camel@redhat.com>
Subject: Re: [PATCH v4 11/19] sched/core: Make migrate disable and CPU
 hotplug cooperative
From:   Qian Cai <qcai@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Date:   Wed, 02 Dec 2020 16:59:56 -0500
In-Reply-To: <20201123181313.ug4fwjcqnmbvo3f2@linutronix.de>
References: <20201023101158.088940906@infradead.org>
         <20201023102347.067278757@infradead.org>
         <ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com>
         <jhjpn4bwznx.mognet@arm.com>
         <dda3b8f67a23dd60d36e5325dbb0c406be18e1db.camel@redhat.com>
         <20201123181313.ug4fwjcqnmbvo3f2@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-23 at 19:13 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-11-18 09:44:34 [-0500], Qian Cai wrote:
> > On Tue, 2020-11-17 at 19:28 +0000, Valentin Schneider wrote:
> > > We did have some breakage in that area, but all the holes I was aware of
> > > have been plugged. What would help here is to see which tasks are still
> > > queued on that outgoing CPU, and their recent activity.
> > > 
> > > Something like
> > > - ftrace_dump_on_oops on your kernel cmdline
> > > - trace-cmd start -e 'sched:*'
> > >  <start the test here>
> > > 
> > > ought to do it. Then you can paste the (tail of the) ftrace dump.
> > > 
> > > I also had this laying around, which may or may not be of some help:
> > 
> > Once I have found a reliable reproducer, I'll report back.
> 
> any update?

Just back from a vacation. I have been running the same workload on today's
linux-next for a few hours and it has been good so far. I'll surely report back
if it happens again in our daily runs.

