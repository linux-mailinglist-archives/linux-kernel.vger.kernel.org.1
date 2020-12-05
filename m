Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8100A2CFC1B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 17:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgLEPgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 10:36:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbgLEO73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 09:59:29 -0500
From:   Krzysztof Kozlowski <krzk@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Alex Smith <alex.smith@imgtec.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: jz4780_nemc: Fix potential NULL dereference in jz4780_nemc_probe()
Date:   Sat,  5 Dec 2020 15:00:37 +0100
Message-Id: <160717677394.8204.5219052683887032938.b4-ty@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1607070717-32880-1-git-send-email-zhangchangzhong@huawei.com>
References: <1607070717-32880-1-git-send-email-zhangchangzhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 16:31:57 +0800, Zhang Changzhong wrote:
> platform_get_resource() may fail and return NULL, so we should
> better check it's return value to avoid a NULL pointer dereference
> a bit later in the code.
> 
> This is detected by Coccinelle semantic patch.
> 
> @@
> expression pdev, res, n, t, e, e1, e2;
> @@
> 
> [...]

Applied, thanks!

[1/1] memory: jz4780_nemc: Fix potential NULL dereference in jz4780_nemc_probe()
      commit: 4bfa07300b9334b487ed4f3d4901c35ebb31b7ca

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>
