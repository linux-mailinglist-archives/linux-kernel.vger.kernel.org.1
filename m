Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67FB2F637F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbhANOxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 09:53:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:53464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbhANOxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 09:53:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2315A23A5E;
        Thu, 14 Jan 2021 14:52:34 +0000 (UTC)
Date:   Thu, 14 Jan 2021 09:52:32 -0500
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
Message-ID: <20210114095232.7ba3f9a8@gandalf.local.home>
In-Reply-To: <CAG_fn=XSkOChCwBp=Vg6jWhZ8K44seCo=0Zu38iUpAj6eCUxjQ@mail.gmail.com>
References: <20210113091657.1456216-1-glider@google.com>
        <20210113091657.1456216-2-glider@google.com>
        <20210113161044.43bc1c1a@gandalf.local.home>
        <CAG_fn=XSkOChCwBp=Vg6jWhZ8K44seCo=0Zu38iUpAj6eCUxjQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 08:49:57 +0100
Alexander Potapenko <glider@google.com> wrote:

> We'll need to explicitly list the enum values once again in
> __print_symbolic(), right? E.g.:
> 
> enum debugging_tool {
>          TOOL_KFENCE,
>          TOOL_KASAN,
>          ...
> }
> 
> TP_printk(__print_symbolic(__entry->error_detector, TOOL_KFENCE,
> TOOL_KASAN, ...),

Usually what is done is to make this into a macro:

#define REPORT_TOOL_LIST \
  EM(KFENCE, kfence) \
  EMe(KASAN, kasan)

#undef EM
#undef EMe

#define EM(a,b) TRACE_DEFINE_ENUM(a)
#define EMe(a,b) TRACE_DEFINE_ENUM(a)

REPORT_TOOL_LIST

#undef EM
#undef EMe

#define EM(a, b) { a, b },
#define EMe(a, b) { a, b }

#define show_report_tool_list(val) \
	__print_symbolic(val, REPORT_TOOL_LIST)


[..]

 TP_printk("[%s] %lx", show_report_tool_list(__entry->error_detector),
    __entry->id)


This is done in several other trace event files.  For example, see
  include/trace/events/sock.h


-- Steve
