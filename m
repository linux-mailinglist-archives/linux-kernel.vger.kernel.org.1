Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49E02FACB5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394753AbhARVcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388244AbhARVam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 16:30:42 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500F4C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 13:30:02 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d26so17782677wrb.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 13:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WuPK/5FjDs42aFnK7V4pjhtJSYgscy2KuC7MzESUVcs=;
        b=UB6V/nv/LoEGDzdOqJvcernoxeBmcQ4pa6PhEUQR+AnquadsHy8PxmAH/SIJnhCXfv
         DbOuIK7khMoBcjvSi9LyY5F3ZdULwAydWbxo7UJ2P6SNDWq4MjtCFNx8P4JLi3V5S3ah
         8e+ieD+zHQ/KKUEiXX7xFYBUrN2oqUUFlYh7FxAJ8cXiZqfZCnUUq8qEkcZ6deH+tG3l
         mQ0e8BOztoHT/a0jyV8iHp13F3781f8xHs84FxCzCXydoEHgYW2WXNtp0yZLQdej9qRy
         SWuAuS+pRYI3Kp1Nb/UCdN07x42juF0JX+XS06GjwRzWoteNOZFqja+zn+HO6wTmt7Yc
         ifDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WuPK/5FjDs42aFnK7V4pjhtJSYgscy2KuC7MzESUVcs=;
        b=fK5pfweVyL8jeaqbo/S2S6amIBGRIkfDaGo3ex886cIVj7IC4/N+FZT+EOz0Cn2M+N
         JuQu1lWNhCA77IOpA1fLB+IxN2CziPZt0QhNt0ViwCcUbVnSDMVTpU2jbw8kPMu7thMC
         o2k9VGjOHB40RAKgIqwgZwm0Ii8caVOhglDyD2epUSpWfxwfGvT12Ec2gFZls+kXfliA
         iqd71fLcZ4aZmKDaZGhaFLf1NKz8lhRfodiCRxCZ9hfNYx147GmRCWvEFsNrbbjfgdhj
         INurtZGG0JE/Mubp/R4Yb/QjOfLeTQtMlJecorDO+DGFwbAgUDHHWa2ZcipFnR9hIwM2
         yZkw==
X-Gm-Message-State: AOAM53139E5cmndTphB1gqu28RVYKZNSRfyv474+QxLeQF8DeaQg3Ydc
        snll+lEBedXFoLc2oL9uJn+K0Q==
X-Google-Smtp-Source: ABdhPJxQ30rTdpLjfHNzbKFsGb688+buapNYTQqt7sUmkOjdbQZ7gDxOVpGLwfpPBUGBfDvgPMACDg==
X-Received: by 2002:a5d:4b44:: with SMTP id w4mr1257950wrs.155.1611005400949;
        Mon, 18 Jan 2021 13:30:00 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:2095:8614:d69:136f? ([2a01:e34:ed2f:f020:2095:8614:d69:136f])
        by smtp.googlemail.com with ESMTPSA id d7sm1048253wmb.47.2021.01.18.13.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 13:30:00 -0800 (PST)
Subject: Re: [PATCH v2] clocksource: mxs_timer: add missing semicolon when
 DEBUG is defined
To:     trix@redhat.com, tglx@linutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210118211955.763609-1-trix@redhat.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3918e9b2-20a5-b2b2-846b-43b3417e4e5f@linaro.org>
Date:   Mon, 18 Jan 2021 22:29:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210118211955.763609-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2021 22:19, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> When DEBUG is defined this error occurs
> 
> drivers/clocksource/mxs_timer.c:138:1: error:
>   expected ‘;’ before ‘}’ token
> 
> The preceding statement needs a semicolon.
> Replace pr_info() with pr_debug() and remove the unneeded ifdef.
> 
> Fixes: eb8703e2ef7c ("clockevents/drivers/mxs: Migrate to new 'set-state' interface")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
> v1: replace pr_info() with pr_debug()
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
