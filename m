Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B664277181
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgIXMuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgIXMuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:50:02 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D7DC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:50:02 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id q13so872126vkd.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KaaVSqIcUUBv4jvMI8tMeec1SHmQSUxYkPa73n8pOFs=;
        b=LYpjW38Lm7yYMUQARmzvP4jZII2YOPICEWNqxpkg/j/+CiIyRuZbhZc44cfVyIMpG0
         QknnZM1f28fIp21NKvF72ieUOW/cKIUxkzUZMeBjoUdHc0eYdAS13YmTZzLeLiJ7SSDI
         NFoPIkMUOUjltzmHnW62ey04HZkaVL1xAI3Yt+EorwTnfWGkIHvOD0VN2+i4Y+np2TyE
         g4glGPmSU7vPxqvwVjQnMyTU4yNOHJMP3F52kAhg2++QyunlrnZ9l5JcL1y/wu5oYoAh
         aQLyBUU2ZKNYfGmd0MxMTQ33qKSur5pc26h3GH1Obwr57cgzeDcJ48rUejH8X8CjFYRh
         qnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KaaVSqIcUUBv4jvMI8tMeec1SHmQSUxYkPa73n8pOFs=;
        b=D6bJQzsswWlaN6ju7/+u73p6QWytjnBCDUNoUNmYlB1e7TC3AYAmnMdbac4LBfGny8
         cSXffkUZLQkgZ0ydAr6gnEqb0eOzupujYKFRyIV/WmCZwBOtSK41s6AMUn/0IEOY44hu
         IWktslGeM4gJD8o8dx6x9QOkW0uboanSgeUMi28/9//CylBRTZQZKWAPKKbPjbuCejRi
         ncXvfpwNUo53hGFZOsxa+34cLxsRgjBpXVae18Du7wqt62RvQGcb2AJKCbpiaIHFkZt7
         i0blkUMp0S29yI+KgXD1y1ONWL24YAAjsez4+KnOi8shsggQKu2ajN2Wt9TWNemmeeqQ
         XLNQ==
X-Gm-Message-State: AOAM530RAx7XHXovpsr1mPIof5iJWGHfVP2SicFjtoXn9OKzlblKt1C2
        lK5yf0qoyaln//9kmZe87bnVCavJLAJOFHeIwx4gqw==
X-Google-Smtp-Source: ABdhPJy1LDyctw9RvbkrcO1XdBDR5rhMeMLQfTrM0BkDMB80+y0l94D8B42YO9htgFE4ZBZaFx7srVi76jbfPMyiNok=
X-Received: by 2002:a1f:964c:: with SMTP id y73mr3613270vkd.8.1600951801042;
 Thu, 24 Sep 2020 05:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <1595180527-11320-9-git-send-email-amittomer25@gmail.com> <1599801849-6071-1-git-send-email-amittomer25@gmail.com>
In-Reply-To: <1599801849-6071-1-git-send-email-amittomer25@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Sep 2020 14:49:23 +0200
Message-ID: <CAPDyKFoCRJrABJ=Ciki4E7Rr0eaE9wCRne3G8AtEdG8o-AmsBA@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] dt-bindings: mmc: owl: add compatible string actions,s700-mmc
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        cristian.ciocaltea@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Sep 2020 at 07:24, Amit Singh Tomar <amittomer25@gmail.com> wrote:
>
> The commit adds a new SoC specific compatible string "actions,s700-mmc"
> in combination with more generic string "actions,owl-mmc".
>
> Placement order of these strings should abide by the principle of
> "from most specific to most general".
>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


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
>         * Added Rob's Reviewed-by tag
> ---
>  Documentation/devicetree/bindings/mmc/owl-mmc.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> index 1380501fb8f0..5eab25ccf7ae 100644
> --- a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> @@ -14,7 +14,11 @@ maintainers:
>
>  properties:
>    compatible:
> -    const: actions,owl-mmc
> +    oneOf:
> +      - const: actions,owl-mmc
> +      - items:
> +          - const: actions,s700-mmc
> +          - const: actions,owl-mmc
>
>    reg:
>      maxItems: 1
> --
> 2.7.4
>
