Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FB02B224B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgKMR2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgKMR1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:27:30 -0500
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68534C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:27:30 -0800 (PST)
Received: by mail-vk1-xa43.google.com with SMTP id s135so2284414vkh.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNeg4qP6VUUjIOr+EpogB4eFqk9juY9gyiBCzYtl5Fw=;
        b=eSoHOmCRpkW35KVQ2MpDLBLg7TiBXu6RgfAM9EYJrcogKGzZK3ZrJ0UeaNTaRtl5sx
         A66LbXrWPSVbH2BwoDyi0kDiZ8QB9ejt4wkdkO/b3wntF1zKPntpX03TUUiCngKDbfPU
         7waZgx5I9He1RJmz/ka1FrVQymueBbbSANj9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNeg4qP6VUUjIOr+EpogB4eFqk9juY9gyiBCzYtl5Fw=;
        b=adDuiuH6I/K307591XbAWs2hTNc/ePhvol8eI5SKKTl3TQ9sklYCbETtiA2N7ypeVf
         1GkbBcQCNsZZ6NBEFoW1lOwQllu2fNtaowpxDm2C2zv4ngQlEGfBDHT3qDSBaOvQ4ygy
         DYPWDDm/MTWT9dOPY1UOYD5fTC/tr1HQuS5RrnrP6jCDionDW/SOcFmT8d88UP4Kmf7e
         zzKpv6CVhwITFCSHydgInbuPWNHQACNtV9TVfC7bL7VAUmrKbCktlGf+L+tP3zP+ZX1H
         9csnRUhejora+qPhBqzDSX7eP1Dmhqn+QoUJnvyLVW53Yw6ik3Syk4r8RapM1UopbDgP
         4B0A==
X-Gm-Message-State: AOAM530Ft1oIJkWDrc9X+zEWrF01QHd4Iexe8v63dsiO40bSjrQj9iax
        ne4T4kUUjlkIO8l0hfS+8FGdk0Yzx1PSnw==
X-Google-Smtp-Source: ABdhPJyONsudrG2Ni+SEh97OGHd/ynptHFIU4pWCAjgRJcevnYjpyUiwrPhysuYtthJSvgOWBnJ3Ug==
X-Received: by 2002:a1f:3105:: with SMTP id x5mr2105013vkx.1.1605288444554;
        Fri, 13 Nov 2020 09:27:24 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id u15sm705026vkp.18.2020.11.13.09.27.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 09:27:24 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id d191so2281824vka.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:27:24 -0800 (PST)
X-Received: by 2002:a1f:2306:: with SMTP id j6mr1991952vkj.21.1605288440171;
 Fri, 13 Nov 2020 09:27:20 -0800 (PST)
MIME-Version: 1.0
References: <20201113101419.GC168908@mwanda>
In-Reply-To: <20201113101419.GC168908@mwanda>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 13 Nov 2020 09:27:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V1tvAw-myadWTA0K_RzJ7R9oYzVuc5-y74Ov06M0dk0w@mail.gmail.com>
Message-ID: <CAD=FV=V1tvAw-myadWTA0K_RzJ7R9oYzVuc5-y74Ov06M0dk0w@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: lpass-sc7180: Clean up on error in lpass_sc7180_init()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 13, 2020 at 2:14 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Clean up the first driver if the second driver can't be registered.
>
> Fixes: 4ee9fe3e292b ("clk: qcom: lpass-sc7180: Disentangle the two clock devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/clk/qcom/lpasscorecc-sc7180.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
> index 1a3925badd7c..9081649f476f 100644
> --- a/drivers/clk/qcom/lpasscorecc-sc7180.c
> +++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
> @@ -491,7 +491,13 @@ static int __init lpass_sc7180_init(void)
>         if (ret)
>                 return ret;
>
> -       return platform_driver_register(&lpass_hm_sc7180_driver);
> +       ret = platform_driver_register(&lpass_hm_sc7180_driver);
> +       if (ret) {
> +               platform_driver_unregister(&lpass_core_cc_sc7180_driver);
> +               return ret;
> +       }
> +
> +       return 0;

Reviewed-by: Douglas Anderson <dianders@chromium.org>
