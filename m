Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2C41D8AC7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 00:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgERW2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 18:28:13 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52628 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbgERW2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:28:11 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jaoEw-00005F-0v; Tue, 19 May 2020 00:28:06 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: fix phy nodename for rk3328
Date:   Tue, 19 May 2020 00:28:01 +0200
Message-Id: <158984064169.2259329.15579989069543124777.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200505170227.6503-1-jbx6244@gmail.com>
References: <20200321215423.12176-1-jbx6244@gmail.com> <20200505170227.6503-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 May 2020 19:02:27 +0200, Johan Jonker wrote:
> A test with the command below gives for example this error:
> 
> arch/arm64/boot/dts/rockchip/rk3328-evb.dt.yaml: phy@0:
> '#phy-cells' is a required property
> 
> The phy nodename is normally used by a phy-handle.
> This node is however compatible with
> "ethernet-phy-id1234.d400", "ethernet-phy-ieee802.3-c22"
> which is just been added to 'ethernet-phy.yaml'.
> So change nodename to 'ethernet-phy' for which '#phy-cells'
> is not a required property
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: fix phy nodename for rk3328
      commit: 8370cc5533b3baa5e0f18075ae638b050458aabd

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
