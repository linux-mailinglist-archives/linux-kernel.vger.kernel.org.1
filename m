Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E74262223
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 23:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbgIHVuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 17:50:16 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40073 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgIHVuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 17:50:15 -0400
Received: by mail-io1-f67.google.com with SMTP id j2so989088ioj.7;
        Tue, 08 Sep 2020 14:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=shpHGPudo4d9G1LgLy9sXEgqpkCmEAyFPt2SZvRURXs=;
        b=LxviYg8TKl+cU91O+ZJmOBYUV78j+peU7+67PpFEboyfc3T1Cb3B/2f4dleX2pfZD0
         bYJJf5BIhpzO/+FnyJYGV2CsKZ4amN0OoZqBd0D8FYilUr73vHfb5eGbCk74/KcQeJLr
         TkFaYo0ifwCy7ZOBhVxCLICOq+ZuuVPsVvQ7hza8j3F/71wJFC1IW9nNnAF2osAsw8yL
         HchmW6pTKpmJfpOEO91jdyzndhUOaELIKRizN8Ap8WuUtP+izlujgWHHWTusjH8zV5GS
         TrW6QSi4CqS06gKVrxvmhyfQRucPkaLhqIvz17NZ0Ufl7jiVfFqYXxCy18fVsE8OdGCK
         GqlA==
X-Gm-Message-State: AOAM5338Z2DjI0IGkcmwEvMls4RecPWio1LbW5xvyDJkndmKUAcpjIbf
        mvA6GkOYjn5TMILsX+a3NQ==
X-Google-Smtp-Source: ABdhPJztHbGunEEtcZCeK7/v7wNaCgAwGb2KmWS/rtPe0EOYJTJDR8/udRm2/SaK7gqlUOOmvddWSQ==
X-Received: by 2002:a6b:5a0d:: with SMTP id o13mr877903iob.186.1599601814235;
        Tue, 08 Sep 2020 14:50:14 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id l2sm257270ilk.19.2020.09.08.14.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 14:50:13 -0700 (PDT)
Received: (nullmailer pid 989673 invoked by uid 1000);
        Tue, 08 Sep 2020 21:50:11 -0000
Date:   Tue, 8 Sep 2020 15:50:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, od@zcrc.me,
        Noralf Tronnes <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/6] dt-bindings: display: Document NewVision NV3052C
 DT node
Message-ID: <20200908215011.GA989643@bogus>
References: <20200822163250.63664-1-paul@crapouillou.net>
 <20200822163250.63664-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200822163250.63664-2-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Aug 2020 18:32:45 +0200, Paul Cercueil wrote:
> Add documentation for the Device Tree node for LCD panels based on the
> NewVision NV3052C controller.
> 
> v2: - Support backlight property
>     - Add *-supply properties for the 5 different power supplies.
>       Either they must all be present, or 'power-supply' must be
>       present.
>     - Reword description to avoid confusion about 'driver'
>     - Use 4-space indent in example
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../display/panel/newvision,nv3052c.yaml      | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/newvision,nv3052c.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
