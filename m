Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEB22B07A8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgKLOjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:39:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLOjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:39:17 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABC2322240;
        Thu, 12 Nov 2020 14:39:16 +0000 (UTC)
Date:   Thu, 12 Nov 2020 09:39:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 12/17] fgraph: Make overruns 4 bytes in graph
 stack structure
Message-ID: <20201112093915.16a42644@gandalf.local.home>
In-Reply-To: <aabe0dd1fd7b46aaaadb2b34912b6718@AcuMS.aculab.com>
References: <20201112003244.764326960@goodmis.org>
        <20201112003334.906341178@goodmis.org>
        <aabe0dd1fd7b46aaaadb2b34912b6718@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 09:18:21 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Steven Rostedt
> > Sent: 12 November 2020 00:33
> > 
> > Inspecting the data structures of the function graph tracer, I found that
> > the overrun value is unsigned long, which is 8 bytes on a 64 bit machine,
> > and not only that, the depth is an int (4 bytes). The overrun can be simply
> > an unsigned int (4 bytes) and pack the ftrace_graph_ret structure better.
> > 
> > The depth is moved up next to the func, as it is used more often with func,
> > and improves cache locality.  
> ...
> >  } __packed;  
> 
> Does this many any/much difference given that the structure is
> marked __packed?
> 
> OTOH the __packed will (probably) kill performance on systems
> that don't support mis-aligned accesses.
> 

I think you answered your own question ;-)

That was why I try to keep 4 byte items together. But the point here was
that overrun is hardly ever used (probably could just be a single byte),
and there was no reason for it to be a long.

-- Steve
