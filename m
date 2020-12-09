Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103D12D458C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgLIPhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbgLIPhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:37:15 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE96EC061794
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 07:36:34 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i9so2220256wrc.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 07:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QcpPX3yoYNcNs1DtgpF/quC1xAKZ6RFXP7cOqf3ALFM=;
        b=pBBkC+bFFqEI1touvhyYUEIg/R2AQ8JmMv4p040jE/nlai4VE/BMBg6truyAS5zz+G
         DRPU+PIjwPpWufzcITMZdlGnektIqCT3rWQ6sBtDy9H5QzYN7tC/SDWy0X4oSMrwG1Cb
         qynpEsI2svUxLmZuCPinZyY/gJonpws3mvliwx6C5xBwDHxYcpKxQ34GZg7i/c3LkpxM
         FCs0TlfG5DmQVG7Ac6+ocqr8ytl6ZRmIkv6j4z79Y7xAUoDSmGYg+UATyvHanQu+j0t9
         aHPGKnD5RF1iQhD3PTw06iVTIILrg7YoSid6u7QG2keZ5MG5/KTm1w0+z/V+FkQJXotR
         uy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QcpPX3yoYNcNs1DtgpF/quC1xAKZ6RFXP7cOqf3ALFM=;
        b=Rp4OmqvbN3ad8j/71FiaYJ+z2S1DS4pNUvjYfQwtav4ykt9P82zBmEOrk208jmX5qR
         /L5Zq2U/iPxkAHyEwJnbI3fnmgqJ7941zC0rh2MyO6LPUwRGM4okYD3bS/7qC6J5jARs
         YvYQExscPczUIMHKN8jyskZ33/rimBvt9+gitrBFCIlXME48wtab0EOqf5hPJghN6Hin
         D9phvUgFVTFNqeM9LCG5vnoLMabonHh3oYRXfsixfRW8JmCR6I0JQoV3OP1GODsFQfTr
         F6oUT9pkmvS3Dt9wxqdYjRSTyG7VZq4SHJCTvgCbWGQkeH+AA19aiwABXig5EtjqbJNr
         SH7g==
X-Gm-Message-State: AOAM531CxY2HaK3LYm+5lpJBbdAUXLQ/QQ+ohtNftelwtMd/DjQ1tB5z
        i5Alk4yBRq7ufsIKQdirz/KWvEGxN3Lick4s
X-Google-Smtp-Source: ABdhPJwL+3/MN6lQUywNHXA6s5i36eQPuMdeMC+JrIYJFdteUjdCIX8yVHsV505yxgD/Dh7kwrndDQ==
X-Received: by 2002:adf:e541:: with SMTP id z1mr3325650wrm.143.1607528192904;
        Wed, 09 Dec 2020 07:36:32 -0800 (PST)
Received: from ?IPv6:2a01:e35:2ec0:82b0:9030:bf2b:a79a:2f88? ([2a01:e35:2ec0:82b0:9030:bf2b:a79a:2f88])
        by smtp.gmail.com with ESMTPSA id h20sm4544435wrb.21.2020.12.09.07.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 07:36:32 -0800 (PST)
Subject: Re: [PATCH] media: MAINTAINERS: correct entry in Amlogic GE2D driver
 section
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201209074658.11557-1-lukas.bulwahn@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <d1d0e624-d9d2-fb67-35cd-8be99360b400@baylibre.com>
Date:   Wed, 9 Dec 2020 16:36:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201209074658.11557-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2020 08:46, Lukas Bulwahn wrote:
> Commit aa821b2b9269 ("media: MAINTAINERS: Add myself as maintainer of the
> Amlogic GE2D driver") introduced a new MAINTAINERS section, but the file
> entry points to the wrong location.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns warns:
> 
>   warning: no file matches    F:    drivers/media/meson/ge2d/
> 
> Adjust the entry to the actual location of the driver.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies on next-20201208, not on current master
> 
> Neil, please ack.
> Hans, Mauro, please pick this minor non-urgent fix-up for your -next tree.
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b20babb9f7b..d66bf50fc640 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11520,7 +11520,7 @@ L:	linux-amlogic@lists.infradead.org
>  S:	Supported
>  T:	git git://linuxtv.org/media_tree.git
>  F:	Documentation/devicetree/bindings/media/amlogic,axg-ge2d.yaml
> -F:	drivers/media/meson/ge2d/
> +F:	drivers/media/platform/meson/ge2d/
>  
>  MESON NAND CONTROLLER DRIVER FOR AMLOGIC SOCS
>  M:	Liang Yang <liang.yang@amlogic.com>
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
