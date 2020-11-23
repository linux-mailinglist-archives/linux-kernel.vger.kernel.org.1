Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1E92C0FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389879AbgKWQHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730059AbgKWQHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:07:32 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F22C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:07:32 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id s135so4065521vkh.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 08:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNsop+cjEneyR6Ql2hsZCZcsflP0cbZhcL6E3kTgIJE=;
        b=Cd9H8Fy/EEy2EVXyMtJdIYyP/IYtfyQfGwJCqk0fyc4pG+Ri//S5+3ZvYM5glp1ZJ4
         ZVpOc3/9mHF17iULTB1oum8mS8BTwOcqNPsBrBr5KOopK58JAPYG3ZtH5Cfh7EM02SfW
         u8v9dh/qskdFaQxe+oZy5GeJzKFJOVzMzvIpfXw6+2isPqbRi+/GT7kpplRCoBpQNKEh
         vluYENBYiw7UwIlqIKR8In3xPatHHeYpCB/CRhdg1R6sNQrRsUOftWmJzz2bxj5PDcHV
         edfTUtm9iAr2BidHf1KMyEU4zK35Rhw7pNGjat+i42krW9SDkcKf9jtgwNbyEGOwpVU7
         8vZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNsop+cjEneyR6Ql2hsZCZcsflP0cbZhcL6E3kTgIJE=;
        b=VANTpZ5I2JPY4UlPOEiXq3wCqMjFspszv7+LcJEbtNRMARs91Wurb4jYK/XvCyRxUy
         qmy+/iQ6ea9tqycJRx46Nk+pR9zj1cFls8I7OF4KyGhTjP491WKvXeT0hCUVu8lH+cuy
         p1XqfqiabZTuZTR6G88Y5RAua4SqBj4wDIywvAkamF66hoD95YgjaHdUSsFdQULiZuN9
         mn2MTFs7Mq6nmKJ2/yu29FvD87medH2G9j+cit7qS7W3NPq7RgHWm9e5WGXaXRU34Og8
         I37hIyNGh7n0Pt60FNbxrbtqbvJO/xUMiWFjgCWu6AL7pYIOvRIEWj709r4P7LzJX2d4
         ZO1g==
X-Gm-Message-State: AOAM532F3rFrdF0JMoh+OeOlIIbQZzzb5aCdKKUVkI4E0b9UGNWk9T2H
        TPhvjYGESK9xdS4hwhOonvojsGIXNeIXNqBImX6BBQ==
X-Google-Smtp-Source: ABdhPJyOs8N3MeZsp7FriWdMaHZTpzFrInprCKZugi76ui1r4JwfNeV5VLB6ZZQVRdgjqtC5UIQahxENrMD8YMjwo74=
X-Received: by 2002:a1f:9889:: with SMTP id a131mr456205vke.15.1606147650704;
 Mon, 23 Nov 2020 08:07:30 -0800 (PST)
MIME-Version: 1.0
References: <20201118063405.24906-1-wenbin.mei@mediatek.com>
In-Reply-To: <20201118063405.24906-1-wenbin.mei@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Nov 2020 17:06:53 +0100
Message-ID: <CAPDyKFpHAWBtxLOOvvqmAYFAwCsV66s_LzzVJg-zfXH5QE++Ng@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: Add system suspend/resume interface
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Nov 2020 at 07:34, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> Before we got these errors on MT8192 platform:
> [   59.153891] Restarting tasks ...
> [   59.154540] done.
> [   59.159175] PM: suspend exit
> [   59.218724] mtk-msdc 11f60000.mmc: phase: [map:fffffffe] [maxlen:31]
> [final:16]
> [  119.776083] mmc0: cqhci: timeout for tag 9
> [  119.780196] mmc0: cqhci: ============ CQHCI REGISTER DUMP ===========
> [  119.786709] mmc0: cqhci: Caps:      0x100020b6 | Version:  0x00000510
> [  119.793225] mmc0: cqhci: Config:    0x00000101 | Control:  0x00000000
> [  119.799706] mmc0: cqhci: Int stat:  0x00000000 | Int enab: 0x00000000
> [  119.806177] mmc0: cqhci: Int sig:   0x00000000 | Int Coal: 0x00000000
> [  119.812670] mmc0: cqhci: TDL base:  0x00000000 | TDL up32: 0x00000000
> [  119.819149] mmc0: cqhci: Doorbell:  0x003ffc00 | TCN:      0x00000200
> [  119.825656] mmc0: cqhci: Dev queue: 0x00000000 | Dev Pend: 0x00000000
> [  119.832155] mmc0: cqhci: Task clr:  0x00000000 | SSC1:     0x00001000
> [  119.838627] mmc0: cqhci: SSC2:      0x00000000 | DCMD rsp: 0x00000000
> [  119.845174] mmc0: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x0000891c
> [  119.851654] mmc0: cqhci: Resp idx:  0x00000000 | Resp arg: 0x00000000
> [  119.865773] mmc0: cqhci: : ===========================================
> [  119.872358] mmc0: running CQE recovery
> From these logs, we found TDL base was back to the default value.
>
> After suspend, the mmc host is powered off by HW, and bring CQE register
> to the default value, so we add system suspend/resume interface, then bring
> CQE to deactivated state before suspend, it will be enabled by CQE first
> request after resume.
>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>

I took the liberty of renaming msdc_sys_suspend|resume to
msdc_suspend|resume, as I think the "_sys" is a bit superfluous.

Additionally, I added a fixes+stable tag, then I applied this for fixes, thanks!

Please tell me, if there is anything you would like me to change.

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index fc5ee5df91ad..c5f9cd6fc951 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2758,11 +2758,29 @@ static int msdc_runtime_resume(struct device *dev)
>         msdc_restore_reg(host);
>         return 0;
>  }
> +
> +static int msdc_sys_suspend(struct device *dev)
> +{
> +       struct mmc_host *mmc = dev_get_drvdata(dev);
> +       int ret;
> +
> +       if (mmc->caps2 & MMC_CAP2_CQE) {
> +               ret = cqhci_suspend(mmc);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return pm_runtime_force_suspend(dev);
> +}
> +
> +static int msdc_sys_resume(struct device *dev)
> +{
> +       return pm_runtime_force_resume(dev);
> +}
>  #endif
>
>  static const struct dev_pm_ops msdc_dev_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -                               pm_runtime_force_resume)
> +       SET_SYSTEM_SLEEP_PM_OPS(msdc_sys_suspend, msdc_sys_resume)
>         SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
>  };
>
> --
> 2.18.0
>
