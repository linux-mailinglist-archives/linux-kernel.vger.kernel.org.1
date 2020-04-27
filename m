Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673FF1BAE32
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 21:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgD0Tmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 15:42:38 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46448 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgD0Tmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:42:35 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jT9eB-00007W-C8; Mon, 27 Apr 2020 21:42:31 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: fix pinctrl sub nodename for spi in rk322x.dtsi
Date:   Mon, 27 Apr 2020 21:42:26 +0200
Message-Id: <158801649141.50507.14560694452002330366.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200424123923.8192-1-jbx6244@gmail.com>
References: <20200424123923.8192-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 14:39:23 +0200, Johan Jonker wrote:
> A test with the command below gives these errors:
> 
> arch/arm/boot/dts/rk3229-evb.dt.yaml: spi-0:
> '#address-cells' is a required property
> arch/arm/boot/dts/rk3229-evb.dt.yaml: spi-1:
> '#address-cells' is a required property
> arch/arm/boot/dts/rk3229-xms6.dt.yaml: spi-0:
> '#address-cells' is a required property
> arch/arm/boot/dts/rk3229-xms6.dt.yaml: spi-1:
> '#address-cells' is a required property
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: rockchip: fix pinctrl sub nodename for spi in rk322x.dtsi
      commit: 855bdca1781c79eb661f89c8944c4a719ce720e8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
