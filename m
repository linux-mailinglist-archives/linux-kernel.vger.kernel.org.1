Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB11B2F3258
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbhALN4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:56:51 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58132 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732957AbhALN4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:56:50 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10CDtfWZ076642;
        Tue, 12 Jan 2021 07:55:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610459741;
        bh=OAyPA6z9ikgZ1vPPSEge+i7syzFzsS9b3mIxvoCVb34=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Jzwzc2Sm8/r3TzGG5fieMUR4kzMjSKhKZiJ4QPp14CjHbMxRsmBJn/CnyFJkaF/Xh
         D+sJ5KlVgDtKB5Z9bmygotbvQbguQLlBFBCZbnAnVAhY8H6APXwLRaA5sjLbGucJ6S
         K3Fjlb2YvRlr4Der9mD1kDJHVx2rLW6iTHZimpbw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10CDtecq071677
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jan 2021 07:55:41 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 Jan 2021 07:55:40 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 Jan 2021 07:55:40 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10CDteBh098573;
        Tue, 12 Jan 2021 07:55:40 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <linux-kernel@vger.kernel.org>, Tero Kristo <kristo@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Borislav Petkov <bp@alien8.de>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Luck <tony.luck@intel.com>, SoC <soc@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] MAINTAINERS: Update my email address and maintainer level status
Date:   Tue, 12 Jan 2021 07:55:39 -0600
Message-ID: <161045957072.21611.7195965911464128734.b4-ty@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217130721.23555-1-t-kristo@ti.com>
References: <20201217130721.23555-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Dec 2020 15:07:21 +0200, Tero Kristo wrote:
> My employment with TI is ending tomorrow, so update the email address
> entry in the maintainers file. Also, I don't expect to spend that much
> time with maintaining TI code anymore, so downgrade the status level to
> odd fixes only on areas where I remain as the main contact point for
> now, and move myself as secondary contact point where someone else has
> taken over the maintainership.

Hi Tero Kristo,

I have applied the following to branch ti-k3-maintainer-next on [1].
Thank you!

[1/1] MAINTAINERS: Update my email address and maintainer level status
      commit: 2672b94d730c4b69a17ce297dc3fa60b980e72dc


All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Original patch reference [2].

[1] git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git
[2] lore.kernel.org/r/20201217130721.23555-1-t-kristo@ti.com
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

