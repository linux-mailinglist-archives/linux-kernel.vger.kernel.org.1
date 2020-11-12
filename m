Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0632B0D9B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgKLTOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:14:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgKLTOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:14:39 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C13DB20B80;
        Thu, 12 Nov 2020 19:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605208477;
        bh=CQVrsFhxionALStdHqSmv142xPjtDpVoDmH7rt3JLrs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z26vT4aMSGqAp0sVbnHuMR0uVxLCBTcSlxFb7/2U0jfyII9e4vT1jV/5prGT1ap7w
         6VIn+2HY2sOE2Y4VNyK4dEqzXYavtN9rgMADFFBGHH05hJnMJHwXNDUPHWgZZxaT8p
         uT54M/AtWDXghvMBtV+mxfqdHeOGt0gh7vq1hc20=
Date:   Thu, 12 Nov 2020 11:14:36 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sudaraja@codeaurora.org, pratikp@codeaurora.org,
        lmark@codeaurora.org
Subject: Re: [PATCH] mm/page_owner: Record timestamp and pid
Message-Id: <20201112111436.c5deeadd3578877fc0b844a1@linux-foundation.org>
In-Reply-To: <20201112184106.733-1-georgi.djakov@linaro.org>
References: <20201112184106.733-1-georgi.djakov@linaro.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 20:41:06 +0200 Georgi Djakov <georgi.djakov@linaro.org> wrote:

> From: Liam Mark <lmark@codeaurora.org>
> 
> Collect the time for each allocation recorded in page owner so that
> allocation "surges" can be measured.
> 
> Record the pid for each allocation recorded in page owner so that
> the source of allocation "surges" can be better identified.

Please provide a description of why this is considered useful.  What
has it been used for, what problems has it been used to solve?

Are there userspace tools which aid in the processing of this new
information?

Can/should Documentation/vm/page_owner.rst be updated?

> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -10,6 +10,7 @@
>  #include <linux/migrate.h>
>  #include <linux/stackdepot.h>
>  #include <linux/seq_file.h>
> +#include <linux/sched/clock.h>
>  
>  #include "internal.h"
>  
> @@ -25,6 +26,8 @@ struct page_owner {
>  	gfp_t gfp_mask;
>  	depot_stack_handle_t handle;
>  	depot_stack_handle_t free_handle;
> +	u64 ts_nsec;
> +	int pid;

pid_t would be nicer?


