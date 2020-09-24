Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1641B277997
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 21:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgIXTn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 15:43:57 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:50382 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIXTn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 15:43:56 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 15:43:55 EDT
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id D99292007A;
        Thu, 24 Sep 2020 21:38:08 +0200 (CEST)
Date:   Thu, 24 Sep 2020 21:38:07 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/3] dt-binding: display: Require two rests on
 mantix panel
Message-ID: <20200924193807.GA1223313@ravnborg.org>
References: <cover.1600707235.git.agx@sigxcpu.org>
 <71a9108f3472ba9af4bead01b1b770d1e73eb08e.1600707235.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71a9108f3472ba9af4bead01b1b770d1e73eb08e.1600707235.git.agx@sigxcpu.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=CaYmGojl c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=8nJEP1OIZ-IA:10 a=ze386MxoAAAA:8 a=6LdyRFKnEOD0PBeQgTUA:9
        a=wPNLvfGTeEIA:10 a=iBZjaW-pnkserzjvUTHh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido.

On Mon, Sep 21, 2020 at 06:55:52PM +0200, Guido Günther wrote:
> We need to reset both for the panel to show an image.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  .../bindings/display/panel/mantix,mlaf057we51-x.yaml       | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
> index 937323cc9aaa..ba5a18fac9f9 100644
> --- a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
> @@ -35,7 +35,9 @@ properties:
>    vddi-supply:
>      description: 1.8V I/O voltage supply
>  
> -  reset-gpios: true
> +  reset-gpios:
> +    minItems: 2
> +    maxItems: 2

reset-gpios is, as you already wrote, defined in panel-common.yaml.
Do not try to change it here.
It would be much better, I think, to introduce a mantix,reset-gpios
property.

This would avoid that we had two different reset-gpios definitions.

	Sam

>  
>    backlight: true
>  
> @@ -62,7 +64,8 @@ examples:
>              avdd-supply = <&reg_avdd>;
>              avee-supply = <&reg_avee>;
>              vddi-supply = <&reg_1v8_p>;
> -            reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
> +            reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>,
> +                          <&gpio1 24 GPIO_ACTIVE_LOW>;
>              backlight = <&backlight>;
>          };
>      };
> -- 
> 2.26.2
