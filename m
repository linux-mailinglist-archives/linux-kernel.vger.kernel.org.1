Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B2B22F706
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 19:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbgG0RuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 13:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgG0RuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:50:02 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425DEC061794;
        Mon, 27 Jul 2020 10:50:02 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id kq25so5002746ejb.3;
        Mon, 27 Jul 2020 10:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3P4kvBv8Rleuknjs/EKTdnAw0nGwmEOuGwij7lqxeU=;
        b=jLtvF/aQ5RtTONzbSrQDOZ1CQZgDhxf9HDJmnPZud7lgph0ilkpZaU78GtBhDuvd/2
         XmfXbx35DAI4/SglbNcNHF7h7zU7e4p0cA0f0vciUXtNUk85F31iGXiz12kBr4+fWgRD
         hb+sgtPHobb0bF263fhJxgjNXPA4nZiC0u01RdMJ7iuCtNx9s8Wrvl2lOVSatGcBy6Y7
         SWxtFNAI6SpEcTTrI96iv1FIfoF6atpJdLZ4tM/SjnLDB5flQ6szb6JfblsDE3BNMXVY
         wbvsp0o3+hXk3D4C2T0BZgwg2apRKpQYk/XrcaLxEAIr98Y9MMoaRATEJKcwDv8Sgoh8
         61aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3P4kvBv8Rleuknjs/EKTdnAw0nGwmEOuGwij7lqxeU=;
        b=scPW5OJ+TZB6P9OGsHPw9eOKm/5HGVx1OkeXDIMEhmHLzFqxa6y43eMdC0M667F7QA
         pgPafJ2aQaO1U4aaTSl1idTP/wWm3MzAHO+BCKuJXXP5GwS1Bhh/UDiSik7//zgwBttx
         scam5ZEIwdkcQvsGk9BN4Vch2lT7t6UzK0jxanLEKa8yLT93GRVMA3mZwojLcyWz/GxG
         0jPDEFRkoVeTmxopeBpM7WApNMnaeAfNKp1ARMIOLgIkU0pMT5jnZkkU/L9nY5IS7KvO
         BwVbHxK3E7MP+X95dqiDSZCK2momCMk3y4xDvh4+vnLus6Ruu011gxRZGeQPs/UqoR4R
         yQ1w==
X-Gm-Message-State: AOAM531vIlPzU+ntyTBtN/hJcAmlw9nTbFQFf6g1zH7Ztv9CR6soszwm
        q7qrC5oKiGTuvzDp9lqef9lVhv95TMs8gbUiI24=
X-Google-Smtp-Source: ABdhPJx00cueCvmkr54gaDTC1tq+EK0jdh4p/C2xAIh4A01uMkWJLB4IiShofhBWPvcEAq/5YL+6MG9izDKcQfaj+q4=
X-Received: by 2002:a17:906:aad2:: with SMTP id kt18mr4042699ejb.537.1595872200937;
 Mon, 27 Jul 2020 10:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200727092346.19780-1-amelie.delaunay@st.com> <20200727092346.19780-4-amelie.delaunay@st.com>
In-Reply-To: <20200727092346.19780-4-amelie.delaunay@st.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 Jul 2020 19:49:50 +0200
Message-ID: <CAFBinCCXuUC4PHgrobYjj=yjA3Tz73Wwx0KWz+B6PfCw_OSi_w@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] usb: dwc2: don't use ID/Vbus detection if
 usb-role-switch on STM32MP15 SoCs
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amelie,

On Mon, Jul 27, 2020 at 11:23 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:
[...]
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
> index a3611cdd1dea..65f8596f6795 100644
> --- a/drivers/usb/dwc2/params.c
> +++ b/drivers/usb/dwc2/params.c
> @@ -183,9 +183,11 @@ static void dwc2_set_stm32mp15_fsotg_params(struct dwc2_hsotg *hsotg)
>  static void dwc2_set_stm32mp15_hsotg_params(struct dwc2_hsotg *hsotg)
>  {
>         struct dwc2_core_params *p = &hsotg->params;
> +       struct device_node *np = hsotg->dev->of_node;
>
>         p->otg_cap = DWC2_CAP_PARAM_NO_HNP_SRP_CAPABLE;
> -       p->activate_stm_id_vb_detection = true;
> +       p->activate_stm_id_vb_detection =
> +               !of_property_read_bool(np, "usb-role-switch");
the rest of params.c uses device_property_read_* instead of of_read_property_*
I thought I'd mention it so you can decide yourself whether this is
fine or needs to be changed


Martin
