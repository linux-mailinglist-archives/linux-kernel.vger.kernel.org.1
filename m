Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7501FC92B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 10:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgFQIqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 04:46:06 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43224 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgFQIqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:46:03 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jlThn-00062C-Jl; Wed, 17 Jun 2020 10:45:59 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, chromeos-bluetooth-upstreaming@chromium.org,
        mka@chromium.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: rockchip: Add marvell BT irq config
Date:   Wed, 17 Jun 2020 10:45:57 +0200
Message-Id: <159238352489.1408655.7330930491123467152.b4-ty@sntech.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200612130219.v2.1.I66864be898aa835ccb66b6cd5220d0b082338a81@changeid>
References: <20200612130219.v2.1.I66864be898aa835ccb66b6cd5220d0b082338a81@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020 13:02:48 -0700, Abhishek Pandit-Subedi wrote:
> Veyron Jaq and Mighty both use the Marvel 8897 WiFi+BT chip. Add wakeup
> and pinctrl block to devicetree so the btmrvl driver can correctly
> configure the wakeup interrupt.

Applied, thanks!

[1/1] ARM: dts: rockchip: Add marvell BT irq config
      commit: 6c2b99a2e7a073575b4ee91abf7d16470991c1f4

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
