Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D9B2FC568
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 01:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392887AbhASNv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 08:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392501AbhASNpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:45:55 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0753C061796
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 05:43:43 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id r24so11059669vsg.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 05:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwifCSX45KhsvY2iJTL0WhKEp/VAHjvt7PynTrJUsDk=;
        b=gXiQ9xYsNg2rnEMj13umiSHP/tkUj27IExlmJW/qZx9JksExVXRsHUCGfoxnZWGyJJ
         SKWAYjFK9DPjcoXXlgUEs9WTuRdGa/03tT/483PmfSPDxQJ6dbN225oN1DNdAsKB4uVH
         /k4QpdhAfSSJQD8AYQSXb4pAQ5AY/AttZgTO5QjFveSHjxZ/B5NE8/kqGaMUNJuhjUso
         UVVEF6SGqB27rWUHyjL+go4wPes6yO13Jlix6AX3TxAcQZ1ygsyq8wN3TPS6FHceaYle
         pc4Kou13auHkqOan07St4EEvFaNXTJ0vIIPjfYz00ZFryUzmj1jtISPyqDlyxslZdlVU
         SQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwifCSX45KhsvY2iJTL0WhKEp/VAHjvt7PynTrJUsDk=;
        b=iguz85oRtpaXl/y3JzdqCb8lOH9cMVNMC+HKfdj98bec3fMhyYGqe/VwQ8P67/Nwxz
         BzCm0j/V3QeoOwWrvMM3SYnOkXxNY2bbGSC2sQtuC+UBGEJxHt45ZoiMWN5RvJ+72OxA
         HjTmWDri3JppXF0G+nu5H4gkoO7NLPQ/MlsKJLgm53dvcOTWHBekhtQLlgtVdFsO3WAA
         mPiEcAGFJTqJHOfnJhqIFI6AFz6dhywzsnVXsfvXYmkoCpR0Kj4yYEknYRGQaCWxssMA
         UvSdtA9kWZd+gQfRRKUumxdM29vbn46L8a8/hFycwonmbBQdRO+FKpSYw5Tk0SiLlv/R
         T/4w==
X-Gm-Message-State: AOAM533o6k/6MNMOfWbIpqz6gRFdYEilZxK2tqsPzn6GDr9t7f2zxdxD
        6pOyhZxD+NGqjcU1T6241kxcQi8yVm2VfPzCSz+l4g==
X-Google-Smtp-Source: ABdhPJyNZwiCneblhx3D9rnVa5WXxr7vgezCM4SQABvJl8PA3qInPMT4IDEoPvGCeZB1In3tRQZbqkcIIA+453oN+aY=
X-Received: by 2002:a67:f997:: with SMTP id b23mr2484759vsq.34.1611063823059;
 Tue, 19 Jan 2021 05:43:43 -0800 (PST)
MIME-Version: 1.0
References: <20210115193218.5809-1-grygorii.strashko@ti.com>
In-Reply-To: <20210115193218.5809-1-grygorii.strashko@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Jan 2021 14:43:06 +0100
Message-ID: <CAPDyKFp3K7G_36vB5BrMjhLgCD99xi4tL9sHGaunTGm+AqYeNw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-am654: fix compatible for j7200
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>, Nishanth Menon <nm@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 at 20:32, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
>
> On TI J7200 SoC the SDHCI controller compatible defined as
>  "ti,j7200-sdhci-8bit", "ti,j721e-sdhci-8bit"
>  or
>  "ti,j7200-sdhci-4bit", "ti,j721e-sdhci-4bit"
> which causes dtbs_check warnings:
> mmc@4f80000: compatible: ['ti,j7200-sdhci-8bit', 'ti,j721e-sdhci-8bit'] is too long
> mmc@4f80000: compatible: Additional items are not allowed ('ti,j721e-sdhci-8bit' was unexpected)
> mmc@4fb0000: compatible:0: 'ti,j7200-sdhci-4bit' is not one of ['ti,am654-sdhci-5.1', 'ti,j721e-sdhci-8bit',
>  'ti,j721e-sdhci-4bit', 'ti,j7200-sdhci-8bit', 'ti,j721e-sdhci-4bit', 'ti,am64-sdhci-8bit', 'ti,am64-sdhci-4bit']
> mmc@4fb0000: compatible: ['ti,j7200-sdhci-4bit', 'ti,j721e-sdhci-4bit'] is too long
> mmc@4fb0000: compatible: Additional items are not allowed ('ti,j721e-sdhci-4bit' was unexpected)
>
> Fix it by adding missing compatible strings and their combinations.
>
> Fixes: 407d0c2cdd12 ("dt-bindings: mmc: sdhci-am654: Convert sdhci-am654 controller documentation to json schema")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/sdhci-am654.yaml  | 21 ++++++++++++-------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> index 34e53db29428..3a79e39253d2 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> @@ -15,14 +15,19 @@ allOf:
>
>  properties:
>    compatible:
> -    enum:
> -      - ti,am654-sdhci-5.1
> -      - ti,j721e-sdhci-8bit
> -      - ti,j721e-sdhci-4bit
> -      - ti,j7200-sdhci-8bit
> -      - ti,j721e-sdhci-4bit
> -      - ti,am64-sdhci-8bit
> -      - ti,am64-sdhci-4bit
> +    oneOf:
> +      - const: ti,am654-sdhci-5.1
> +      - const: ti,j721e-sdhci-8bit
> +      - const: ti,j721e-sdhci-4bit
> +      - const: ti,j721e-sdhci-4bit
> +      - const: ti,am64-sdhci-8bit
> +      - const: ti,am64-sdhci-4bit
> +      - items:
> +          - const: ti,j7200-sdhci-8bit
> +          - const: ti,j721e-sdhci-8bit
> +      - items:
> +          - const: ti,j7200-sdhci-4bit
> +          - const: ti,j721e-sdhci-4bit
>
>    reg:
>      maxItems: 2
> --
> 2.17.1
>
