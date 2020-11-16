Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A59E2B3DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgKPHiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:38:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:46296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbgKPHiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:38:01 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA0E02227F;
        Mon, 16 Nov 2020 07:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605512280;
        bh=HZYKaCjuFYm1x81FaBrewRuQuRwQHQ4aSvcmjFLaPXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KlpdHlNJx806C1/bW6pg2aUKzBONsmXGEsSt4Qz9sK9I150yhhPXZZ3nbXaHBI7uy
         6iSNoFCRQ5emx4wNttjj45Y4mNt95xsudWgOSfqcx1wydjEqWvApGBiZrczA86t4nc
         ++7+mvrts5aObfAwGIiyFDB6MIpQ+UrKKmlwmPKs=
Date:   Mon, 16 Nov 2020 13:07:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Etienne Carriere <etienne.carriere@st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/2] phy: stm32: don't print an error on probe deferral
Message-ID: <20201116073756.GL7499@vkoul-mobl>
References: <20201110102305.27205-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110102305.27205-1-amelie.delaunay@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-11-20, 11:23, Amelie Delaunay wrote:
> Change stm32-usbphyc driver to not print an error message when the device
> probe operation is deferred.

Applied all, thanks

-- 
~Vinod
