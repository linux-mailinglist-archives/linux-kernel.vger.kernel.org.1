Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DDA2F6D65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbhANVoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:44:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:50422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbhANVoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:44:16 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AA0923A5B;
        Thu, 14 Jan 2021 21:43:34 +0000 (UTC)
Date:   Thu, 14 Jan 2021 16:43:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     trix@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        karolherbst@gmail.com, ppaalanen@gmail.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        alexandre.chartre@oracle.com, ying-tsun.huang@amd.com,
        mchehab+huawei@kernel.org, paulmck@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: Re: [PATCH v2] x86 : remove definition of DEBUG
Message-ID: <20210114164332.5e7ed5f5@gandalf.local.home>
In-Reply-To: <20210114212827.47584-1-trix@redhat.com>
References: <20210114212827.47584-1-trix@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 13:28:27 -0800
trix@redhat.com wrote:

> diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
> index bd7aff5c51f7..cd768dafca9e 100644
> --- a/arch/x86/mm/mmio-mod.c
> +++ b/arch/x86/mm/mmio-mod.c
> @@ -10,8 +10,6 @@
>  
>  #define pr_fmt(fmt) "mmiotrace: " fmt
>  
> -#define DEBUG 1

Seems to only be used for printing the pr_debug() functions.

> -
>  #include <linux/moduleparam.h>
>  #include <linux/debugfs.h>
>  #include <linux/slab.h>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
