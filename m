Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323811C97CE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 19:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgEGRa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 13:30:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgEGRa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:30:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D510E20663;
        Thu,  7 May 2020 17:30:25 +0000 (UTC)
Date:   Thu, 7 May 2020 13:30:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Jason Yan <yanaijie@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Return true,false in
 voluntary_active_balance()
Message-ID: <20200507133024.18dbe349@gandalf.local.home>
In-Reply-To: <20200507132828.1af39b80@gandalf.local.home>
References: <20200507110625.37254-1-yanaijie@huawei.com>
        <jhjpnbg6lkf.mognet@arm.com>
        <20200507132828.1af39b80@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 13:28:28 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > It's perfectly safe to return 0/1 in a boolean function; that said seeing
> > as this is the second attempt at "fixing" this I'm tempted to say we should
> > pick it up...
> >   
> 
> Actually, I disagree. We should push back on the check to not warn on 0/1
> of boolean. Why is this a warning?

If anything, we can teach people to try to understand their fixes, to see
if something is really a fix or not. Blindly accepting changes like this,
is no different than blindly submitting patches because some tool says its
an issue.

-- Steve
