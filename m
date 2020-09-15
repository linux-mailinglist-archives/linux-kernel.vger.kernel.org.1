Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDE626A059
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 10:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgIOIDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 04:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgIOIB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:01:58 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBAFC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 01:01:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so2173069wrn.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 01:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rxqNxz7IqogthDXcJNKzpaq9bKYlVI8bycyXjieSEKw=;
        b=IpsAVyTWybgeSvH6UjnWZvVJQNnxZOmYKe2KyhT7chmp8q7L3M/Aw9vuoYL2ZR3D1e
         TiusXKQvj3ZShVxdDMIDLTX5rTWUauyAMG8b+eD0BiOCMqcdYb00orp+R5RpEj8sQmlX
         +MUVWYJh2CCuMkrYimPDWWptsOjqEXcyR8Kfa0pwjtoJ0Q9Sn5wv9W3KTKuOZpt5RBid
         opx26zwPKUTkCHut3evre7k2D6VQ/AdEJXteXPXLX0IH6Ligd1lh+j2TT0QnjyoGm8mh
         FNG8eIL8TXZacaOMxkIe/E1aWQ1oputTNmwWbluTOPJX6W5ylyzkjSjnmRsYGqlguacw
         y8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rxqNxz7IqogthDXcJNKzpaq9bKYlVI8bycyXjieSEKw=;
        b=R7f5uOdzLxx/f6k5qPv8mImfdBvwZSXQk2QgyCTccZHqQ35E9Ev7wN6so/+sFGuRlK
         AD0mP0EAlnP+xJUjriFilsQZEWGoxJQ3/CjjVSLTQOg3XBEYm2Yv8YOfCL6e23+HGum+
         GxLhTQaESTAeVnus9AXh4Nqz4MqimWcoXgUypydQrfZQHz95ISATQxH9qDRUgTbFvbOe
         fcvAoScaLAk98x451R8EJ2QrnOACYXG1muWmUhqYBuG2eHjQwcf2umSWNlFW0RM+dF8v
         QpmE04wBeaUCVyegaWoqW9AM8b9U15BLLmJUWmmo4ixSGv0erN6pnKflfEwI/IqDiwM+
         KNrg==
X-Gm-Message-State: AOAM530Ki+JGUtZAEWAXx1df8Tp3jwaSnZmfJGI6O0xNRN0a6jXjZwH8
        MLD2oFYBvTnwgJVuRN2HZIBtm6wZvq0PA3c5
X-Google-Smtp-Source: ABdhPJzIGSaPxlrW0DzmCWtrZunu4x8PmwRAB+ALpP+5XJgh6F79Nxp7PouwR/rndMq23WbHuNdYcw==
X-Received: by 2002:a5d:414b:: with SMTP id c11mr19286347wrq.181.1600156914542;
        Tue, 15 Sep 2020 01:01:54 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a402:e7fb:d494:d130? ([2a01:e34:ed2f:f020:a402:e7fb:d494:d130])
        by smtp.googlemail.com with ESMTPSA id 9sm22523543wmf.7.2020.09.15.01.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 01:01:54 -0700 (PDT)
Subject: Re: [GIT PULL] timer drivers fixes for v5.9-rc4
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Tony Lindgren <tony@atomide.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
References: <921c157b-7f18-52bb-2d94-513f33cf9f41@linaro.org>
Message-ID: <2a20bb9f-13ee-784f-a717-baf2e466a5b1@linaro.org>
Date:   Tue, 15 Sep 2020 10:01:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <921c157b-7f18-52bb-2d94-513f33cf9f41@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gentle reminder, thanks

  -- Daniel

On 04/09/2020 12:52, Daniel Lezcano wrote:
> 
> Hi Thomas,
> 
> The following changes since commit b0294f30256bb6023b2044fd607855123863d98f:
> 
>   time: Delete repeated words in comments (2020-08-10 22:14:07 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.linaro.org/people/daniel.lezcano/linux.git
> tags/timers-v5.9-rc4
> 
> for you to fetch changes up to bc6717d55d07110d8f3c6d31ec2af50c11b07091:
> 
>   clocksource/drivers/timer-gx6605s: Fixup counter reload (2020-08-24
> 13:01:39 +0200)
> 
> ----------------------------------------------------------------
> - Fix wrong signed return value when checking of_iomap in the probe
>   function for the h8300 timer (Tianjia Zhang)
> 
> - Fix reset sequence when setting up the timer on the dm_timer (Tony
>   Lindgren)
> 
> - Fix counter reload when the interrupt fires on gx6605s (Guo Ren)
> 
> ----------------------------------------------------------------
> Guo Ren (1):
>       clocksource/drivers/timer-gx6605s: Fixup counter reload
> 
> Tianjia Zhang (1):
>       clocksource/drivers/h8300_timer8: Fix wrong return value in
> h8300_8timer_init()
> 
> Tony Lindgren (1):
>       clocksource/drivers/timer-ti-dm: Do reset before enable
> 
>  drivers/clocksource/h8300_timer8.c         |  2 +-
>  drivers/clocksource/timer-gx6605s.c        |  1 +
>  drivers/clocksource/timer-ti-dm-systimer.c | 44
> +++++++++++++++++++++++---------------------
>  3 files changed, 25 insertions(+), 22 deletions(-)
> 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
