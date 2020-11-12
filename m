Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBABD2B016D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgKLI7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 03:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgKLI7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:59:22 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55978C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 00:59:22 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id d17so929416plr.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 00:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=no/VBwmUjyEkDBIEofBNskIYF3ICygqIU7/YLyjE5C4=;
        b=b/jcmDDMQAT1WbXCvjBYsCflryrWai8ZDgcuYqrDbfJVyYRszRnIqGdg8pN7ionBqy
         ptzYc7wrkbIYnHS5mXKB/s1CKc8bZXiuUkzYsxSD74LAm+Y+gN8Yw7+8sAHfRr8YSfjJ
         iCPhWBqgGWPURrzG0vtRy2S3bKBJh5DVFWuK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=no/VBwmUjyEkDBIEofBNskIYF3ICygqIU7/YLyjE5C4=;
        b=Nn3eJ+XterkCV3hZuDFXdsmnqnxLFMDYffajTj2nu94z6lCFFXldMzLVuKepXdg0Qj
         HQP5vufTSqt8zdB10W+LNE3anrCDv1VFmZoHBZzSAT1Hyi/WIuq4pED3hUpNTF358ZeS
         Wz+67HaZGSA/tJPrO3qPYCtKb5UMI0j1mKnJjzH2xJyJqvcSyMkMKWT1XemDLBYBqCpg
         g/OB2W85m7ZNkpxNXOtCGQ2cCSdB1dwiYUF+iFGesIDT9gmgUUa8L2TVIxxAZhMgrpPT
         pXJn9Jqwzwg/KZVWyaz/bwvGljpQ57tXf1GrFK9MwIf8X9igoYQZ4jtdSq7Q8ORfjwJt
         nQTw==
X-Gm-Message-State: AOAM530MRrVRlSOboV/tipa2o9Ffhc5tfeW38FNrXwjqnLTXm2q2sGDW
        bOGBexPALvAaAMJz7g0jLZUk8g==
X-Google-Smtp-Source: ABdhPJwf/qNRp3cdldTds8ed7cGrz7q2smzK8HoQ1pypne4fSV0HbvzbGqmxypGV6+H8R+U4q+Reig==
X-Received: by 2002:a17:902:eb42:b029:d6:ba60:ba41 with SMTP id i2-20020a170902eb42b02900d6ba60ba41mr24797270pli.0.1605171561915;
        Thu, 12 Nov 2020 00:59:21 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id mv16sm5741013pjb.36.2020.11.12.00.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 00:59:21 -0800 (PST)
Date:   Thu, 12 Nov 2020 00:59:20 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Xin Ji <xji@analogixsemi.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        heikki.krogerus@linux.intel.com
Subject: Re: [PATCH] drm/bridge: anx7625: Add anx7625 port switching.
Message-ID: <20201112085920.GB1367855@google.com>
References: <20201112064051.3716968-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112064051.3716968-1-pihsun@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pi-Hsun,

I haven't gone through the code, but did have a high-level comment
(kindly see inline)

On Thu, Nov 12, 2020 at 02:40:40PM +0800, Pi-Hsun Shih wrote:
> When output 2 lanes DP data, anx7625 can output to either TX1/RX1 or
> TX2/RX2. In typical usage, these two TX/RX pairs corresponds to two
> orientations of typec.
> 
> On some board one anx7625 is used as DPI to DP converter for two typec
> ports. In this case, the TX1/RX1 and TX2/RX2 are connected to two usb
> muxes, which mux the DP data with the rest of the USB3 data, and
> connects to the two typec ports.
> 
> This patch adds option for anx7625 to acts as a usb typec switch and
> switch output lanes based on the typec orientation, or acts as two usb
> typec mux and switch output lanes depending on whether the two ports
> currently has DP enabled.
> 
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> 
> ====================================================================
> 
> This is an attempt to use typec framework with how we're using anx7625
> on Chrome OS asurada board.
> 
> An example of the dts for the two ports case can be found at
> https://crrev.com/c/2507199/6

Do you plan on submitting DT schemas & bindings documentation for the switch(es)
that are intended to be used?

I would strongly recommend that for usb-c-connector since AFAIK they don't exist, and
I don't believe there is explicit support for them in the Type C connector class framework
(even .

IMO this would be needed to ensure an implementation here doesn't break
in the event of modifications to the connector class framework (or Type
C port drivers like cros-ec-typec) in the future. I think some patches
were floated for this for orientation switch [1] so those might provide
some hints about how to proceed.

I've CC-ed Heikki (Type C maintainer) in case he has additional comments regarding this.

> 
> Sending this as a RFC patch since I'm not sure about the best approach
> here. Should the logic of switching output lanes depends on ports be
> coupled inside anx7625 driver, or in another driver, or is there
> any existing way to accomplish this?

Might be good to add [RFC] as a tag instead of [PATCH] in case this
iteration is chiefly to solicit comments.

Best regards,

-Prashant

[1]:
https://lore.kernel.org/linux-usb/1604403610-16577-1-git-send-email-jun.li@nxp.com/
> 
