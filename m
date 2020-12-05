Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B6B2CFD5D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgLEScS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbgLES3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 13:29:17 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA75BC08C5F2;
        Sat,  5 Dec 2020 04:03:07 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id jx16so12575001ejb.10;
        Sat, 05 Dec 2020 04:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+Nd8+nofEfkgv7RY5TiH0dbaZKmUKFTlo9WVvygj7I=;
        b=UEiEDDbjRr3k5Oif/EZAaZRuWvrt1nF60+g2LS3O8Y/ZmgLdv00tsKhe++ekrPHDsT
         HkEKWp8WE0dyyicxhKGuXTpBen5g7PR95/FVtFhbxTybBkEs6oCxqmXCcSAygRbOSJwv
         nAXY18W5ilEja8BnNfRaaWvh7TSGWwlBeaSfCGEjcI/0AFSGy4Fqw5nSYug4h15ihpuI
         aGigkZYyagIvyU5WBGz22ZIRHoUA9m7qEiYrgKiz3WbWJsX7GCAEca9nq45wrZO26vNA
         tmfMXDYudEVzOlwIQ3cTNOD5oegmYGrsWgtQwTq42PdR4jn0cfrhcJm/fYvUJa8ZxWwF
         Gn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+Nd8+nofEfkgv7RY5TiH0dbaZKmUKFTlo9WVvygj7I=;
        b=NMi5bKgmJDYlrnTA4CcGXZrS153njscpy9rP7PyDA0CA6AKN+CevQLMVmBItBZGzYi
         fi4qC7nn7l1qXu1wRvH1RTtVBcYXVQc7+M5Nqns1+XGDeioBGk2bTSug1voEjzBobaVy
         2fLSdboQiMdfxG+Ww2vG1YChMJ/QuIu2+dWf+rN48pXipx0nLuKDuh0XgRwz1cM19aCv
         tiHfpJM7NZGRQauMlURMUazm8aGute4SRV3RoU1jsVC2psmTuBLa37JnaNA4V4NN4+IR
         xWtT7EeESkza1i4TYHGthHuDmcaNIige7ep20AWExrM+Qs0WIBgj2c2at43NdEYLifdy
         ziQw==
X-Gm-Message-State: AOAM53255NgpIiAjiyTrQoJzecGXx8hQY0e14Fo5c7oOWNMMr0DHGO4b
        KkUq4glsaCkoY++1RD3DPPGoSOnfaXEejHQFLDpHMfgWtZ8=
X-Google-Smtp-Source: ABdhPJxEeR4LSHPCH3FbOfM5VPpQQVWklnI1NwWuK8bcagmOklydL7dULL4rnPTjYLP1j3hih01YhQvHjd+mbNPZa6E=
X-Received: by 2002:a17:906:3081:: with SMTP id 1mr11751630ejv.162.1607169786456;
 Sat, 05 Dec 2020 04:03:06 -0800 (PST)
MIME-Version: 1.0
References: <20201125024001.19036-1-christianshewitt@gmail.com>
In-Reply-To: <20201125024001.19036-1-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 5 Dec 2020 13:02:55 +0100
Message-ID: <CAFBinCCQ0Zw=FB9Oy0ZnP7V-n7jvO6q9sgfV_51sC88Kq5iUpg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: fix spi-max-frequency on Khadas VIM2
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Artem Lapkin <art@khadas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 3:40 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> From: Artem Lapkin <art@khadas.com>
>
> The max frequency for the w25q32 (VIM v1.2) and w25q128 (VIM v1.4) spifc
> chip should be 104Mhz not 30MHz.
>
> Fixes: b8b74dda3908 ("ARM64: dts: meson-gxm: Add support for Khadas VIM2")
> Signed-off-by: Artem Lapkin <art@khadas.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
