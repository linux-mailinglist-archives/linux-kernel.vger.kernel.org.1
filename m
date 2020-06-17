Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3761FC928
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 10:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgFQIqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 04:46:03 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43218 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgFQIqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:46:02 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jlThn-00062C-UK; Wed, 17 Jun 2020 10:45:59 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/2] ARM: dts: rockchip: rename label and nodename pinctrl subnodes that end with gpio
Date:   Wed, 17 Jun 2020 10:45:58 +0200
Message-Id: <159238352489.1408655.17289334888304699451.b4-ty@sntech.de>
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

[1/2] ARM: dts: rockchip: rename label and nodename pinctrl subnodes that end with gpio
      commit: fff987e7328951f7d6fb2d0545de8635ceafa89f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
