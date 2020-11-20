Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1D12BB391
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbgKTSgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:36:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:54588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730816AbgKTSgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:36:14 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4A2E24181;
        Fri, 20 Nov 2020 18:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897374;
        bh=DCzg+6wHBm7e86v5BdxFAMEVmr4S1kd/XsHoGDogEM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+qBdEebw2tom5lBE1EZbdE91oAmG02IwcfxU+ku/YhV+R5cr8OI+OkTa+xVX+UHq
         k1YIXjN7bwJnMewvvU8gjIEC9bcFq11ipmp8YdqfEvBv1YK6n0MF6QM1Qbf7uWCtfb
         DDMa6VtZqGhn1qarb3yW/0LxEGholMRz0yS0vBcE=
Date:   Fri, 20 Nov 2020 12:36:20 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 089/141] ide: Fix fall-through warnings for Clang
Message-ID: <720e899a98d4c9578e5378c051273f22f30b8b30.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/ide/siimage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ide/siimage.c b/drivers/ide/siimage.c
index c4b20f350b84..145c0ab3a856 100644
--- a/drivers/ide/siimage.c
+++ b/drivers/ide/siimage.c
@@ -493,6 +493,7 @@ static int init_chipset_siimage(struct pci_dev *dev)
 	case 0x30:
 		/* Clocking is disabled, attempt to force 133MHz clocking. */
 		sil_iowrite8(dev, tmp & ~0x20, scsc_addr);
+		break;
 	case 0x10:
 		/* On 133Mhz clocking. */
 		break;
-- 
2.27.0

