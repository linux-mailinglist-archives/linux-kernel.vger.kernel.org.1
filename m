Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E8E2B5B85
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgKQJHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgKQJHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:07:47 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC62BC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 01:07:46 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r17so22396446wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 01:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ts4BFcU0sHwTEKKetcBY/3wKsZjB9OOJgvAEje1H0F0=;
        b=v22/1V4+04gSsSDBR/Ch5PN/piZrAcdlR0tXX1ctQ0NKy28D+GeZRe54zIgiuGmxOz
         sjwflDpyMenJdH8w36vKXVpY24Yir+1erqNDiCgkWwEF1rC3f/BDmc30JaKMXSa0jZbM
         AhkgjiooQcp9eU5ctkIjsN3KotmKT0fUgniaLsjBU6y4/p6206baFMnJK62BNmPueUx7
         AHjc5LqjxXbofktYvPStmZf5cOSvCIqBYuBKbCD1beyhh4gr61GdWLkylIn8LEhPALCP
         dvZN/Ne4xYJL+Cs5Z8YUZOwfhkxNFzxdMADXu7Xr5xPwC6h0F238N62o4DSnC9d4Dszp
         qO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ts4BFcU0sHwTEKKetcBY/3wKsZjB9OOJgvAEje1H0F0=;
        b=h60ewq1kYNHoTuReBXs0I09FvIkA0QJnZmUKnJoktS03kByLC5KPrfvOUj36KuZWvY
         bsFZdGULF3U+bsCnKZyMjnLXQOrXGVAEubqtyzVe+Ifq54g/uN0kLW2xOBXYP0SxcBC4
         yBS/whQ50X6qAoAVSlvTBBpS7zrlR0p+4MQP2W+Z7NzFOQEwWqZ8howLmLekWZKMYMpj
         UM2UPCIzaHhEWuovKCnZZpShuEBMncU8Bayx5FZ8n+KKaRg5CJSE3KjWbIQy1Pb5drPs
         jy/gXLOly6dcf84H2MizPp1SsDQBUTJRMvIaJ9bS6dXkqjQKsS7jipqQwP4mzabg+mTh
         vPTw==
X-Gm-Message-State: AOAM532cT3ZFzzjijxd8gpUOGzPvOf0HqY7QaW9jrZCfSBlJrCsoEd9g
        owdg9stDSLLJyExvAbDmhfWjLw==
X-Google-Smtp-Source: ABdhPJwDDbgFpsuYQELr3NNS8bdXjMS+2XuAKHywdNCvGmWnp+ygpVfxML9V7JK4bkd2OZV25rIDSA==
X-Received: by 2002:adf:f783:: with SMTP id q3mr23238148wrp.88.1605604065531;
        Tue, 17 Nov 2020 01:07:45 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6186:703a:2abc:2187? ([2a01:e34:ed2f:f020:6186:703a:2abc:2187])
        by smtp.googlemail.com with ESMTPSA id p3sm20121858wrs.50.2020.11.17.01.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 01:07:44 -0800 (PST)
Subject: Re: [PATCH V4] clocksource/drivers/cadence_ttc: fix memory leak in
 ttc_setup_clockevent()
To:     Yu Kuai <yukuai3@huawei.com>, michal.simek@xilinx.com,
        tglx@linutronix.de, soren.brinkmann@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com
References: <20201116070802.1353842-1-yukuai3@huawei.com>
 <20201116135123.2164033-1-yukuai3@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c967b46b-2093-7a99-5629-79bee7fcdb9e@linaro.org>
Date:   Tue, 17 Nov 2020 10:07:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201116135123.2164033-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2020 14:51, Yu Kuai wrote:
> If clk_notifier_register() failed, ttc_setup_clockevent() will return
> without freeing 'ttcce', which will leak memory.
> 
> Fixes: 70504f311d4b ("clocksource/drivers/cadence_ttc: Convert init function to return error")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
