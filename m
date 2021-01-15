Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EB72F8077
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 17:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbhAOQSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 11:18:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbhAOQSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:18:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D3CA23772;
        Fri, 15 Jan 2021 16:17:55 +0000 (UTC)
Date:   Fri, 15 Jan 2021 11:17:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 1/4] tracing: add error_report trace points
Message-ID: <20210115111753.5b69579d@gandalf.local.home>
In-Reply-To: <CAG_fn=Uq9SeT4wBsbuEEniy7UmQBvtaLwkgAAR_FqkqD7aoDfw@mail.gmail.com>
References: <20210113091657.1456216-1-glider@google.com>
        <20210113091657.1456216-2-glider@google.com>
        <20210113161044.43bc1c1a@gandalf.local.home>
        <CAG_fn=XSkOChCwBp=Vg6jWhZ8K44seCo=0Zu38iUpAj6eCUxjQ@mail.gmail.com>
        <20210114095232.7ba3f9a8@gandalf.local.home>
        <CAG_fn=Uq9SeT4wBsbuEEniy7UmQBvtaLwkgAAR_FqkqD7aoDfw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 13:53:19 +0100
Alexander Potapenko <glider@google.com> wrote:

> > #define REPORT_TOOL_LIST \
> >   EM(KFENCE, kfence) \
> >   EMe(KASAN, kasan)  
> 
> Thanks, will be done in v2!
> Note that checkpatch doesn't really like this declaration style,
> claiming that "Macros with complex values should be enclosed in
> parentheses".
> (although it is consistent with what's done in other trace event headers)

checkpatch.pl hates most of the tracing macro code ;-)

It's the one place that you can mostly ignore checkpatch reports.

-- Steve
