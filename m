Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1C11D8ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 00:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgERW2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 18:28:11 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52632 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728359AbgERW2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:28:10 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jaoEv-00005F-7R; Tue, 19 May 2020 00:28:05 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH] arm64: dts: rockchip: remove disable-wp from rk3308-roc-cc emmc node
Date:   Tue, 19 May 2020 00:27:58 +0200
Message-Id: <158984064169.2259329.2215953121884920884.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20191219121954.2450-1-jbx6244@gmail.com>
References: <20191219121954.2450-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2019 13:19:54 +0100, Johan Jonker wrote:
> The mmc-controller.yaml didn't explicitly say disable-wp is
> for SD card slot only, but that is what it was designed for
> in the first place.
> Remove all disable-wp from emmc or sdio controllers.

Applied, thanks!

[1/1] arm64: dts: rockchip: remove disable-wp from rk3308-roc-cc emmc node
      commit: 1fab4cf51e48e9525cf70a9604e90dd3dd666a2f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
