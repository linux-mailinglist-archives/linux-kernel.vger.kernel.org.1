Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DAB300397
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbhAVM7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbhAVM7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:59:19 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1635CC061788
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 04:58:36 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id n11so6404905lji.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 04:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4seuth170OHrpzcvrGxWNmFx5FHFxq8P84afz/6Z5Xo=;
        b=HDnNK/PLHiVdfRkWV5yeyxOxcoyCn24hwPU4U5xCPwq9vE8u2n7RaykoB9INj9iET2
         qUuiJw/ezJMAYKqwQ7h8IxlVNfZwDGlZZF6GpSe26TrDgk/w6HvHpeAWDxUbbe+E/xty
         IP3BH3yzs6HK2qPiedEnoeSTrLmR1CdeJX7crvwKs2nTNUQGoeTHl0catxZTLfTkXsVO
         Pda4DDu/6DrlmZtvXnU1vRjCKW/8QMLlU7aoEzt2FFKEwyeRxBe3+Eec4bzCujuiac+y
         R0N+yTNXq7d2rzCjwGs9Ed3mh/bpNkyn7x+uz4CdUJEgwTkIsaF0BiCl9WNM0uZmSfN/
         Popw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4seuth170OHrpzcvrGxWNmFx5FHFxq8P84afz/6Z5Xo=;
        b=F9hO5dVV8XYaTDLJvDf1m99/+4UeXu+5QLtCI+eaNBMSA5niinVTzhm3Zx9w7VdsS0
         +YNxztk0lN6z8ywGUfjNvSbZDtyxhFv9W1OU2plAGnNSzyLMAoEY9w/omAwh842EMLax
         ZRan8DzIGfc8n3XZ7x5ipR79bPnwGl+Xm2u5GePt/t14UJlfnrhBm2nrCq5HvV4PJgVv
         icBf9atL2u8v9zWowhWKO3YO1jYzAtvqj8oVciJkTD5PDfZ41uhM5TlUdYC1NbkjGTRn
         m2MMriewYuqrofrxQQ3oTYJJ0xk3LsuLYRScmCVqqzbmWELhR0vEX2Fe5Q/w/ghcmRJT
         js7w==
X-Gm-Message-State: AOAM531dppcytMXQjr/Wv6e1XYf/VcXQb4kdvhrixixVas5Ij1C1suFP
        UACeGsacKjLLJw+D6WfvfYiBFOdtalsi+Mj11FYIwA==
X-Google-Smtp-Source: ABdhPJzj59F+7XmvRLWmVdxewFMrw4mj2TMxm/ZMG2OB+xID5A+BKHAHHzn8FfIafN2lCelvrEVeOCnbUajF+SnUnUI=
X-Received: by 2002:a05:651c:205b:: with SMTP id t27mr218754ljo.368.1611320314554;
 Fri, 22 Jan 2021 04:58:34 -0800 (PST)
MIME-Version: 1.0
References: <20210121225712.1118239-1-saravanak@google.com> <20210121225712.1118239-2-saravanak@google.com>
In-Reply-To: <20210121225712.1118239-2-saravanak@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Jan 2021 13:58:23 +0100
Message-ID: <CACRpkdbR+W_prw-ONbU90q2hYrm9vTvFUDXHCvtDcbdZ8UwXsg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] of: property: Add fw_devlink support for "gpio"
 and "gpios" binding
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Android Kernel Team <kernel-team@android.com>,
        Rob Herring <robh@kernel.org>,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 11:57 PM Saravana Kannan <saravanak@google.com> wrote:

> To provide backward compatibility for boards that use deprecated DT
> bindings, we need to add fw_devlink support for "gpio" and "gpios".
>
> We also need to ignore these properties on nodes with "gpio-hog"
> property because their gpio[s] are all supplied by the parent node.
>
> Cc: linux-tegra <linux-tegra@vger.kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
