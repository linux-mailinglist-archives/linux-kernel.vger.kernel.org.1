Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E2A1BD08B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 01:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgD1XUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 19:20:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38723 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725853AbgD1XUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 19:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588116041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awX/WDzY4v/mrZcN7vzH0b6aC46+DakYZAFmWm381lc=;
        b=VxOM/1Z0VXK3kLd30XNn6dEIWGc78lqIjVsU2iLW9+pjmCxbRcxfK/6IMNQCNuGpynQ4S8
        hvY3din3xA5aBWc+grWJTgqj8frleQ2p3P8dYa5J6hvtSXrj50gnUC3M82M/DlpLG4Gpsw
        W1yOHJO9wpyEg+UZw63nmQhAuG4zjqo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-tV07bsIDNPug05Cx3avFfg-1; Tue, 28 Apr 2020 19:20:36 -0400
X-MC-Unique: tV07bsIDNPug05Cx3avFfg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81E68800C78;
        Tue, 28 Apr 2020 23:20:34 +0000 (UTC)
Received: from ovpn-112-24.phx2.redhat.com (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D634C5D710;
        Tue, 28 Apr 2020 23:20:32 +0000 (UTC)
Message-ID: <89043649a64fc97dd90eb25c85bcc8f65483cf4f.camel@redhat.com>
Subject: Re: [RFC PATCH 1/3] sched/fair: Call newidle_balance() from
 finish_task_switch()
From:   Scott Wood <swood@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Date:   Tue, 28 Apr 2020 18:20:32 -0500
In-Reply-To: <20200428230204.GE16027@hirez.programming.kicks-ass.net>
References: <20200428050242.17717-1-swood@redhat.com>
         <20200428050242.17717-2-swood@redhat.com> <jhjftcns35d.mognet@arm.com>
         <20200428220917.GB16027@hirez.programming.kicks-ass.net>
         <c4a8d1f044b721a2c396fa00a0244eff0b851ae4.camel@redhat.com>
         <20200428230204.GE16027@hirez.programming.kicks-ass.net>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-29 at 01:02 +0200, Peter Zijlstra wrote:
> On Tue, Apr 28, 2020 at 05:55:03PM -0500, Scott Wood wrote:
> > On Wed, 2020-04-29 at 00:09 +0200, Peter Zijlstra wrote:
> > > Also, if you move it this late, this is entirely the wrong place. If
> > > you
> > > do it after the context switch either use the balance_callback or put
> > > it
> > > in the idle path.
> > > 
> > > But what Valentin said; this needs a fair bit of support, the whole
> > > reason we've never done this is to avoid that double context switch...
> > > 
> > 
> > balance_callback() enters with the rq lock held but BH not separately
> 
> BH? softirqs you mean? Pray tell more.

In https://lore.kernel.org/lkml/5122CD9C.9070702@oracle.com/ the need to
keep softirqs disabled during rebalance was brought up, but simply wrapping
the lock dropping in local_bh_enable()/local_bh_disable() meant that
local_bh_enable() would be called with interrupts disabled, which isn't
allowed.

> > disabled, which interferes with the ability to enable interrupts but not
> > BH.
> > It also gets called from rt_mutex_setprio() and __sched_setscheduler(),
> > and
> > I didn't want the caller of those to be stuck with the latency.
> 
> You're not reading it right.

Could you elaborate?

-Scott


