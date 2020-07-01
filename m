Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E11C210D1F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 16:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbgGAOHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 10:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbgGAOHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 10:07:34 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D938E2068F;
        Wed,  1 Jul 2020 14:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593612453;
        bh=jDUclDpj8mV8KImAtlH1CFivMXps1jDitGyJjc1qS3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qz70uUT0upQoGhjvozXuO8en3st9B+rMczbZLLJdq6aogZ3mb0mPYJzsnEfrDNYld
         9UO7NrfVm9/HobD3/BG5ZV+wlrkc/QPgfJnAv85biivY8YIHL++cfK9oFTjiWct9G6
         mkZeoVSi/2CDyptwdGkWPl1VR1Zdh9wD/n0KQnsE=
Date:   Wed, 1 Jul 2020 19:37:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: phy: zynqmp-psgtr: Fix example's numbers of
 cells in reg
Message-ID: <20200701140729.GB2599@vkoul-mobl>
References: <20200701134853.30656-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701134853.30656-1-laurent.pinchart@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-07-20, 16:48, Laurent Pinchart wrote:
> The DT examples are by default compiled in a parent that has
>  #address-cells and #size-cells both set to 1. Fix the example
> accordingly, even if it doesn't match the actual hardware, as this is
> the recommended practice for DT bindings examples.

Applied, thanks

-- 
~Vinod
