Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E442AA894
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 01:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgKHAba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 19:31:30 -0500
Received: from gloria.sntech.de ([185.11.138.130]:40082 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgKHAb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 19:31:29 -0500
Received: from p508fc3ee.dip0.t-ipconnect.de ([80.143.195.238] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kbYc8-0008Lx-HA; Sun, 08 Nov 2020 01:31:24 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Aditya Prayoga <aditya@kobol.io>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: rockchip: Add Kobol Helios64
Date:   Sun,  8 Nov 2020 01:31:21 +0100
Message-Id: <160479547333.328385.5009987146654676702.b4-ty@sntech.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102150658.167161-1-uwe@kleine-koenig.org>
References: <20201102150658.167161-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Nov 2020 16:06:58 +0100, Uwe Kleine-König wrote:
> Document the new board by Kobol introduced recently in
> rockchip/rk3399-kobol-helios64.dts.

Applied, thanks!

[1/1] dt-bindings: arm: rockchip: Add Kobol Helios64
      commit: 62dbf80fc581a8eed7288ed7aca24446054eb616

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
