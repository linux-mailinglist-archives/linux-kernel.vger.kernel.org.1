Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6ED82995AF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790299AbgJZSs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:48:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52667 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781154AbgJZSs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:48:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id c194so12719271wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 11:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mTa3qzBfjfO3fupd3BnS4ZZoXR8ThRJTTlcwcEE0TEc=;
        b=YW50LAX+bb8u8ygC3Jx9FFIBJVTQ4y3hcs8Ug6IXC4X5DIMNM5pqiH5kuRRilM1Gvj
         bL7IO6croLQZ1IMy3QoXFOm4v948vnBe5WnDYE1qe+3LhyGVMHYoMCBBYDSJ5XLZ6Srm
         BAlxtsMJhNixpMf01ONSle7wd3zeP57g4JZlrX6pKjdCLcM8oW2tcpAzCr3WxgBdyLdt
         MScanx0uWFQ+aSdMtegIzi1SvNk5OiaHjSmrAtiizzhQy/B8MSYinf15bLyL4QzzePoS
         xmYmj9bMDGtBPHFIC9sHPVcpS0YlAZYwsSbDJYr5kwT0sVUECIw56ieG7I29q1ATTav5
         ulxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mTa3qzBfjfO3fupd3BnS4ZZoXR8ThRJTTlcwcEE0TEc=;
        b=Ap78JE0dU9T0OD+VTFPbZO/zsAL+JbJCIzxaRxW7MoLRaOhVukjMD1BxBdeVSFgG5Z
         iZX2u1YJKSlNQOzMIjhQIuEsJ4yC7Qz0VkV4kC2aF5tuYD/SZVg5Shj204vFJG8B9GiP
         4yf4wMGCxXf1t5ydIshzbNgTHY+EFv/qI93OzcUFoBJ+AS6j7M1LHR6BSOWbkL594oOW
         H5LxS/rxrKIz2zjGQVE2nAoQJnvZHkC9lkuwWNK4vSDGRxqU66VPBhKuXoyPsayIMR8o
         mYVdGCMDAi1M1gNhDCSR2lpustGIEWMrVXo52vJRy1lp4LElBnKjrlwLPhUs7l4F4D1t
         u9Qw==
X-Gm-Message-State: AOAM532PoeTyPCZSZyx190xh2BwVCdbIJJy7VVjMXt4AnboxN35v3u6S
        0try47Xxj8pwIxZBe701EWHvQQ==
X-Google-Smtp-Source: ABdhPJzGA5pjDsLggSCcMVH9c0IEnEe7XZRCpc5Ul1C/Fu74L0JMBEZofYzEoWSPtR0z7J3PDwW2RQ==
X-Received: by 2002:a1c:7f97:: with SMTP id a145mr18185230wmd.160.1603738136430;
        Mon, 26 Oct 2020 11:48:56 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6cbc:1a3:aabd:d451? ([2a01:e34:ed2f:f020:6cbc:1a3:aabd:d451])
        by smtp.googlemail.com with ESMTPSA id q7sm23253863wrr.39.2020.10.26.11.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:48:55 -0700 (PDT)
Subject: Re: [Resend][PATCH] drivers/thermal: remove unnecessary structure
 members allocated_tzp
To:     Bernard <bernard@vivo.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <APAAJwCGDWnQvuJmRuA5r4pv.1.1603677021468.Hmail.bernard@vivo.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0d4e0753-c565-3ba5-852a-32156a0ca067@linaro.org>
Date:   Mon, 26 Oct 2020 19:48:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <APAAJwCGDWnQvuJmRuA5r4pv.1.1603677021468.Hmail.bernard@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2020 02:50, Bernard wrote:
> Struct power_allocator_params element allocated_tzp is only used
> in unbind to kfree the kzalloc space.
> Maybe we don’t have to need this member to mark, also, kfree will
> handle NULL point, there is no risk.
> This change is to make the code run a bit fast.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Applied, thanks

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
