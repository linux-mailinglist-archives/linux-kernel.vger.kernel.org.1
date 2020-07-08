Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4612187F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 14:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgGHMsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 08:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgGHMsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:48:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E8BC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:48:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so48817569wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tP79VqG7CMbstXgtjxB3EzhhqsXondoATEl/e8+haYo=;
        b=mOXekM3JgRvIKXsraGFS8IHyESbpjercTF5q2CzEgwrDzGG1Fk2q0BMEfop2UPW/kG
         /TYgL98OP/oiMkN0tVSMaxrCv1hYtT6QIgGPkaCUSW/66+cXyF4ZE6qu1apJ7NdKgGWq
         stHuIR3NJxD01lw3BF7D5xOh/NEhk8IbSRt5SJQxkULS1uorIctBaWLS/8Xy7hoXY4hN
         ANN2uirdAaIk09A7Cv71a0eT2AiPE02oeE5WWim+LVvLxmqMBCnLEZu/uC3iHboiKYcz
         u1kOoE68JY1Dlf2mqfkg7zx7v1K9TVvQnkekJYBVBIIWZa5bRrp/iYCypAEC7cm2CtJ8
         bLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tP79VqG7CMbstXgtjxB3EzhhqsXondoATEl/e8+haYo=;
        b=J4veire66xOR/dU7DBVmnTtfwyO94sUMfwGDKAgCHeSIBeCxhVz4ljjj7dhHcAooZ0
         5fI60bbeqkZewjSyzNaT9ILg3bzAy+MCUVvhJ8TOeQssGKt7+qtIPiPOGgSpCt9KxXSg
         l2B2xDxHpLW99V+E9SASKKm9BXxyoC7vx6iwvrIOWHa4gfxOFQqpm+pRs33fsUnA0bwE
         cKCiWF5uUd/oJ8X2zkF1ASJqk1qmIAfL5Ht8m7qstgUH1+Z0q8VEhqvmT578GaVWlqyE
         7lSoKv+fSbIpVyacg3B6ut3T7diURHEmqbL/WQF9/cziQ/PHa7l9vabfDxHyxv/rgCL6
         P9GQ==
X-Gm-Message-State: AOAM530uiINTt24dLx4DejP3qZmXCR9YEEMnWkPIycbKAWTjZ0BQAxvG
        9gnQ4fY9fq2nflHYXGA5SfRzzw==
X-Google-Smtp-Source: ABdhPJxullf1Zyoaj7A7MgN5woWZKlJie5p2Y1TZBRKRaBYv8IZC5euAtkhJtMFeQC+l/75SvjA9jA==
X-Received: by 2002:adf:f14c:: with SMTP id y12mr57536932wro.30.1594212515510;
        Wed, 08 Jul 2020 05:48:35 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id x1sm5745408wrp.10.2020.07.08.05.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:48:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 0/3] W=1 loose ends for Regulator
Date:   Wed,  8 Jul 2020 13:48:29 +0100
Message-Id: <20200708124832.3441649-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These either needed small fix-ups for a rebase.

Lee Jones (3):
  regulator: devres: Fix issues with kerneldoc headers
  regulator: of_regulator: Add missing colon for rdev kerneldoc argument
  regulator: devres: Standardise on function documentation headers

 drivers/regulator/devres.c       | 54 +++++++++++++++++---------------
 drivers/regulator/of_regulator.c |  2 +-
 2 files changed, 29 insertions(+), 27 deletions(-)

-- 
2.25.1

