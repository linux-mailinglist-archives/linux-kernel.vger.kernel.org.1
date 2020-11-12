Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3FE2B0775
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgKLOTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:19:12 -0500
Received: from muru.com ([72.249.23.125]:48140 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLOTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:19:11 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1CB3180AE;
        Thu, 12 Nov 2020 14:19:15 +0000 (UTC)
Date:   Thu, 12 Nov 2020 16:19:06 +0200
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
Subject: Re: [PATCH V2 2/5] arm64: dts: ti: k3-j721e*: Cleanup disabled nodes
 at SoC dtsi level
Message-ID: <20201112141906.GS26857@atomide.com>
References: <20201112014929.25227-1-nm@ti.com>
 <20201112014929.25227-3-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112014929.25227-3-nm@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [201112 01:49]:
> The device tree standard states that when the status property is
> not present under a node, the okay value is assumed. There are many
> reasons for doing the same, the number of strings in the device
> tree, default power management functionality, etc. are a few of the
> reasons.

Reviewed-by: Tony Lindgren <tony@atomide.com>
