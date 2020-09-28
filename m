Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BCF27A856
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgI1HPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1HPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:15:04 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0DFC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:15:03 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id y194so146643vsc.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCXdMKNDB4m8MlwDrPmz+XV4KwYnVdM/qHc8DcVYWww=;
        b=ARNv/b4yV78actnJ0SE5pQEsF9qbZjb0qiYFZyLvAAi7wtsltM+289weq9fVgYDHZ2
         pUAdIXSWvcnjVZFJ9LX5QxfoGp+JVEitm4WwFE2AH5XJDk4NUM2XKYMDKqvG36nDGfjM
         yz7UcuT73+t78gooBxyXTqxo6hFnVWwhhLgQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCXdMKNDB4m8MlwDrPmz+XV4KwYnVdM/qHc8DcVYWww=;
        b=Cb6IYeyrDmYZf9BVU8RYgs9Yv5PtqJ0Ze3pHRxEDAS9wJlhKxZZx6N5IEaFfN/Djzo
         fPD+vp3sJd6F0h14ssBl68woMu3b+g/tNdbZTJyVpPuYPk/napAVURWH31WnZuyjYRX0
         76+6cghozR5J2tXzv8txjWp8dTig/AhCk85YeG9h48A4hbUcWvZscc6AW1XIsl+91qJb
         lSPWiHSeb8FKfN2yVgq0CJT01g/BFJhj8gOUQcuYmAN/b+fQ835XF6c+HQAUDv8xy9Qi
         8n/8VtisRn0Qz6NOcKHdjMCpgybdcPcR8TdYnqchM35gKzi/04lOT174EXkeE1SFig+Q
         6Bpg==
X-Gm-Message-State: AOAM532W56Q5SEFSrOvyFOxk/JXCRMBhJRbjGSbf02lglsouQefwLoih
        Xmewd4/wKkMJuGE4qjnce2GQsfwC/ngsRIVd0m9dCA==
X-Google-Smtp-Source: ABdhPJzgpnpkOxCGPLSVYGGd+XgZUifTyoBe8zmUJ1pjig3VfddPP2GwmgKduNv1AMm7rusj7VWmXWs6Kk031JOtkXw=
X-Received: by 2002:a67:fe07:: with SMTP id l7mr4701508vsr.21.1601277302935;
 Mon, 28 Sep 2020 00:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <1596705715-15320-1-git-send-email-weiyi.lu@mediatek.com> <1596705715-15320-7-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1596705715-15320-7-git-send-email-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 28 Sep 2020 15:14:52 +0800
Message-ID: <CANMq1KByYjeD0D81sPzDxx5SzrPvpGxPgm+xvLWcFsmfUJDWBQ@mail.gmail.com>
Subject: Re: [PATCH v17 06/12] soc: mediatek: Add support for hierarchical
 scpsys device node
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 5:22 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> Try to list all the power domains of under power controller
> node to show the dependency between each power domain directly
> instead of filling the dependency in scp_soc_data.
> And could be more clearly to group subsys clocks into power domain
> sub node to introduce subsys clocks of bus protection in next patch.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
[snip]
> +static int traverse_scp(struct platform_device *pdev, struct scp *scp,
> +                       const struct scp_domain_data *scp_domain_data)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       struct device_node *sub;
> +       int ret;
> +
> +       INIT_LIST_HEAD(&scp->dep_links);
> +
> +       for_each_available_child_of_node(np, sub) {
> +               ret = scpsys_get_domain(pdev, scp, sub, scp_domain_data);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "failed to handle node %pOFn: %d\n", sub, ret);

minor comment: this error should not be printed if ret ==
-EPROBE_DEFER (use the new dev_err_probe?)

> +                       goto err;
> +               }
> +       }
> +
> +       return 0;
> +
> +err:
> +       of_node_put(sub);
> +       return ret;
> +}
[snip]
