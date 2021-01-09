Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB8E2F00EC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 16:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbhAIPks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 10:40:48 -0500
Received: from gloria.sntech.de ([185.11.138.130]:36752 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbhAIPkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 10:40:43 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kyGLM-0000jX-4l; Sat, 09 Jan 2021 16:39:56 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: defconfig: Enable REGULATOR_MP8859
Date:   Sat,  9 Jan 2021 16:39:47 +0100
Message-Id: <161020678303.3482489.13826472381359966074.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20200731160324.142097-1-jagan@amarulasolutions.com>
References: <20200731160324.142097-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 21:33:24 +0530, Jagan Teki wrote:
> RK3399 boards like ROC-RK3399-PC is using MP8859 DC/DC converter
> for 12V supply.
> 
> roc-rk3399-pc initially used 12V fixed regulator for this supply,
> but the below commit has switched to use MP8859.
> 
> commit <1fc61ed04d309b0b8b3562acf701ab988eee12de> "arm64: dts: rockchip:
> Enable mp8859 regulator on rk3399-roc-pc"
> 
> [...]

Applied, thanks!

[1/1] arm64: defconfig: Enable REGULATOR_MP8859
      commit: 3c8e5d51e4c6e5e93d31f59d4a54fb3a14358ee4

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
