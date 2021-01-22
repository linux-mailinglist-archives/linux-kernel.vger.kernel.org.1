Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF0D300565
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 15:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbhAVO2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 09:28:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728567AbhAVOXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:23:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0482A23B77;
        Fri, 22 Jan 2021 14:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611325021;
        bh=EdgThWKuEJVBx6lw9RiAM+60bMd/eseSJsce1dNI5Tc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KRKLwOHYIVsR7XuLTVTpQD7208q8McTaMEHkdKBDP63/aJoS48i2dvRErmWsBkch7
         zrsL96vBZ5dNlQlNFXvoY6luLbOA9aEsD5ah5gaBsv04QGJA6coJ/GCFf9btjeH/Aj
         yRok8twcjtNQ28J1J1YD32IY9nlMMlMOk+bxu85NzuZP+FaAWpg9pyx3lkijj9GPXz
         8Kgw9NByP+HNr8elkMY745STYsiYWNF/C7uYFy0aHTGy9U40vCBjhj1I5dC9On7n2Y
         ASR6wgwz72SB9qjb2Z2EfucRRhVjXHjqVtVoTnVmBsw8OlAgoxF1vGGiPDMndlTN09
         IQcJL5T5rKFxw==
Received: by mail-ej1-f43.google.com with SMTP id hs11so7892068ejc.1;
        Fri, 22 Jan 2021 06:17:00 -0800 (PST)
X-Gm-Message-State: AOAM533VUz1TNLPRcOz9XImMLLaSQxW9jJLQq2TBCaVlsBaLnf10HVmL
        nmjBmcDd5vfB1k2nHJIHeKDZyJhVgvHwhYE63g==
X-Google-Smtp-Source: ABdhPJyi+FdecRS65MOWvr18vvimJ4MGPuhOEb2VgQQcPu72/6AkpAPIOPYRBYirdMn66EiWCscPvbwrtWPtCjnGMdU=
X-Received: by 2002:a17:907:968e:: with SMTP id hd14mr2074447ejc.108.1611325019650;
 Fri, 22 Jan 2021 06:16:59 -0800 (PST)
MIME-Version: 1.0
References: <1611318097-8970-1-git-send-email-claudiu.beznea@microchip.com> <1611318097-8970-2-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1611318097-8970-2-git-send-email-claudiu.beznea@microchip.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 22 Jan 2021 08:16:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKjpMkMyzydpchWdbSRSo9vnvKRu5hg+Uc9Hm9hwB4VPQ@mail.gmail.com>
Message-ID: <CAL_JsqKjpMkMyzydpchWdbSRSo9vnvKRu5hg+Uc9Hm9hwB4VPQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] drivers: soc: atmel: add spdx licence identifier
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 6:21 AM Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:
>
> Add SPDX-Licence-Identifier.

License

>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/soc/atmel/soc.c | 1 +
>  drivers/soc/atmel/soc.h | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
> index 728d461ad6d6..1a6cb4bc7d67 100644
> --- a/drivers/soc/atmel/soc.c
> +++ b/drivers/soc/atmel/soc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Kernel sources are generally GPL-2.0-only and that was the default.
The commit should note the relicensing and why that is okay (if it
is).

Rob
