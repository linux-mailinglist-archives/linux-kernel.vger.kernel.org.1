Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9971D8AD0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 00:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgERW2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 18:28:21 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52640 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbgERW2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:28:11 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jaoEv-00005F-OU; Tue, 19 May 2020 00:28:05 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: rockchip: fix defines in pd_vio node for rk3399
Date:   Tue, 19 May 2020 00:28:00 +0200
Message-Id: <158984064169.2259329.3276929143055218816.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200428203003.3318-1-jbx6244@gmail.com>
References: <20200428203003.3318-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 22:30:02 +0200, Johan Jonker wrote:
> A test with the command below gives for example this error:
> 
> arch/arm64/boot/dts/rockchip/rk3399-evb.dt.yaml: pd_vio@15:
> 'pd_tcpc0@RK3399_PD_TCPC0', 'pd_tcpc1@RK3399_PD_TCPC1'
> do not match any of the regexes:
> '.*-names$', '.*-supply$', '^#.*-cells$',
> '^#[a-zA-Z0-9,+\\-._]{0,63}$',
> '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$',
> '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$',
> '^__.*__$', 'pinctrl-[0-9]+'
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: fix defines in pd_vio node for rk3399
      commit: 84836ded76ec9a6f25d1d0acebaad44977e0ec6f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
