Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8E7275995
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgIWONA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWONA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:13:00 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D422C0613CE;
        Wed, 23 Sep 2020 07:13:00 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n13so19955342edo.10;
        Wed, 23 Sep 2020 07:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mdUO4rdr50MnV1BrXIxomFi8tZf9S0Tgpb4dKKT+L6M=;
        b=qlSdUE8aJwkzEyqt8pukPEy+fB5tlgAI1XHvSUkYNRGQisCEteg2hs4Iepm4PZeiwU
         8m+mkoyE/1pOHPh7PVzJqGr+Uc1dzry7NtHAWfhCmKGc8hHQvDurueKu923retm890hN
         iUUkliEUdO2O5eisL4i1tikUqshX4h/nMgTvoWuolVnOFfGW8F0JUSLH22XSeOpWX95M
         C8ZtUMOk0VeCYdodJ1WZg/Qrargt6j7qhP9nm/UP1x+GoINIVXFNyhYpknpqt62ZHT1c
         +faQbRuldVK+eF113zrmX2nsDbtI2JB3eISYl3NeOdrw2tFtrzz9WcAsVTLKRSpCiJb/
         jV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mdUO4rdr50MnV1BrXIxomFi8tZf9S0Tgpb4dKKT+L6M=;
        b=jaba29vkYl8M9IUMDDPoCrfWr11lT2qjmxQ/Vm7SNO0IHqarPJWKyo/GiLGDyHCzGO
         Blel+nZZAw+IONG/JiKpAQ5LWH63Jy7Nsac+NRsFjSAdkMMrJbFnR4iqmJZfa0v7zejL
         ujLLupt+EjRBfbyuFmvsredRLDJyI1ZR1+VIK6ouddu1SmuXlzGH/bveY5I4BNT2Hdh3
         1H8Z2AWZhF4GBJ3BoN9KobSzNBCqwqmSTD9ueqmdeVP4Izy0uSQothTZu4hzuTA1KQPn
         74otT6gj3NPRl/xABuOMBzrTSYUO2J9dNwkx51UxK55UeRUgezmKvXgCb37DdWHrdYLM
         iyqQ==
X-Gm-Message-State: AOAM533+ND1A9qtaMrGU3KBH2DKazXmEhukZSEXiafql6aMflXKEvFQW
        479NEpc60zxrEXt7uFAEppiUD02pLNNY7ySsKVK76JbvJSk=
X-Google-Smtp-Source: ABdhPJz60qOETLJanuZwtWyp2XoZ9fAx9QVXf7xhJCsy78hkEewN3uePBgTaDz3zT33MlvorJbD0T0a+uFA3r34Egmw=
X-Received: by 2002:aa7:da42:: with SMTP id w2mr9728548eds.287.1600870378866;
 Wed, 23 Sep 2020 07:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200917065949.3476-1-narmstrong@baylibre.com> <20200917065949.3476-4-narmstrong@baylibre.com>
In-Reply-To: <20200917065949.3476-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 23 Sep 2020 16:12:47 +0200
Message-ID: <CAFBinCCqqT_pNurE0Lj5Md0gdi+PU7NwnspsmFkag5y9cw7bqA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] usb: dwc-meson-g12a: Add support for USB on AXG SoCs
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, balbi@kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

thanks for updating this patch!

On Thu, Sep 17, 2020 at 9:00 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic AXG is close to the GXL Glue but with a single OTG PHY.
>
> It needs the same init sequence as GXL & GXM, but it seems it doesn't need
> the host disconnect bit.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
