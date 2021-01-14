Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB222F6AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbhANTMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:12:05 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:43783 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbhANTMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:12:05 -0500
Received: by mail-ot1-f52.google.com with SMTP id q25so6197870otn.10;
        Thu, 14 Jan 2021 11:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WJH+/RP8cD+cn+XHnaVewTvw/PKu6pAE6tZBSia24UE=;
        b=LByV8ZlMoWhXqsvq4fgCIFwGLIKSCA81iQ0HZaUr0sAyqNaYqMkt62EvBAR1/7Y18a
         RH1Ds7rFR2R9FrFTN3rPbDL9r6sbC3MscpIUEgDtaf8N9WOhe26m4rOdYh0qXYYugcY6
         zsNVGe2ojMPp49OubkN2yBlWetBaNt/i8bD6U6k1kMvv3qIQumuKW4297ZrCoK72bwLy
         6s88jdW4mv/S/IUxp9xw4b/6gbLHnMEla+GLZ/sfzPLK3ZXxWQfnDYydb8Js+TjWkDj9
         z/ufFClcvT1Yy//JKZh9wXIvFUB7hFPNphk7dBRC1eEjKrIgQb5bJAH358qVronlCmCv
         dEVg==
X-Gm-Message-State: AOAM531bD7lyjEL3NJv5ecvQmIx+w3BIJ40sG9906gRHxQgHdK5T+2SU
        n9JJO9kNja/PlahJwVtmdg==
X-Google-Smtp-Source: ABdhPJyzqW5jSgIwdHBBZZDHiZ6CkCOObxHInv5OjKe74ArGH+HMT7Poink2jRgipIR7enRQx+r5Fw==
X-Received: by 2002:a9d:4c8b:: with SMTP id m11mr396885otf.319.1610651484287;
        Thu, 14 Jan 2021 11:11:24 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v17sm1241102oou.41.2021.01.14.11.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:11:23 -0800 (PST)
Received: (nullmailer pid 3394232 invoked by uid 1000);
        Thu, 14 Jan 2021 19:11:22 -0000
Date:   Thu, 14 Jan 2021 13:11:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>, CK Hu <ck.hu@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3, 01/15] dt-bindings: mediatek: add description for
 postmask
Message-ID: <20210114191122.GA3394181@robh.at.kernel.org>
References: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com>
 <1610351031-21133-2-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610351031-21133-2-git-send-email-yongqiang.niu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021 15:43:37 +0800, Yongqiang Niu wrote:
> add description for postmask
> postmask is used control round corner for display frame
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
