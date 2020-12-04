Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35BD2CECAA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 12:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387828AbgLDLC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 06:02:59 -0500
Received: from gloria.sntech.de ([185.11.138.130]:46214 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727365AbgLDLCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 06:02:55 -0500
Received: from [95.90.166.74] (helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kl8qf-0005Lx-Ou; Fri, 04 Dec 2020 12:02:01 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PM: AVS: rockchip-io: Fix error return code in rockchip_iodomain_probe()
Date:   Fri,  4 Dec 2020 12:01:56 +0100
Message-Id: <160707971061.1322141.10632143200660381591.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <1607070805-33038-1-git-send-email-zhangchangzhong@huawei.com>
References: <1607070805-33038-1-git-send-email-zhangchangzhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 16:33:25 +0800, Zhang Changzhong wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.

Applied, thanks!

[1/1] PM: AVS: rockchip-io: Fix error return code in rockchip_iodomain_probe()
      commit: c2867b2e710fc85bb39c6f6e5948450c48e8a33e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
