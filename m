Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A6C1C1F18
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 23:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgEAUyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 16:54:45 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:48794 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgEAUyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:54:45 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 729062002A;
        Fri,  1 May 2020 22:54:39 +0200 (CEST)
Date:   Fri, 1 May 2020 22:54:38 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: display: Document TM5P5 NT35596 panel
 compatible
Message-ID: <20200501205438.GA26726@ravnborg.org>
References: <20200501204825.146424-1-konradybcio@gmail.com>
 <20200501204825.146424-3-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200501204825.146424-3-konradybcio@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8 a=nsjD_eZvI9l_Tp8ZG94A:9
        a=wPNLvfGTeEIA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad.

Thanks for the new panel binding.
But you need to redo this as panel bindings today must be in DT Schema
format (.yaml).
Please see other bindings in the same dir for examples.

	Sam

On Fri, May 01, 2020 at 10:48:23PM +0200, Konrad Dybcio wrote:
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> ---
>  .../devicetree/bindings/display/panel/tm5p5,nt35596.txt    | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/tm5p5,nt35596.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/tm5p5,nt35596.txt b/Documentation/devicetree/bindings/display/panel/tm5p5,nt35596.txt
> new file mode 100644
> index 0000000000000..6be56983482bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/tm5p5,nt35596.txt
> @@ -0,0 +1,7 @@
> +TM5P5 NT35596 5.5" 1080×1920 LCD Panel
> +
> +Required properties:
> +  - compatible: "tm5p5,nt35596"
> +  - reset-gpios: GPIO spec for reset pin
> +  - vdd-supply: VDD regulator
> +  - vddio-supply: VDDIO regulator
> -- 
> 2.26.1
