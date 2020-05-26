Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799B91B187C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 23:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgDTVbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 17:31:32 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38414 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgDTVbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:31:32 -0400
Received: by mail-oi1-f193.google.com with SMTP id r66so10205667oie.5;
        Mon, 20 Apr 2020 14:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xCbMSBWE/K7CMTFoStyxNkJaPmhk/SFie0hTZQJVUuE=;
        b=sJMjECmu0mmTTgHhyEETBQesotteG5lfuWufzJGnqs0lHdDFHFv+wbseCsPUftz91Z
         K7Fu91EVn4YotE4SCEcpdMgKSJ7JhiKbC/qOaWfFn9x1ycWU7ipifDeZ3sYlff5KNsMu
         DWXJan/NkVA4eBCKIKaL7mjRVR7Iy3bOagUTQSj5j/1Y+zlqS8rSMJXv4ZabGMGb94NJ
         UEcvjcSVYGQLzwXjlW2v+guSCEMAcmJ2EM0ip1orzToahBQVHBrvxK26slqmwdpI3UAI
         qZseXhF4nO4GKNHg+Ad6JSqBXExZrxE4vDm+rhAb3j21gUuRQPeHM58ShzyaG4+zJeXK
         byfA==
X-Gm-Message-State: AGi0PuYpfAGpmdEwVi1CaI2jzxA50OdeVAvxWBMFsi4hXWiF4xIS3pvW
        0vr3nW6deOYGGd0PunfaGg==
X-Google-Smtp-Source: APiQypKp/aMom3WcZIgx4KD9/tZ1PBp+icqSBiPeREh6uL2GtZ7nUmS6xX3EHcojP7gq2hudxYyZ2A==
X-Received: by 2002:aca:4155:: with SMTP id o82mr1118364oia.16.1587418291457;
        Mon, 20 Apr 2020 14:31:31 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s73sm171791oih.14.2020.04.20.14.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:31:30 -0700 (PDT)
Received: (nullmailer pid 22338 invoked by uid 1000);
        Mon, 20 Apr 2020 21:31:29 -0000
Date:   Mon, 20 Apr 2020 16:31:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com, huijuan.xie@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [PATCH v15 2/3] dt-bindings: display: mediatek: convert the
 document format from txt to yaml
Message-ID: <20200420213129.GA22262@bogus>
References: <20200415011319.25559-1-jitao.shi@mediatek.com>
 <20200415011319.25559-3-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415011319.25559-3-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 09:13:18 +0800, Jitao Shi wrote:
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../bindings/display/mediatek/mediatek,dpi.txt     | 42 ----------
>  .../bindings/display/mediatek/mediatek,dpi.yaml    | 97 ++++++++++++++++++++++
>  2 files changed, 97 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
