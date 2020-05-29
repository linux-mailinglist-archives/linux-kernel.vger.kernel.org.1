Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E011E830E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 18:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgE2QF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 12:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbgE2QFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:05:25 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C53A3206E2;
        Fri, 29 May 2020 16:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590768325;
        bh=OzpXQ1Q9RmujDk+GUGhIG8wnjN6WaWbUYLF9IQSTyqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwMIOjduxEHLGhiy5Yud6xeZRzr83ObkfEvR5K1l8+rhJ1IDbfIw41gnyCNCbqcc3
         X46vv4h192fkTu6jr6yI+hRs24FyS/N0mfczEOU1bi6CKACQciZOFOGOp4eQy+7R6L
         MMmqq4WwwSMimRudqGBul6TCYRiT0BcEg2XLrAeA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C3A8840AFD; Fri, 29 May 2020 13:05:22 -0300 (-03)
Date:   Fri, 29 May 2020 13:05:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ed Maste <emaste@freefall.freebsd.org>
Cc:     linux-kernel@vger.kernel.org, Ed Maste <emaste@freebsd.org>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RESEND PATCH v2] perf tools: correct license on jsmn json parser
Message-ID: <20200529160522.GC537@kernel.org>
References: <20191213154625.41064-1-emaste@FreeBSD.org>
 <20200528170858.48457-1-emaste@freefall.freebsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528170858.48457-1-emaste@freefall.freebsd.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 28, 2020 at 05:08:59PM +0000, Ed Maste escreveu:
> From: Ed Maste <emaste@freebsd.org>
> 
> This header is part of the jsmn json parser, introduced in 867a979a83.
> Correct the SPDX tag to indicate that it is under the MIT license.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Ed Maste <emaste@freebsd.org>
> Acked-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/pmu-events/jsmn.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/jsmn.h b/tools/perf/pmu-events/jsmn.h
> index c7b0f6ea2a31..1bdfd55fff30 100644
> --- a/tools/perf/pmu-events/jsmn.h
> +++ b/tools/perf/pmu-events/jsmn.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: MIT */
>  #ifndef __JSMN_H_
>  #define __JSMN_H_
>  
> -- 
> 2.24.0
> 

-- 

- Arnaldo
