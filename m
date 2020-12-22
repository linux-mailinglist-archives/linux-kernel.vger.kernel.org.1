Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D352E1014
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 23:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgLVWWX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Dec 2020 17:22:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgLVWWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 17:22:23 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97E2C230FC;
        Tue, 22 Dec 2020 22:21:41 +0000 (UTC)
Date:   Tue, 22 Dec 2020 17:21:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 5/9] platform/surface: aggregator: Add error
 injection capabilities
Message-ID: <20201222172140.38afad6c@gandalf.local.home>
In-Reply-To: <20201221183959.1186143-6-luzmaximilian@gmail.com>
References: <20201221183959.1186143-1-luzmaximilian@gmail.com>
        <20201221183959.1186143-6-luzmaximilian@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Dec 2020 19:39:55 +0100
Maximilian Luz <luzmaximilian@gmail.com> wrote:

> This commit adds error injection hooks to the Surface Serial Hub
> communication protocol implementation, to:
> 
>  - simulate simple serial transmission errors,
> 
>  - drop packets, requests, and responses, simulating communication
>    failures and potentially trigger retransmission timeouts, as well as
> 
>  - inject invalid data into submitted and received packets.
> 
> Together with the trace points introduced in the previous commit, these
> facilities are intended to aid in testing, validation, and debugging of
> the Surface Aggregator communication layer.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
> 
> Changes in v1 (from RFC):
>  - remove unnecessary default in Kconfig entry
> 
> Changes in v2:
>  - use dedicated trace event class for data error injection
>  - spell check comments and strings, fix typos
>  - unify comment style
>  - run checkpatch --strict, fix warnings and style issues
> 

From a tracing point of view:

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  drivers/platform/surface/aggregator/Kconfig   |  14 +
>  .../surface/aggregator/ssh_packet_layer.c     | 296 +++++++++++++++++-
>  .../surface/aggregator/ssh_request_layer.c    |  35 +++
>  drivers/platform/surface/aggregator/trace.h   |  31 ++
>  4 files changed, 375 insertions(+), 1 deletion(-)
> 
