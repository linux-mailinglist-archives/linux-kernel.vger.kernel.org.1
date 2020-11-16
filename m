Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925552B4C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732525AbgKPRIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:08:42 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35170 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730296AbgKPRIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:08:42 -0500
Received: by mail-ot1-f65.google.com with SMTP id n11so16730325ota.2;
        Mon, 16 Nov 2020 09:08:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cpje3Ch1E7xsRe01ORBCqLDrqUWUK2vaTS9b/qGcoGw=;
        b=GPXhFnCXj0xnqj3gDHUrk0xlg++YqBf5XoVD58Z426dvrGA/cG7kZhc4onGJ58pXvZ
         rHLUgSbAJnQ7VB9R+HJ+8G3W3OrBMgOWCud6E5X3lFzVroGuYSqyFhW0iWQpoGOYBZhX
         rqoBph60jJeBPSPpDFHzTwD4ETL9vX1LMgrTc8VBySOu8ao7pO+9a0ZjWq+gS4W86b6U
         myDaQUHwXSVnsG2NYxBu8gUr+jkAPBkGdbUNNWkqKGCyroWk88UrPEfSHB6EGt0V4xOF
         Geoq09ZvyLw4xi3IAg/8hd1EMnRrga/r72Qh+0NGYuDPLbfMAoxIjeKf+IWPih5zLsDG
         FlTw==
X-Gm-Message-State: AOAM533RNwCQ/mI6RmwqiCH00kp+TSUtyCSeuLJze4CwkyzQALyBPGgy
        9/+Wt+oMlNTQit7oql82Ew==
X-Google-Smtp-Source: ABdhPJwkLS4G7CmYy/+6uMtcAlryYwRd4L3Fhxdc+19D87FDBiWWkwziEXOXNjQzl1fO4w/qkF4kVA==
X-Received: by 2002:a9d:65c7:: with SMTP id z7mr195112oth.25.1605546521077;
        Mon, 16 Nov 2020 09:08:41 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r206sm4850030oih.14.2020.11.16.09.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:08:40 -0800 (PST)
Received: (nullmailer pid 1816812 invoked by uid 1000);
        Mon, 16 Nov 2020 17:08:39 -0000
Date:   Mon, 16 Nov 2020 11:08:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        broonie@kernel.org, tzungbi@google.com, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, Trevor.Wu@mediatek.com,
        linux-arm-kernel@lists.infradead.org, shane.chien@mediatek.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: mediatek: mt8192: revert "add audio afe
 document"
Message-ID: <20201116170839.GA1816761@bogus>
References: <1605081920-11848-1-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605081920-11848-1-git-send-email-jiaxin.yu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 16:05:20 +0800, Jiaxin Yu wrote:
> This reverts commit 1afc60e00de3abbb6c559da409c5c1bb8c1d98ec.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  https://mailman.alsa-project.org/pipermail/alsa-devel/2020-November/176873.html
>  These dependency are continuing to upstream, I will revert this patch first.
>  After the dependencies are merged, I will send 'mt8192-afe-pcm.yaml' again.
> 
>  .../bindings/sound/mt8192-afe-pcm.yaml        | 100 ------------------
>  1 file changed, 100 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
