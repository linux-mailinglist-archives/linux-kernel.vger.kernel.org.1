Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C592F24C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405147AbhALAZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404222AbhALADS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:03:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4911C22CA2;
        Tue, 12 Jan 2021 00:02:37 +0000 (UTC)
Date:   Mon, 11 Jan 2021 19:02:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Liu Peibao <liupeibao@163.com>
Cc:     mhiramat@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] init/main.c: fix strings split across lines
Message-ID: <20210111190235.3e81770f@gandalf.local.home>
In-Reply-To: <20201230060424.29097-2-liupeibao@163.com>
References: <20201230060424.29097-1-liupeibao@163.com>
        <20201230060424.29097-2-liupeibao@163.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Dec 2020 14:04:23 +0800
Liu Peibao <liupeibao@163.com> wrote:

> Fix warning found by checkpatch.pl.
> 
> Signed-off-by: Liu Peibao <liupeibao@163.com>
> ---
>  init/main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 6feee7f11eaf..1e492de770c8 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1470,8 +1470,7 @@ static int __ref kernel_init(void *unused)
>  	    !try_to_run_init_process("/bin/sh"))
>  		return 0;
>  
> -	panic("No working init found.  Try passing init= option to kernel. "
> -	      "See Linux Documentation/admin-guide/init.rst for guidance.");
> +	panic("No working init found. Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.");

Sorry, we don't add changes to the kernel that checkpatch warns about.
checkpatch should only be run on new code. Please do not submit any patches
on existing code because checkpatch warns about it.

-- Steve


>  }
>  
>  /* Open /dev/console, for stdin/stdout/stderr, this should never fail */

