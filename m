Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF42627716E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgIXMrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbgIXMrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:47:35 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A9BC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:47:35 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z17so3714981lfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f64eNyMDkqF7rIi7j77YU8cPPeMMAflX6gkGTptc5So=;
        b=Rn1HUOVP3l5gnsRPSNDD7NZAxQV9ErudqZMf3H4VdybEViMJEh77HqHX6MPIQHbQsu
         F9wUQ89FoF316lIFCrQ8cR+5O81fHQBgWWcAp6SdJiz6HlBJ+pu6icUT++LXvDvuzx9e
         rYq2gMs6YxmZhVwj6WAh7lw9QGMO2dT31NZ8S6YTCue6jWhA3XElI/PiraIjq5RNTos8
         Z8ndHndXfk6IvtADuciH2BRqYAqFhwGHQhfZS9+5ESiw5kFrFRFxuD5hll/yIaQ0cZU3
         lJJiL/zlJnXGyOdVEt/kD6rpsZ8gE3EXyOczPqRjTxQkb6s+ioXwW/kw338uSCp7qLFU
         Mo4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f64eNyMDkqF7rIi7j77YU8cPPeMMAflX6gkGTptc5So=;
        b=q3mT/SRK2QTCjhf/U/KiD7BmddX0fAfasydMljlo2moylhEY/7dUg7GSSvK+lZj5wC
         RuQbnbeb/QoOdKCAUOSBzJiwnh7oJYcnYxixy28VPPUzRhlMUiMkBdI5Z8tUbudhbBv4
         FnUJSTT3aRDj4TU1YpBME5LdfkHbbbbqs62o8b5vc92XQmsynufw4tHJxcoXf+msSAAL
         SteGr8Aw+TQCK2zBxKpW7T6hQ+iuCKZbhfI1998Xf6SowNF4Kx9OJmT0UHkVuQeByECL
         vT8dCubNwvpvtL9fgqEevR122LxoLny/lSzjQoEa6T5MeVNtenqqt4P5+uLCvMLo9BuP
         yg6g==
X-Gm-Message-State: AOAM530AVQ2whZUzDXme6ojppxQlTKKH0gLys92t2h54hjEfXJJjymyD
        BsOlKrbkjlcKyGSlb+VU9zgbkw==
X-Google-Smtp-Source: ABdhPJz8yfmG1UfkLIR+fdyUJOJEKNire/MxEsT/iywsIjS57CnNXoOtn4Kfd92XGfUX8Kg/mYGK+w==
X-Received: by 2002:a19:f245:: with SMTP id d5mr225857lfk.97.1600951652216;
        Thu, 24 Sep 2020 05:47:32 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-169.NA.cust.bahnhof.se. [155.4.133.169])
        by smtp.gmail.com with ESMTPSA id o128sm1959187lfa.126.2020.09.24.05.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:47:31 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.9-rc7
Date:   Thu, 24 Sep 2020 14:47:30 +0200
Message-Id: <20200924124730.331517-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with an MMC fix intended for v5.9-rc7. Details about the highlights
are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit f0c393e2104e48c8a881719a8bd37996f71b0aee:

  mmc: sdio: Use mmc_pre_req() / mmc_post_req() (2020-09-07 08:57:44 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9-rc4-2

for you to fetch changes up to 14801c624066a55139c2c57963eb1b859d0a316a:

  mmc: mmc_spi: Fix mmc_spi_dma_alloc() return type for !HAS_DMA (2020-09-14 11:46:16 +0200)

----------------------------------------------------------------
MMC host:
 - mmc_spi: Fix build warning when CONFIG_HAS_DMA is unset

----------------------------------------------------------------
Geert Uytterhoeven (1):
      mmc: mmc_spi: Fix mmc_spi_dma_alloc() return type for !HAS_DMA

 drivers/mmc/host/mmc_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
