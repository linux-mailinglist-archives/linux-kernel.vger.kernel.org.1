Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486422CEFDC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 15:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388022AbgLDOkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 09:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387781AbgLDOkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 09:40:18 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3ADC08ED7E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 06:39:06 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id l11so7974781lfg.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 06:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gCvgf9SsePfgxYMuD1WNMKjq/viyendYVg7MdniZolA=;
        b=VeTyCc9cXxNLbp1W4GPY73r1xI0NKKLDr84XjBcpHqLokqbvULGt9MwbbkPly0tSu6
         29+65aa8KGh0MGS5C+EZdKq33GMRLQKua8u3yLZAKNEUGogjVYeHaaSfAfWN6h1aRUqh
         lG6q4IIMR//hI1DZKGIvDJXWtYDBhq5fAxvENZVaFRFzWpuHGK7ce6beir0KJuXcEJ90
         YwSI4aZJpkdQ41QXopHfLQGWz1c3Il9UrRXfmaPSbfsizkF9AxPz7dEPHon37TaJ4K2v
         dnLkWZpWyLGYC4OhbPg5YfQ7SvGXZxL3dhbd5IfoW3LbjOAnwoQWv+UmcTcJu+RnrprB
         m5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCvgf9SsePfgxYMuD1WNMKjq/viyendYVg7MdniZolA=;
        b=ksj2FakwzP1d6UaYQdxllj7iVvyT3+87BhWcLa8HlJ4ZYuj5R8Zaa1z9+Dqy6qw4Zb
         ptivzylpw146JYRDv9rvm5BgiQIdMgnMnQAFsX2Jxlggj98ko/gQd7ZLeSA6VWSmwQuU
         KFZbwE2kRH9hMOm3dsuznFRAVbgZpQv4geFEXrC4m2G3OfYsXycWkK7VMsByo1fXd9Tu
         D/R831RrUuOFBVIhzxBrgfo43BABdISW48z60W225RN3TJefrJYTmchzOAe6y5gW3wil
         V8boByDCVH1k7r3mitI77vh/kegzy4uAf55ddOg8cKSRdFMXjMHMT6mcAy96SRG1rXBd
         sFyA==
X-Gm-Message-State: AOAM5327gO0uzumpX5QWOJc1fTGu075TFtCvPyCHdHuxeMoW5u13DSTV
        QV6L2/9I0L8lbiSOfWz3R5bfWq7QDWJAEAGv3si3Nw==
X-Google-Smtp-Source: ABdhPJyXme2sn852/oSVQ2LSWRFUTlW9YLFL6WModQ4nu/BipCDYdbPjNCrjJI2L4cpLI/5sXGDNK7CadH2SUm1+x7I=
X-Received: by 2002:ac2:498e:: with SMTP id f14mr3229359lfl.59.1607092745405;
 Fri, 04 Dec 2020 06:39:05 -0800 (PST)
MIME-Version: 1.0
References: <5fa17dfe4b42abefd84b4cbb7b8bcd4d31398f40.1606914986.git.michal.simek@xilinx.com>
In-Reply-To: <5fa17dfe4b42abefd84b4cbb7b8bcd4d31398f40.1606914986.git.michal.simek@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Dec 2020 15:38:17 +0100
Message-ID: <CAPDyKFqTqKeV0kjqddQVQkdJg4iu04Yq+aT=4A6_bVxMZzwYeg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Fix xlnx,mio-bank property values for
 arasan driver
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 at 14:16, Michal Simek <michal.simek@xilinx.com> wrote:
>
> Xilinx ZynqMP has 3 mio banks and all of them are valid. That's why also
> list the first one which is missing. Property is enumeration not range.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> index 58fe9d02a781..8958e54e522d 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> @@ -147,7 +147,7 @@ properties:
>
>    xlnx,mio-bank:
>      $ref: /schemas/types.yaml#/definitions/uint32
> -    enum: [0, 2]
> +    enum: [0, 1, 2]
>      default: 0
>      description:
>        The MIO bank number in which the command and data lines are configured.
> --
> 2.29.2
>
