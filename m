Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EEF1BAE39
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 21:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgD0Tmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 15:42:37 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46446 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgD0Tmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:42:35 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jT9eB-00007W-KU; Mon, 27 Apr 2020 21:42:31 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: swap clock-names of gpu nodes
Date:   Mon, 27 Apr 2020 21:42:27 +0200
Message-Id: <158801649141.50507.12679129425303471594.b4-ty@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200425192500.1808-1-jbx6244@gmail.com>
References: <20200425192500.1808-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020 21:25:00 +0200, Johan Jonker wrote:
> Dts files with Rockchip 'gpu' nodes were manually verified.
> In order to automate this process arm,mali-utgard.txt
> has been converted to yaml. In the new setup dtbs_check with
> arm,mali-utgard.yaml expects clock-names values
> in the same order, so fix that.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: rockchip: swap clock-names of gpu nodes
      commit: b14f3898d2c25a9b47a61fb879d0b1f3af92c59b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
