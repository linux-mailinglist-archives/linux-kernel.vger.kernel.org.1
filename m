Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9ECE2C85E2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgK3NvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:51:12 -0500
Received: from gloria.sntech.de ([185.11.138.130]:44474 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgK3NvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:51:12 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kjjZQ-0002YW-KJ; Mon, 30 Nov 2020 14:50:24 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Will Deacon <will@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Tom Cubie <tom@radxa.com>, linux-kernel@vger.kernel.org,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH 1/2] arm64: defconfig: Enable RTC_DRV_HYM8563
Date:   Mon, 30 Nov 2020 14:50:21 +0100
Message-Id: <160674371009.1066509.16638501077486662468.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201023181814.220974-1-jagan@amarulasolutions.com>
References: <20201023181814.220974-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Oct 2020 23:48:13 +0530, Jagan Teki wrote:
> RTC HYM8563 used in the ARM64 Rockchip SoC's SDIO power
> sequence enablement.
> 
> Enable it as module.

Applied both patches, thanks!


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
