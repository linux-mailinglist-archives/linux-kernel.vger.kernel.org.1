Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B70D2B0777
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgKLOTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:19:43 -0500
Received: from muru.com ([72.249.23.125]:48154 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbgKLOTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:19:42 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4E5F280AE;
        Thu, 12 Nov 2020 14:19:47 +0000 (UTC)
Date:   Thu, 12 Nov 2020 16:19:37 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Roger Quadros <rogerq@ti.com>,
        Keerthy <j-keerthy@ti.com>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/5] arm64: dts: ti: am65/j721e: Fix up un-necessary
 status set to "okay" for crypto
Message-ID: <20201112141937.GT26857@atomide.com>
References: <20201112014929.25227-1-nm@ti.com>
 <20201112014929.25227-4-nm@ti.com>
 <774fa259-af70-d08e-605a-c419239e9a1a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <774fa259-af70-d08e-605a-c419239e9a1a@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [201112 13:34]:
> On 12/11/2020 03:49, Nishanth Menon wrote:
> > The default state of a device tree node is "okay". There is no specific
> > use of explicitly adding status = "okay" in the SoC dtsi.
> > 
> > Fixes: 8ebcaaae8017 ("arm64: dts: ti: k3-j721e-main: Add crypto accelerator node")
> > Fixes: b366b2409c97 ("arm64: dts: ti: k3-am6: Add crypto accelarator node")
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > Cc: Keerthy <j-keerthy@ti.com>
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>

Reviewed-by: Tony Lindgren <tony@atomide.com>
