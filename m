Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6F92C3F86
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgKYMFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:05:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:44156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbgKYMFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:05:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 33274AF58;
        Wed, 25 Nov 2020 12:05:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E8AC71E130F; Wed, 25 Nov 2020 13:05:07 +0100 (CET)
Date:   Wed, 25 Nov 2020 13:05:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Hui Su <sh_def@163.com>,
        mingo@redhat.com, jack@suse.cz, akpm@linux-foundation.org,
        neilb@suse.de, trond.myklebust@hammerspace.com,
        liuzhiqiang26@huawei.com, tytso@mit.edu, cai@lca.pw,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: fix potenial dangerous pointer
Message-ID: <20201125120507.GE16944@quack2.suse.cz>
References: <20201124165205.GA23937@rlk>
 <20201124120523.34a59eed@gandalf.local.home>
 <X70+Ll+L2ksoeCMv@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X70+Ll+L2ksoeCMv@mtj.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-11-20 12:09:02, Tejun Heo wrote:
> On Tue, Nov 24, 2020 at 12:05:23PM -0500, Steven Rostedt wrote:
> > On Wed, 25 Nov 2020 00:52:05 +0800
> > Hui Su <sh_def@163.com> wrote:
> > 
> > > The bdi_dev_name() returns a char [64], and
> > > the __entry->name is a char [32].
> > > 
> > > It maybe dangerous to TP_printk("%s", __entry->name)
> > > after the strncpy().
> > 
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > This should go through the tree that has the code that uses these
> > tracepoints.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Andrew, can you please route this one?

I'll queue it to my tree and push it to Linus on Friday since I sometimes
handle writeback stuff myself anyway...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
