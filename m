Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF09E25703A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 21:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgH3Tmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 15:42:40 -0400
Received: from gloria.sntech.de ([185.11.138.130]:48008 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgH3Tmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:42:36 -0400
Received: from p508fca7b.dip0.t-ipconnect.de ([80.143.202.123] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kCTDl-0002KX-AO; Sun, 30 Aug 2020 21:42:33 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix cpu-supply for rk3328-evb
Date:   Sun, 30 Aug 2020 21:42:28 +0200
Message-Id: <159881654154.22245.13684137249237383351.b4-ty@sntech.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813181711.15906-1-jbx6244@gmail.com>
References: <20200813181711.15906-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 20:17:11 +0200, Johan Jonker wrote:
> The property cpu-supply should be added to each cpu separately,
> so fix that for rk3328-evb.

Applied, thanks!

[1/1] arm64: dts: rockchip: fix cpu-supply for rk3328-evb
      commit: 4be8df7b3bcd46a75f7e297ef310234975a437d8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
