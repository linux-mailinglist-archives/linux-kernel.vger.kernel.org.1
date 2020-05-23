Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2422D1DFB65
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 00:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbgEWWlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 18:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgEWWlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 18:41:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB1CC061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 15:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rEhQc8nPRj6pNHRuhpyFj/7KloC1gR0WJOhC//z8Bc0=; b=rUCedh7PDozXHVTy5eOirA9f6T
        j4U1za+Zbyqx9Qf8n7bEwCIv8oHvl51T5p1Enuh5an1eQjS2no7awadJsntDFDp/WBct8dCMMXjBe
        xbKl5xGfHMZhx1SI/DRf/wbhIYKeLaYVBeJi0eudEYsHP7d/PlXHQ01mE1IYwzehqGYVfuMZUjQNc
        tu2nYuBsa46uM/cx317dDCUH376kUACsLk1TbArGGo6X3J6TkuNLO2LFU/gReR9d82JKH6GwZgRkW
        TGQ9YCvOuWqKvvr3iAG6PFbCRznGJ2w2JWGmE9C0qivocDuSN4oGgj1dXMTCstfd6cC5qIMlkqRTO
        M29QMzJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jccpj-0001Ok-D4; Sat, 23 May 2020 22:41:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D707B9834A2; Sun, 24 May 2020 00:41:32 +0200 (CEST)
Date:   Sun, 24 May 2020 00:41:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Sebastian A. Siewior" <bigeasy@linutronix.de>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 07/25] lockdep: Add preemption disabled assertion API
Message-ID: <20200523224132.GD2483@worktop.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-8-a.darwish@linutronix.de>
 <20200522175503.GQ325280@hirez.programming.kicks-ass.net>
 <20200523145942.vjk3z6pbj6yicqa4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523145942.vjk3z6pbj6yicqa4@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 04:59:42PM +0200, Sebastian A. Siewior wrote:
> On 2020-05-22 19:55:03 [+0200], Peter Zijlstra wrote:

> > That is both more consistent with the things you claim it's modelled
> > after and also completely avoids that header dependency.
> 
> So we need additionally: 
> 
> - #include <linux/sched.h> in include/linux/flex_proportions.h
>   and I think un another file as well.
> 
> - write_seqcount_t_begin_nested() as a define
> 
> - write_seqcount_t_begin() as a define
> 
> Any "static inline" in the header file using
> lockdep_assert_preemption_disabled() will tro to complain about missing
> current-> define. But yes, it will work otherwise.

Because...? /me rummages around.. Ah you're proposing sticking this in
seqcount itself and then header hell.

Moo.. ok I'll go have another look on Monday.
