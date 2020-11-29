Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107F02C7821
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 07:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgK2GDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 01:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgK2GDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 01:03:04 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80C6C0613D2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 22:02:23 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id jx16so13730243ejb.10
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 22:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOJePbnIwaExU9jLd03lUnaNrDCMN/HWo7t0wyAP25E=;
        b=Rd3ipsa2AJM+7Qvi713J8i3+10Ej8rUhIQAfk9VjpyZdAWjDKjkv9jIE9iOHnaNKS1
         bz20a7/h6+adkm79yT/9z0YJtUBEa0QwBWky2MW0i6Wo1ErCpoHL9fZXKnhJO8AVeNyr
         u0l+uPxqOUiaN3Ku2GQubMqPZshP7Y9i/9rHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOJePbnIwaExU9jLd03lUnaNrDCMN/HWo7t0wyAP25E=;
        b=sVqArooCehta3y5BHvZencVK/fa4+dt4aTY1EYBvW7kNfRJyCuwxCXDj5G4B37M7xg
         RqbFBSjyB98hawdKlqf8ohIP0mqRw31B4aVe7P3NR9gMQZMQ81hhucYgMCIQpP3FlJES
         0Pdjse2An7ZPZEVKkNYJOrdpfIkobIIJUpyZJ12oc6+IrT0DLK65Bfqhc5ZtnFYP1R3G
         8ppP4h2n21P/5T4xqe230ErS4Colky60DiMyKR3twCR8t0xR1KRm8wetswOI3Uolf6ar
         4R0FbWFiIlGqBMQiqZ9EHHPpFmP1ecOPYBfUgvT3aAxn5a8s8bygamdLMtZF6dVy/KDV
         4LMw==
X-Gm-Message-State: AOAM532lZX1CqShoIOlWm3N5YazcW7Vixt0g0Ee/6c7UmOwoHfatUYoM
        +IJ6/6YZBqv0/bs4BQJQ/0mjOfzxftfktA==
X-Google-Smtp-Source: ABdhPJyRzdZaEbNfW1ab4Qfybgq2ltex6/H7oQtPa6Ba/AgqEtguKhNy+5q/HIaJzDMRvJjPvfAl7g==
X-Received: by 2002:a17:906:b745:: with SMTP id fx5mr14914346ejb.103.1606629742358;
        Sat, 28 Nov 2020 22:02:22 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id t19sm6906491eje.86.2020.11.28.22.02.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2020 22:02:21 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id 23so10615578wrc.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 22:02:21 -0800 (PST)
X-Received: by 2002:adf:e607:: with SMTP id p7mr20639872wrm.93.1606629740798;
 Sat, 28 Nov 2020 22:02:20 -0800 (PST)
MIME-Version: 1.0
References: <20201111143755.24541-1-stanimir.varbanov@linaro.org> <20201111143755.24541-2-stanimir.varbanov@linaro.org>
In-Reply-To: <20201111143755.24541-2-stanimir.varbanov@linaro.org>
From:   Fritz Koenig <frkoenig@chromium.org>
Date:   Sat, 28 Nov 2020 22:02:08 -0800
X-Gmail-Original-Message-ID: <CAMfZQbx5j+c3HQBjaT45ur_6r6Nm3tsRji8D0f_EtLJF_CFiyw@mail.gmail.com>
Message-ID: <CAMfZQbx5j+c3HQBjaT45ur_6r6Nm3tsRji8D0f_EtLJF_CFiyw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] venus: hfi: Use correct state in unload resources
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 6:38 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> INST_RELEASE_RESOURCES state is set but not used, correct this
> by enter into INIT state once the unload resources is done.
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/hfi.c | 2 +-
>  drivers/media/platform/qcom/venus/hfi.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
> index 638ed5cfe05e..4c87228e8e1d 100644
> --- a/drivers/media/platform/qcom/venus/hfi.c
> +++ b/drivers/media/platform/qcom/venus/hfi.c
> @@ -388,7 +388,7 @@ int hfi_session_unload_res(struct venus_inst *inst)
>         if (ret)
>                 return ret;
>
> -       inst->state = INST_RELEASE_RESOURCES;
> +       inst->state = INST_INIT;
>
>         return 0;
>  }
> diff --git a/drivers/media/platform/qcom/venus/hfi.h b/drivers/media/platform/qcom/venus/hfi.h
> index f25d412d6553..e9c944271cc1 100644
> --- a/drivers/media/platform/qcom/venus/hfi.h
> +++ b/drivers/media/platform/qcom/venus/hfi.h
> @@ -87,7 +87,6 @@ struct hfi_event_data {
>  #define INST_LOAD_RESOURCES                    4
>  #define INST_START                             5
>  #define INST_STOP                              6
> -#define INST_RELEASE_RESOURCES                 7
>
>  struct venus_core;
>  struct venus_inst;
> --
> 2.17.1
>

Reviewed-by: Fritz Koenig <frkoenig@chromium.org>
