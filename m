Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22130276A27
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgIXHLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgIXHL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:11:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25506C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:11:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e17so2397897wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t2BLoZHpNGhwozbHfmm+7Cxrk+/2q/P1UcF6fmfr4Wg=;
        b=Ij3Vi84VpuuW73Dk1Hnkv/BLr92LW3/GH6fdKJS6nNTPULwxNjXtCC2AmwI0eywo5p
         cgl7GCaqt4AXtOwnh7SZ8d0JqKD6L5XVBZe6BqBGFFV6TKGyIWV+zRUZ78U3uIVZJaVK
         /z7Y1q+TVdS94iNmJBdhommCjTp/jXBJQfd55Ly3p9uZTwc87fwOfzX2Eo6kvHJo5dFs
         8NVZrXNnwzVtJkvMO1tk6RVaxoY194KlIi20Om3u8Dh4yYULs3W63u8hfCMN/QYBZGn2
         vUBsS0EKyf8nRG45OJIg+QTsOHTYovkETK3jXNh171UrQZvNBxQBMkzYTwxrWPiUBsSD
         owLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=t2BLoZHpNGhwozbHfmm+7Cxrk+/2q/P1UcF6fmfr4Wg=;
        b=M+a3TutOcYp5cNEw1krxwax/efkr+trzzgmOPklnhUmPiLVL2ZwVQq/m+LBK4X3Nmw
         Cwe3y0JakinlwpRW8Vcq7RlBolF3gBfzk0jM5pKcUvo+zcozKXuiw+9hpnEj+bYiX+IJ
         WWvtGGSqu40cdPAwgngbwmJNO99Vm0wug8grvwnU1b8KDCFxeoDSk11QC+NmYM0wbfo0
         +6egTH4rfnUxVsdSrfTif3s0arElNLPUrthZAy4PnOIaGcevU1BYMiFXa3HrCMwnJ+R5
         JT1jwUw7DqAtBNpI05/lnsbkepdJkyXp23Zh/2uwHUK9UCKQD0q+DOZ1az5zy/aDDlYv
         8K2Q==
X-Gm-Message-State: AOAM530y1i7bJ7hNo0NY5I/PY5KSwLNhcShniFJj7XkKTCuHBNWbqgXJ
        FwF8Qo1oLEI8wfHoTURKRW3JTg==
X-Google-Smtp-Source: ABdhPJxGlIsjrI4uBvy4G0/yf0BiUqaeKy3F9JYG8tVNCsN9joDqxVBb4E7z2NNkKnV9KYFUbH5+9g==
X-Received: by 2002:a1c:a988:: with SMTP id s130mr3082024wme.31.1600931484770;
        Thu, 24 Sep 2020 00:11:24 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id k6sm2189419wmf.30.2020.09.24.00.11.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 00:11:23 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     broonie@kernel.org
Cc:     amit.kumar-mahapatra@xilinx.com, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RESEND v2 PATCH 0/3] spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework
Date:   Thu, 24 Sep 2020 09:11:16 +0200
Message-Id: <cover.1600931476.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am resending this series instead of Amit because his patches are broken
in lore. Mark has reported the issue with it and I clearly see that patch
is broken in lore.
For example:
https://lore.kernel.org/linux-spi/20200922164016.30979-2-amit.kumar-mahapatra@xilinx.com/raw

There is additional = which shouldn't be there.
@@ -183,7 +184,7 @@ static u32 zynqmp_gqspi_read(struct zynqmp_qspi *xqspi,=
u32 offset)

We will investigate why this is happening but it is related to any his
setting.

Thanks,
Michal

This patch series:
 - Fixes kernel-doc warnings in ZynqMP qspi controller driver file.
 - Updates the ZynqMP qspi controller driver to use spi-mem framework.
 - Fixes incorrect indentation in ZynqMP qspi controller driver file.

Tested: flashcp and mtd_utils
Branch: for-5.10
HEAD commit: bf253e6bf6b8 (spi/for-5.10) spi: spi-imx: spi_imx_transfer(): add support for effective_speed_hz


Amit Kumar Mahapatra (3):
  spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
  spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework
  spi: spi-zynqmp-gqspi: Fix incorrect indentation

 drivers/spi/spi-zynqmp-gqspi.c | 720 +++++++++++++++++++--------------
 1 file changed, 407 insertions(+), 313 deletions(-)

-- 
2.28.0

