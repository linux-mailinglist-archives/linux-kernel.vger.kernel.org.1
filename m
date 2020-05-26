Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E60D1D8B20
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 00:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgERWmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 18:42:31 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52918 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgERWm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:42:29 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jaoSn-0000D0-7B; Tue, 19 May 2020 00:42:25 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Justin Swartz <justin.swartz@risingedge.co.za>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] ARM: dts: enable WLAN for Mecer Xtreme Mini S6
Date:   Tue, 19 May 2020 00:42:23 +0200
Message-Id: <158984169638.2264085.17568438379923007784.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406135006.23759-1-justin.swartz@risingedge.co.za>
References: <e602c1b8-3606-a8d3-c64c-ec9e58315974@gmail.com> <20200406135006.23759-1-justin.swartz@risingedge.co.za>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Apr 2020 13:50:04 +0000, Justin Swartz wrote:
> The Mecer Xtreme Mini S6 features a wireless module, based on a
> Realtek 8723BS, which provides WLAN and Bluetooth connectivity via
> SDIO and UART interfaces respectively.
> 
> Define a simple MMC power sequence that declares the GPIO pins
> connected to the module's WLAN Disable and Bluetooth Disable pins
> as active low reset signals, because both signals must be deasserted
> for WLAN radio operation.
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: enable WLAN for Mecer Xtreme Mini S6
      commit: 6067ec2c7ffacab4689ddfed3df74a467d112efe

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
