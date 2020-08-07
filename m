Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CF023F520
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Aug 2020 01:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgHGXNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 19:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgHGXNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 19:13:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EC7C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 16:13:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f1so3035737wro.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 16:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YL9zt2WbJU71Ga7dBvhNUaOuTYHvavWD2LcWl2hdkeQ=;
        b=MEk0+oDcxuERPS6+TpI1fh80WorW8W3/693j0RsfCUY2mnT4NSTaA27wmxpwEV97+t
         G9EyqKwnXK0jCl5kq58htMpvzBl76XR5Yyh2saUJIXAZ5oRNVeQpSINs+zTQUuFQ2D+8
         Uafbik5MQcLpHqtyUEs9laHhCTRFndsrRY/5z4gzcAj2jxT96HZ/P/x+2j4b7hgCdWGd
         8/i/cv7Jb0lyE6MHPmpSewbg9hcS+uZiNiERbA+3CbwSRP6Ych9bNj7zC+n8iyZ/V1IL
         VIrUi9abmM638D+zQ7DEtinZ6n8gCwnb0ypxiN+Ie+qVWW7CcgveK0G3gqFA9bmsEngQ
         Fh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YL9zt2WbJU71Ga7dBvhNUaOuTYHvavWD2LcWl2hdkeQ=;
        b=GECm6I5If6OrEmZ4izrKDzeIa/MAHjVAT1InYTinyReGThB3+8JSlCEfOHznehBga+
         tUrISyCRp5guw2rkBD6KrNWfxOGFdchj1FnnZOzRYOQR5cjMdPi0p9QuZ43uWs6Hsdqj
         fFGqdwAwdByctSP7xQm/3ENb7ft6XCqxCI1dKtmZO7QfoOw5D/ENn1KeIrqHok83k27i
         8EwrcB+oBkMNxxC8tWdNsVteVhenYVkc0oLN3Wb+Ho9l8SUfppWtK9NTk8y0et3H14q7
         rPca+jTszpP5SkKUHLJnB8q/4zUa5Ljjeu+iWKTUIsXGAkAZYXsORXf4iOD3GIHIolK0
         /DmA==
X-Gm-Message-State: AOAM530BExft6tDsHEdbFLVUkyVhgFBpnxCsmNBnHiqFwi5oxjcv7eBC
        70zXkSnd7ubsuTBRuD/L6FldxA==
X-Google-Smtp-Source: ABdhPJy9eMExSO3JZlYfjT+S9umINTP7s5tBKiNZLG7O7ig3iEbWC0CeCyWsLgNPNHU/Jw6BiR4o2A==
X-Received: by 2002:a5d:400e:: with SMTP id n14mr13690179wrp.75.1596841978607;
        Fri, 07 Aug 2020 16:12:58 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a9ac:cbdb:2935:5df0? ([2a01:e34:ed2f:f020:a9ac:cbdb:2935:5df0])
        by smtp.googlemail.com with ESMTPSA id o2sm12939474wrh.70.2020.08.07.16.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 16:12:57 -0700 (PDT)
Subject: Re: [GIT PULL] RESEND: thermal for v5.9-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Colin King <colin.king@canonical.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Henry Yen <henry.yen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
References: <db1dc155-0c7c-f4eb-7fa6-047a78829a82@linaro.org>
 <CAHk-=wgLt61owJ_eKwy43bBujxy3-s=xQXwsSi6VHME7SiAgiA@mail.gmail.com>
 <b903cdd8-cbb5-1a6a-3943-9bb019f1eed7@linaro.org>
 <CAHk-=wgSJwbghhQYCoAVq6ewGKZ+rZvxeKvxb-o_gMt7d7-Nbw@mail.gmail.com>
 <88678a80-4ca2-5cb0-d9c5-3e64b7f113f5@linaro.org>
 <CAHk-=whe9+soLhAtO2hctL4PgnnG67BGHpSPSyxTLAe0c2zqmQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b3d73eaa-4954-dbe5-3a57-edf7bb502335@linaro.org>
Date:   Sat, 8 Aug 2020 01:12:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whe9+soLhAtO2hctL4PgnnG67BGHpSPSyxTLAe0c2zqmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2020 20:12, Linus Torvalds wrote:
> On Fri, Aug 7, 2020 at 11:06 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> Ok, I will send a fix.
> 
> I ended up doing it during my morning routine of looking around for,
> and applying, random patches.
> 
> So it's commit 0f5d0a4c01cc ("thermal: don't make THERMAL_NETLINK
> 'default y'") in my tree now.

Great, thank you!


  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
