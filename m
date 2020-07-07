Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F4321735F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 18:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgGGQKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 12:10:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbgGGQKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:10:43 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C323520674;
        Tue,  7 Jul 2020 16:10:42 +0000 (UTC)
Date:   Tue, 7 Jul 2020 12:10:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/15] perf ftrace: factor out function
 write_tracing_file_int()
Message-ID: <20200707121041.15811cca@oasis.local.home>
In-Reply-To: <20200707120923.26f7e349@oasis.local.home>
References: <20200627133654.64863-1-changbin.du@gmail.com>
        <20200627133654.64863-6-changbin.du@gmail.com>
        <20200707120923.26f7e349@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 12:09:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 27 Jun 2020 21:36:44 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > We will reuse this function later.
> >   
> 
> BTW, trace-cmd.git now has a libtracefs.so library, which I'm hoping
> within a month to have as a stand alone (probably along with
> libtraceevent and even a libtracecmd).
> 
>   https://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git/tree/lib/tracefs

And the API is defined in this header:

 https://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git/tree/include/tracefs/tracefs.h

-- Steve

> 
> This is a library made to interact with the tracefs directory to remove
> reimplementing it all over the place.
