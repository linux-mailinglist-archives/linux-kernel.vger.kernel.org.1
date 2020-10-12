Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90D728AEFD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgJLHYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:24:37 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44688 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgJLHYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:24:37 -0400
Received: by mail-oi1-f195.google.com with SMTP id x62so17762349oix.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 00:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RXMZC6BcTZzfv1Fuk35nRT3JTEf+0mhCLiGzuphZHl8=;
        b=kwJf6Whneco4mcvcLYCO2L49C4wo6Zm76XtlQ98uFRaqU8boFLY3V4G18arPlgdMhQ
         Fbsj8foPebOa/lqQQAa4SVHofuJPV3dOl1B1fXZoMKqBEoF8LVmxtqHg/OvxGobvGRjs
         Z2IOp992wKnQhmyQToITSsYbO7qin8WFY3zbD4eXMgqd6Jyp2uoJon0s288u0ldmUKLI
         Zx+oqvjhSd2rth24P1KzHfI+nfJ/biVmCSxJ1hJV27yWsOQRskDahV+PYQ/LeNtHuPVJ
         gncUiwmb5q8DO7FBTtKe6z9CLVps4f3Pq7tU8wsz5H8lMmV4qRyQcroAj8XRQWDbNXN3
         3/SA==
X-Gm-Message-State: AOAM5329CVgR2uOiSksc54yiSZ6eVmtQ1bBcq7G3FN5BHu7AvqeMSlqI
        zfzVhW8cW+k2SdMFb0z5SDjTwomjdYPX/xj4pjuxWTfnuL0=
X-Google-Smtp-Source: ABdhPJwitkepHUiETgcL671cEpg5zhwJIgCG6qbyIy3aQPsn9a6bt8xSHwdL2+9noceeeLoQoJhwQ6XPRKZx7vgr3fI=
X-Received: by 2002:aca:c490:: with SMTP id u138mr10014122oif.54.1602487476220;
 Mon, 12 Oct 2020 00:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201012072114.5245-1-geert@linux-m68k.org>
In-Reply-To: <20201012072114.5245-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Oct 2020 09:24:25 +0200
Message-ID: <CAMuHMdU_RtEsoRy0Accb99uiTTb4Y_z1iDAg4yijNtDZA9ZoNw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.9
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-um <linux-um@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 9:22 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.9[1] to v5.9-rc8[3], the summaries are:
>   - build errors: +6/-3
>   - build warnings: +5/-0

  + error: modpost: "devm_ioremap"
[drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
  + error: modpost: "devm_ioremap_resource"
[drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!:  => N/A
  + error: modpost: "devm_of_iomap"
[drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
  + error: modpost: "devm_platform_ioremap_resource"
[drivers/iio/adc/adi-axi-adc.ko] undefined!:  => N/A
  + error: modpost: "devm_platform_ioremap_resource"
[drivers/ptp/ptp_ines.ko] undefined!:  => N/A
  + error: modpost: "devm_platform_ioremap_resource_byname"
[drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A

um-all{mod,yes}config

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bbf5c979011a099af5dc76498918ed7df445635b/ (all 192 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/549738f15da0e5a00275977623be199fbbf7df50/ (all 192 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
