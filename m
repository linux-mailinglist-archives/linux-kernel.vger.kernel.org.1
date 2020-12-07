Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276F62D1C31
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgLGVcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:32:50 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35374 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgLGVct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:32:49 -0500
Received: by mail-ot1-f67.google.com with SMTP id i6so7861130otr.2;
        Mon, 07 Dec 2020 13:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0ynb8iLyUqADhkwHS9Qnd7e5/0N0ngWwVvaQV6B/88U=;
        b=eJ3gZmsavRxrWygZv5xdcQeE3KKpVQUTmwhTvLDxcO0ghAgcd9Up803xYSyomjgC95
         vtpDRJuaJHWGehB8TiVvrbsdXpyzDNGrcFro9ApTEONepD0gx3cWXPeQhmxm+1bcnb+O
         SnIaVTVyZZaI5UXpldjtIG99Tp/NIalCXE2oCIHWU27pO9rKQmZMYuejAFa27oxBjAPZ
         ERLjWMmQ+n5QjtxsN3TnWM8y5ujA/3dEV69nvKGNYZHc7emBBIX29YT8tTXwZy5N5JGH
         1MMIvFUiaTx+BiZHMJ4yTFq0hbOHi9Y9mNifsAGds+BSjffqlvsm27Wz9VicbmsDnoXQ
         ZQjg==
X-Gm-Message-State: AOAM533PWHBqUbidqi5cGmoXL+uLRgHRZmcESs9zTDFQKk3ILfzAo02C
        PM+RUX6IGS/XeCwGP3zn8VcmL93NUA==
X-Google-Smtp-Source: ABdhPJwGilcs+3zsB2f6/w9E6wHpMwawQixZFs99uC0mM+0NRsxaeavmnh/Lh9H+XbLxDmBuHdErVA==
X-Received: by 2002:a9d:4d8b:: with SMTP id u11mr4261161otk.13.1607376728681;
        Mon, 07 Dec 2020 13:32:08 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o82sm3074342oih.5.2020.12.07.13.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 13:32:07 -0800 (PST)
Received: (nullmailer pid 864264 invoked by uid 1000);
        Mon, 07 Dec 2020 21:32:06 -0000
Date:   Mon, 7 Dec 2020 15:32:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Airlie <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 6/6] dt-binding: display: mantix: Add compatible for
 panel from YS
Message-ID: <20201207213206.GA864202@robh.at.kernel.org>
References: <cover.1605688147.git.agx@sigxcpu.org>
 <eb2a0e50cbb8cfebc27d259607e543fedb8c6b27.1605688147.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb2a0e50cbb8cfebc27d259607e543fedb8c6b27.1605688147.git.agx@sigxcpu.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Nov 2020 09:29:53 +0100, Guido Günther wrote:
> This panel from Shenzhen Yashi Changhua Intelligent Technology Co
> uses the same driver IC but a different LCD.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml  | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
