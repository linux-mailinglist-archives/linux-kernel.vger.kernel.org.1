Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9063030309B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 00:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbhAYXzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 18:55:02 -0500
Received: from gloria.sntech.de ([185.11.138.130]:33902 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731500AbhAYXy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 18:54:58 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l4BgT-000664-Ry; Tue, 26 Jan 2021 00:54:13 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add device_type property to rk3399 pcie node
Date:   Tue, 26 Jan 2021 00:54:13 +0100
Message-ID: <4620030.31r3eYUQgx@phil>
In-Reply-To: <20210122180559.18171-1-jbx6244@gmail.com>
References: <20210122180559.18171-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 22. Januar 2021, 19:05:59 CET schrieb Johan Jonker:
> A test with the command below gives for example this error:
> /arch/arm64/boot/dts/rockchip/rk3399-rock960.dt.yaml:
> pcie@f8000000: 'device_type' is a required property
> 
> Fix this by adding a device_type property to the rk3399 pcie node.
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/
> schemas/pci/pci-bus.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

already done in
https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v5.11-armsoc/dtsfixes&id=43f20b1c6140896916f4e91aacc166830a7ba849


