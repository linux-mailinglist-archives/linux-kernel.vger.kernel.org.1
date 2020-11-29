Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683682C7832
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 07:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgK2GJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 01:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgK2GJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 01:09:25 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45F6C061A04
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 22:08:41 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id q16so10647138edv.10
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 22:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wt+i8mCuCik4YSJ0kM//c8mqY8ZlAwEjQilfu5+58jE=;
        b=QnkG6tHZpsm7stG82Y/AGjsPdf4vitr0uJ5ICNCnZ5wuKuQJro4vd/FvhGlRFZBc8R
         6iebDWJ/oMEF5rw6NOZ1eo+b6YQVnvy/462GBGSJcpI/asxCiq9LImNJxxtk9MvRKEK9
         hiQfbidc74wwYNgEqO93ji3L8h0FRQaEMfScQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wt+i8mCuCik4YSJ0kM//c8mqY8ZlAwEjQilfu5+58jE=;
        b=lVzTJINAXScHiUQCzKK6qLr9fxha8otu6PBO3F9GspmSKHgvaM+Q0S4R/HRhKB1jIC
         +l7DIUBOllBq2deR/osMZHxBcsIIrB51arB+lY491WUNah0aI1OC1kawyafhfstPeyfE
         go7L4QhVK6/C1dCErR0RdeEvdKOlPDNEw/A04qyrZMI5i4IV2k6zdu+gFHMfOlK+baSd
         rAb6IOKtCDdhBOyQRKpWaK3CiZa4OcCNIPeu9OJZ5thBEJ846ZEJjMzdENeasNdgKJGX
         XaIIvE6a80QIe1TFwSiu8lpbekPxbT1AB9QhTRfKZyJ657MOG6KZAYqmqemhoIknSBfm
         50MA==
X-Gm-Message-State: AOAM531un1NyQ9JF2zfuxRvV6utrSvcB7ivKv3+MgKB6DvclynZXOxsX
        JtMyhJUKLS2xm19B06A+D7zkUq52+7jVBg==
X-Google-Smtp-Source: ABdhPJxvkx/QILo9XImmYZn8hZaoiIzDn1/AFdPnG9WbZXnpaAV9dbg4ghbZ3PtexPg57LhltP4XzA==
X-Received: by 2002:a50:9f6c:: with SMTP id b99mr16100799edf.90.1606630120500;
        Sat, 28 Nov 2020 22:08:40 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id z26sm5156588edl.71.2020.11.28.22.08.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2020 22:08:39 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id w24so14747738wmi.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 22:08:39 -0800 (PST)
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr17108061wml.11.1606630119035;
 Sat, 28 Nov 2020 22:08:39 -0800 (PST)
MIME-Version: 1.0
References: <20201111143755.24541-1-stanimir.varbanov@linaro.org> <20201111143755.24541-6-stanimir.varbanov@linaro.org>
In-Reply-To: <20201111143755.24541-6-stanimir.varbanov@linaro.org>
From:   Fritz Koenig <frkoenig@chromium.org>
Date:   Sat, 28 Nov 2020 22:08:26 -0800
X-Gmail-Original-Message-ID: <CAMfZQbxfLw_Rwz9jjpzvEO7bnBdQoW_UbA45G1UmBjADEUHfFw@mail.gmail.com>
Message-ID: <CAMfZQbxfLw_Rwz9jjpzvEO7bnBdQoW_UbA45G1UmBjADEUHfFw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] venus: pm_helpers: Check instance state when
 calculate instance frequency
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
> Skip calculating instance frequency if it is not in running state.
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/pm_helpers.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index ca99908ca3d3..cc84dc5e371b 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -940,6 +940,9 @@ static unsigned long calculate_inst_freq(struct venus_inst *inst,
>
>         mbs_per_sec = load_per_instance(inst);
>
> +       if (inst->state != INST_START)
> +               return 0;
> +
>         vpp_freq = mbs_per_sec * inst->clk_data.codec_freq_data->vpp_freq;
>         /* 21 / 20 is overhead factor */
>         vpp_freq += vpp_freq / 20;
> --
> 2.17.1
>

Reviewed-by: Fritz Koenig <frkoenig@chromium.org>
