Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D8C298E16
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780228AbgJZNgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:36:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56219 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780180AbgJZNgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:36:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id a72so11680989wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 06:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rK/RPPWZa6SKsTnYF1m5W/2wUEvSNz6Acgvt6X95mP4=;
        b=I3SvKOowrQFnXIZoR/oZsaDasfhvCO8Zeid+jDIbKjD2aDn4ZRz5U88BuCY9CqxP2L
         o/QBPW+j/bdRD2T8KY66vV/g4OPGZME22iESWAMjWvInR9voNHAoCssvCalfM9Xx+WaD
         Rhc50f4L4HK2yH7uNXtuXVjTXWlv1S8QL5b3ZU9ghs/jUoPLxNamvni51Bw1AbV4+2h/
         r0XVygPtVw3sqq6Fa5dioUyWteuDQevsj0a6mZiKJ/YafaJ8aGLCARSkArvdsHsYQSHj
         liFAJDWcaQeJmkVXmKSnPuu5BdFRqDwsRW76CMcnbulo3wHZx81LvcYV12Lxk40Il/rS
         d8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rK/RPPWZa6SKsTnYF1m5W/2wUEvSNz6Acgvt6X95mP4=;
        b=cluVb5ILJldIqdyWjPq0Q8LT0ZvuFAiD2mM09WJ6rm8IWZ9CGTXrDma5ggBqcxVLOs
         RwMvNCshT3TwoeRqxwLaRq8N39Sqc1iAJOjYa7DR19CR/hhb6Tm5qzJJG9rMHyyEo2kN
         0I0QYtNd7slbpwFpFyaqdcrA5O0n8FwswHEVsLDRuzppIAaeZXh6CgTYCDrhYI7okBHD
         ciLWZhku4tafMl/LU0hA/xZiSIUK5m0PDoSgJsNFS3JUefPHWrJ1aI7QycAgU32t98js
         gylYiWyJ5Mj0scXvcTD+7H/nDLFYWstTsZw1dyxUTOkkVynp/b8jcWzZtxwHvul/9/GL
         7G7Q==
X-Gm-Message-State: AOAM5305JcK30BridaIJ3E0gJLOXbcH2haSRopZ7MmZzsA7Y9hWdaosF
        7aR9/V8QmTosKTvvUpwJ80+mCQ==
X-Google-Smtp-Source: ABdhPJxqxVK69kCs+H7Q6ctTXL0zfP3e46GNJTHoOBg0q3znmlrnaRTHu8zmbNU77y1yOO2vpgeRag==
X-Received: by 2002:a1c:6355:: with SMTP id x82mr17115177wmb.177.1603719379480;
        Mon, 26 Oct 2020 06:36:19 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id f7sm23688991wrx.64.2020.10.26.06.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:36:18 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/5] iio: adc: xilinx: use even more devres
Date:   Mon, 26 Oct 2020 14:36:04 +0100
Message-Id: <20201026133609.24262-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is a follow-up to commit 750628c79bb1 ("iio: adc: xilinx-xadc: use
devm_krealloc()"). I noticed we can use even more devres helpers and entirely
drop the remove() callback.

Bartosz Golaszewski (5):
  iio: adc: xilinx: use helper variable for &pdev->dev
  iio: adc: xilinx: use devm_krealloc() instead of kfree() + kcalloc()
  iio: adc: xilinx: use a devres action to disable and unprepare the
    clock
  iio: adc: xilinx: use devres for irq handling
  iio: adc: xilinx: use iio devres helpers

 drivers/iio/adc/xilinx-xadc-core.c | 146 +++++++++++++----------------
 1 file changed, 65 insertions(+), 81 deletions(-)

-- 
2.29.1

