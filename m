Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6792BA6F8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgKTKEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:04:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgKTKEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:04:23 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20F6C22244;
        Fri, 20 Nov 2020 10:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605866663;
        bh=ARRNZfpi+Mn1V6hzOdD605q35U5qiyEAfEvZ9NLxQYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zKMYARwWUfc4c3r+USqkSPVcAVGEPkVMTtKs8egzt2R6APjiPlEQ5fKpWa9rH6VHR
         7jRRF8FdsG1EEOeuPR8nPnlq2GZrbvOEfeftih+9T5nA2NwzP9w9tbHHYeIxFe1iUU
         ZqCg9fFGKhjSFgP31Kl/9yPrT/2P/S1vjOWmabkw=
Date:   Fri, 20 Nov 2020 15:34:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 1/1] dt-bindings: phy: phy-stm32-usbphyc: convert
 bindings to json-schema
Message-ID: <20201120100408.GG2925@vkoul-mobl>
References: <20201116171917.10447-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116171917.10447-1-amelie.delaunay@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-20, 18:19, Amelie Delaunay wrote:
> Convert the STM32 USB PHY Controller (USBPHYC) bindings to DT schema format
> using json-schema.

Applied, thanks

-- 
~Vinod
