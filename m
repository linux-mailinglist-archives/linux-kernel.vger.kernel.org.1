Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B0A213D76
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 18:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGCQS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 12:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgGCQS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 12:18:56 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0379220899;
        Fri,  3 Jul 2020 16:18:54 +0000 (UTC)
Date:   Fri, 3 Jul 2020 12:18:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Subject: Re: [PATCH v2 01/15] tools lib traceevent: Add API to read time
 information from kbuffer
Message-ID: <20200703121853.739ee54d@oasis.local.home>
In-Reply-To: <20200703113107.GD1320@kernel.org>
References: <20200702185344.913492689@goodmis.org>
        <20200702185703.619656282@goodmis.org>
        <20200703113107.GD1320@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jul 2020 08:31:07 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Thu, Jul 02, 2020 at 02:53:45PM -0400, Steven Rostedt escreveu:
> > From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
> > 
> > Add the functions kbuffer_subbuf_timestamp() and kbuffer_ptr_delta() to get
> > the timing data stored in the ring buffer that is used to produced the time
> > stamps of the records.
> > 
> > This is useful for tools like trace-cmd to be able to display the content of
> > the read data to understand why the records show the time stamps that they
> > do.
> > 
> > Link: http://lore.kernel.org/linux-trace-devel/20200625100516.365338-2-tz.stoyanov@gmail.com
> > 
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> > [ Ported from trace-cmd.git ]
> > Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> 
> Humm, is that intentional, i.e. two signed-off-by you?
> 

Yes.

It was originally written by me at Red Hat (thus the "From: Steven
Rostedt (Red Hat)"), and that signed-off-by is from Red Hat Steven.
Then Tzvetomir ported it over to libtraceveent in the kernel tree,
which requires his signed-off-by, and then I pull Tzvetomir's work and
the VMware Steven Rostedt signed it off. ;-)

As Signed-off-by does have some legal meaning for "right to use this
code" I feel it's more than prudent to include both the Red Hat
Steven's signed-off-by as well as the VMware Steven's signed-off-by.

Make sense?

-- Steve
