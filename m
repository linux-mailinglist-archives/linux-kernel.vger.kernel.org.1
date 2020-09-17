Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E573F26DBB6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgIQMid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgIQMel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:34:41 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E7BC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 05:34:39 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y15so1880618wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 05:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KyyxODxIBbOj2ahnrjUn6zJncw7bD6W4xO64z4Qh99g=;
        b=SIkF3wBG49sq64Ru5pxTu9VG4dImtz8k9fpsrVMfspidhbnFEYMBx94X3vmhNH1eAC
         7mIxW56E1ZejxsAn1uAg3C0pA1PcNfP7Y0BfPq8pRVhZOErrDNqeqA1hd6OjaY+A6GYe
         D5kd2SHZxEXMWnTQSpQnV85GpM5cAJF2Vy2nqB3eD7OU7b37b1Ng0MSVMRI1nRHRiF/Y
         AAYQi8FB1uOBQsRk84PG66fV4BqFj6EsB+MN6aqZzr0IR3wXcsiLcvbUTMYoDjNNfglm
         Gy4Qf/vTFlBfEhgQE8vxPlMaTTRmiYzf0qk/+fJUmltMxOrWqaO56EJZjq9BaVMauJaX
         lcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KyyxODxIBbOj2ahnrjUn6zJncw7bD6W4xO64z4Qh99g=;
        b=WQEyaauNs9ttDl7qSRoQx+P25d0oHBbFzhKI+arSqXt9A5Llbr/H122cJV4hlcO+me
         rlPQxVTZsd+1/XhWIgBM4pp27GeCyeHtuPhTO4tDb9BopnDdpWcBATC3s68xnlaaDAUz
         zEXG058El2T5xWtef06o9zpaRWrefP471csCA3NVcxYaGbJc0TsY5pyV0zZOMNIf9t1I
         A2qUTiTAcGcsBdlGEu2pSmmUhiGqMYqbToyrZZIU4JVr/ePEv3emqyNRIzuNLWM38A+T
         12I+GUXVKnjYdwjSDwzkANCUV0UQUFCIEqH2z4l5c14NOaV5orq/2rT6lDgwDgIoh1oG
         vziA==
X-Gm-Message-State: AOAM531jzZHP2xOF6+l9CQIUfvy5CiQUdmMHjzf5vqrOnE9eDze9/2YT
        DEww7xKCVP++9cJk7UXaeLutQOdO9yiepA/u
X-Google-Smtp-Source: ABdhPJwEFBCLLZevIUsDUu0g/lTJZapZPwCZXRvCvVrY0SvomDpvO3vVm7TE7tP/p1BOdm2694u+Mw==
X-Received: by 2002:a1c:4e0a:: with SMTP id g10mr10190752wmh.71.1600346078370;
        Thu, 17 Sep 2020 05:34:38 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9934:ad8d:e364:de32? ([2a01:e34:ed2f:f020:9934:ad8d:e364:de32])
        by smtp.googlemail.com with ESMTPSA id c16sm9407232wrx.31.2020.09.17.05.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 05:34:37 -0700 (PDT)
Subject: Re: [PATCH v2 0/9] clocksource: sp804: add support for Hisilicon
 sp804 timer
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
References: <20200912114536.2910-1-thunder.leizhen@huawei.com>
 <b6bc2ed2-cf83-cca4-d599-ad4f20438349@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0af1f6a8-56dd-a60c-7fd9-6a6ac51a6526@linaro.org>
Date:   Thu, 17 Sep 2020 14:34:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b6bc2ed2-cf83-cca4-d599-ad4f20438349@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2020 03:27, Leizhen (ThunderTown) wrote:
> Hi, Daniel Lezcano, Thomas Gleixner:
>   Do you have time to review these patches?

Give me a couple of days.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
