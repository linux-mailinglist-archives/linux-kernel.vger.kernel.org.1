Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3AD26F546
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 07:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgIRFGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 01:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgIRFGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 01:06:43 -0400
Received: from localhost (unknown [136.185.124.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B4772176B;
        Fri, 18 Sep 2020 05:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600405602;
        bh=2N1BAoy3owj2IQTBTXXVpM2bnpLhEQ68IoREQojSbYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yL/ZImgYyLanyBwaVCh8tC2NPxMTiFNHL2X/zZ1efBOXtkh/MgTc9tAKr2AbbqNBJ
         4WP1Fk8Tyub7CWTIl8kgNUCNuMdn3GXMGvrsjXcJo7Ex3Jl2l/NUd1XlqsfupGdyUL
         ZQBmTNbWdNGg5nT/x8ClR34Ch2YUwf5Rg+4VRQL4=
Date:   Fri, 18 Sep 2020 10:36:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mparab@cadence.com,
        yamonkar@cadence.com, tomi.valkeinen@ti.com, jsarha@ti.com,
        nsekhar@ti.com
Subject: Re: [PATCH v3 0/7] PHY: Prepare Cadence Torrent PHY driver to
 support multilink configurations
Message-ID: <20200918050638.GB2968@vkoul-mobl>
References: <1600280911-9214-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600280911-9214-1-git-send-email-sjakhade@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-09-20, 20:28, Swapnil Jakhade wrote:
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

Applied, thanks

-- 
~Vinod
