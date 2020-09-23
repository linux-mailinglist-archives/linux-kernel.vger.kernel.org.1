Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E96C274E54
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgIWB2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:28:25 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:44496 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgIWB2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:28:24 -0400
Received: by mail-il1-f195.google.com with SMTP id y8so18905475ilm.11;
        Tue, 22 Sep 2020 18:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wOFsOWTjSL4FRYR4bymj2SkxEWR6B/1aPP2FtvhSKOI=;
        b=gidSMD7J3frKtOZyE9xitrvocB+yv8/Y1h+wyCnxBAGOW3daOe4LqN2xgjUQXadOUp
         10NqrQ4EDdAvgkWTAipmtbylwRUU0K4QfJf7EZGHGwGSfRvFHhUoQ7BMk8/Lda4iqBlx
         UsbxkZU3/aaWFeI5PsXUJo3GufU5TCsQBdKksFa08FkJsZIwKA0HSFHIBwrvC6f7Zw/T
         B6SLwntMUpFN0t5KoXV2ME65yjvoWz84zrXIi1xlNe2041jq1iwoKLjblzTfrDjkZoKz
         QjzSTA7d4P/MNc0JbBEZqWUsGDxgBENkeTTdawkRno6qysFqZkSTqUu35AQaHLutxXXZ
         SwFg==
X-Gm-Message-State: AOAM5322uL0IMYdm41jJOFji4/eE25VUeCYAkotP6i0Mi/O3JtMNTU4x
        ebHBexVcsdLWm3+ExXMlaplsZb/gkI7F
X-Google-Smtp-Source: ABdhPJyH2nFFin5pTlEaPxsP4fOtHfm6oOn+qr9bRGNajCNvS0DOljj+PsMwGVw/ytYsc0e+Uq3tYQ==
X-Received: by 2002:a92:c7ac:: with SMTP id f12mr6724566ilk.2.1600824503966;
        Tue, 22 Sep 2020 18:28:23 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u14sm9873738ilj.7.2020.09.22.18.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:28:23 -0700 (PDT)
Received: (nullmailer pid 3656192 invoked by uid 1000);
        Wed, 23 Sep 2020 01:28:22 -0000
Date:   Tue, 22 Sep 2020 19:28:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, sam@ravnborg.org,
        thierry.reding@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v4 2/4] dt-bindings: display: panel-simple-dsi: add
 optional reset gpio
Message-ID: <20200923012822.GA3656163@bogus>
References: <20200915121912.4347-1-narmstrong@baylibre.com>
 <20200915121912.4347-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915121912.4347-3-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 14:19:10 +0200, Neil Armstrong wrote:
> Simple DSI panels can also have a reset GPIO signal in addition/instead of an
> enable GPIO signal.
> 
> This adds an optional reset-gpios property.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple-dsi.yaml      | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
