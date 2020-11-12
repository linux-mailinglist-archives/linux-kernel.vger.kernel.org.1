Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2580F2B02A9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgKLKZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 05:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgKLKZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:25:38 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4799EC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:25:38 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so5418384wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tyAYMwBoO94zSnNWICk2qSAx2iWJtJnznqvRXYqPRaM=;
        b=ou8ezO+5QBh5CHQdmfDvJmrv4be9fTbsMUjxsj7mkyDlUVPgtPAH+eGV/rlufCJex7
         VBiQhFfj9TjteTwixdDfydXwH1ygMk5qPj0iColGNm2/BguyjBU7wyHqnXeGLA+bdxQQ
         bBJ+5foNooOhzdNNd6nHc6V2DHXF+XSOrLU3KXG7dhxQA+Jz4TdnqMoVUy7GIyIAoTnW
         zatbHOfj6nbbbes9uB/3n/AbaX/SDUgj3CTOUXkfdNdYkKJ/SvHUxWle5FE76WJ6msH/
         1uUEbODslMu93vqf0vR5SzX0LN1hoZ0NDWp1pWXhRU8hWAwEzRizBSJNVumGXSo4PDot
         5qDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tyAYMwBoO94zSnNWICk2qSAx2iWJtJnznqvRXYqPRaM=;
        b=s1WnEUyK0NHK09cdcUayqJ8ZQtdN2lfGvPG3z5jdhG6++i6NvTl1xAOOH6GyJ9KAJS
         6zYNTgO4bq4rUDdqDUm+grsl6NhBHVAmFlfymGg5p7tI5sa26a0CB4IQNBq0hW29MJGq
         l6IpSvaK6EB3C7GZEjDnUCF9alFa1Myhv4Gc9y2SG29T+vHxoEbXHp6tZ/bY3LSZVVtl
         fAi1sXu/pWmKUfP1I7UYnYNxVHSX1yYg16XOF4dcQI2FPl/5mSS1WQ1LD9QfHA1zFKUO
         NqKgXPYGfM9A8TMbP+M38B/3Fluis3lPpeIUfTTRMVWixx9Xkz9W1rL/2bOGdan4YA2j
         AVCg==
X-Gm-Message-State: AOAM5326UFKkinomj4XfZYCI1CZreKCgbYsmJjak6FofNUEoZX0ojdA7
        1/OQ3E8To4weGwubt1W3sh0OZJmrY8NfAg==
X-Google-Smtp-Source: ABdhPJxEcVT13aylbkpn0lYfrDMVPZoj1KzlZMPdSs2Cr12pOm5nZ6RPnxAIEb7XA1HJ0Ay3BXn8cQ==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr33378420wrj.328.1605176736545;
        Thu, 12 Nov 2020 02:25:36 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6971:b700:3764:fa96? ([2a01:e34:ed2f:f020:6971:b700:3764:fa96])
        by smtp.googlemail.com with ESMTPSA id t5sm6052882wmg.19.2020.11.12.02.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 02:25:35 -0800 (PST)
Subject: Re: [PATCH v2] thermal: sun8i: Use bitmap API instead of open code
To:     Frank Lee <frank@allwinnertech.com>, anarsoul@gmail.com,
        tiny.windzz@gmail.com, rui.zhang@intel.com, amitk@kernel.org,
        mripard@kernel.org, wens@csie.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20201109114624.23035-1-frank@allwinnertech.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b81ef373-4d1d-94a8-b220-3cc3c58f72b8@linaro.org>
Date:   Thu, 12 Nov 2020 11:25:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201109114624.23035-1-frank@allwinnertech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2020 12:46, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
> 
> The bitmap_* API is the standard way to access data in the bitfield.
> So convert irq_ack to return an unsigned long, and make things to use
> bitmap API.
> 
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> ---
> v2:
> Make irq_ack to return an unsigned long
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
