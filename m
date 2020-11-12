Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DAC2B0779
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgKLOUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:20:03 -0500
Received: from muru.com ([72.249.23.125]:48162 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbgKLOUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:20:01 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 31C0480AE;
        Thu, 12 Nov 2020 14:20:06 +0000 (UTC)
Date:   Thu, 12 Nov 2020 16:19:56 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Keerthy <j-keerthy@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/5] arm64: dts: ti: k3-am654-base-board: Fix up
 un-necessary status set to "okay" for USB
Message-ID: <20201112141956.GU26857@atomide.com>
References: <20201112014929.25227-1-nm@ti.com>
 <20201112014929.25227-5-nm@ti.com>
 <ff878520-4939-0f51-dabf-7f7b5ff54311@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff878520-4939-0f51-dabf-7f7b5ff54311@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [201112 13:01]:
> On 12/11/2020 03:49, Nishanth Menon wrote:
> > The default state of a device tree node is "okay". There is no specific
> > use of explicitly adding status = "okay" in the board dts.
> > 
> > Fixes: 7e7e7dd51d06 ("arm64: dts: ti: k3-am654-base-board: enable USB1")
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > Cc: Roger Quadros <rogerq@ti.com>
> 
> Acked-by: Roger Quadros <rogerq@ti.com>

Reviewed-by: Tony Lindgren <tony@atomide.com>
