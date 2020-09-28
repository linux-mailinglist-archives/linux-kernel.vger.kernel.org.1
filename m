Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4400027ABE1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgI1Ket (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgI1Ket (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:34:49 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1DAC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:34:49 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id y194so449794vsc.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p/sgL+aVEw/SbZ7i/2yif0Mub+iXCt2c2zPIclUv0qk=;
        b=pHDNOTkK1V7ca9x0HKlzzq7pTSg/H+aIf186Cy8a0f/OeqSTQisEsUoFTZFQhy8qaN
         hBY4X2zGeUwYIR2E5Cj/2M68DO2sMFKEGIHeWKhD7wfWp0zY7leR2lP+TWHyYViqFZWV
         Mm6bFrDETuVmMuOFIWPwsjhx4bVxft1StvyLtv2iM3kaD7M7LFf5IolffmtQuipfZbPq
         PsmdHoDYKOgGdXjMIW7bX/5p0Pkl9yKASW6UDyDxWVq+wT//9Ji9VgExVuKFXTXhqALI
         sGC2YqCXzhh7GzIOGWYIO+yrs1RGYsKI+C27TMEdCh3v4AkbKvXUhuTlbyMauL9AGbNj
         +J+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p/sgL+aVEw/SbZ7i/2yif0Mub+iXCt2c2zPIclUv0qk=;
        b=ZJNDUW9Y4xejIJ6mPS2549ilSgIHkaODotG+bVObarQ1LF6afF7P+LcgogU0T6Ea21
         VSExYhqK4ocmwZmMgM6MlZ/eC9sw0ewIIsr0yn2B7luxUvHDXIe3VBkt1hj6EAEsf90E
         qD+qhzVeBg+PpMYR0rLd7pcHRepU4r60ypm8Jiw8+DPpIspZZB6RwFF+4yeNg4PMQwhO
         Wu5cF+41VlJFa3M64Ovs9JoZgo/nYI2pscLrNyGIGBn/s0vsZd9mP6rkA6l0fA6Jw7Dw
         +r3kc4nwltsO2r2EAEICCkSWI/qULQdFAqmW9d1pxYJCmVl8h4ZTKgNsN6mVLFT9nfDW
         lf2A==
X-Gm-Message-State: AOAM530MchZN5wc6H55VzDxwfL+K7x9/ZrSpJff7b7VR2zRY8kHk7VX3
        Sjl6fRcVKL8n9JTkzvYAGKCJBq+dwG8H1bGwZIVZDg==
X-Google-Smtp-Source: ABdhPJxuAjx5AuVcbdnorA4qOfcmMQqNHWaWA1DejDLS3W+8Ah0RTXq4Hmd0ByQifEVKjqvCSAPHhrY945U8oc6S7xI=
X-Received: by 2002:a67:3009:: with SMTP id w9mr5225484vsw.19.1601289288436;
 Mon, 28 Sep 2020 03:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200923105206.7988-1-faiz_abbas@ti.com>
In-Reply-To: <20200923105206.7988-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Sep 2020 12:34:12 +0200
Message-ID: <CAPDyKFpC4dU2gqN+e=zoZXxBB7Ao-4x0gCHcjCWsJiPcyO5cog@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add UHS mode support for TI's AM65x, J721e, J7200 boards
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>, Kishon <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Sep 2020 at 12:52, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> The following are driver and documentation patches to enable UHS modes for
> TI's AM65x, J721e, and J7200 boards. Device tree and defconfig patches
> will be sent in a separate series.
>
> With the complete set, the following maximum modes will be supported:
>
> am654x-evm,idk          - SDR104, HS200
> j721e-common-proc-board - DDR50, HS200
> j7200-common-proc-board - DDR50, HS200
>
> These patches mainly add support for the software tuning algorithm[1]
> needed for higher speed modes
>
> [1] [1] https://www.ti.com/lit/pdf/spract9
>
> Faiz Abbas (6):
>   dt-bindings: mmc: sdhci-am654: Convert sdhci-am654 controller
>     documentation to json schema
>   dt-bindings: mmc: sdhci-am654: Add documentation for input tap delay
>   mmc: sdhci_am654: Fix hard coded otap delay array size
>   mmc: sdhci_am654: Add support for input tap delay
>   mmc: sdhci_am654: Add support for software tuning
>   mmc: sdhci_am654: Enable tuning for SDR50
>
>  .../devicetree/bindings/mmc/sdhci-am654.txt   |  65 ------
>  .../devicetree/bindings/mmc/sdhci-am654.yaml  | 218 ++++++++++++++++++
>  drivers/mmc/host/sdhci_am654.c                | 179 ++++++++++----
>  3 files changed, 358 insertions(+), 104 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
>
> --
> 2.17.1
>

Applied for next, thanks!

Kind regards
Uffe
