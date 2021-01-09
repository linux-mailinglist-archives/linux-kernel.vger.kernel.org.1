Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972002F00E7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 16:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbhAIPkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 10:40:40 -0500
Received: from gloria.sntech.de ([185.11.138.130]:36642 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbhAIPki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 10:40:38 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kyGLM-0000jX-O8; Sat, 09 Jan 2021 16:39:56 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org
Subject: Re: (subset) [PATCH v2 1/4] ARM: dts: rockchip: add QoS register compatibles for rk3066/rk3188
Date:   Sat,  9 Jan 2021 16:39:49 +0100
Message-Id: <161020678303.3482489.18290216929874336363.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206103711.7465-1-jbx6244@gmail.com>
References: <20201206103711.7465-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Dec 2020 11:37:08 +0100, Johan Jonker wrote:
> With the conversion of syscon.yaml minItems for compatibles
> was set to 2. Current Rockchip dtsi files only use "syscon" for
> QoS registers. Add Rockchip QoS compatibles for rk3066/rk3188
> to reduce notifications produced with:
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/syscon.yaml

Applied, thanks!

[3/4] arm64: dts: rockchip: add QoS register compatibles for rk3399
      commit: bd3fd04910ab5e4d571c19f50c341de175597dfa
[4/4] arm64: dts: rockchip: add QoS register compatibles for px30
      commit: 6c3ae9f9a133d387ef4e1b4297c9df4e9a1c469d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
