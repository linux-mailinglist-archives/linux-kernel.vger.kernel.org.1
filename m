Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C23F2DAEAE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgLOOOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgLOOOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:14:10 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE65BC0617A7;
        Tue, 15 Dec 2020 06:13:29 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id r5so21134665eda.12;
        Tue, 15 Dec 2020 06:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJYSjx8moRh9VFGJMpbfz9SoxxxRTBulQgPkLgClyoQ=;
        b=gKkDnioL4mB09Jcb2ubVk7FW0XEFNq0bRPUHe0X020/PSIVQs/kXcbe5sC2CAqctcQ
         JNV2u31v75fMYDVcPsICIzBOXGMSTnKtjXLKyOGivvwlpGKXLogS79gi+StO866amoID
         u3pn4ayXHSe92UCI0zfcrg95p7wS5D/aXinVn3F+3vQWJg/Q1Qsi1cpN7+KcV/cdlV1q
         8IWqUPMzhiHEqUAxG7A71BbtBYe+EFATmqalbTKqZ4Mme4j/Ks17amilCzxZAkYh9bkG
         rcmv74l8hvhGFjfs50JHjHE5oFO3+N5OAJc2XPrgCQMt9dpZd1XyxMLgjmjtA35MG9Gc
         XorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJYSjx8moRh9VFGJMpbfz9SoxxxRTBulQgPkLgClyoQ=;
        b=P5iDzGuf48hrIQ+YA92/ilWYqzWjBFkqY9DvKp4ewi2OJgN31cluH3Lceu9Qx7svmf
         /GDLyJoBatShm5/sHWzhmtLp5cZvloOv3zjeoO+7B6bMK/KRWzJgN1mrE0SP4dw0vrCn
         uO1iqUyETmOdUQ2EJmO31SMWwQNoSOD1Y+c6d7hNy1PL0cU+mAenx3w7Kn2FyJX77Pm9
         Wj8tthgPoWyOV2ztSK1/uRxq4t+M4Urm4V/3t3ALK13q8Opy/KW1cIpchV5z0opmyg08
         WZCTyAUTCrbh06MBypGRGazf9exbWcHfr7wsKO5klCZIdE3ZQWhS19VDWjbpuI6+5/OT
         UDMA==
X-Gm-Message-State: AOAM532EoHqAx3FHGfDcD1pID5CU67Nv9FKivGFYOD8Qyn7UYxQrYO2A
        jiWbfTInzCbTMK0NBUJcAVUF0OGTkRpgXV+SgER+cdBuLthegg==
X-Google-Smtp-Source: ABdhPJzM115PkKKUs4/mpIyUWyvmmILF+Y6Y7uxFpH7K51vgdsYhdly3ZL/p7FmwavBknIcM/id0h1DX2NYkBYC8bg0=
X-Received: by 2002:aa7:cf8f:: with SMTP id z15mr29724056edx.17.1608041608598;
 Tue, 15 Dec 2020 06:13:28 -0800 (PST)
MIME-Version: 1.0
References: <1595180527-11320-8-git-send-email-amittomer25@gmail.com> <1599802143-6218-1-git-send-email-amittomer25@gmail.com>
In-Reply-To: <1599802143-6218-1-git-send-email-amittomer25@gmail.com>
From:   Amit Tomer <amittomer25@gmail.com>
Date:   Tue, 15 Dec 2020 19:42:52 +0530
Message-ID: <CABHD4K_3huTchnJC9ZHK==25ePh6TOb8FgYGvWpievcwTaaWYQ@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] dt-bindings: reset: s700: Add binding constants
 for mmc
To:     Andre Przywara <andre.przywara@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, sboyd@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen ,

Could you please help get this merged ?

Thanks
-Amit

On Fri, Sep 11, 2020 at 10:59 AM Amit Singh Tomar <amittomer25@gmail.com> wrote:
>
> This commit adds device tree binding reset constants for mmc controller
> present on Actions S700 Soc.
>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
> ---
> Changes since v6:
>         * No change.
> Changes since v5:
>         * Added Mani's Reviewed-by: tag.
> Changes since v4:
>         * No change.
> Changes since v3:
>         * No change.
> Changes since v2:
>         * No change.
> Changes since v1:
>         * No change.
> Changes since RFC:
>         * added Rob's acked-by tag
> ---
>  include/dt-bindings/reset/actions,s700-reset.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/dt-bindings/reset/actions,s700-reset.h b/include/dt-bindings/reset/actions,s700-reset.h
> index 5e3b16b8ef53..a3118de6d7aa 100644
> --- a/include/dt-bindings/reset/actions,s700-reset.h
> +++ b/include/dt-bindings/reset/actions,s700-reset.h
> @@ -30,5 +30,8 @@
>  #define RESET_UART4                            20
>  #define RESET_UART5                            21
>  #define RESET_UART6                            22
> +#define RESET_SD0                              23
> +#define RESET_SD1                              24
> +#define RESET_SD2                              25
>
>  #endif /* __DT_BINDINGS_ACTIONS_S700_RESET_H */
> --
> 2.7.4
>
