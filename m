Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DBA2C7054
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 19:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732854AbgK1Rzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 12:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732523AbgK1Ewi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 23:52:38 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AFCC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 20:52:37 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w187so6195446pfd.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 20:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PyIFSwXL6dQs+sHD60V3IkBS0j8n2afG7+mouz+Gpko=;
        b=anLdFmZvKYAMGR5SKXOXOrxgIi11X1hfQ1Qa2zYYx/0iy9cMZIdQb5tTiIX7Ll1wVh
         KkyiHarp2wmVIYCfT9LcGGbyYVt2fb9Zxn5pVIsc/8YUHI1DGJkErZh/79FdJvHGumaM
         41bQjMFPXCD08eP5OemqgU2QlOJSsbjlVxSnCLeufOg34Sl7pBeOeT7XzZx/laAdjdTK
         1COF2NwXCUAACxZhZf415WbnnXC6fwcwlJ+30aWv+dX09FjciyvAw/zeKxugztNFPmgZ
         RyJWbglEKq9wskEcMeddC2c2Z6VrYCi0ga95VU67NU3N8XeUS6cg/bp7e2AMwbaESb/d
         Lmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PyIFSwXL6dQs+sHD60V3IkBS0j8n2afG7+mouz+Gpko=;
        b=p/h+pbEn7S24Fv045BVQjk1anNFjE7O6v7KT2qpSPbu1vnst2cgHcuuSaMSUR2Zqib
         RAufRqLPCw9O4u9JaQLUluys4bSv6aJ1KTjCqiz+H5J6UlLdyUY5mnZt7V6+VHyEzpo1
         wWaZDSncaF3y6tUYtmZHnsWnIG38QZxgFX/2lsu4n4ZeK0fkih+K/GPwq0ATl3/Iy9b0
         UxxWne0sQHXNfeiupAEHy3+zASzhlcQfH0T5oyG/IN3D+ig7swKWcA1uSLzduxoHcCb7
         yNYww9UnMmjvx3OZL7MlmcDwhavBzUGyRrmXJJ4M1sbJ/IQ2j2U70QOC6dEelblCQaM8
         qlpg==
X-Gm-Message-State: AOAM533mb9Rj2FGsWeJJKY6P1gwE6hIkpQbdODZCcg9fLphnuerkH9d9
        uWCMmx/JDOdDAWlPTEy3lwi0PlvRVOo=
X-Google-Smtp-Source: ABdhPJyopXH2XnQ4hsAvJISp+m/sSAsjl663rach5Z3nHOfRajzybVSeHLgVl8qcr7J+5SMchR1rDA==
X-Received: by 2002:a17:90b:1811:: with SMTP id lw17mr14153546pjb.105.1606539156882;
        Fri, 27 Nov 2020 20:52:36 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m11sm9494868pfa.24.2020.11.27.20.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 20:52:36 -0800 (PST)
Subject: Re: [PATCH 0/2] ARM/ARM64: Enable SCMI in default configurations
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>,
        open list <linux-kernel@vger.kernel.org>
References: <20201109044228.6836-1-f.fainelli@gmail.com>
 <20201109095659.js52qlukfw5dasvq@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1fcc0b8d-c6c8-4184-78b3-4f68e377990b@gmail.com>
Date:   Fri, 27 Nov 2020 20:52:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201109095659.js52qlukfw5dasvq@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/2020 1:57 AM, Sudeep Holla wrote:
> On Sun, Nov 08, 2020 at 08:42:26PM -0800, Florian Fainelli wrote:
>> This patch series enables support for the ARM SCMI and the various
>> drivers provided (cpufreq, clock, sensors, reset) since these are
>> utilized by Broadcom STB platforms.
>>
>> Please let me know if you would like me to carry those patches through
>> the ARM SoC pull requests for v5.11 or if you would like to see those
>> applied differently.
> 
> Both looks fine to me.
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Series applied, thanks!
-- 
Florian
