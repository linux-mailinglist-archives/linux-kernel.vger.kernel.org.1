Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2D41F429F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 19:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbgFIRnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 13:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728472AbgFIRnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:43:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1683F2074B;
        Tue,  9 Jun 2020 17:43:16 +0000 (UTC)
Date:   Tue, 9 Jun 2020 13:43:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Guo Ren <guoren@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Security Officers <security@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] uprobes: ensure that uprobe->offset and
 ->ref_ctr_offset are properly aligned
Message-ID: <20200609134314.1e07d494@gandalf.local.home>
In-Reply-To: <CAHk-=wgOkWaEwCNunc4_WXF_SLJZSeNEnstvHha9n82iLYpyCA@mail.gmail.com>
References: <CAHk-=whQt69ApMkZF8b2Q2idMDgPpPETZeeOuZg59CrOO4025w@mail.gmail.com>
        <20200428091149.GB19958@linux.vnet.ibm.com>
        <20200428123914.GA27920@redhat.com>
        <20200504164724.GA28697@redhat.com>
        <20200609153020.GB17951@redhat.com>
        <CAHk-=wgOkWaEwCNunc4_WXF_SLJZSeNEnstvHha9n82iLYpyCA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jun 2020 09:48:45 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Jun 9, 2020 at 8:30 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Looks like this patch was forgotten...
> >
> > Should I resend it?  
> 
> I guess I'll just take it directly, since it was triggered by me
> complaining anyway.
> 
> I had hoped it would go through the usual channels.

Perhaps there was confusion about which tree it was suppose to go
through :-/

-- Steve

