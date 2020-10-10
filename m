Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0FB289CDB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 03:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgJJAyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 20:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729046AbgJJAcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 20:32:13 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F818C0613D5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 17:32:07 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id q123so8256559pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 17:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=usDG2PLdPyLQAzOUl6ObINJYoYvZzqlBCfKxogUXi+w=;
        b=oUcHTSIuwUxftohlFMz4I0B/wRKe9Svmb4QiNs+Jpw8hw+O7CMdkVX65KQeHslpNPv
         m+W6TpMOsLjkLI/7v8oK0m9TwxNhuHCZFiBI7SPrYlDK/fdyWrRKtXsE9kEflTj316bw
         FSNV/bFMt6E9WeJ7MviswjdaxMAZaB+2P7/j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=usDG2PLdPyLQAzOUl6ObINJYoYvZzqlBCfKxogUXi+w=;
        b=WOYK3Vl4xkwB7l+mni2Y2KrOa4Yca53yBprixtjYgH5nRX9cGPLXSgBHjwFBU31EE/
         pt5xy6wdklNXOXmmXjJcBEAF2Z9xKWDvQyccLzXRemw6Yt5PaGb1mKn0O1DjBjbTUi8x
         LLo+11V4mWmRKHkfndWxam36j9QNyyxqseq7fdRBliQc+Ky6xBaD+A1YBg8RSLqynFUK
         JOsyVhZLprv1Hfqb6WO3TYMhJtbDG8bk/jge0TdC+TtTV5RGho7ThVpGV2pt7pJeWJQ2
         A4bDYY/dteNvZoId06CKmSIRxGK8rIqfR8NZCQJrNsf7XOpH3mfxC6gv7GUC5O/rS/tz
         PWUg==
X-Gm-Message-State: AOAM533QPOgjCASkWlOk8zUdoSNEUu/CC5THz1UijY8pmrVT785gvQgB
        dib0YnlgZ7BVW13F8xj3qvxgkA==
X-Google-Smtp-Source: ABdhPJxz4qYfCA2+uiwu7z3QPfF3YUvoch2gJkR+VE9cg5sDgR4bJzK/q3r4kEAh/zUJpcXcDjlmiw==
X-Received: by 2002:a63:c053:: with SMTP id z19mr5275781pgi.418.1602289926918;
        Fri, 09 Oct 2020 17:32:06 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id d128sm12381188pfd.94.2020.10.09.17.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 17:32:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201008155154.3.I646736d3969dc47de8daceb379c6ba85993de9f4@changeid>
References: <20201008225235.2035820-1-dianders@chromium.org> <20201008155154.3.I646736d3969dc47de8daceb379c6ba85993de9f4@changeid>
Subject: Re: [PATCH 3/3] soc: qcom: geni: Optimize select fifo/dma mode
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
To:     Akash Asthana <akashast@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Wolfram Sang <wsa@kernel.org>
Date:   Fri, 09 Oct 2020 17:32:04 -0700
Message-ID: <160228992470.310579.7455188858203154687@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-10-08 15:52:35)
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni=
-se.c
> index 751a49f6534f..746854745b15 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -266,49 +266,53 @@ EXPORT_SYMBOL(geni_se_init);
>  static void geni_se_select_fifo_mode(struct geni_se *se)
>  {
>         u32 proto =3D geni_se_read_proto(se);
> -       u32 val;
> +       u32 val, val_old;
> =20
>         geni_se_irq_clear(se);
> =20
> -       val =3D readl_relaxed(se->base + SE_GENI_M_IRQ_EN);
>         if (proto !=3D GENI_SE_UART) {
> +               val_old =3D val =3D readl_relaxed(se->base + SE_GENI_M_IR=
Q_EN);
>                 val |=3D M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN;
>                 val |=3D M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN;
> -       }
> -       writel_relaxed(val, se->base + SE_GENI_M_IRQ_EN);
> +               if (val !=3D val_old)
> +                       writel_relaxed(val, se->base + SE_GENI_M_IRQ_EN);
> =20
> -       val =3D readl_relaxed(se->base + SE_GENI_S_IRQ_EN);
> -       if (proto !=3D GENI_SE_UART)
> -               val |=3D S_CMD_DONE_EN;
> -       writel_relaxed(val, se->base + SE_GENI_S_IRQ_EN);
> +               val =3D readl_relaxed(se->base + SE_GENI_S_IRQ_EN);

Can we use the val_old trick here too?

> +               if (!(val & S_CMD_DONE_EN))
> +                       writel_relaxed(val | S_CMD_DONE_EN,

Because this val | S_CMD_DONE_EN thing is just hard to read :/

> +                                      se->base + SE_GENI_S_IRQ_EN);
> +       }
> =20
>         val =3D readl_relaxed(se->base + SE_GENI_DMA_MODE_EN);
> -       val &=3D ~GENI_DMA_MODE_EN;
> -       writel_relaxed(val, se->base + SE_GENI_DMA_MODE_EN);
> +       if (val & GENI_DMA_MODE_EN)
> +               writel_relaxed(val & ~GENI_DMA_MODE_EN,
> +                              se->base + SE_GENI_DMA_MODE_EN);
>  }
>
