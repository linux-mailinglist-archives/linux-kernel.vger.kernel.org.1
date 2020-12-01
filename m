Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565DD2CAE78
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgLAVbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:31:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgLAVbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:31:49 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63B58208C3;
        Tue,  1 Dec 2020 21:31:06 +0000 (UTC)
Date:   Tue, 1 Dec 2020 16:31:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michel Lespinasse <walken@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
        dsahern@kernel.org, gregkh@linuxfoundation.org, kuba@kernel.org,
        liuhangbin@gmail.com, tj@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: mmap_lock: fix use-after-free race and css ref
 leak in tracepoints
Message-ID: <20201201163104.5d178986@gandalf.local.home>
In-Reply-To: <20201201162847.654f3013@gandalf.local.home>
References: <20201201203249.4172751-1-axelrasmussen@google.com>
        <20201201162847.654f3013@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Dec 2020 16:28:47 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  1 Dec 2020 12:32:49 -0800
> Axel Rasmussen <axelrasmussen@google.com> wrote:
> 
> > +/* Called with reg_lock held. */  
> 
> The above comment is reduntant, as the lockdep_is_held() below also suggest
> that it is ;-)
>


> 
> >  static inline char *get_memcg_path_buf(void)
> >  {
> > +	char *buf;
> >  	int idx;
> >  
> > +	rcu_read_lock();  
> 
> The caller of get_mm_memcg_path() has preemption disabled, which is also
> now an RCU lock. So the rcu_read_lock() is somewhat redundant.


BTW, both of these comments are FYI. You can keep the comment and keep the
rcu_read_lock(). I was just stating that they are redundant, but keeping
them may make the code a bit more robust.

-- Steve
