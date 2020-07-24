Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB19822CC92
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 19:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGXRsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 13:48:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgGXRsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:48:14 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C428206F6;
        Fri, 24 Jul 2020 17:48:13 +0000 (UTC)
Date:   Fri, 24 Jul 2020 13:48:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 2/2] kernel/trace: Remove function callback casts
Message-ID: <20200724134811.01704cbf@oasis.local.home>
In-Reply-To: <20200724134020.3160dc7c@oasis.local.home>
References: <20200719155033.24201-1-oscar.carter@gmx.com>
        <20200719155033.24201-3-oscar.carter@gmx.com>
        <20200721140545.445f0258@oasis.local.home>
        <20200724161921.GA3123@ubuntu>
        <20200724123528.36ea9c9e@oasis.local.home>
        <20200724171418.GB3123@ubuntu>
        <20200724133656.76c75629@oasis.local.home>
        <20200724134020.3160dc7c@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 13:40:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 24 Jul 2020 13:36:56 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Which BTW, is supported by the following architectures:


> >   x86  

Ah, you can lose support on x86 if you don't enable DYNAMIC_FTRACE,
which is stupid to do. I only enabled disabling of DYNAMIC_FTRACE on
x86 to test it, as not all architectures have it, and I currently only
test on x86.

Without DYNAMIC_FTRACE enabled, you *always* call into the ftrace
infrastructure for *every* function. This adds something like 15 to 20%
overhead to the kernel. Did I say it was stupid to do so?

If you are going through all this work because some randconfig causes
this warning because it enables CONFIG_FUNCTION_TRACER but without
DYNAMIC_FTRACE enabled, then I strongly suggest you start spending your
time elsewhere, because it will be a big NAK on my part to add all this
intrusive code for a config used only for debugging the non
DYNAMIC_FTRACE case.

-- Steve
