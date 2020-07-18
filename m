Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85493224C57
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 17:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgGRPOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 11:14:20 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39290 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 11:14:20 -0400
Received: from x2f7f83e.dyn.telefonica.de ([2.247.248.62] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jwoXY-0007lj-G9; Sat, 18 Jul 2020 17:14:16 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: rockchip: Fix VBUS on rk3288-vyasa
Date:   Sat, 18 Jul 2020 17:14:14 +0200
Message-Id: <159508524658.17330.14380421061218290244.b4-ty@sntech.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707101214.2301768-1-michael@amarulasolutions.com>
References: <20200707101214.2301768-1-michael@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 12:12:14 +0200, Michael Trimarchi wrote:
> Connect the voltage regulator of vbus to the otg connector.
> Depending on the current mode this is enabled (in "host" mode")
> or disabled (in "peripheral" mode). The regulator must be updated
> if the controller is configured in "otg" mode and the status changes
> between "host" and "peripheral".

Applied, thanks!

[1/1] ARM: dts: rockchip: Fix VBUS on rk3288-vyasa
      commit: 719646b76a41b8a482f8701825b635e9710ab329

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
