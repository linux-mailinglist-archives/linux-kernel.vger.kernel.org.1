Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7153227A91B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgI1HyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgI1HyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:54:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D68C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:54:16 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z4so115684wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=In2sIrZUOdT6d9l0rp8/qe3T9EAaqtHwy60CydIPILU=;
        b=XYqjoAGltZfPV9JzXD12eK5iPoanLNCCBxBeyJblwQN8AzOPM01z8m05KQQRQ5VZoN
         eQXJV18DTxAPBaMCxFQ/wIXwgu7Xj7MIhMHnEkDQBystr7wC2CpguGAeImPXYoUjCaFP
         9g8QAi3f89QLVU0218s25U394ModL+nN/vm4cpVPjxIID/I3GDAv9odnzSjXjq/7C9su
         +5FzvMMR9rQtUKhZ27JlsZJlKSH/LMCfM0o6/eR8uYNEy5CJ21beggh6lEGq0GNs8YVV
         FLinj1f32JnCj6T2x3C/0jbF60w2K4nJJ3ASw6szUdeV8SyfAadiB8FIelc0xo1ffHzw
         Wvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=In2sIrZUOdT6d9l0rp8/qe3T9EAaqtHwy60CydIPILU=;
        b=GgB2kXtRnwSMUFY5XCLMNTi9NhILtEvaJIIyckeqaU02ne4qUM4v/OxLzW3tgMIQb0
         8I9AcKTQYhk2oIQX6XzGfMk/6USZ9/opwJcjmdi2q2fhPSsP/Qf2ruuvBL/ks0Lf8q8A
         o2QOCVcoKlIKC1nV4GBsS7TaX5uW7jWCgqtKoRtwE0uw6fWS6n5VSx6p5rgMtr1Q26jI
         a00wCcjQbSWld1pMCu4wciso+cB6XCpPn9rztcAQSzfjX/ABcU3l1lfHNPMYZH50zm9J
         +f3sb7+3hQF5n4c/OjzV+1NSnzmZUpWytPxehr/j2AK57IlVvyOddymCnhE43zt7xCCZ
         7CJw==
X-Gm-Message-State: AOAM533BZrSTF89b9zVO2l4H0KTLwNbcxPk6uxvKfH6b4tePT/ZTzMAN
        fZgFsTfPwQEYvGwUZm0pzjSIXg==
X-Google-Smtp-Source: ABdhPJwdXX8oDTNaPKfmbRWZInxFYYCQxNiO7EoXj0JrI4vIJdgwsgTGIiNkqtXkExbAoQzdqAqNFw==
X-Received: by 2002:a05:6000:104c:: with SMTP id c12mr166119wrx.133.1601279655332;
        Mon, 28 Sep 2020 00:54:15 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:e0eb:3ca3:e2d3:fa75? ([2a01:e35:2ec0:82b0:e0eb:3ca3:e2d3:fa75])
        by smtp.gmail.com with ESMTPSA id d9sm125368wmb.30.2020.09.28.00.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 00:54:14 -0700 (PDT)
Subject: Re: [PATCH 1/8] arm64: dts: meson: update spifc node on Khadas VIM2
 meson-gxm-khadas-vim2
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Artem Lapkin <email2tema@gmail.com>
Cc:     khilman@baylibre.com, robh+dt@kernel.org, jbrunet@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
References: <20200925033017.1790973-1-art@khadas.com>
 <20200925033017.1790973-2-art@khadas.com>
 <CAFBinCDcwHUJzK4HsvKxs1n4_jH9K47bNZcZobocLxKVj7+iNw@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <10f7b5fd-a86c-c705-fb3e-5bc6c998ab2c@baylibre.com>
Date:   Mon, 28 Sep 2020 09:54:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCDcwHUJzK4HsvKxs1n4_jH9K47bNZcZobocLxKVj7+iNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2020 09:51, Martin Blumenstingl wrote:
> Hi Artem,
> 
> On Fri, Sep 25, 2020 at 5:30 AM Artem Lapkin <email2tema@gmail.com> wrote:
>>
>> 1) The VIM2 Boards use w25q128 spi chip only not w25q32 or w25q16
>>    it's not really seriously becouse have 'jedec,spi-nor' which
>>    have auto chips identifications
> according to the "VIM2 - Transitioning From v1.2 to v1.4" document [0]
> (page 7) both board revisions are using different SPI flash sizes
> for which board revision are your changes?

Indeed, if you changed the flash for the v14 VIM2 board, please:
- move arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts into meson-gxm-khadas-vim2.dtsi leaving only the
root compatible, model and the v12 spi flash model&size into the meson-gxm-khadas-vim2.dts file
- add "khadas,vim2-v14" to amlogic board bindings
- introduce a arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2-v14.dts file adding the
changes (spi flash change, MCU) with a different root compatible & model

Neil

> 
>> 2) max-frequency is 104Mhz
> (note to self: according to the w25q16 datasheet it supports a maximum
> clock frequency of 104MHz, so this is fine)
> 
> 
> Best regards,
> Martin
> 

