Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026572A1F1B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 16:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgKAPdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 10:33:54 -0500
Received: from gloria.sntech.de ([185.11.138.130]:47646 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbgKAPdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 10:33:53 -0500
Received: from p57b773f8.dip0.t-ipconnect.de ([87.183.115.248] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kZFMZ-0003rS-70; Sun, 01 Nov 2020 16:33:47 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     robh+dt@kernel.org, Maciej Matuszczyk <maccraft123mc@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix poweroff issue on Odroid Go Advance
Date:   Sun,  1 Nov 2020 16:33:42 +0100
Message-Id: <160424139256.1224767.16555811022678597887.b4-ty@sntech.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023181629.119727-1-maccraft123mc@gmail.com>
References: <20201023181629.119727-1-maccraft123mc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Oct 2020 20:16:29 +0200, Maciej Matuszczyk wrote:
> 


Applied, thanks!

[1/1] arm64: dts: rockchip: Remove system-power-controller from pmic on Odroid Go Advance
      commit: 01fe332800d0d2f94337b45c1973f4cf28ae6195

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
