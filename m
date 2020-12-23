Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3842E1C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 14:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgLWN3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 08:29:33 -0500
Received: from foss.arm.com ([217.140.110.172]:50120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbgLWN3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 08:29:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97FAE30E;
        Wed, 23 Dec 2020 05:28:47 -0800 (PST)
Received: from e107158-lin (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 626B33F66E;
        Wed, 23 Dec 2020 05:28:46 -0800 (PST)
Date:   Wed, 23 Dec 2020 13:28:43 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     YANG LI <abaci-bugfix@linux.alibaba.com>
Cc:     tglx@linutronix.de, peterz@infradead.org, mpe@ellerman.id.au,
        bristot@redhat.com, ethp@qq.co, npiggin@gmail.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/cpu: fix: use scnprintf or sprintf.
Message-ID: <20201223132843.5xqiwm6che3nbndd@e107158-lin>
References: <1608628299-124339-1-git-send-email-abaci-bugfix@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1608628299-124339-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang

'or sprintf' in the subject line doesn't make much sense for what's done in
this patch. Perhaps you meant "Use scnprintf instead of snprintf"?

On 12/22/20 17:11, YANG LI wrote:
> The snprintf() function returns the number of characters which would
> have been printed if there were enough space, but the scnprintf()
> returns the number of characters which were actually printed. If the
> buffer is not large enough, then using snprintf() would result in a
> read overflow and an information leak.
> 
> Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>
> Reported-by: Abaci <abaci@linux.alibaba.com>

Two different yet very similar email addresses, it seems both are you? The
Reported-by is unnecessary.

> ---
>  kernel/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 4e11e91..c123741 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2345,7 +2345,7 @@ static ssize_t show_cpuhp_states(struct device *dev,
>  {
>  	const char *state = smt_states[cpu_smt_control];
>  
> -	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
> +	return scnprintf(buf, PAGE_SIZE - 2, "%s\n", state);

show_cpuhp_states() doesn't have snprintf() in Linus' master. Which tree is
this based on?

I can see two snprintf() in cpu.c, show_smt_active/control().

Mind resend to fix them both?

Thanks

--
Qais Yousef
