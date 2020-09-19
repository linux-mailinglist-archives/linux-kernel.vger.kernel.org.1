Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966A4270DCE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 13:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgISLv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 07:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgISLv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 07:51:29 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D1BC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 04:51:28 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q9so7667579wmj.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 04:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Op/a2HEXudfmbL2zW3KfDGxdlIacPR52588lQsIE5KA=;
        b=OTgvtXMERaFupZE/K9in1OTN8nd+50HAwoG/pYCDpN3sQZPt7AjISa8Q8zYVpYFJeD
         kK6jWfEyvjgnC01KPmbzta+UtwVdIWKelNh8uhXSfLe8hNNlSQlhWSuJrZABBu7rIbGa
         VO88huBjklSVaKlfXBsEwdRGUxL1UflH5YK17GnfuDtVhlwtd0VXjLP4RlqGDo2MArq/
         4Ulu+bCOirkEr8uQsJkswrH5bbjba+HoE5QwRIQARDEIP8oURwZkgwR4lCA8gBJsF4Xf
         z+LdjnyL4vpm9+KxNve5nOzwINStAVr7pddVSYvOSGjEhCo1ui+DRAtLwrVL16fyT9Mk
         ZH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Op/a2HEXudfmbL2zW3KfDGxdlIacPR52588lQsIE5KA=;
        b=AJFxVoIrkv3ifbDoV4DKo9h0dWdF8AONWsc5VqX6SNizNVkzGztzjbunqoqHHNV26z
         eJHSl6zQUj+Qrrr1FgfwI/Uq03JFnRRhTJKMCHrwJVTWmXE+t2NMbn17P/JYrFnnYV/7
         jGA5QG1F1Jnrwg9SM8Akb05LmTqhK7K7q8Okg1kFr0bYs3kRtrVCM4RcbzfO7e7zu2+P
         cyNafL2cl87qlxTSjRS16ch1gAR1JN7QuUvcIX9KlTCGX1sCxZ0f3yolE/JqCvyDzglu
         vWd4fRI9PJqJdf9wP+8VHAaUrShZRD3T7nV7KBbe+/B/xboPelwdM4Cg2Dw5Mb4a1Qie
         d51A==
X-Gm-Message-State: AOAM531kA26qvPq7xpVbEx1wGozpjOBXmtBTT0o8aMiEUi4c5o0pCwnQ
        CPj1P/vYxguXdCdrudiMP2Ud9g==
X-Google-Smtp-Source: ABdhPJwgT6nK9YXWOVF+UkEDm96RavXOm+FO28P0ROMSRcmaOXxV2OnLJmNZ+QzGadWivPfO20vhXw==
X-Received: by 2002:a7b:ce86:: with SMTP id q6mr21370324wmj.163.1600516287482;
        Sat, 19 Sep 2020 04:51:27 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9142:20e7:201d:cd11? ([2a01:e34:ed2f:f020:9142:20e7:201d:cd11])
        by smtp.googlemail.com with ESMTPSA id k5sm10132879wmb.19.2020.09.19.04.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2020 04:51:27 -0700 (PDT)
Subject: Re: [PATCH v3 0/9] clocksource: sp804: add support for Hisilicon
 sp804 timer
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
References: <20200918132237.3552-1-thunder.leizhen@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f25d4aa6-80f9-0ff6-25f5-f1def38ef824@linaro.org>
Date:   Sat, 19 Sep 2020 13:51:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200918132237.3552-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2020 15:22, Zhen Lei wrote:

[ ... ]

> 
> Zhen Lei (8):
>   clocksource: sp804: remove unused sp804_timer_disable() and
>     timer-sp804.h
>   clocksource: sp804: delete the leading "__" of some functions
>   clocksource: sp804: remove a mismatched comment
>   clocksource: sp804: prepare for support non-standard register offset
>   clocksource: sp804: support non-standard register offset
>   clocksource: sp804: add support for Hisilicon sp804 timer
>   clocksource: sp804: enable Hisilicon sp804 timer 64bit mode
>   dt-bindings: sp804: add support for Hisilicon sp804 timer

Applied all patches, except 9/9 which should go through Rob's tree as
the yaml conversion is there.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
