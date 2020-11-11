Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9FE2AF9BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 21:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgKKU13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 15:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgKKU13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 15:27:29 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E045C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 12:27:27 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id j205so4996791lfj.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 12:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XZmfGtRxDCHjyRL+yjTXA76PNCz6+Ohv5RBOW8kx/ik=;
        b=J2QS6vF6KKwZh4DdstPZSqvzJvRRUIk8iVfGCsPw4jmnYcBPof34if+fp8wU5qgR7n
         B1leiB+GaLRtBXWU+GMGB4LOOPcERIWw/4E18CQsRifKX+czjCE9LXUtbx6UxqMkfc/s
         lzhrRkfjQ7jh/E9cz8yA4GHeHKUvi8+wtaihCxo1DFPy6dm3ObF1miQgSDRuv87NO11q
         0+HcFmj081oow/sG1YDFgyKAesZxfRcP3o2lwWVlMggcl+IZT15+XC29Og8JXosTV6Ye
         RGai6aq028QDpT9md1yj1skwVU8cf458KwIDgxgCG4Zg5JfifqKcRcnNkJg3gburtx80
         JdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XZmfGtRxDCHjyRL+yjTXA76PNCz6+Ohv5RBOW8kx/ik=;
        b=NF3Syr2ihK0NPKxCOVhtAEs/uFxm4Tpz5T3a79nYsk4ji6Yub6bURNdIumvrrGRZ/g
         2mLFp5MpaE5NE4OMs3YC2+Q5BLbR9AO/uN74MecXTBxwT/xTYxyAvavZ0wX3s9E//h+P
         cIsj2g45CC5xlu1kPds7cdjVyDAC4vBScyR6TCYQ71BlAIlFvgeArXhcnNmXp0GtQuan
         qRr1HgtbRGuQqMrqSKUjNgV6pEtvi315WWXjxlUW+rQWzwVdIw7mG0RTagAii88E3FVA
         Ip0W5Owj1+4cytjFAI0Hf8T7vvQGdqXJlgWpZAbRJ9DWGpJGefe1hBkKkfBDLo8ccAhx
         Q5XA==
X-Gm-Message-State: AOAM532MKFN+MMeUHzH5p+pMnpe0R01BRMjidpgNIwRiHqS5yvhZRumb
        828BRScQ59WTNkEXv8XVQ8QIYA==
X-Google-Smtp-Source: ABdhPJzUMfSbw17UCSxKUFEJXL+AvwOT7GJ0qJj0qC6GzgA1i8WaodOoYPI9Jo3JuQq7OFnETXZHAQ==
X-Received: by 2002:a19:cc16:: with SMTP id c22mr2872720lfg.75.1605126446071;
        Wed, 11 Nov 2020 12:27:26 -0800 (PST)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id k2sm331639lfm.20.2020.11.11.12.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:27:24 -0800 (PST)
Date:   Wed, 11 Nov 2020 21:27:24 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] dt-bindings: timer: renesas: tmu: Document
 r8a774e1 and
Message-ID: <20201111202724.GB667473@oden.dyn.berto.se>
References: <20201110162014.3290109-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201110162014.3290109-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thanks for your work.

On 2020-11-10 17:20:12 +0100, Geert Uytterhoeven wrote:
> 	Hi Daniel, Thomas,
> 
> This patch series picks up missing Device Tree binding updates for the
> Renesas Timer Unit (TMU), and converts the bindings to json-schema.
> 
> Thanks for applying!

For the whole series,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> 
> Geert Uytterhoeven (1):
>   dt-bindings: timer: renesas: tmu: Convert to json-schema
> 
> Marian-Cristian Rotariu (1):
>   dt-bindings: timer: renesas: tmu: Document r8a774e1 bindings
> 
>  .../devicetree/bindings/timer/renesas,tmu.txt | 49 ---------
>  .../bindings/timer/renesas,tmu.yaml           | 99 +++++++++++++++++++
>  2 files changed, 99 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/renesas,tmu.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/renesas,tmu.yaml
> 
> -- 
> 2.25.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds

-- 
Regards,
Niklas Söderlund
