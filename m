Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BD22FA0B5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392021AbhARNFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:05:51 -0500
Received: from gloria.sntech.de ([185.11.138.130]:47500 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390640AbhARM63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:58:29 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l1U6D-000424-Uh; Mon, 18 Jan 2021 13:57:38 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: (subset) [PATCH 1/3] ARM: dts: rockchip: rename thermal subnodes for rk3288.dtsi
Date:   Mon, 18 Jan 2021 13:57:33 +0100
Message-Id: <161097370156.287816.791052279750108287.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117150953.16475-1-jbx6244@gmail.com>
References: <20210117150953.16475-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jan 2021 16:09:51 +0100, Johan Jonker wrote:
> A test with the command below gives for example this error:
> /arch/arm/boot/dts/rk3288-tinker.dt.yaml:
> thermal-zones: 'cpu_thermal', 'gpu_thermal', 'reserve_thermal'
> do not match any of the regexes:
> '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'
> 
> Rename Rockchip rk3288 thermal subnodes
> so that it ends with "-thermal"
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: rockchip: rename thermal subnodes for rk3368.dtsi
      commit: 7c96a5cf680ac7339999becd454e1f2fd9b258fb
[3/3] arm64: dts: rockchip: rename thermal subnodes for rk3399.dtsi
      commit: e58061b59787270a57839397e50bb4400b9e2de9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
