Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC682B3D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgKPHVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:21:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:43954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgKPHVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:21:00 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E79A02224F;
        Mon, 16 Nov 2020 07:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605511259;
        bh=USE1eoOM7a/YxTA2VViU+dFQkDRh4BDj9agOemMLxgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yl8Nx9tqnEriAiAY7wpDmB1mJ7Z5tXbBVbFsO4D+ASMYUt966z0liFeNJUDkS13gB
         J6Va21CR7oHzxruKl31MjsA+0Xmh7OYUaYqLlEnpdpUuQKpKy0itO6f1l2uB0AJ2tC
         8+ez5Y1a31ceJQaHLYmsFyw3AYVFFyTCYbDBZ6s4=
Date:   Mon, 16 Nov 2020 12:50:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mparab@cadence.com,
        yamonkar@cadence.com, tomi.valkeinen@ti.com, jsarha@ti.com,
        nsekhar@ti.com
Subject: Re: [PATCH] dt-bindings: phy: Add Cadence Sierra PHY bindings in
 YAML format
Message-ID: <20201116072055.GF7499@vkoul-mobl>
References: <1603898561-5142-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603898561-5142-1-git-send-email-sjakhade@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-10-20, 16:22, Swapnil Jakhade wrote:
> Add Cadence Sierra PHY bindings in YAML format.

Applied, thanks

-- 
~Vinod
