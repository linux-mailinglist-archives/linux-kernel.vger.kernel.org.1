Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6172E1C9B52
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 21:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgEGTpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 15:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbgEGTpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:45:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 944F8208E4;
        Thu,  7 May 2020 19:45:13 +0000 (UTC)
Date:   Thu, 7 May 2020 15:45:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Jason Yan <yanaijie@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Return true,false in
 voluntary_active_balance()
Message-ID: <20200507154512.1065cba8@gandalf.local.home>
In-Reply-To: <96fe70f11245433ce4f19bffaf2d167dbf69a2a0.camel@perches.com>
References: <20200507110625.37254-1-yanaijie@huawei.com>
        <jhjpnbg6lkf.mognet@arm.com>
        <20200507132828.1af39b80@gandalf.local.home>
        <20200507133024.18dbe349@gandalf.local.home>
        <f0e6f50e910238366b1d8f398c91d3066baac7cf.camel@perches.com>
        <20200507144534.09abd685@gandalf.local.home>
        <96fe70f11245433ce4f19bffaf2d167dbf69a2a0.camel@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 May 2020 12:06:56 -0700
Joe Perches <joe@perches.com> wrote:

> People describe changes as a "fix" all the time for stuff
> that isn't an actual fix for a logic defect but is instead
> an update to a particular style preference.
> 
> Then the "fix" word causes the patch to be rather uselessly
> applied to stable trees by AUTOSEL.
> 
> It's especially bad when the 'Fixes: <sha1> ("description")'
> tag is also added.
> 
> It's a difficult thing to regulate and I don't believe a
> good mechanism would be possible to add to checkpatch or
> coccinelle to help isolate these things.
> 
> git diff -w sometimes helps, but that's not really a thing
> that checkpatch could do.
> 
> Any suggestions?

I'm unfamiliar with how the coccinelle script is used, but I thought there
was some discussion some time back to have checkpatch not produces the same
kinds of warnings to code as it does to patches.

A lot of useless updates were being submitted when people were running
checkpatch on existing kernel code and producing warnings that are not
worth "fixing", but something that new code should try to avoid.

Basically, I'm fine with a warning that tells you that 1/0 is used for
boolean on code being submitted, but we really shouldn't be encouraging
people to change the code that currently exists with such updates.

-- Steve
