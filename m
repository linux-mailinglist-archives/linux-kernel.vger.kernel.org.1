Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601A82DB598
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 22:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgLOVHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 16:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbgLOVHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 16:07:48 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0955EC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 13:07:08 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id qw4so29674168ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 13:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5oyP6mvBrvE3aEYFhLfs2RYWHj0K8mQLLM6Luko/efo=;
        b=del9jE5SOnMZt6v3+c7d+G/TxIN3JzQQaLdEu/P/mWpV1LqwThTlFgRGPPh7HyeAVH
         JDrbSeo5jQNYKIxUcBS4lME2fzO1FieKxP/gopAy3MPqExnhHza1QJHU/LbujshLUV03
         tLIUVYkyVUb2qUN09S38om1HeQMcNu+KdL8Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5oyP6mvBrvE3aEYFhLfs2RYWHj0K8mQLLM6Luko/efo=;
        b=KtggqaEWky2owG/0ko890SCAMVMq1gLq5c5Lbrc4byduyn2HcR8mxOJw9fijS90eQW
         DTQl5gy5YFPQlTm/cL7Wzp22jskLU9UsQ+9hpFuMsM4/66QWz8YGxyH5DNNZsZO6LudJ
         03RCnBpKobe1+E80h+rvUOlQ+Tzm0pAXsmVjhTcB+tJvMX8uCU/7Unrp1m2sqRYY6r5B
         aL9q1SddHQK8G4Sm2U8eM93qsMQIQ2AxpOMK1OdbZORe6YFdaoIIVYFHB1Sf/Cm5dgFN
         HAdG1XrBkNs724inmgM0NhCV4m3RCRsr37E6hrr1KKzt3j1QgNi3uTJHKVSsxC7BXTWv
         G9EA==
X-Gm-Message-State: AOAM533d3cJmf/zxWSXEFjXqMk2KgqmrjkqploguEe9GSh35WDmFsahZ
        g4dplMvQol8jCIOpWt7+1XDK5/MthlbPfjhPZiPjoA==
X-Google-Smtp-Source: ABdhPJzWwlcPoqKhjHTrI6zoBOxh/CVBgBRXg6QTI1801GgWXVReiXUxUyJ9HY6W6Y/LCE22kPBK9M045rauq7GzpII=
X-Received: by 2002:a17:906:4ec7:: with SMTP id i7mr6677702ejv.252.1608066426798;
 Tue, 15 Dec 2020 13:07:06 -0800 (PST)
MIME-Version: 1.0
References: <20201215204858.8186-1-adrien.grassein@gmail.com> <20201215204858.8186-4-adrien.grassein@gmail.com>
In-Reply-To: <20201215204858.8186-4-adrien.grassein@gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 16 Dec 2020 02:36:54 +0530
Message-ID: <CAMty3ZD2WsFeuCnt4DEL87Ou-sxHPYiBVu1n-LoK2gEzgO3XwQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] regulator: dt-bindings: pf8x00: fix nxp,phase-shift doc
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Troy Kisky <troy.kisky@boundarydevices.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 2:19 AM Adrien Grassein
<adrien.grassein@gmail.com> wrote:
>
> nxp,phase-shift is an enum so use enum format to describe it.
> Minimum and maximum values are also wrong.
>
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../bindings/regulator/nxp,pf8x00-regulator.yaml | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> index 913532d0532e..1da724c6e2ba 100644
> --- a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> @@ -60,21 +60,13 @@ properties:
>
>            nxp,phase-shift:
>              $ref: "/schemas/types.yaml#/definitions/uint32"
> -            minimum: 45
> -            maximum: 0
> +            minimum: 0
> +            maximum: 315
> +            default: 0
> +            enum: [ 0, 45, 90, 135, 180, 225, 270, 315 ]

Do you mean 0 is the minimum or starting value? I can see Table 48.
SWx phase configuration with minimum and maximum values are starting
from 45, 90, 135, 180, 225, 270, 315, 0 with phase bits as 0x0 to 0x7

Jagan.
