Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140A32B5B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgKQJOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgKQJN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:13:59 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE7CC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 01:13:58 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p1so22350340wrf.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 01:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OR30Ri59Ax7IpNJY8Gv39vgzGLTXJgPp4Uy2vKvkYFc=;
        b=igklpoADzxrfYaKjM1Xzrl/jf85gx3y8/wrQJOxcjxSojDSr6dSuPGnqkUBOYWsj1B
         rSwsm8PeQqB8/+IxJeAgZEcZl/uNa+R227MDPS4buybyWxk+iJCahEiIMH4rPRsIEl6V
         V74st9bagynVU8PbpM09agbKKMJyTfkkWS6QG/jGrpu1+eHs9C/w7L4jVD5e8xTag0o8
         blLXh9wAfdV2k637jP/4AYLLSBJ068+i6gyqZCEoPGx1EUs/N88KuO6BfjZF+q4kYFku
         lJcrZWBb16K0hjXXFxx3t81YDdP3lvaHbp81r1DSdhu5vXfQhXbVxgs2tPnib9efXwdi
         AXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OR30Ri59Ax7IpNJY8Gv39vgzGLTXJgPp4Uy2vKvkYFc=;
        b=Ocqat5tJWAQtKXgb6OS5+uovnFcT7c2zwSS2ciTEvY3aUIZ0+EQB07/QxtS4VSj7MC
         adZJMA56kW2EkxwuE03lwIMezBWx+zLY47py6ZmUCHd5tDqnd4arG4oIWEMC6yud96xf
         QT2LCxXoghDbjv6WSKQVB0mliNLyo7w4uaQDYaNZwROplw//ZIB6qNALVPkZyLSkM2+t
         Em4DHdyfoLudvzYmya0xPZLZSoa0h7hHTuzXPf/hQXcZ7sZ/nudOZOihfMjVSZh1QlDA
         DL4a5OcQ/auN+xAH6mG4ThgfB9uncg/ygFEPq414FGRCYAlEIPwR9jo1x5SzFnyFltQb
         oU9Q==
X-Gm-Message-State: AOAM530wm/KqQGegftlV9B1b1czxbBJpcCxB/ZU4oikF9nW5M2g7odrR
        RFci4a/q8BCqNCT4azx7mq8KtA==
X-Google-Smtp-Source: ABdhPJwUOdjKDl9430Lx6lmJNchpAdC2x/s14wJ3qQ4YyvTROcQ7NihVTDZjeiONwjI2nXYp3pjQxA==
X-Received: by 2002:a5d:548b:: with SMTP id h11mr24421181wrv.306.1605604436755;
        Tue, 17 Nov 2020 01:13:56 -0800 (PST)
Received: from ?IPv6:2001:861:3a84:7260:b09f:f7de:c7af:258b? ([2001:861:3a84:7260:b09f:f7de:c7af:258b])
        by smtp.gmail.com with ESMTPSA id a18sm2484557wme.18.2020.11.17.01.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 01:13:56 -0800 (PST)
Subject: Re: [PATCH 3/3] phy: amlogic: meson8b-usb2: fix shared reset control
 use
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-amlogic@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20201113000508.14702-1-aouledameur@baylibre.com>
 <20201113000508.14702-4-aouledameur@baylibre.com>
 <CAFBinCA6_Cei5QdiVRTX14S5QFoyDgAOhFUXtnx5uiAxuTRs9A@mail.gmail.com>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Message-ID: <b7989575-e7f0-a4c4-9f00-7500b432571e@baylibre.com>
Date:   Tue, 17 Nov 2020 10:13:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCA6_Cei5QdiVRTX14S5QFoyDgAOhFUXtnx5uiAxuTRs9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thank you for the review !

On 14/11/2020 20:11, Martin Blumenstingl wrote:

> Hi Amjad,
>
> On Fri, Nov 13, 2020 at 1:07 AM Amjad Ouled-Ameur
> <aouledameur@baylibre.com> wrote:
> [...]
>>          ret = clk_prepare_enable(priv->clk_usb);
>>          if (ret) {
>>                  dev_err(&phy->dev, "Failed to enable USB DDR clock\n");
>> +               reset_control_rearm(priv->reset);
> this should come after reset_control_rearm so we're cleaning up in
> reverse order of initializing things
> (in this case it probably makes no difference since
> reset_control_rearm is not touching any registers, but I'd still have
> it in the correct order to not confuse future developers)

Agreed, it works in this current order since the two lines do not
interfere with each other, but it is cleaner to do it in the reverse
order of initialization. Will fix it in next change.

>>                  clk_disable_unprepare(priv->clk_usb_general);
>>                  return ret;
>>          }
>> @@ -197,6 +199,7 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
>>                          regmap_read(priv->regmap, REG_ADP_BC, &reg);
>>                          if (reg & REG_ADP_BC_ACA_PIN_FLOAT) {
>>                                  dev_warn(&phy->dev, "USB ID detect failed!\n");
>> +                               reset_control_rearm(priv->reset);
> same here, reset_control_rearm should be after clk_disable_unprepare

Ditto, will fix it in next change.

>
>>                                  clk_disable_unprepare(priv->clk_usb);
>>                                  clk_disable_unprepare(priv->clk_usb_general);
>>                                  return -EINVAL;
>> @@ -216,6 +219,7 @@ static int phy_meson8b_usb2_power_off(struct phy *phy)
>>                                     REG_DBG_UART_SET_IDDQ,
>>                                     REG_DBG_UART_SET_IDDQ);
>>
>> +       reset_control_rearm(priv->reset);
> same here, reset_control_rearm should be after clk_disable_unprepare

Ditto, will fix it in next change.

>
>>          clk_disable_unprepare(priv->clk_usb);
>>          clk_disable_unprepare(priv->clk_usb_general);
>
> Best regards,
> Martin
>

Sincerely,
Amjad

