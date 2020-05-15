Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE71D1D4E83
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 15:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgEONL3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 May 2020 09:11:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgEONL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:11:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7E4220657;
        Fri, 15 May 2020 13:11:27 +0000 (UTC)
Date:   Fri, 15 May 2020 09:11:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Li Xinhai" <lixinhai.lxh@gmail.com>
Cc:     linux-trace-devel <linux-trace-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Theodore Ts'o <tytso@mit.edu>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: Documentation/trace/events.rst: wrong numbering of sections
Message-ID: <20200515091126.75db6ec9@gandalf.local.home>
In-Reply-To: <2020051515434115672512@gmail.com>
References: <2020051515434115672512@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


It's best to Cc the maintainers of the file. Nobody reads linux-kernel (it
produces 800 emails a day!). Luckily, I happen to monitor the
linux-trace-devel list (which is mostly for userland tools), otherwise this
email would have been lost to the LKML abyss.

On Fri, 15 May 2020 15:43:43 +0800
"Li Xinhai" <lixinhai.lxh@gmail.com> wrote:

> This document has below numbering of its sections:
> 
> 1. Introduction
> 2. Using Event Tracing
> 2.1 Via the 'set_event' interface
> 2.2 Via the 'enable' toggle
> 2.3 Boot option
> 3. Defining an event-enabled tracepoint
> 4. Event formats
> 5. Event filtering
> 5.1 Expression syntax
> 5.2 Setting filters
> 5.3 Clearing filters
> 5.3 Subsystem filters
> 5.4 PID filtering
> 6. Event triggers
> 6.1 Expression syntax
> 6.2 Supported trigger commands
> 6.3 In-kernel trace event API
> 6.3.1 Dyamically creating synthetic event definitions
> 6.3.3 Tracing synthetic events from in-kernel code
> 6.3.3.1 Tracing a synthetic event all at once
> 6.3.3.1 Tracing a synthetic event piecewise
> 6.3.4 Dyamically creating kprobe and kretprobe event definitions
> 6.3.4 The "dynevent_cmd" low-level API
> 
> It seems wrong numbering within 6.3 section. 
> or, would it be better to have separated chapter #7, for 'In-kernel trace
> event API'? it seems not belong to 'Event triggers'.

Yeah, 6.3.4 (both of them) probably should have been under a new top level
section. (#7).

-- Steve
