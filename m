Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8506F2C85DF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgK3NvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:51:07 -0500
Received: from gloria.sntech.de ([185.11.138.130]:44462 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgK3NvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:51:06 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kjjZQ-0002YW-V4; Mon, 30 Nov 2020 14:50:25 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: rockchip: rename wdt nodename to watchdog in rv1108.dtsi
Date:   Mon, 30 Nov 2020 14:50:22 +0100
Message-Id: <160674371009.1066509.12752605391442707719.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116150756.14265-1-jbx6244@gmail.com>
References: <20201116150756.14265-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 16:07:56 +0100, Johan Jonker wrote:
> A test with the command below gives for example this error:
> 
> /arch/arm/boot/dts/rv1108-evb.dt.yaml:
> wdt@10360000: $nodename:0: 'wdt@10360000'
> does not match '^watchdog(@.*|-[0-9a-f])?$'
> 
> Fix it by renaming the wdt nodename to watchdog
> in the rv1108.dtsi file.
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: rockchip: rename wdt nodename to watchdog in rv1108.dtsi
      commit: 06bccda2c13c07d4ac7ebfef766a968c788cbdbf

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
