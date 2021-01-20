Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411082FDD9A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388772AbhAUAFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387935AbhATWOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 17:14:23 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7570EC061795
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 14:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=H603GUvTsV5/p6cx5WZjf9Jz/sRtn7FJe9+A2fMe4M4=; b=QTXUCVETYXdtGTTiwFBzy1LNYV
        kZSUcz5bY3bSWDGC59nCN7ExfiSsbKzsSXnUWK268cTII6yizHCI7SFDBnDuXc3GkyofydtN5KXh/
        Uv7VOGOwWlavgz/H5dS/vg/jqHXUvh20BM5w5TLUs23FGxAg5y+iKlTlXVVC4Yb8E7OsM5R8O9YiU
        wZT5VlIt9nXqVPSx7GN1v4JTQzGJX7nS4sXtNt2S4srXyoQl3WzMG2lI4pSlTc2/VCLTI5W32aqUz
        a38R4vZhMxzgYF9kbOJqul973VwFw4SmJn+YQN7k3AtTiMXuDIXR7PPvdHsMipENaZ4vLzkLhsjbd
        nlcNqU4A==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2LhX-0004LV-NU; Wed, 20 Jan 2021 22:11:44 +0000
Subject: Re: [PATCH] fix the issue that the tick_nohz_get_sleep_length()
 function could return a negative value
To:     "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <YTBPR01MB3262E37307F17B3374B64CF6C4A20@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5f43e80a-7f04-65c0-9c24-02c8330d691a@infradead.org>
Date:   Wed, 20 Jan 2021 14:11:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <YTBPR01MB3262E37307F17B3374B64CF6C4A20@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/21 10:58 AM, Zhou Ti (x2019cwm) wrote:
> Fix the issue that the tick_nohz_get_sleep_length() function could return
> a negative value.
> 
> The variable "next_event" has a small possibility to be smaller than the
> variable "now" during running. Since both the menu idle governor and the
> teo idle governor use u64 to store the return value of the function, this
> may result in an extremely large and invalid value.
> 
> One can easily detect the existence of this issue by using printk to
> output a warning.
> 
> Signed-off-by: Ti Zhou <x2019cwm@stfx.ca>
> ---
> --- tip/kernel/time/tick-sched.c.orig   2021-01-20 05:34:25.151325912 -0400
> +++ tip/kernel/time/tick-sched.c        2021-01-20 07:09:15.060980886 -0400
> @@ -1156,6 +1156,9 @@ ktime_t tick_nohz_get_sleep_length(ktime
>         next_event = min_t(u64, next_event,
>                            hrtimer_next_event_without(&ts->sched_timer));
> 
> +       if (unlikely(next_event < now))
> +               next_event = now;
> +
>         return ktime_sub(next_event, now);
>  }
> 

Hi,

You need to send this to some maintainer who can apply/merge it.
Just sending it to a mailing list is not sufficient.

thanks.
-- 
~Randy

