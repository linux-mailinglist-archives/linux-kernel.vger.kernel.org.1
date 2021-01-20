Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D2F2FDD97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733049AbhAUAE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:04:59 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41834 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387742AbhATVse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:48:34 -0500
Received: by mail-ot1-f43.google.com with SMTP id x13so24851836oto.8;
        Wed, 20 Jan 2021 13:48:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RYiLrGhcJLAAUHtrVI8d9P1h8COy/rO0jrSizRQNgyU=;
        b=snGNRcj7B9nmVc3VFGYfWgMeeItCKYfuUjdZEEZGsr83SIp6erZ3R5zhPT1Yedd4Ni
         GZLcE/cto/Rl0SV4BBH5wwqM9otoU8rriqFSMWluLWSf8a9kpOQLUn0ByaJVK4A6L6ft
         mnH6gP4+kZasWIUcxE6DmmOGHRxvh26i/phyJAcJJT7aGVg29svuuZ20acYRIMczobum
         qrqYEOuOQ6DkgYyjINctHewfsLS7avaMdaCp4uOCu59H+r3d2PzIUZwPHWjylAmFvDhf
         HTC/hX52grwpAUGJKXRND0l5A4rkD6x/uct2+ucwHSXNcy6EGklnWBiGbw0frx9DBhsF
         q3kA==
X-Gm-Message-State: AOAM532eAELpSpJIOJgudKxGikvof45kK2ED9s4bT5ZC3WXyAWrL0goL
        wVh4Co89CJu2rUk7c8TyCGMYkqJfjg==
X-Google-Smtp-Source: ABdhPJxYfPB/9UFcjdVsorlzePdRphHmAQkXGYqjRi6/Xol24sVNJD+KrM7TislYw9OYzVg7ZKHljA==
X-Received: by 2002:a9d:4587:: with SMTP id x7mr2312485ote.241.1611179273540;
        Wed, 20 Jan 2021 13:47:53 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v67sm678427otb.43.2021.01.20.13.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 13:47:52 -0800 (PST)
Received: (nullmailer pid 898723 invoked by uid 1000);
        Wed, 20 Jan 2021 21:47:51 -0000
Date:   Wed, 20 Jan 2021 15:47:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dp-connector: Drop maxItems from -supply
Message-ID: <20210120214751.GA895542@robh.at.kernel.org>
References: <20210120175922.1579835-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120175922.1579835-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 09:59:22AM -0800, Bjorn Andersson wrote:
> The meta-schema recently gained a definition for the common -supply$
> property, which denotes that maxItems is not a valid property. Drop this
> to clear up the binding validation error.
> 
> Fixes: a46c112512de ("dt-bindings: dp-connector: add binding for DisplayPort connector")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../devicetree/bindings/display/connector/dp-connector.yaml      | 1 -
>  1 file changed, 1 deletion(-)

Applied to drm-misc-next.

Thanks,
Rob
