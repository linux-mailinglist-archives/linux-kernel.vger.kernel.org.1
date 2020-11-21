Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C13B2BBF44
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 14:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgKUNaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 08:30:03 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37163 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgKUNaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 08:30:02 -0500
Received: by mail-qt1-f193.google.com with SMTP id e10so1878779qte.4;
        Sat, 21 Nov 2020 05:30:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LMYkpGZPQIEZX3RblcCkU4XSLIMzz4ngLSXNIvs/ag8=;
        b=pyGpqL5PFXkrD766VviJQg/XmeKOX7Sr7pAIQTREPTrIhf/YDohcGM02aW+MjYHNOW
         UqIBKLC1FK7HmH9X6ykTrzbAWpyJFFZWOnFwrmLJBhUGF421P+uLkuxTFDp5jZetcsgI
         7V5YoCwnQjp0U9sG9GNT2b+4YQOiyKLTgOPckFwu5tPyMwXoDsT0B3CQBYjEUkKnKH7n
         vf0SnM+ayD+H7t3PS9q8U6vi0kGAfDU1Klh6WQYi1odYfeSswRTgcw50c3JfHYPiD0MK
         KHIoCZVy3vXKcXvaCnEjOKh6Kz5cpp4qR819W1SwpU2yzXAQN+u/GDE76mLpMPJ2+rIT
         mZ0w==
X-Gm-Message-State: AOAM531wrN2ceQOra9C1liuAZokiL5yP+9Pfw1YoWcTe0OK+UamhOaxI
        kLmqegM1AVS9zk/dVrTdTw==
X-Google-Smtp-Source: ABdhPJx/wQGCEQFWfBQ9eUPjaL7l5ZoIwci2QkBaFnEVkDtVziQnW/HiaxN4icHbgUFnNWX0bTuNQQ==
X-Received: by 2002:ac8:59c5:: with SMTP id f5mr13710063qtf.192.1605965399806;
        Sat, 21 Nov 2020 05:29:59 -0800 (PST)
Received: from xps15 ([172.58.99.237])
        by smtp.gmail.com with ESMTPSA id z23sm1164116qtq.66.2020.11.21.05.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 05:29:58 -0800 (PST)
Received: (nullmailer pid 2128208 invoked by uid 1000);
        Sat, 21 Nov 2020 13:29:54 -0000
Date:   Sat, 21 Nov 2020 07:29:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: fsl-imx-drm: fix example compatible string
Message-ID: <20201121132954.GA2128113@robh.at.kernel.org>
References: <20201113150618.417424-1-cengiz@kernel.wtf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113150618.417424-1-cengiz@kernel.wtf>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 18:06:19 +0300, Cengiz Can wrote:
> Example `display-subsystem` has an incorrect compatible string.
> 
> Required properties section tells that developers should use
> "fsl,imx-display-subsystem" as "compatible" string but the example
> misses 'imx-' prefix.
> 
> Change example to have correct "compatible" string.
> 
> Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
> ---
>  Documentation/devicetree/bindings/display/imx/fsl-imx-drm.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
