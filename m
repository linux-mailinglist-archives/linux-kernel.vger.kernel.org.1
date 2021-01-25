Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E403030B4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 00:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbhAYX7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 18:59:05 -0500
Received: from gloria.sntech.de ([185.11.138.130]:34020 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbhAYX5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 18:57:13 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l4Big-00066j-Ns; Tue, 26 Jan 2021 00:56:30 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: cleanup cpu_thermal node of rk3399-rock960.dts
Date:   Tue, 26 Jan 2021 00:56:21 +0100
Message-Id: <161161878917.2050283.17103817523010630624.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118180054.9360-1-jbx6244@gmail.com>
References: <20210118180054.9360-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jan 2021 19:00:54 +0100, Johan Jonker wrote:
> The cpu_thermal node in the rk3399-rock960.dts file does not
> reference &cpu_thermal directly to add the board-specific parts,
> but also repeats all the SoC default properties.
> Clean the whole thing up and fix alignment.
> Place new nodes in the correct alphabetical order.
> Compered to rk3399.dtsi the temperature property in
> cpu_alert0 changes from <70000> to <65000>.
> A sustainable-power property was added.
> The trip property in cooling map0 points to <&cpu_alert1>
> instead of <&cpu_alert0>.

Applied, thanks!

[1/1] arm64: dts: rockchip: cleanup cpu_thermal node of rk3399-rock960.dts
      commit: 376e46b5dd0ad9d06f029bbc4a66dd25dd059597

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
