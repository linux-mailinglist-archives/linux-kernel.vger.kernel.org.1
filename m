Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DF62770B6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgIXMOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:14:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56006 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgIXMOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:14:16 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08OCEArm071778;
        Thu, 24 Sep 2020 07:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600949650;
        bh=Ebm4Jt49V9jdfk1u5fYmECSGaXT/aBA9QSDjJDwEzL0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=reGeaNefy73+xfyyOj8WFUPb8Dyr3nK+ZES34qB2PuCFbEp00pDlBtrbyI87vx8F8
         G+TpBu/ekygaCLSRi713UrXBuLXm5PwLfMQyNudvCNjoyDK6QQfGtNrUxg/g6aOZ8U
         0pAMTGm+PZ+0enTMWhvGePUeD99sh0/31DzFvwg4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08OCEANR128922;
        Thu, 24 Sep 2020 07:14:10 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Sep 2020 07:14:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Sep 2020 07:14:10 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08OCE9sZ064855;
        Thu, 24 Sep 2020 07:14:09 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Faiz Abbas <faiz_abbas@ti.com>,
        <devicetree@vger.kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <robh+dt@kernel.org>, <t-kristo@ti.com>
Subject: Re: [PATCH v2 0/2] Add support for MMC/SD on j7200-evm
Date:   Thu, 24 Sep 2020 07:14:08 -0500
Message-ID: <160094958540.7259.9993811347863300452.b4-ty@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924112644.11076-1-faiz_abbas@ti.com>
References: <20200924112644.11076-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 16:56:42 +0530, Faiz Abbas wrote:
> The following patches add dt support for MMC/SD on TI's j7200-evm.
> 
> Currently, eMMC support upto HS200 speed and SD card supports upto high
> speed speed mode.
> 
> v2:
> Fixed node names to use mmc@* format
> Fixed reg address format to align with others in the file
> 
> [...]

Hi Faiz Abbas,

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j7200-main: Add support for MMC/SD controller nodes
      commit: 7cd03dc78b290400875b6b54e257ba5ea4e810c3
[2/2] arm64: dts: ti: k3-j7200-common-proc-board: Add support for eMMC and SD card
      commit: a2178b83ae8f61b2a9fae2aa9a4d4ed2511690a4


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

[1] git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

