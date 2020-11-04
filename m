Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82BF2A701D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 23:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbgKDWEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 17:04:25 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46431 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731900AbgKDWD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 17:03:56 -0500
Received: by mail-ot1-f68.google.com with SMTP id g19so178794otp.13;
        Wed, 04 Nov 2020 14:03:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZS24L4Q1SnbH+3TvbhszBTqlwtEhinFPk10NBRg1yko=;
        b=fRKYSijqxIWfSDrEdO47RQIkD9pKY9DlgrzrXaxuDYhnakhy914/hNIWn00ol64Uax
         9rXSK659PrVWK/wmGVC94sW/RZsdDAu1ax0QY3uJ0GmoYj9AvEr8q56FFfpHrX/59BKO
         t2T9hkT42fyQY4hCwE6AkY+Kg7e00e28vQrRpRp9CPmJp1NNjnfFec4IuztV41epEe14
         GG607TV+T5ePkJwv2QOoz48zmhiu3KGHUtdXq8jQ/K4ct5ofTt1AMRrShrth5PGRyJnL
         lxN8NzCA4E9VIc96EhWbaTyvzJp1nDrjqL+nsB6VyDC2Kz8kavGlir414qNv5it6vNZP
         Fa9Q==
X-Gm-Message-State: AOAM530EMfXSlAYEbwKUPB6YcElXj65rxNle5xB524gIBf5CTwQxG+2f
        KvxwzXYa4MMG+werojZJBw==
X-Google-Smtp-Source: ABdhPJxokC+UXU6bqZgFYIN4rSC5flEX4qMFtuP75+FBYUPFzTsiqnMj/DLbjQAzJoJPttM5dr3PwQ==
X-Received: by 2002:a9d:65d5:: with SMTP id z21mr10255726oth.251.1604527435398;
        Wed, 04 Nov 2020 14:03:55 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k15sm785105oor.11.2020.11.04.14.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 14:03:54 -0800 (PST)
Received: (nullmailer pid 7602 invoked by uid 1000);
        Wed, 04 Nov 2020 22:03:54 -0000
Date:   Wed, 4 Nov 2020 16:03:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     weiyi.lu@mediatek.com, fparent@baylibre.com,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        drinkcat@chromium.org, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, hsinyi@chromium.org
Subject: Re: [PATCH v4 10/16] dt-bindings: power: Add MT8183 power domains
Message-ID: <20201104220354.GA7572@bogus>
References: <20201030113622.201188-1-enric.balletbo@collabora.com>
 <20201030113622.201188-11-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030113622.201188-11-enric.balletbo@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 12:36:16 +0100, Enric Balletbo i Serra wrote:
> Add power domains dt-bindings for MT8183.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  .../power/mediatek,power-controller.yaml      |  2 ++
>  include/dt-bindings/power/mt8183-power.h      | 26 +++++++++++++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt8183-power.h
> 

Acked-by: Rob Herring <robh@kernel.org>
