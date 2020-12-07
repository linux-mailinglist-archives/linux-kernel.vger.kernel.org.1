Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEBF2D1C2E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgLGVcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:32:47 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32780 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgLGVcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:32:46 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so13979134ots.0;
        Mon, 07 Dec 2020 13:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YdIJ0cVvLcaZw842WkJYzbX/9+PQf7WPJ2/asgIqMAo=;
        b=m8Tr0tU/+5/Zx1THDn97To+URTShRxv9yi4O0kvsEOe0q44aZSh1ZR/ISsCn4mEStc
         tlaU+xRIlw1+0N24iE9QMzDvzxbJnNtQDPh7rMCVjsKJAawa48dSB6s+0dH+E5aSOhWU
         F7JBj2Z3B9SovMsZEuAaPf8pw2pYtqGFfhl7j7FpJ8CqEFaIKoR+9s+wy/R/MiX7ffU4
         IlMkGR9LDxwFcwKZjNPGExSXpbvIPBNx0Uqgmy94vynKgeXnWf/V4qBxggj1BBIaWKHU
         +ybCIJTYj1xwCjeIS0PA562Co5dTyiqE1g5oFIJ3anf3TrOpO6zPSVKdIgByjv1hBILL
         vWZA==
X-Gm-Message-State: AOAM532jTTmY4bZmHisYQoF1zVIz0REQjeC6FEKEVPpzMwE8Wg7WhWO9
        ccfhSvMnRFceUL6cTMKatg==
X-Google-Smtp-Source: ABdhPJynUSeUJfvdffPqKHkyHxZkw5osI59qNIBgtb8M/rH1rJtmbMdqsrprbx/fJ7YQRpvK4fK1Uw==
X-Received: by 2002:a9d:27a7:: with SMTP id c36mr1402179otb.59.1607376720005;
        Mon, 07 Dec 2020 13:32:00 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u10sm3439121oig.54.2020.12.07.13.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 13:31:59 -0800 (PST)
Received: (nullmailer pid 863978 invoked by uid 1000);
        Mon, 07 Dec 2020 21:31:57 -0000
Date:   Mon, 7 Dec 2020 15:31:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ondrej Jirman <megous@megous.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] dt-bindings: vendor-prefixes: Add ys vendor prefix
Message-ID: <20201207213157.GA863327@robh.at.kernel.org>
References: <cover.1605688147.git.agx@sigxcpu.org>
 <efa9b6da947e0cd87ec47c1a211690045304989b.1605688147.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efa9b6da947e0cd87ec47c1a211690045304989b.1605688147.git.agx@sigxcpu.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 09:29:52AM +0100, Guido Günther wrote:
> Add prefix for Shenzhen Yashi Changhua Intelligent Technology Co., Ltd.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
