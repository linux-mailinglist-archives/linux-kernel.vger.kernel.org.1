Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3092B1AFA11
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 14:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgDSMgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 08:36:25 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56432 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgDSMgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 08:36:11 -0400
Received: from p508fcedd.dip0.t-ipconnect.de ([80.143.206.221] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jQ9BB-0006k5-QT; Sun, 19 Apr 2020 14:36:09 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: add micro SD card regulator to rockpro64
Date:   Sun, 19 Apr 2020 14:35:58 +0200
Message-Id: <158729964647.70529.2619682470015783245.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416145534.1263575-1-t.schramm@manjaro.org>
References: <20200416145534.1263575-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 16:55:34 +0200, Tobias Schramm wrote:
> This patch adds the RockPro64's micro SD card regulator to the
> RockPro64 dtsi. The regulator is present on all revisions of the
> device.
> Previously the regular was missing, resulting in unreliable boot
> behaviour when booting from SD card.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: add micro SD card regulator to rockpro64
      commit: 1f5a3e1679353fb53e955afd8801a7f4f60877ff

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
