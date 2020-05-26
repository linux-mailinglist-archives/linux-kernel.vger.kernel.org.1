Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65511AF9CF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 14:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgDSMIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 08:08:40 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56090 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgDSMIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 08:08:39 -0400
Received: from p508fcedd.dip0.t-ipconnect.de ([80.143.206.221] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jQ8kQ-0006c3-T7; Sun, 19 Apr 2020 14:08:30 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: display: convert rockchip rk3066 hdmi bindings to yaml
Date:   Sun, 19 Apr 2020 14:08:25 +0200
Message-ID: <5903181.62QgbpdqVa@phil>
In-Reply-To: <20200403133630.7377-1-jbx6244@gmail.com>
References: <20200403133630.7377-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am Freitag, 3. April 2020, 15:36:30 CEST schrieb Johan Jonker:
> Current dts files with 'hdmi' nodes for rk3066 are manually verified.
> In order to automate this process rockchip,rk3066-hdmi.txt
> has to be converted to yaml.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.yaml
> @@ -0,0 +1,140 @@
> +# SPDX-License-Identifier: GPL-2.0

checkpatch complains about the licensing:

-:100: WARNING:SPDX_LICENSE_TAG: DT binding documents should be licensed (GPL-2.0-only OR BSD-2-Clause)
#100: FILE: Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.yaml:1:
+# SPDX-License-Identifier: GPL-2.0

please consider adapting the license accordingly

Thanks
Heiko


