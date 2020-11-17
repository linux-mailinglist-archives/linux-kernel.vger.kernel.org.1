Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15572B5C13
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgKQJqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQJqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:46:06 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFA4C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 01:46:05 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p22so2588531wmg.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 01:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CEo+OPOZFN7m+DXF/d+KmtTmXBb+z+Ic943KkTxig2s=;
        b=SBl2mWdsCVbnfA1+rqUH5lEWISe1PLoahAv0tGaN5ZTvsa06oK3iqW/JVPzZALRiUA
         WqrbaTaEgIaoeKmk1y5glynS3QHNmrPXlrYJxcbLLTuLNHOxakei3FGte15aMZoFKdF1
         ICD0tH6mnviMohyj/+1S+jdMVj+jtKyHQtA11uRdrfjOppyxbvDqiX7QaNrCnFMu1ptW
         kiGuH4FUZm/UjDRFU86nVXJF5iHhjCDYgc83xt61ffjeroZ+fRjDDBtO++HsmxRQW5bh
         XMr/Dpgy9n+EJ9oD4Y2/z4osDP/rJEJdsBss44o/aGbtYz55ooe/DiBw0vbW80VDGoeV
         sMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CEo+OPOZFN7m+DXF/d+KmtTmXBb+z+Ic943KkTxig2s=;
        b=WyJcxkLA4gmMXd3qnb6wLBOwWWpsGV4laLnEllgAf9OWbS4GQtLRD5wSvtSvFhiuJf
         CAksUAW9+4YhmAvKzF+bRS+1XJgxD1n9bhFI44vgWJZZ/e0WMm3umkBukcy4LKLEJ9Bi
         caorcBI0ljf8Ne3IhBT9zc1OJGI7l5/1KguDQGlUVz57E7eNHnwKWo650a8e9l8gKK7r
         qYeYu3eMEFqPRWCqPCW45zFDHTR/9bI52AnR6uyJGNMNtsCCldNhQBZLj9SaGcpUjifd
         rmD3GUwpq6HUqTizvmNuqlI7FN8MUCR109/gmBzL4GNBearbPcsF6/mNH7pmmAX/IXjd
         qdlw==
X-Gm-Message-State: AOAM530T/+6Xq+bJVwgMdINM9oxvp9+DaTaIe2yOgABrGY34YdHjsxW6
        d//+dGeE2mI/OjrIzw4cSdZrr2UmdcZonyYC
X-Google-Smtp-Source: ABdhPJxmO6r2750VN9m69jdjO1eoCD4DL7nc3S56PG/4plHgnKNVIzcbQTzKRmssmwa02Go7trLCsA==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr3398751wmk.100.1605606364002;
        Tue, 17 Nov 2020 01:46:04 -0800 (PST)
Received: from ?IPv6:2a01:e35:2ec0:82b0:1561:9f4b:5829:8e26? ([2a01:e35:2ec0:82b0:1561:9f4b:5829:8e26])
        by smtp.gmail.com with ESMTPSA id c17sm26842223wro.19.2020.11.17.01.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 01:46:03 -0800 (PST)
Subject: Re: [PATCH 0/4] drm/meson: Module removal fixes
To:     Marc Zyngier <maz@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kernel-team@android.com, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201116200744.495826-1-maz@kernel.org>
 <0b429c41-421a-2ae0-66a0-a142c56acadd@baylibre.com>
 <09de6683eea499cfd83ab0c67e0cdca2@kernel.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <e73609a6-5502-3a97-d231-c7c419863842@baylibre.com>
Date:   Tue, 17 Nov 2020 10:46:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <09de6683eea499cfd83ab0c67e0cdca2@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2020 10:19, Marc Zyngier wrote:
> Hi Neil,
> 
> On 2020-11-17 08:49, Neil Armstrong wrote:
>> Hi Marc,
>>
>> On 16/11/2020 21:07, Marc Zyngier wrote:
>>> Hi all,
>>>
>>> Having recently moved over to a top-of-the-tree u-boot on one of my
>>> VIM3L systems in order to benefit from unrelated improvements
>>> (automatic PCIe detection, EFI...), I faced the issue that my kernel
>>> would hang like this:
>>>
>>> [  OK  ] Finished Helper to synchronize boot up for ifupdown.
>>> [  OK  ] Started Rule-based Manager for Device Events and Files.
>>> [    7.114516] VDDCPU: supplied by regulator-dummy
>>> [  OK  ] Found device /dev/ttyAML0.
>>> [    7.146862] meson-drm ff900000.vpu: Queued 2 outputs on vpu
>>> [    7.169630] fb0: switching to meson-drm-fb from simple
>>> [    7.169944] Console: switching to colour dummy device 80x25
>>> [    7.179250] meson-drm ff900000.vpu: CVBS Output connector not available
>>>
>>> and that's it.
>>>
>>> After some poking around, I figured out that it is in the
>>> meson-dw-hdmi module that the CPU was hanging...
>>
>> I'll be interested in having your kernel config, I never had such report
>> since I enabled HDMI support in U-Boot a few years ago.
> 
> Yeah, I was pretty surprised too. I have a hunch that this is caused
> by u-boot DT exposing an extra MMIO region (dubbed "hhi") that gets
> picked up by the kernel driver. *Not* having the region in the DT
> (as in the kernel's version of the same DT) makes the driver work
> exactly once:

Yeah, we used this to simplify our u-boot driver, the bindings were missing this
memory space, it should be fixed at some point and stop relying on the
main drm driver to get this memory space.

> 
> Decompiled u-boot DT:
> 
>         hdmi-tx@0 {
>                 compatible = "amlogic,meson-g12a-dw-hdmi";
>                 reg = <0x00 0x00 0x00 0x10000 0x00 0x3c000 0x00 0x1000>;
>                 [...]
>                 reg-names = "hdmitx\0hhi";
> 
> Decompiled kernel DT:
> 
>         hdmi-tx@0 {
>                 compatible = "amlogic,meson-g12a-dw-hdmi";
>                 reg = <0x00 0x00 0x00 0x10000>;
> 
> There seem to be some complex interactions between the HDMI driver
> and the DRM driver, both using this MMIO region at any given time.
> But I admit not having tried very hard to follow the DRM maze of
> intricate callbacks. All I needed was this box to reliably boot with
> the firmware-provided DT.

Yes, the HDMI stuff has some dependencies on the DRM display subsystem.
I plan to reorganize stuff but I lack time...

Anyway, thanks.

Applying to drm-misc-next

Neil

> 
> You can find a reasonably recent version of my config at [1].
> 
>         M.
> 
> [1] http://www.loen.fr/tmp/Config.full-arm64

