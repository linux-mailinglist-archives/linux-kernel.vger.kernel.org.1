Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB4D2609C6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 07:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgIHFFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 01:05:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgIHFFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 01:05:41 -0400
Received: from localhost (unknown [122.182.239.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C78C52078B;
        Tue,  8 Sep 2020 05:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599541540;
        bh=h7ulyY1ECSDj4DDRDKfQHLDqzFTyxT+YLVGkU/FGt9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aQu+Rfz1DrAR4iOec0oxzm/Bo5DICB8wxSsSGsiUVq8aoA/W0XMDD4FyeRs+QF52o
         JXmO/tViJ7UQ0OjjkC3ttz1w+lLllt32XOIO5voC0e4QHKpocmPgxoXkg6ntT7Qxh0
         AJvUuo3rZRbvNOk/dXBxBzZ4gm65HVk/BYAmMNRc=
Date:   Tue, 8 Sep 2020 10:35:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mparab@cadence.com,
        yamonkar@cadence.com, tomi.valkeinen@ti.com, jsarha@ti.com,
        nsekhar@ti.com
Subject: Re: [PATCH v2 0/7] PHY: Prepare Cadence Torrent PHY driver to
 support multilink configurations
Message-ID: <20200908050533.GB77521@vkoul-mobl>
References: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-08-20, 15:28, Swapnil Jakhade wrote:
> Cadence Torrent PHY is a multiprotocol PHY supporting different multilink
> PHY configurations including DisplayPort, PCIe, USB, SGMII, QSGMII etc.
> Existing Torrent PHY driver supports only DisplayPort. This patch series
> prepares Torrent PHY driver so that different multilink configurations can
> be supported. It also updates DT bindings accordingly. This doesn't affect
> ABI as Torrent PHY driver has never been functional, and therefore do not
> exist in any active use case.
> 
> Support for different multilink configurations with register sequences for
> protocols above will be added in a separate patch series.

Series looks good to me.

> This patch series is dependent on PHY attributes patch series [1].

I did not see any obvious depends in the series, if it is not maybe good
to rebase and send without dependency

-- 
~Vinod
