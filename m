Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE3023EA97
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 11:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgHGJkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 05:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgHGJkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:40:06 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEDDC061575
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 02:40:06 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g8so1154438wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 02:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2ygenASuFAVHeSxyfRvlwBCfbX67rwOVVS8/a2O5+lk=;
        b=vCUz+KQVy1TVKykoi2FIr81nxc/Dlf66XKmkkyc6xVTHk6IfWWXk8aLggri1BoX4H4
         sd7UJ6SnzD3ZBnabDJrahu1OR8ZiELVkKEruE9wzBCo49m6qx+FmF6bBcoSBGUFMB00H
         ewDq5c8XABr7mfCaZs0P1qvsYSwa405Uz9XwsefdjgcGd1udB3OPZSKOY+4eLYUtFX68
         DNPTHTwYSkcuLiQBDBZKukk/kijCebWpgd3EYFC/b37S9S6QEYFlwUP1voaQvpuX6AbT
         YhwKAZVGHquNbMMhmdZu8YrzITupoPwk6x7lTE7yu1s302i33Rhvoyp3lM7Xk1yAiD7V
         PbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ygenASuFAVHeSxyfRvlwBCfbX67rwOVVS8/a2O5+lk=;
        b=SK7GcXWr31Y1NOG0ZmUWgk/mBWCCzg1b3q+V53jX2mVgzHmHV/poXZ18EKPiTbtyRV
         w08tZcWru4Dkes7vXoLXPq/McLg/yIPlfN4X/VC/od4Sw+HFlmH5GSj94y/QGYQaeB3+
         VJUV+Ziq2Vif4G4jztlLH7Vh96+svjMfRLHfSt1NAwoKxiG8t0KYOkBReyMNXkJ+VAIR
         I0zhLpMQQSvJZPLhw8eVFWgg73c7wdXRBNUVc7ZGHGXp7y2cffQS6RyMjvVKLuHwmUzG
         cY25RhoW/nhfw3pti+YCAY5xMVRU8Wfmj8r8pZfuNQm6sOkmz+595pcb/Fn95omUfMOx
         s44A==
X-Gm-Message-State: AOAM533z3BjDCDd4qpVq6D06t6d6DzKoK/Z5zeYM0KDg7K7zXfnzpWTp
        M3vyfCZ9J6CQSwPA4l8ncBuhfg==
X-Google-Smtp-Source: ABdhPJwuqQGf4ihtasBI+Gyuf4ZsDRFnz4dqvO8MH6E2ks+1/REokqPvz45ZuYKgSxuFeG9iFggAhA==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr11787250wmc.186.1596793204726;
        Fri, 07 Aug 2020 02:40:04 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:f457:5fc1:5262:84c? ([2a01:e34:ed2f:f020:f457:5fc1:5262:84c])
        by smtp.googlemail.com with ESMTPSA id o10sm9397248wrw.79.2020.08.07.02.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 02:40:04 -0700 (PDT)
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
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>
References: <db1dc155-0c7c-f4eb-7fa6-047a78829a82@linaro.org>
 <CAHk-=wgLt61owJ_eKwy43bBujxy3-s=xQXwsSi6VHME7SiAgiA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b903cdd8-cbb5-1a6a-3943-9bb019f1eed7@linaro.org>
Date:   Fri, 7 Aug 2020 11:40:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgLt61owJ_eKwy43bBujxy3-s=xQXwsSi6VHME7SiAgiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,


On 07/08/2020 04:43, Linus Torvalds wrote:
> On Thu, Aug 6, 2020 at 1:19 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>>
>> - Add generic netlink support for userspace notifications: events,
>> temperature
>>   and discovery commands (Daniel Lezcano)
> 
> This is "default y".
> 
> Why?
> 
> The help text doesn't explain either.
> 
> Please explain, or remove the default y. We don't add new features and
> then try to force people to use them by enabling them by default.
> 
> "default y" is mainly for when something unconditional gets split up
> and becomes conditional (so now "default y" means that you don't break
> peoples setups when they don't even know what it is).
> 
> Alternatively, "default y" is for things that are make peoples lives
> immeasurably better somehow, and it would be a crime to not enable it
> because it's _so_ wonderful.

Well, I won't argue the netlink notification is so that fantastic but it
is a feature that was needed since a long time. A previous partial
implementation was directly compiled-in and then removed [1] because
there were no user as it is and we wanted to introduce a clean new
notification framework based in our previous discussion at Linux
Plumbers Conference [2] but that needed some cleanups of the thermal
core code before.

This netlink framework fulfills the needs of the thermal daemons for
Intel, Android HAL and SoC vendors which are hacking the thermal
framework or constantly polling the temperature.

Because the compilation failed if CONFIG_NET=n, the Kconfig option was
introduced afterwards [3]. It could have been directly handled in the
code with a 'ifdef' directive without option but it sounded more
convenient to at least give the opportunity to opt-out the notification.

It defaults to 'y' because the previous (but unused) implementation was
unconditionally compiled-in and because of the thermal users needs.

Is default=y wrong given this history?

 -- Daniel


[1] https://patchwork.kernel.org/patch/11202093/
[2]
https://www.linuxplumbersconf.org/event/2/contributions/185/attachments/39/46/LPC_2018_Thermal-Srinivas-Rui.pdf
[3]
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?h=thermal/next&id=5b8583d3bd7fc10cea07e4a5bfa59465758a39dc


> So far, I'm not convinced we've ever hit that second case.
> 
> Convince me that the thermal layer is so magical that it really
> warrants it. Tell me why and how my life is improved by enabling it.
> 
>              Linus
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
