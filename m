Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C7E1FC8E9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 10:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgFQIhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 04:37:17 -0400
Received: from gloria.sntech.de ([185.11.138.130]:42982 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbgFQIhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:37:16 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jlTZI-0005rL-P1; Wed, 17 Jun 2020 10:37:12 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: rockchip: rename label and nodename pinctrl subnodes that end with gpio
Date:   Wed, 17 Jun 2020 10:37:08 +0200
Message-Id: <159238301927.1406601.14874206586861717011.b4-ty@sntech.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200524160636.16547-1-jbx6244@gmail.com>
References: <20200524160636.16547-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 May 2020 18:06:35 +0200, Johan Jonker wrote:
> A test with the command below gives for example this error:
> 
> arch/arm/boot/dts/rk3288-tinker.dt.yaml: tsadc: otp-gpio:
> {'phandle': [[54]], 'rockchip,pins': [[0, 10, 0, 118]]}
> is not of type 'array'
> 
> 'gpio' is a sort of reserved nodename and should not be used
> for pinctrl in combination with 'rockchip,pins', so change
> nodes that end with 'gpio' to end with 'pin' or 'pins'.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: rename label and nodename pinctrl subnodes that end with gpio
      commit: 2bc65fef4fe424f5f8295175f1b42f8b94c6df01

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
