Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9D1264548
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 13:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbgIJLUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 07:20:00 -0400
Received: from foss.arm.com ([217.140.110.172]:33556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729741AbgIJLPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 07:15:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4F5731B;
        Thu, 10 Sep 2020 04:15:52 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B029E3F68F;
        Thu, 10 Sep 2020 04:15:51 -0700 (PDT)
Date:   Thu, 10 Sep 2020 12:15:49 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, cai@lca.pw,
        mingo@kernel.org, ethp@qq.com, tyhicks@canonical.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: Use scnprintf() in show_smt_*() instead of
 snprintf()
Message-ID: <20200910111547.wkayyfmcf3crvcmh@e107158-lin.cambridge.arm.com>
References: <20200901234930.359126-1-skhan@linuxfoundation.org>
 <20200901234930.359126-2-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200901234930.359126-2-skhan@linuxfoundation.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/20 17:49, Shuah Khan wrote:
> Since snprintf() returns would-be-output size instead of the actual
> output size, replace it with scnprintf(), so the show_smt_control(),
> and show_smt_active() routines return the actual size.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Looks good to me.

Cheers

--
Qais Yousef

> ---
>  kernel/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 6ff2578ecf17..29a5ceb93cda 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2334,7 +2334,7 @@ show_smt_control(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>  	const char *state = smt_states[cpu_smt_control];
>  
> -	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
> +	return scnprintf(buf, PAGE_SIZE - 2, "%s\n", state);
>  }
>  
>  static ssize_t
> @@ -2348,7 +2348,7 @@ static DEVICE_ATTR(control, 0644, show_smt_control, store_smt_control);
>  static ssize_t
>  show_smt_active(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> -	return snprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
> +	return scnprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
>  }
>  static DEVICE_ATTR(active, 0444, show_smt_active, NULL);
>  
> -- 
> 2.25.1
> 
