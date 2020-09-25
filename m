Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9302793D9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgIYV7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:59:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgIYV7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:59:36 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47F462068D;
        Fri, 25 Sep 2020 21:59:35 +0000 (UTC)
Date:   Fri, 25 Sep 2020 17:59:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Linux MM <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 1/3 v2] tracepoints: Add helper to test if tracepoint is
 enabled in a header
Message-ID: <20200925175933.2b7fa5f5@oasis.local.home>
In-Reply-To: <CAJHvVcjO=c7=k2-9=iQMh8t56FL-9duFX-FU0yu-HEX+1Da8YA@mail.gmail.com>
References: <20200925211206.423598568@goodmis.org>
        <20200925211819.767526657@goodmis.org>
        <CAJHvVcjO=c7=k2-9=iQMh8t56FL-9duFX-FU0yu-HEX+1Da8YA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020 14:36:37 -0700
Axel Rasmussen <axelrasmussen@google.com> wrote:

> > +In a C file::
> > +
> > +       void do_trace_foo_bar_wrapper(args)
> > +       {
> > +               trace_foo_bar(args);
> > +       }
> > +
> > +In the header file::
> > +
> > +       DECLEARE_TRACEPOINT(foo_bar);  
> 
> Should be "DECLARE_..."

But that's the British spelling!

OK, I'll go ahead and fix that in v3.

-- Steve
