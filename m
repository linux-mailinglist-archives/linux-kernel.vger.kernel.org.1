Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D469293768
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392289AbgJTJBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392277AbgJTJBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:01:41 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83843C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:01:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e17so1136292wru.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q4O6c5ivLmf5Ylkh4llF14kt1PENj2Zzl8IB9YFIIj4=;
        b=m6eHkmT8IEJpYr2gcGiLGKBcZkF81y5O8Z+qXZPwHQyM4EyEn/vONmrRSoD8KUP1X+
         +zCT0rHB77mVw1NrAGD4FB0+FjB2+Pml1pNdF4eHUPW6OzP+3RCTaMgWkjDxb2oAtPVa
         Lf9ePlf8LP2nNXfB12DYW7AuoMFitb84Wq47bEvGocLpm8o+k1XlLgeqE4kURGu5SVMW
         nUzOxwwdDkDlDG9sWmobczknUQmwuEw6lSqWewhvb4A8dRKK/2xhkJGxWR73GJgSI2ET
         GaJLk2oN/ShfwRoUSXiKlub1gN9+CJ1Qr3f3iXdnWy/1iKeyvlZIrEzqCLc6V44NvHNy
         94zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q4O6c5ivLmf5Ylkh4llF14kt1PENj2Zzl8IB9YFIIj4=;
        b=Dfq15Vr+r8x8dDjCAFg1FQhdMvW3K8V/4jICdesC+ZjSmPXARzJ5lPoDoKbWAndqOm
         9noroqkR1Z5+HKhLjJWUSE0fIg5hK+iSqKAAuWVAcyICWPHH9uX8bXQdO6Q5ifNFA+L1
         2+8kzBQocvuJavIz1wCVPfZQSY0v/n+XqkI/3kYjtv3PPthWdAi0oSyAP2XVW7CdZ+t6
         9DD061JwDQx93fh8S1378Q9y4aF1OMvcwaeJtVl9YEgQM5GjW5rPpir4e3BMb/VW8j8l
         aHwhXQHxy0gP5xQlXOCKF0UB05Y8RXxE/Ihe6zTvkqHeKbR39PuJ4qxaiEo3d/zZea7Y
         dCMw==
X-Gm-Message-State: AOAM531GqY2fdtQI0emsM+P1P5DnPa1ARutcozMdjKZnOz86Ht/iK0HK
        4jYxWxZlb+RlW2UW3bRsqvLdOg==
X-Google-Smtp-Source: ABdhPJzTL0aKsgR/snCSdeHOMhJQnqO/Ml9Vj2IqzAyO5HT5bSkRr7fMGxq3FQUW7rb/RaUFkcwrdQ==
X-Received: by 2002:adf:d4c5:: with SMTP id w5mr2420156wrk.226.1603184500233;
        Tue, 20 Oct 2020 02:01:40 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id 71sm2057313wrm.20.2020.10.20.02.01.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2020 02:01:39 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] clk: qcom : add sm8250 LPASS GFM drivers
To:     Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20201016141241.5839-1-srinivas.kandagatla@linaro.org>
 <160314732379.884498.15569172477533491589@swboyd.mtv.corp.google.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <af7d64f5-aa30-2965-3c2c-ca72aed1ae49@linaro.org>
Date:   Tue, 20 Oct 2020 10:01:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <160314732379.884498.15569172477533491589@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/10/2020 23:42, Stephen Boyd wrote:
> Quoting Srinivas Kandagatla (2020-10-16 07:12:37)
>> This patchset adds support for GFM Muxes found in LPASS
>> (Low Power Audio SubSystem) IP in Audio Clock Controller
>> and Always ON clock controller.
>>
>> Clocks derived from these muxes are consumed by LPASS Digital Codec.
>> Currently the driver for Audio and Always ON clock controller only
>> supports GFM Muxes, however it should be easy to add more clock
>> support when required
>>
>> Changes since v2:
>> - updated Kconfig text and help as suggested by Stephen
>> - removed unnecessary header file include
>> - use fw_name instead of name for parents
>> - use devm_platform_ioremap_resource
>>
>> verified dt_binding_check to pass on linux master,
> Which linux master? Can you try on linux-next?

I meant linus master branch. However I learned that Bot runs only based 
on rc1 tag (5.9-rc1 in this case) which is why its still reporting this 
errors even though the dependent patches are already in linus master branch!

I will resend this version patchset once rc1 is out!

thanks,
srini
