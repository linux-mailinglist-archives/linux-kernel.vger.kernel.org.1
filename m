Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D631FC8E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 10:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgFQIhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 04:37:16 -0400
Received: from gloria.sntech.de ([185.11.138.130]:42984 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgFQIhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:37:16 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jlTZJ-0005rL-9s; Wed, 17 Jun 2020 10:37:13 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Tobias Schramm <t.schramm@manjaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/1] Add fuel gauge to Pinbook Pro dts
Date:   Wed, 17 Jun 2020 10:37:10 +0200
Message-Id: <159238301927.1406601.17225470584885012496.b4-ty@sntech.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528172550.2324722-1-t.schramm@manjaro.org>
References: <20200528172550.2324722-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 19:25:49 +0200, Tobias Schramm wrote:
> since the cw2015 fuel gauge will be supported in 5.8 this patch
> adds a node for it to the Pinbook Pro device tree.
> 
> Best regards,
> 
> Tobias
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: add fuel gauge to Pinebook Pro dts
      commit: c7c4d698cd2882c4d095aeed43bbad6fc990e998

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
