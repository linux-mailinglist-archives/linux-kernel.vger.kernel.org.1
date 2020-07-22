Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4081C22A013
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 21:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732841AbgGVTV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 15:21:26 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47724 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgGVTVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:21:24 -0400
Received: from x2f7fa19.dyn.telefonica.de ([2.247.250.25] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jyKIr-0005Ud-74; Wed, 22 Jul 2020 21:21:21 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        linux-rockchip@lists.infradead.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH 1/3] ARM: dts: rockchip: Add USB for RockPI N8/N10
Date:   Wed, 22 Jul 2020 21:21:05 +0200
Message-Id: <159544564767.763387.9815839004542852680.b4-ty@sntech.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720110230.367985-1-jagan@amarulasolutions.com>
References: <20200720110230.367985-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 16:32:28 +0530, Jagan Teki wrote:
> Radxa dalang carrier board has 2x USB 2.0 and 1x USB 3.0
> ports.
> 
> This patch adds support to enable all these USB ports for
> N10 and N8 combinations SBCs.
> 
> Note that the USB 3.0 port on RockPI N8 combination works
> as USB 2.0 OTG since it is driven from RK3288.

Applied, thanks!

[1/3] ARM: dts: rockchip: Add USB for RockPI N8/N10
      commit: 417b188a985d3557b0ecb5623b27bd9843f03aec
[2/3] ARM: dts: rockchip: Add HDMI out for RockPI N8/N10
      commit: d0cb2f30e7c033f0a8bbe98ec73dbc1db4788942
[3/3] arm64: dts: rockchip: Add PCIe for RockPI N10
      commit: 93ca8ac2e8fcea6feb02a40edd2334144b62fc6e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
