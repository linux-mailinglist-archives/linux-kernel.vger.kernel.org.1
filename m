Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3132AA899
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 01:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgKHAcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 19:32:14 -0500
Received: from gloria.sntech.de ([185.11.138.130]:40122 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgKHAcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 19:32:14 -0500
Received: from p508fc3ee.dip0.t-ipconnect.de ([80.143.195.238] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kbYcv-0008Nd-E0; Sun, 08 Nov 2020 01:32:13 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: add adc joystick to Odroid Go Advance
Date:   Sun, 08 Nov 2020 01:32:12 +0100
Message-ID: <2927303.vgcXVVlYnW@phil>
In-Reply-To: <160479547333.328385.10405736155189441984.b4-ty@sntech.de>
References: <20200703221413.269800-1-heiko@sntech.de> <160479547333.328385.10405736155189441984.b4-ty@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 8. November 2020, 01:31:19 CET schrieb Heiko Stuebner:
> On Sat, 4 Jul 2020 00:14:13 +0200, Heiko Stuebner wrote:
> > Add the now usable adc-joystick node that describes the analog
> > joystick connected to two saradc channels from the rk3326 soc.
> 
> Applied, thanks!
> 
> [1/1] arm64: dts: rockchip: add adc joystick to Odroid Go Advance
>       commit: c20e6dd9a953d62f14399dabf457dce61dd5611f

forgot to add, I fixed the things Johans commented on when applying

> 
> Best regards,
> 




