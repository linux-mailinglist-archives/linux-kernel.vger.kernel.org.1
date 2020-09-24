Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF0027747D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgIXO6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:58:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgIXO62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:58:28 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FDEF2396D;
        Thu, 24 Sep 2020 14:58:26 +0000 (UTC)
Date:   Thu, 24 Sep 2020 10:58:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     peterz@infradead.org
Cc:     Prasad Sodagudi <psodagud@codeaurora.org>, tglx@linutronix.de,
        qais.yousef@arm.com, mingo@kernel.org, cai@lca.pw,
        tyhicks@canonical.com, arnd@arndb.de, rameezmustafa@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] measure latency of cpu hotplug path
Message-ID: <20200924105823.0e11f2e4@oasis.local.home>
In-Reply-To: <20200924083414.GB1362448@hirez.programming.kicks-ass.net>
References: <1600904266-102397-1-git-send-email-psodagud@codeaurora.org>
        <20200924083414.GB1362448@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 10:34:14 +0200
peterz@infradead.org wrote:

> On Wed, Sep 23, 2020 at 04:37:44PM -0700, Prasad Sodagudi wrote:
> > There are all changes related to cpu hotplug path and would like to seek
> > upstream review. These are all patches in Qualcomm downstream kernel
> > for a quite long time. First patch sets the rt prioity to hotplug
> > task and second patch adds cpuhp trace events.
> > 
> > 1) cpu-hotplug: Always use real time scheduling when hotplugging a CPU
> > 2) cpu/hotplug: Add cpuhp_latency trace event  
> 
> Why? Hotplug is a known super slow path. If you care about hotplug
> latency you're doing it wrong.

I'd like to know the answer to Peter's question too. Why?

-- Steve
