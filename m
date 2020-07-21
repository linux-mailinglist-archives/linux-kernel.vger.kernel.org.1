Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076B6228758
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 19:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbgGURaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 13:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbgGURaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:30:14 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB5472065D;
        Tue, 21 Jul 2020 17:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595352613;
        bh=ivHskNM+Pzn/uxKF3bGeiO3eYOoZTUBmqmoPTc51p0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pYc8ac+q5DvNUo0IZN5t0WjWeadKhYBtcqiWnRgr3rIqYq14n+dJ8yB0GD/EqKqDP
         3kapzZ5xXdIoT3LlYByRzbHb9BDBKnLJiAdcJyRGNY2FiNhp9jGbZf2pRnICkCaMX4
         fhHIo+4jv0opfsN2LLSRc5cpTrYMMqOtDGxzyMno=
Date:   Tue, 21 Jul 2020 23:00:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     jonas.gorski@gmail.com, kishon@ti.com, robh+dt@kernel.org,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        p.zabel@pengutronix.de, krzk@kernel.org,
        gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 0/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
Message-ID: <20200721173009.GO12965@vkoul-mobl>
References: <20200720131209.1236590-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200720131209.1236590-1-noltari@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-20, 15:12, Álvaro Fernández Rojas wrote:
> Add BCM63xx USBH PHY driver for BMIPS.
> 
> v8: readd Simon as author and remove his email address from the source code.
> v7: remove Simon from authors and introduce changes suggested by Rob:
>   - Move clock conditions to the main section.
>   - Set missing additionalProperties to false.
> v6: introduce changes suggested by Rob and Vinod:
>  - Remove BMIPS_GENERIC default from kconfig.
>  - Print registered message as debug.
>  - Add another if case to device tree binding for SoCs with just 1 clock.
>  - Ignored "additionalProperties: false" suggestion since it triggers a
>   warning. This has been reported, but I haven't received any answer yet.
> v5: use devm_reset_control_get_exclusive.
> v4: fix dt-bindings documentation and improve device mode config.
> v3: introduce changes suggested by Florian:
>  - Add support for device mode.
> v2: introduce changes suggested by Florian:
>  - phy-cells changed to 1.
>  - Drop OF dependency (use device_get_match_data).
>  - Drop __initconst from variant tables.
>  - Use devm_clk_get_optional.

Applied, thanks

-- 
~Vinod
