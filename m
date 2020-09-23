Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE43275045
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 07:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgIWF2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 01:28:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgIWF2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 01:28:15 -0400
Received: from localhost (unknown [122.171.175.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DAF421974;
        Wed, 23 Sep 2020 05:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600838895;
        bh=RjhLMXt/b1I6E+E0MwKZD5yTljhVA2abPNYP6STiOwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uvvcptujw0Cg/1IcRUASNopFQ1uHXSIp4eufrELpZTY6t+W0AKA0uGTeUwfBj7ma6
         0Q4wSIVTH8XOONeb/2DPLBBZdapaaVmcIxRVxEcZ36/6YFzuHfouAO75oUpENZbZTm
         wsP0/x8nzsoQvs8JxeAOs17CIbxDGmgsvH9PagVk=
Date:   Wed, 23 Sep 2020 10:58:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: cdns,torrent-phy: add
 reset-names
Message-ID: <20200923052806.GC2968@vkoul-mobl>
References: <20200918083743.213874-1-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918083743.213874-1-tomi.valkeinen@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-09-20, 11:37, Tomi Valkeinen wrote:
> Add reset-names as a required property.
> 
> There are no dts files using torrent phy yet, so it is safe to add a new
> required property.

Applied both, thanks

-- 
~Vinod
