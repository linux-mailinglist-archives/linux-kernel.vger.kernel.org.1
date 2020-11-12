Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6692B0452
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgKLLtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbgKLLli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:41:38 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49139C0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:41:38 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id dk16so7209235ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kl9tnH9JsEuY5xR1ZDNEf7fbe3orNGKtQm0f8d9FFN8=;
        b=SjJNEMfZmVVaZ2hOamYxtStOa75uLPmpyaHl1JNBh1bQgQnkcFmNjs0ikRbJbMp1sb
         tBkjGJLL9OpktGykqkkHskmQR4qVL45RIzToHoQTiVrRv+65crWBdISxkddxPktl8GrB
         EFb4p6xrrG1JqLIXVU9Y6ETIGA70z0iR7SUVEnC7AdLrt3bNtFWKJE0GZmtaRsbqx94k
         RszKNQ/dTU2+M4+zA3pZI4FG8FgO5bGBF6KtVIxpYbd9/eMKYg7NGnrbjGSMyqRjw7ZB
         5wvNYpvkTVw5R8fP2BNrkbpcDLob1GHTy+T4Z8Cgk1BegmiFx8TmAMo59zByhU1xFpKq
         IvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kl9tnH9JsEuY5xR1ZDNEf7fbe3orNGKtQm0f8d9FFN8=;
        b=gUTa666U1R7pHNaCmVGGyn09yR7lUx+h1syNvbPbtZ8TuTr+Z54hfeyUCkNNPkdtDa
         zbEKGecPx0yMPTd2Aieaa4X5mYjliPsz6FnyK4xv4jIEtdd5DOw6DpkXOFGwYwmnpCXo
         9mvySQhPDMLqg+gBGxGNRWJxFbl88K8y2B7WgeW4px1bNYeWMexQRBTZY60JKIJk8my1
         4nPAjubqsVHmCYde4Gl4Tb7vZ921X+S+yOtUTR4t6+8uUt5vus0q5LYV1mpQJfQ0DS7H
         JmhOPaolUyGF9LkWkdCsAwWuPwvGSyXeRloriE/V9igd5+AbVsT97Y4G1jBRdUkr/M0A
         R98Q==
X-Gm-Message-State: AOAM5337nSM0R7hmvS2sCUFHjWtnRx7RXspV+20Veq5oOZvEL9lwubhG
        RdS9SLPGkDUcgj6Ou8nLn3qhxzLRWd2vq2g9iXAhBQ==
X-Google-Smtp-Source: ABdhPJxMeuASqaNc97krYC5AoaVThbcBdJdK5408UkNEwkL9fh4N87sDwky3OpV33fNJcFh8kODSW1Byauv8NiPRv/Q=
X-Received: by 2002:a17:906:14d:: with SMTP id 13mr29245264ejh.516.1605181297002;
 Thu, 12 Nov 2020 03:41:37 -0800 (PST)
MIME-Version: 1.0
References: <1605180879-2573-1-git-send-email-zhangchangzhong@huawei.com>
In-Reply-To: <1605180879-2573-1-git-send-email-zhangchangzhong@huawei.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 12 Nov 2020 12:41:26 +0100
Message-ID: <CAMpxmJXy3upa=xMpuTzoNdgCUyuZ7YQ6kSHtuji8hj7xGo5KGQ@mail.gmail.com>
Subject: Re: [PATCH net] net: ethernet: mtk-star-emac: fix error return code
 in mtk_star_enable()
To:     Zhang Changzhong <zhangchangzhong@huawei.com>
Cc:     nbd@nbd.name, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 12:33 PM Zhang Changzhong
<zhangchangzhong@huawei.com> wrote:
>
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
>
> Fixes: 8c7bd5a454ff ("net: ethernet: mtk-star-emac: new driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
> ---
>  drivers/net/ethernet/mediatek/mtk_star_emac.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
> index 1325055..2ebacb6 100644
> --- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
> +++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
> @@ -966,6 +966,7 @@ static int mtk_star_enable(struct net_device *ndev)
>                                       mtk_star_adjust_link, 0, priv->phy_intf);
>         if (!priv->phydev) {
>                 netdev_err(ndev, "failed to connect to PHY\n");
> +               ret = -ENODEV;
>                 goto err_free_irq;
>         }
>
> --
> 2.9.5
>

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
