Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E412CFBB4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 16:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgLEPNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 10:13:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:44134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbgLEO7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 09:59:30 -0500
From:   Krzysztof Kozlowski <krzk@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: ti-emif-sram: only build for ARMv7
Date:   Sat,  5 Dec 2020 15:00:36 +0100
Message-Id: <160717677393.8204.10565594770948625598.b4-ty@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203230832.1481767-1-arnd@kernel.org>
References: <20201203230832.1481767-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 00:08:14 +0100, Arnd Bergmann wrote:
> The driver can be compile-tested on all ARM machines, but
> causes a failure when built for ARMv7-M:
> 
> arm-linux-gnueabi-ld: error: drivers/memory/ti-emif-sram-pm.o: conflicting architecture profiles A/M
> 
> Limit the target machines to configurations that have ARMv7 enabled.

Applied, thanks!

[1/1] memory: ti-emif-sram: only build for ARMv7
      commit: d77d22d701b0471584abe1871570bb43deb6e3c4

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>
