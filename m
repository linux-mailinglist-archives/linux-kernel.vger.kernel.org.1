Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADA82F5750
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 03:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbhAMVQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 16:16:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728988AbhAMVKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 16:10:33 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3525721D95;
        Wed, 13 Jan 2021 21:10:46 +0000 (UTC)
Date:   Wed, 13 Jan 2021 16:10:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/4] tracing: add error_report trace points
Message-ID: <20210113161044.43bc1c1a@gandalf.local.home>
In-Reply-To: <20210113091657.1456216-2-glider@google.com>
References: <20210113091657.1456216-1-glider@google.com>
        <20210113091657.1456216-2-glider@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 10:16:54 +0100
Alexander Potapenko <glider@google.com> wrote:

> +DECLARE_EVENT_CLASS(error_report_template,
> +		    TP_PROTO(const char *error_detector, unsigned long id),

Instead of having a random string, as this should be used by a small finite
set of subsystems, why not make the above into an enum?

> +		    TP_ARGS(error_detector, id),
> +		    TP_STRUCT__entry(__field(const char *, error_detector)
> +					     __field(unsigned long, id)),
> +		    TP_fast_assign(__entry->error_detector = error_detector;
> +				   __entry->id = id;),
> +		    TP_printk("[%s] %lx", __entry->error_detector,

Then the [%s] portion of this could also be just a __print_symbolic().

-- Steve

> +			      __entry->id));
> +
> +/**
