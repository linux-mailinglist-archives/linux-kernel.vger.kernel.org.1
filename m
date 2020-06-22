Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038F6203869
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 15:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgFVNrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 09:47:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728449AbgFVNrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 09:47:06 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA66A20732;
        Mon, 22 Jun 2020 13:47:05 +0000 (UTC)
Date:   Mon, 22 Jun 2020 09:47:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Enderborg <peter.enderborg@sony.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/2] tracefs: Remove unnecessary debug_fs checks.
Message-ID: <20200622094704.589220a9@oasis.local.home>
In-Reply-To: <20200622083019.15479-2-peter.enderborg@sony.com>
References: <20200617133738.6631-1-peter.enderborg@sony.com>
        <20200622083019.15479-1-peter.enderborg@sony.com>
        <20200622083019.15479-2-peter.enderborg@sony.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020 10:30:18 +0200
Peter Enderborg <peter.enderborg@sony.com> wrote:

> This is a preparation for debugfs restricted mode.
> We don't need debugfs to trace, the removed check stop tracefs to work
> if debugfs is not initialised. We instead tries to automount within
> debugfs and relay on it's handling. The code path is to create a
> backward compatibility from when tracefs was part of debugfs, it is now
> standalone and does not need debugfs. When debugfs is in restricted
> it is compiled in but not active and return EPERM to clients and
> tracefs wont work if it assumes it is active it is compiled in
> kernel.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/trace/trace.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index ec44b0e2a19c..34ed82364edb 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8946,9 +8946,7 @@ struct dentry *tracing_init_dentry(void)
>  	if (tr->dir)
>  		return NULL;
>  
> -	if (WARN_ON(!tracefs_initialized()) ||
> -		(IS_ENABLED(CONFIG_DEBUG_FS) &&
> -		 WARN_ON(!debugfs_initialized())))
> +	if (WARN_ON(!tracefs_initialized()))
>  		return ERR_PTR(-ENODEV);
>  
>  	/*

