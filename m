Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF8A2C8199
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgK3KDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:03:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:60950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgK3KDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:03:01 -0500
Received: from localhost (unknown [122.171.214.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64AE220855;
        Mon, 30 Nov 2020 10:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606730540;
        bh=MrvHp+QaAwZN0j5U0NA9vpfUa5C8veOC1J4dptqhh1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0cU8ezEUceeNWFmG0T68/GzROtiHH/dCjfzNV6OEojCw7xTIzOoUQa55R9iT8mX6H
         rArNaWRMudvn5YFBrzwdhzQNaTcMsu8oOMHT/qVri+McS+nkt7QDt5FRFT9IW76R4O
         4BAfxgDIgsahXF04UkpRrGoJ71QYBPj+0cqY9CYE=
Date:   Mon, 30 Nov 2020 15:32:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v4 0/2] phy: intel: Add Keem Bay USB PHY support
Message-ID: <20201130100211.GL8403@vkoul-mobl>
References: <20201116120831.32641-1-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116120831.32641-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-20, 20:08, Wan Ahmad Zainie wrote:
> Hi.
> 
> Intel Keem Bay USB subsystem incorporates DesignWare USB3.1 controller,
> an USB3.1 (Gen1/2) PHY and an USB2.0 PHY. It is a Dual Role Device
> (DRD), operating as either a USB host or a USB device.

Applied all, thanks

-- 
~Vinod
