Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DE92DB127
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgLOQTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:19:25 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38451 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730834AbgLOQSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:18:46 -0500
Received: by mail-oi1-f194.google.com with SMTP id x13so14871421oic.5;
        Tue, 15 Dec 2020 08:18:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YUVQgTwv4axq9vrq6olsh3jfHaZ2i0lCLI1YkMK+law=;
        b=h+SyEhnzRzB5O5kmk3W+hg6KK+Z9B6kbFGatp4G+h9sJR7U7p+1eJRp3CcWZ0uGIlj
         Bb5DLsAmHSjlN4SdV01MhK3Ow+PZBIKE7qHq/qZfxVC1N7DGbV0DOn/l/Qy9olJDLf5t
         htq0fnguP9iQthV7oZ9qqVE9SRr4bJLaif/dYWCYXEYpHg8uQSvu6RDvXP/gGj0YuEZ5
         YUC4ZVXTeSaIF8rKuyN+xy1dPHW74SYRRADrBHilG/C4itM/MWMq+4nGEIaHQVNKTHpO
         T4T3d0nedtXJUMFF8cPN8utiy/qjFN8uFVPGc2Og2N0gz4AhtUZCtERLkxpaUvtg2A2e
         nz6A==
X-Gm-Message-State: AOAM533vVZDR2idqJuxhuTzo8VMknGho8zAjie6gsmvbk1zNYvz6dm0g
        v5EOFSDBjCr1f8jGppcr8A==
X-Google-Smtp-Source: ABdhPJw7xmnZHDRKJs46SGJ3AWYtxkn2pMs1JTWzHmp6//B2xTY90PQcCmSuYtYHQJnczE/c3/MkgA==
X-Received: by 2002:aca:c4c2:: with SMTP id u185mr1188400oif.177.1608049085661;
        Tue, 15 Dec 2020 08:18:05 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m3sm195649ots.72.2020.12.15.08.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 08:18:04 -0800 (PST)
Received: (nullmailer pid 3957725 invoked by uid 1000);
        Tue, 15 Dec 2020 16:18:03 -0000
Date:   Tue, 15 Dec 2020 10:18:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [RFC PATCH 02/12] dt-bindings: clk: sunxi-ng: add V833 CCU
 clock/reset indices headers
Message-ID: <20201215161803.GA3957671@robh.at.kernel.org>
References: <20201212040157.3639864-1-icenowy@aosc.io>
 <20201212040318.3640236-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212040318.3640236-1-icenowy@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Dec 2020 12:03:08 +0800, Icenowy Zheng wrote:
> As the device tree needs the clock/reset indices, add them to DT binding
> headers.
> 
> The driver itself will be then added.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  include/dt-bindings/clock/sun8i-v833-ccu.h | 89 ++++++++++++++++++++++
>  include/dt-bindings/reset/sun8i-v833-ccu.h | 52 +++++++++++++
>  2 files changed, 141 insertions(+)
>  create mode 100644 include/dt-bindings/clock/sun8i-v833-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun8i-v833-ccu.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
