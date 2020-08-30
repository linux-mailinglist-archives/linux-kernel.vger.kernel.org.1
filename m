Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64E225706E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 22:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgH3UQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 16:16:45 -0400
Received: from gloria.sntech.de ([185.11.138.130]:48254 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgH3UQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 16:16:43 -0400
Received: from p508fca7b.dip0.t-ipconnect.de ([80.143.202.123] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kCTkn-0002d8-D3; Sun, 30 Aug 2020 22:16:41 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/2] ARM: dts: rockchip: rk3066a: add label to cpu@1
Date:   Sun, 30 Aug 2020 22:16:33 +0200
Message-Id: <159881858451.25534.15596063326454752914.b4-ty@sntech.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813172451.13754-1-jbx6244@gmail.com>
References: <20200813172451.13754-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 19:24:50 +0200, Johan Jonker wrote:
> Add label to cpu@1 for later use.

Applied, thanks!

[1/2] ARM: dts: rockchip: rk3066a: add label to cpu@1
      commit: 9ab4a7312bf31611f3a9c95470f15b3f2bcd83e3
[2/2] ARM: dts: rockchip: update cpu supplies on rk3066a
      commit: 20e464c0f12a9b1930adb0365326037d5b060cee

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
