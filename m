Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9735285439
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 23:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgJFV4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 17:56:37 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44665 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgJFV4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 17:56:37 -0400
Received: by mail-oi1-f195.google.com with SMTP id x62so199730oix.11;
        Tue, 06 Oct 2020 14:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bglMfaGCPZoIC769u/qzkj7/UCSVgyZAU0TAtaZX0ic=;
        b=PNxfwSJtWr5vChKNJuvYikUsxqK5Ma37JsRjlu9J9xy1g+LgVEEUEI989etqgyUqZZ
         JXM5Nk4PMj9OkMa0iX812rTxnGMVALtABkvFZ0tyGqPd+wfIMOJAnGrojtXD7GdD2lLe
         tehy732F/wVD9ndnCnngMuYRMMYqiYaok4lSu0m6zn6HKkcCA0ejxy84zseaB/nTZC1K
         OzuiW9nDEToZtS93WM856E/lniyozCNztCjHcBTpLwUB+mrHyd8RAq3tiRplE4TpKNnL
         59rcsbI2vUXVYshKZLYreoP3EHqvFuR9gJG2P6pWP2Ekrt57KAOcBMgxdN4D5GfiDYXA
         d0wQ==
X-Gm-Message-State: AOAM5331E+SfkXqwd7jVp+uS4sPvSkmcEn9mth187kqqbOwXJZPOgLQx
        EiyCPeR8ab9UTTCx+17wPg==
X-Google-Smtp-Source: ABdhPJw9X+yy5sd6g0SoJzD18HZAK6goRNyUoFypAxbzPgCKrSy5wep/PHIMRmMtvq9FD8Ds5sYzUg==
X-Received: by 2002:a05:6808:b24:: with SMTP id t4mr194181oij.93.1602021396142;
        Tue, 06 Oct 2020 14:56:36 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m15sm187545ooj.10.2020.10.06.14.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 14:56:35 -0700 (PDT)
Received: (nullmailer pid 2920605 invoked by uid 1000);
        Tue, 06 Oct 2020 21:56:34 -0000
Date:   Tue, 6 Oct 2020 16:56:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     poeschel@lemonage.de
Cc:     Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        allen <allen.chen@ite.com.tw>, Lubomir Rintel <lkundrak@v3.sk>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Willy Tarreau <w@1wt.eu>, Daniel Palmer <daniel@0x0f.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 31/32] auxdisplay: lcd2s DT binding doc
Message-ID: <20201006215634.GA2920548@bogus>
References: <20201005130128.3430804-1-poeschel@lemonage.de>
 <20201005130128.3430804-19-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005130128.3430804-19-poeschel@lemonage.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Oct 2020 15:01:27 +0200, poeschel@lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> 
> Add a binding doc for the modtronix lcd2s auxdisplay driver. It also
> adds modtronix to the list of known vendor-prefixes.
> 
> Reviewed-by: Willy Tarreau <w@1wt.eu>
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> ---
> Changes in v3:
> - Fixed make dt_binding_doc errors
> Changes in v2:
> - Adopted yaml based file format
> ---
>  .../bindings/auxdisplay/modtronix,lcd2s.yaml  | 58 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
