Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEE41D7E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 18:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgERQVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 12:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgERQVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:21:22 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F97C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:21:19 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m185so144758wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SAlVc8Y9WPmWCnfLlC2hsjQ0F9+TvwmR33hhaJXJf5I=;
        b=UrRxqqN20RhAdbH4vEHZ28qeT50NZ8UZ05N7xM2PspJfHqF8RVO/by2VD5XAbYGZKe
         9XfhDMFZtmKAcsW+9o+SbuTGlkfHwOPykhJ/XU45iJBebw9Zp+6p0zhtzUUyjpqQulJ7
         SRN71x3FSqyXSIDfCOx1KbIgYAr1aY+54IyfUOYm6H1S0Xv13Eh8H3OChphTEU9snVKU
         va0Sp4LLHM3Pe9kWy0P4va4d+bKyHiXKqchHqaUWYWQO5xLoAr0qGmAZp6IgqDk+y/z2
         MJQL657Ezc6ATeHZ6Qtga/agwgn8enZVlz0AsQBvnF13F3Op8dvQEsoWWTO4DAsbTvcc
         QSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SAlVc8Y9WPmWCnfLlC2hsjQ0F9+TvwmR33hhaJXJf5I=;
        b=E+tEcH/GJi64INN6wthgC/O7OH4VD0a7gWgRczOM/hhnA3smk6BGXQLxnr+eVQrRXI
         s/BwCbE09CO2Qi0RlgHciif+A6sys50cxXDgdbbqach3fhAo4Ib0MLsvAEUuMSD9g2/g
         e/2BlRbVr4mEDVvvkoJmUzbxxEg2/uA6UKcYZijlIl69P+e4eCT/65Om7UkapfI0+yhE
         8AwaTx086cbi0ccUXBdRAhUmITix1MJXFkpm9U7/FxB1hkC33lD9YCyBQidNIvLdM7jM
         DgGS4paSkzoyZJ5idinzh+Rl6Ryw2bV/bRfipx4VanIifWlPjHU89AudvF0C/9xz6xJz
         KX7A==
X-Gm-Message-State: AOAM533P4kHfg/cpm+aPcR+d8Sch53UUJpqwFMMBS/JRvZvMhxIn9ZQz
        DgUF3aIJnWakWd7NjKOqHDTI9rqdg4c=
X-Google-Smtp-Source: ABdhPJyPVB4AbD+I0nNx5e85Skgk/Z8I85dB/DJShQQyEM8ES2m0iao8D9F8E6K5aP7R23YCOD4MtA==
X-Received: by 2002:a05:600c:d7:: with SMTP id u23mr135046wmm.155.1589818878212;
        Mon, 18 May 2020 09:21:18 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8? ([2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8])
        by smtp.googlemail.com with ESMTPSA id f128sm125911wme.1.2020.05.18.09.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 09:21:17 -0700 (PDT)
Subject: Re: [PATCH v1] drivers/clocksource/arm_arch_timer: remove duplicate
 error message
To:     Dejin Zheng <zhengdejin5@gmail.com>, mark.rutland@arm.com,
        maz@kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <20200429153559.21189-1-zhengdejin5@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a787b855-3b06-6b07-6222-cd33a5dfbf03@linaro.org>
Date:   Mon, 18 May 2020 18:21:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429153559.21189-1-zhengdejin5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2020 17:35, Dejin Zheng wrote:
> it will print an error message by itself when acpi_gtdt_init()
> goes wrong. so remove the duplicate error message.
> 
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
