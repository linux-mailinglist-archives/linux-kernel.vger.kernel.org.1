Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9392B0785
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgKLOZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:25:02 -0500
Received: from muru.com ([72.249.23.125]:48178 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbgKLOZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:25:02 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9666480AE;
        Thu, 12 Nov 2020 14:25:06 +0000 (UTC)
Date:   Thu, 12 Nov 2020 16:24:57 +0200
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
Subject: Re: [PATCH V2 5/5] arm64: dts: ti: am65/j721e/j7200: Mark firmware
 used uart as "reserved"
Message-ID: <20201112142457.GV26857@atomide.com>
References: <20201112014929.25227-1-nm@ti.com>
 <20201112014929.25227-6-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112014929.25227-6-nm@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [201112 01:49]:
> Follow the device tree standards that states to set the
> status="reserved" if an device is operational, but used by a non-linux
> firmware in the system.

Makes sense to me:

Reviewed-by: Tony Lindgren <tony@atomide.com>
