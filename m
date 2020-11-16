Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9012B4022
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 10:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgKPJqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 04:46:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:41730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgKPJqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 04:46:16 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30AE420782;
        Mon, 16 Nov 2020 09:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605519976;
        bh=88dgvohs5sFfjwOsI6WM53YIqM3Q3dM9tg6dsFyp4bE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OWn7aaXR7ABabK9+RwFQUlkWeeIKuufY6m2/1e8PiAn4xkpyB9IZ9JqwlM6btiatf
         pObXnDohcXpGz2QYMaRFGqRGOL5glx91V6RQ5XweEqTxUrgsAfqXKFCtv2nVN85nfc
         Su5vBYtQZho8oyUhoP5Q1NdSeweG2J7LoYhW2z6I=
Date:   Mon, 16 Nov 2020 15:16:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] phy: amlogic: Add support for AXG MIPI D-PHY
Message-ID: <20201116094611.GT7499@vkoul-mobl>
References: <20201104134730.1545875-1-narmstrong@baylibre.com>
 <b2aa7b6c-b590-ff4a-d161-364e4e968b26@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2aa7b6c-b590-ff4a-d161-364e4e968b26@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-20, 09:47, Neil Armstrong wrote:
> Hi Vinod, Kishon,
> 
> 
> On 04/11/2020 14:47, Neil Armstrong wrote:
> > The Amlogic AXg SoCs embeds a MIPI D-PHY to communicate with DSI
> > panels, this adds the bindings.
> > 
> > This D-PHY depends on a separate analog PHY.

Am not sure why but these two do not seem to be in my inbox, can you
please resend this and the other one please

-- 
~Vinod
