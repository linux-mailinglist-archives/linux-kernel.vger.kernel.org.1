Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A59224D36
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 18:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgGRQxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 12:53:07 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:44746 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgGRQxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 12:53:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 95893FB03;
        Sat, 18 Jul 2020 18:53:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oM9Y5MKKCY_p; Sat, 18 Jul 2020 18:53:04 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 63C3142576; Sat, 18 Jul 2020 18:53:04 +0200 (CEST)
Date:   Sat, 18 Jul 2020 18:53:04 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Fabio Estevam <festevam@gmail.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-binding: display: Allow a single port node on
 rocktech,jh057n00900
Message-ID: <20200718165304.GB26122@bogon.m.sigxcpu.org>
References: <20200703114717.2140832-1-megous@megous.com>
 <20200703114717.2140832-3-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200703114717.2140832-3-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Jul 03, 2020 at 01:47:17PM +0200, Ondrej Jirman wrote:
> The display has one port. Allow it in the binding.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  .../devicetree/bindings/display/panel/rocktech,jh057n00900.yaml  | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> index a6985cd947fb..d5733ef30954 100644
> --- a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> @@ -24,6 +24,7 @@ properties:
>          # Xingbangda XBD599 5.99" 720x1440 TFT LCD panel
>        - xingbangda,xbd599
>  
> +  port: true
>    reg:
>      maxItems: 1
>      description: DSI virtual channel

Reviewed-by: Guido Günther <agx@sigxcpu.org>
 -- Guido

> -- 
> 2.27.0
> 
