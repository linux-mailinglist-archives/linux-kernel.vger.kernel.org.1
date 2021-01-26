Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64605303F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405632AbhAZODv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:03:51 -0500
Received: from gloria.sntech.de ([185.11.138.130]:37722 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405657AbhAZODL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:03:11 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l4Ov7-0002W8-An; Tue, 26 Jan 2021 15:02:13 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: more user friendly name of sound nodes
Date:   Tue, 26 Jan 2021 15:02:11 +0100
Message-Id: <161166972365.2090171.10072509023679503084.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210110151913.3615326-1-katsuhiro@katsuster.net>
References: <20210110151913.3615326-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021 00:19:13 +0900, Katsuhiro Suzuki wrote:
> This patch changes device name to more user friendly name of
> Analog and SPDIF sound nodes for rk3399-rockpro64.

Applied, thanks!

[1/1] arm64: dts: rockchip: more user friendly name of sound nodes
      commit: 5b295839ba3cd78f4142699b8bebc1f23af9a49d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
