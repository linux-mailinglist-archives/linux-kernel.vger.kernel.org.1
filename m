Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AB426DCF2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgIQNgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgIQNdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:33:23 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6441C06178B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:22:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so2057731wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iLZSPSD/ZsMU/VhPvC7PVhozMgUGYrN+a+2GW/HC5c4=;
        b=xXN9ybCyme/x/KNyTDjjlQj/2XVtUTdaIzrIOGyPx72cu4ZpKLW5W+nYUsVAVO1vJh
         t6hv3J6Ztg1hSM7ueLDl9x8AJ4NkIduTvSaWD8KvrYQ5AD0U76HE8/VcX4WgktMdSet6
         pdkzZ9Iqd1JDxMyAMlmkge5JjjqHN86bYtfSnqBC8CeokkaTNRQoHO4RwCx3cTthW0+n
         fRJrUOP61bYS4dLOD0cXRHjkq0U9EvS83ynp+LoLO4BOg4iqm0VsjDTaCtz7wgEg1tU2
         /+f7QrxDcxzOD547T5YhqmEFh6TJ7/iqPsaO8m030YJBDsJ5VN5/sVhgV7DmUbTK+B1A
         aYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iLZSPSD/ZsMU/VhPvC7PVhozMgUGYrN+a+2GW/HC5c4=;
        b=T0C6fl5wRw1+9B0rAyminpu0vsmxxLWkLfZOKeeejpGddbeQ1scI0jr25VtvpXIgKa
         dlblsMo3PhciLoIBxUvyVuAKHy4lGQZ/+BM4Ipkc2RNSIEJ67TQ8gMqr98OXWD1AjlRf
         SLbK4taP6vsJtrGOv16ioPUlQ5ubionLiJLaHytoHAB2gj9+ObXdVyVBteJmgj+9X/6U
         HDrWAYJJBra1SIGo6a0pLyR2BCVbHex+1ozO3wQeRCjNHE0u/O4FfaJve42erfI1lEIU
         nbB94J54Jir/mXHNVL4YVD76zCsmN04XZ+58w74IS5etRcsrSfqC6t7b5IbRM2ZIn1ao
         n2yg==
X-Gm-Message-State: AOAM533/mG9/+v9PDKpfDaKmADQ5VH8PRD4F00Zmxvj6yHwju67ue7jX
        PJ7SoCN9opQYMO6++CDXFqVq2kjCyBMPV98M
X-Google-Smtp-Source: ABdhPJztkq6byhLykI8VIdHer61V/nJiMFZCB2XFILnEb5UWHB4s/NHiHcaHOV8rjlaza1/Vewmlmg==
X-Received: by 2002:adf:e952:: with SMTP id m18mr31706208wrn.171.1600348971148;
        Thu, 17 Sep 2020 06:22:51 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9934:ad8d:e364:de32? ([2a01:e34:ed2f:f020:9934:ad8d:e364:de32])
        by smtp.googlemail.com with ESMTPSA id 18sm10622495wmj.28.2020.09.17.06.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 06:22:50 -0700 (PDT)
Subject: Re: [PATCH] thermal/drivers/cpuidle_cooling: Change the set_cur_state
 function
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     zhuguangqing83 <zhuguangqing83@gmail.com>, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, zhuguangqing@xiaomi.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <19e301d68ce3$de5f9840$9b1ec8c0$@gmail.com>
 <d1367763-335a-53ba-d4fc-7b02dbd59c88@linaro.org>
Message-ID: <ca967b7d-d772-abc0-8dc2-d24af36f28cc@linaro.org>
Date:   Thu, 17 Sep 2020 15:22:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d1367763-335a-53ba-d4fc-7b02dbd59c88@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2020 14:33, Daniel Lezcano wrote:

[ .. ]

> It does not really matter if the update is delayed. Restarting the idle
> injection at each update will be worth in the cooling context than
> waiting an idle cycle.

s/worth/worse/





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
