Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AC32B0B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgKLRvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:51:17 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51890 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgKLRvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:51:17 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACHpBfn054950;
        Thu, 12 Nov 2020 11:51:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605203471;
        bh=m0KtljefQbWNsOKhLw8VLEpYtJ1dCRYsl/oIixMChdE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VZaXx665vQ65GG1RS31qSkxW1vdmukyipkiJQJSc/PHSaqNysXOTQ/oNUDfAwUHuK
         +w/5KPsZobFIuFvCxCIzFnJPqXD2XLEjUfnaSBqsIraAJYlpISQiarJfcF419tROqX
         QiQeRPmIIXClozOdSrgGmbpPnLITR8rr2wkVyLyU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACHpBjC022555
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 11:51:11 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 11:51:11 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 11:51:11 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACHpBTo045694;
        Thu, 12 Nov 2020 11:51:11 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Faiz Abbas <faiz_abbas@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <catalin.marinas@arm.com>,
        <t-kristo@ti.com>, <will@kernel.org>
Subject: Re: [PATCH v3] arm64: defconfig: Enable GPIO and I2C configs for TI's J721e platform
Date:   Thu, 12 Nov 2020 11:51:10 -0600
Message-ID: <160520343230.32498.5408335003969545426.b4-ty@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103190821.30937-1-faiz_abbas@ti.com>
References: <20201103190821.30937-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Nov 2020 00:38:21 +0530, Faiz Abbas wrote:
> Add configs to enable regulators that supply power to the SD card
> on TI's J721e platform. These regulators are controlled by either
> SoC gpios or gpios over i2c expander.
> 
> Changes to vmlinux size:
> Before:
>    text	    data     bss       dec       hex	  filename
> 20219067  10875634  523924   31618625   1e27641	  vmlinux
> 
> [...]

Hi Faiz Abbas,

I have applied the following to branch ti-k3-config-next on [1].
Thank you!

[1/1] arm64: defconfig: Enable GPIO and I2C configs for TI's J721e platform
      commit: 6b133f475a97a0839f02e3c0b937886b9adc2933


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

