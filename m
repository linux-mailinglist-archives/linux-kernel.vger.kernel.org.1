Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410B12AC0A5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgKIQR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:17:56 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46767 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgKIQR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:17:56 -0500
Received: by mail-ot1-f66.google.com with SMTP id g19so9430987otp.13;
        Mon, 09 Nov 2020 08:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y/5H6VxBZZXcUHYsYBM9BpswtOs34TchvizhtJh9foc=;
        b=OtD9Z1exUhLpjwmk7sC3lq4pAlp9LCB5FA8/7t0QM6dp03ppQMsdyjqbzkHF4w+iUE
         e+LMVAaKZTpAYa+HXHyxYyJzAhTHnzLtIW3qPlEx0b5TetHvONHfj6QHNEwaZ7OnaLHZ
         Alq/Tjm4wsWZHZXNhsnpCOHnChszvq7RjcK81/MpEDL0zG85ji14msJIYzKDe/xw3PeN
         ILua8EpzFr8HAjaCd6f8oWkY0imrBECs/P3Iz4Y5TiVI/4u2sTDwadxx0rY8Bwg7DAXg
         TNVBYfv7kefkfDzn6XHt4wxsWGJGGSfwY88I6RRBXP9mBLmH3pFh+6xmpL6WYUyUdoJg
         Qz9g==
X-Gm-Message-State: AOAM533kAz7qX7+aPY+xtTWonQgWO+ZWNqZdsGP+AczCNJiwQJcAA6Yr
        zuBAGZ9JKOLm+N1ccaI/Xw==
X-Google-Smtp-Source: ABdhPJz5l+1WVP+1j+2NAClk8hKooBFEISti/wifdURdJ15YnFUVsW6dBeSP16yOkcNar2aQs/P2NA==
X-Received: by 2002:a05:6830:84:: with SMTP id a4mr7298820oto.341.1604938675517;
        Mon, 09 Nov 2020 08:17:55 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u138sm2458156oie.33.2020.11.09.08.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 08:17:54 -0800 (PST)
Received: (nullmailer pid 1387782 invoked by uid 1000);
        Mon, 09 Nov 2020 16:17:54 -0000
Date:   Mon, 9 Nov 2020 10:17:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/6] dt-bindings: arm: sunxi: Add SL631 with IMX179
 bindings
Message-ID: <20201109161754.GA1387734@bogus>
References: <20201103205058.435207-1-contact@paulk.fr>
 <20201103205058.435207-6-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103205058.435207-6-contact@paulk.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Nov 2020 21:50:57 +0100, Paul Kocialkowski wrote:
> This adds documentation for the compatible strings of the
> SL631 Action Camera with IMX179.
> 
> Note that the device is sold under various different names, such as the
> SJCAM SJ4000 Air or F60 Action Camera. This is a similar situation to
> the Q8 tablets and just like them, the allwinner vendor is used as
> fallback.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
