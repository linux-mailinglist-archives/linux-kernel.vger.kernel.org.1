Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501A52DAEF0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgLOO12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:27:28 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41904 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbgLOO0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:26:51 -0500
Received: by mail-ot1-f68.google.com with SMTP id x13so19510097oto.8;
        Tue, 15 Dec 2020 06:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Di6e3zk8oS0etbJqpgGcmuo1HcvG/3ApCGRJweCbZeQ=;
        b=NwvoqpQo6gWeiIcAPpTZiPjoqprQcc1trchiKZu4GPTA4QX6PZyJeI3u5WCBVA8Fld
         D/tSGxaPFkmYdI/h+tLjKhSKcMPPZ5+yUbjymy4Egp+ndruLXjeUJxTw7DBqwUk/CXhs
         GeP+HqYlO6YZL4rx9PGTRk/nFseP/7+pXswfBg1Td1XgfgkDYkTLawPu1InODD9P0zw8
         66ynynj0AGjzRnF5n5j1jn+PZE0G6Q+o35yzIHZkaOuf27sfQUJHVlNnhWklYaZ/lTWs
         V1cX1Mpj9/4MCaLbqIEUu/+FdPq5pEZoYVofrGqmsu3rFEoueYIjuntxOAVt/fR4U9NR
         /N8w==
X-Gm-Message-State: AOAM533wkWD9eqzCsysx9ozvoo7nF5lZukGmAZ2qZRgyJW2Y3HgO0Ju9
        c4a4hEF04uFQO/oxhbUNcA==
X-Google-Smtp-Source: ABdhPJw8GOO5HxCZiUJSYpWvX2zTLsjXdnSUVTmlo5MeXq8qJNOimO3I5K6K1qJBB+tvfodBRdF1Og==
X-Received: by 2002:a9d:4c8d:: with SMTP id m13mr21008336otf.229.1608042370869;
        Tue, 15 Dec 2020 06:26:10 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z6sm4690069ooz.17.2020.12.15.06.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 06:26:09 -0800 (PST)
Received: (nullmailer pid 3775382 invoked by uid 1000);
        Tue, 15 Dec 2020 14:26:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, a.hajda@samsung.com, jonas@kwiboo.se,
        narmstrong@baylibre.com, airlied@linux.ie, jernej.skrabec@siol.net,
        linux-kernel@vger.kernel.org, Laurent.pinchart@ideasonboard.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
In-Reply-To: <20201215124227.1872-1-peter.ujfalusi@ti.com>
References: <20201215124227.1872-1-peter.ujfalusi@ti.com>
Subject: Re: [PATCH] dt-bindings: display: bridge: tc358768: Remove maintainer information
Date:   Tue, 15 Dec 2020 08:26:07 -0600
Message-Id: <1608042367.307112.3775381.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Dec 2020 14:42:27 +0200, Peter Ujfalusi wrote:
> My employment with TI is coming to an end and I will not have access to
> the board where this bridge is connected to.
> 
> It is better to remove a soon bouncing email address.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../devicetree/bindings/display/bridge/toshiba,tc358768.yaml   | 3 ---
>  1 file changed, 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml: 'maintainers' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml

See https://patchwork.ozlabs.org/patch/1416419

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

