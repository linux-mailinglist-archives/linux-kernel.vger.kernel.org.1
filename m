Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F583026BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 16:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbhAYPM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 10:12:28 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:40376 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbhAYOwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:52:21 -0500
Received: by mail-oi1-f180.google.com with SMTP id p5so14979735oif.7;
        Mon, 25 Jan 2021 06:52:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=wNTAmKC0zu5iO9mM7sxm7NcDuEttIlxDD2+2CiOrQPM=;
        b=SrkGvNrG9reWAhp55jTFTk17exV2FMr44MkibQdjdXt5YDm6brr4jgybXih448Une7
         Q3NT09wG0Tbc52V/zf3cSjwN8DJvSATMDOi5e7FYhNrT6q5BSnFbXGY5qBgOwp4DaiIB
         ItWhe16+LydmFxJVkXw/R2U3Ag6gOD1XC3uYHwJ9S0QQz6TQH4THeqYb+LD72TKCEE1a
         t1+AC3Noqw/Ofj5mSc0WghQw9kZ1eIJGhdVof9qiw5Lr61n0EaqkUxNrjBm8NJ+vZ49f
         bQuKNWDrUj1gzY+Hv77w5zrcWtMwlniSxHLnS04HcClN2d8Bqa9wcgleqKZRtbdHTorf
         M6uA==
X-Gm-Message-State: AOAM532iYM3lC5uWi+1z1ykYep1Ij6QSmYgoswpkRJB6njIvyCnyDET2
        9tV+Q9vBuvF3/jyFTbGJxcTDo+k17Q==
X-Google-Smtp-Source: ABdhPJy3JbZEiAsAKDW30PEDE5gz4huf/K7EbGR5/y5uPiRGW74tdF3GYJ6R424CRyK9UhjP03yQNQ==
X-Received: by 2002:aca:d643:: with SMTP id n64mr318001oig.151.1611586299897;
        Mon, 25 Jan 2021 06:51:39 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l11sm608502otf.59.2021.01.25.06.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 06:51:38 -0800 (PST)
Received: (nullmailer pid 327908 invoked by uid 1000);
        Mon, 25 Jan 2021 14:51:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sheng Pan <span@analogixsemi.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Nicolas Boichat <drinkcat@google.com>,
        David Airlie <airlied@linux.ie>,
        =?utf-8?q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Maxime Ripard <mripard@kernel.org>
In-Reply-To: <75e29d7386df2ebca4a8e3f0b91c8370a4a8f74f.1611572143.git.xji@analogixsemi.com>
References: <cover.1611572142.git.xji@analogixsemi.com> <75e29d7386df2ebca4a8e3f0b91c8370a4a8f74f.1611572143.git.xji@analogixsemi.com>
Subject: Re: [PATCH v3 1/3] dt-bindings:drm/bridge:anx7625:add HDCP support flag and swing reg
Date:   Mon, 25 Jan 2021 08:51:35 -0600
Message-Id: <1611586295.672940.327907.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 19:12:21 +0800, Xin Ji wrote:
> Add 'bus-type' and 'data-lanes' define for port0, add HDCP support
> flag and DP tx lane0 and lane1 swing register array define.
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  .../bindings/display/bridge/analogix,anx7625.yaml  | 57 ++++++++++++++++++++--
>  1 file changed, 54 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.example.dt.yaml: encoder@58: ports: '#address-cells', '#size-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.example.dt.yaml: encoder@58: ports:port@1:endpoint: Additional properties are not allowed ('remote-endpoint' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml

See https://patchwork.ozlabs.org/patch/1431199

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

