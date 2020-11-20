Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80262BB434
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbgKTSmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:42:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:60002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731491AbgKTSmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:42:44 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEFDE21D91;
        Fri, 20 Nov 2020 18:42:43 +0000 (UTC)
Date:   Fri, 20 Nov 2020 13:42:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Printk specifiers for __user pointers
Message-ID: <20201120134242.6cae9e72@gandalf.local.home>
In-Reply-To: <20201120164412.GD619708@rowland.harvard.edu>
References: <20201120164412.GD619708@rowland.harvard.edu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 11:44:12 -0500
Alan Stern <stern@rowland.harvard.edu> wrote:

> To the VSPRINTF maintainers:
> 
> Documentation/core-api/printk-formats.rst lists a large number of format 
> specifiers for pointers of various sorts.  Yet as far as I can see, 
> there is no specifier meant for use with __user pointers.
> 
> The security implications of printing the true, unmangled value of a 
> __user pointer are minimal, since doing so does not leak any kernel 
> information.  So %px would work, but tools like checkpatch.pl don't like 
> it.
> 
> Should a new specifier be added?  If not, should we simply use %px?

There's currently no user of '%pu' (although there is a '%pus'. Perhaps we
should have a '%pux'?

I would even state that if it is used, that if makes sure that the value is
indeed a user space pointer (goes through the same checks as accessing user
space), before its printed, otherwise it shows "(fault)" or something.

-- Steve

