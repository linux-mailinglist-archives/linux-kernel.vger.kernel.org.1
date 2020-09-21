Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC178271FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIUKNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgIUKNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:13:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8AFC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:13:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b79so11985810wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RRqhc8Nlwm2DDwWTkuXckex2GFJqP8TMEjH3RDhwROc=;
        b=lPohekoT479zA+Ink3ei/17Cf5QfQB8rgzWc9VJtDuLwo/MsOu1QdVWHwKW+iXfbFg
         5SgfcvbsnMu91VIR9G54UU6GlwAKmRBLytahyVWxS6L4hpdX7aCEAXODfn3gYoW5BWuP
         FURKAIbbOqYBawyzXKfIiQOsxA7INJeaW/W8yxWMC0oWjEwl7Ery5Akl+M1tdplWCLHd
         ucFb91RYiS3u0qOaPRRwGZitmTr1jp5JwLQ4+91Va/fxq7NrLCfwNchXCL1LOP+VumaJ
         IRSZJMn1NyqsJUrP2WdZbI77gqCA47ZUReO8XyztySW4+Je74/PRinvGgcXOaffFjCKt
         mMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RRqhc8Nlwm2DDwWTkuXckex2GFJqP8TMEjH3RDhwROc=;
        b=qRop1xc2MTrAPdOqG8L0W1Tboff9IKozo7LMoVpf48FMJREQ03H9r23eojXuR25TQl
         DT171zTGCIUYW2MDdxcEvlOvp4gvuOeVC4JdORLxSrfoHtVGvsTkoXTTpjBnikN3LUgA
         TkoEFvmb0KY5DMy4el/DyNyfjesbmqtbo4oPA+0OmBkzyJkHwCpDfj2d5jpl7vUlXBRK
         I+02qlUv+Tra0jIbuQtNDnrpQxgHnQzWf4XmszVR+aXVUP6bGyv18c+LgxYeEa9ICQ6j
         QaCQTR9oKndQQ98W3h7CpBr1DYYDBQeZ9dH0EI9oO2IzbwRKRDUAejRbXYx6tKZVL6be
         bzvg==
X-Gm-Message-State: AOAM5330rn+x+0zXWaZGfn99cSpgQ3VQr7Km7RuzgVRJa1KwpCScqvGx
        LEWaLPhpsnnRJyAvd/bKiYqtuiI/U/qujpIV
X-Google-Smtp-Source: ABdhPJyr58F+Cvw7KvfAN0WVqdVyAFJTi8qQQfvsHiTASAOUkP4u51PfEcNiAkswmY28OR4OYM/wFQ==
X-Received: by 2002:a7b:c959:: with SMTP id i25mr30590820wml.39.1600683200125;
        Mon, 21 Sep 2020 03:13:20 -0700 (PDT)
Received: from [192.168.0.18] (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id y1sm19249095wmi.36.2020.09.21.03.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:13:19 -0700 (PDT)
Subject: Re: [PATCH] drm/bridge: dw-mipi-dsi: Use kmemdup cf. kmalloc+memcpy
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Philippe Cornu <philippe.cornu@st.com>,
        =?UTF-8?Q?Yannick_Fertr=c3=a9?= <yannick.fertre@st.com>,
        Antonio Borneo <antonio.borneo@st.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200909190213.156302-1-alex.dewar90@gmail.com>
 <c14d055d-1f6e-8c46-3a6e-7794ec69e6fe@baylibre.com>
 <89c599d2-6766-df68-5359-7672679b3d89@gmail.com>
 <CAKMK7uEwQhdqmU4+Ri+M9JtYqMmetmK8p9uFrhx1Lp16g=1edA@mail.gmail.com>
 <7450528b-4204-ce6e-63ed-0976ba412dd5@baylibre.com>
From:   Alex Dewar <alex.dewar90@gmail.com>
Message-ID: <274b0d15-25dc-27cb-dade-6f12c71e88e6@gmail.com>
Date:   Mon, 21 Sep 2020 11:13:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7450528b-4204-ce6e-63ed-0976ba412dd5@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Hmm, I applied this already:
> commit 33f290811d4c1a09c4e92f5bf0458525835dbcba
> Author: Alex Dewar <alex.dewar90@gmail.com>
> Date:   Wed Sep 9 20:02:08 2020 +0100
>
>      drm/bridge: dw-mipi-dsi: Use kmemdup cf. kmalloc+memcpy
>
>      kmemdup can be used instead of kmalloc+memcpy. Replace an occurrence of
>      this pattern.
>
>      Issue identified with Coccinelle.
>
>      Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
>      Acked-by: Neil Armstrong <narmstrong@baylibre.com>
>      Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>      Link: https://patchwork.freedesktop.org/patch/msgid/20200909190213.156302-1-alex.dewar90@gmail.com
>
> Neil
Sorry! My bad. Thanks for applying :)

Alex
