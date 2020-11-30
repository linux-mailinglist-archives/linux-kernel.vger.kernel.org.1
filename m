Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F5E2C8963
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgK3QZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:25:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgK3QZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:25:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AD8D206E3;
        Mon, 30 Nov 2020 16:24:50 +0000 (UTC)
Date:   Mon, 30 Nov 2020 11:24:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 0/3] clear_warn_once: add timed interval resetting
Message-ID: <20201130112448.5a356ff3@gandalf.local.home>
In-Reply-To: <X8ElwBh9tw+OLHF+@alley>
References: <20201126063029.2030-1-paul.gortmaker@windriver.com>
        <X8ElwBh9tw+OLHF+@alley>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Nov 2020 17:13:52 +0100
Petr Mladek <pmladek@suse.com> wrote:

> I do not know. Maybe I am just too paranoid today. Anyway, there
> are other possibilities:

This is another reason I think the resolution should be in minutes and not
seconds. It would be less of an issue if it could dump all warnings only
once a minute than once every two seconds.

> 
> + Move clear_warn_once from debugfs to a location that is always
>   available. For example, into /proc

I was thinking of /proc/sys/ as well.

-- Steve
