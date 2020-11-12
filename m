Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6662B0770
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgKLORr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:17:47 -0500
Received: from muru.com ([72.249.23.125]:48118 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLORq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:17:46 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 932F780AE;
        Thu, 12 Nov 2020 14:17:50 +0000 (UTC)
Date:   Thu, 12 Nov 2020 16:17:41 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Roger Quadros <rogerq@ti.com>, Keerthy <j-keerthy@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/5] arm64: dts: ti: k3-am65*: Cleanup disabled nodes
 at SoC dtsi level
Message-ID: <20201112141741.GQ26857@atomide.com>
References: <20201112014929.25227-1-nm@ti.com>
 <20201112014929.25227-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112014929.25227-2-nm@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [201112 01:49]:
> While there are pros and cons on each of these approaches, the right
> thing to do will be to stick with device tree default standards and
> work within those established rules. So, we choose to go with option
> (a).
> 
> Lets cleanup defaults of am654 SoC dtsi before this gets more harder
> to cleanup later on and new SoCs are added.
> 
> The dtb generated is identical with the patch and it is just cleanup to
> ensure we have a clean usage model

Thanks this looks good to me:

Reviewed-by: Tony Lindgren <tony@atomide.com>
