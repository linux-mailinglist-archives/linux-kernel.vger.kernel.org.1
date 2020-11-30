Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2EB2C8950
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgK3QVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:21:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728777AbgK3QVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:21:07 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 699C72073C;
        Mon, 30 Nov 2020 16:20:26 +0000 (UTC)
Date:   Mon, 30 Nov 2020 11:20:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 2/3] clear_warn_once: bind a timer to written reset
 value
Message-ID: <20201130112024.34bcbbd1@gandalf.local.home>
In-Reply-To: <20201126063029.2030-3-paul.gortmaker@windriver.com>
References: <20201126063029.2030-1-paul.gortmaker@windriver.com>
        <20201126063029.2030-3-paul.gortmaker@windriver.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 01:30:28 -0500
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> +++ b/Documentation/admin-guide/clearing-warn-once.rst
> @@ -7,3 +7,12 @@ echo 1 > /sys/kernel/debug/clear_warn_once
>  
>  clears the state and allows the warnings to print once again.
>  This can be useful after test suite runs to reproduce problems.
> +
> +Values greater than one set a timer for a periodic state reset; e.g.
> +
> +echo 3600 > /sys/kernel/debug/clear_warn_once

I wonder if the value should be in minutes and not seconds, otherwise, a
wrong value could possibly DoS the machine, if you were to write 2 into it.
If there were a lot of warnings in high frequency events.

Or is dumping out a bunch of warnings every 2 seconds not be a problem?

Anyway, would there ever be a need to have it cleared in less than 1 minute
intervals?

-- Steve


> +
> +will establish an hourly state reset, effectively turning WARN_ONCE
> +into a long period rate-limited warning.
