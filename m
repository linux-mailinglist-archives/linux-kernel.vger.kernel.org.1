Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB102D3222
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 19:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbgLHS1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 13:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbgLHS1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 13:27:33 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992A9C061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 10:26:53 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id y8so1412500plp.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 10:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MifJDC6oiPkcsHhmQA2my9RcYv2v204hKjUk4sHUxf0=;
        b=qrVASteIFFABTktb5yIRYuhdQvO6U8mhUNt17QPzNYyYW2Apyur7TQr54rKwnxqbdE
         Jj9EMw8EVJoyqg9XUQB+Mk1osgy62WQMZFpL+g0YDgEOFbsngdNsHNCxU0IsdnDFn7fp
         0FiiUTWZQOeoxbt8TlTO1YYCsViU14NwMZxf1s1vyVY4rrQIgT+I/Id3RI1qqw1GuGB4
         qQRi3koS1/2wXr116gR5/kUgyG1lIk/D8b7hRa0U3y9sGkt854XIfINhRQTZu+nSkRBj
         fPnaoSWrF+zNStcx0Hp87GnP7xfyh8Z6ips0OJOWPc3JPpZ87k4b5lfMrRIvd8RhVuLF
         XGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MifJDC6oiPkcsHhmQA2my9RcYv2v204hKjUk4sHUxf0=;
        b=hVS/PBD6erUj68dpffNAYXEd5PUr2ocQogHOOX0fks6j8w/JWsYjao4Cza84coArYF
         /GkR/B5f4J731DEgAgcKY6BMRxfzbn9LhCS1cPhXgYc02FlALi9T32o1rlx2LfkeWyTa
         nwrNb0BS7GtFMxes1c2dd0qObgEsiIPKdGLOR0kIFB3kYeFG/JW3H1jb+GXtju1ZXsNd
         jD7WMEkARP4qO0eNxIkUszyxvZ3T+qTFtdSv9YeDs4PglpFgQijjEgLt3DH+kdC0aAoN
         VAGGx6KHScQWpTaio3Xhx1sMNB7Q5HEA+ZUIVZ/MdXlqkMWyFuduGDA9dULQSPw/gGI9
         L80Q==
X-Gm-Message-State: AOAM5308o2HGHOD3c9c8PETOOndh1RZcNL9/WkfHM+6JkazY2mGsJD1l
        6GylzCZUY+r+jKGYPOcaAIa/Vw==
X-Google-Smtp-Source: ABdhPJz6UNafClur7ZAPgYsxKnP3I3bKDbd6xNDYA4lZPSNCtJfLqxRcWmx8Z6GA7PZBz7AbFA4ZcQ==
X-Received: by 2002:a17:902:b7cb:b029:db:c0d6:96ee with SMTP id v11-20020a170902b7cbb02900dbc0d696eemr3479502plz.21.1607452013200;
        Tue, 08 Dec 2020 10:26:53 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id nm6sm3966801pjb.25.2020.12.08.10.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 10:26:52 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] coresight: Patches for v5.11 (part 2) 
Date:   Tue,  8 Dec 2020 11:26:48 -0700
Message-Id: <20201208182651.1597945-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

As expected a few more fixes came late in the cycle - please
see if you can include them in the v5.11 cycle.

Applies cleanly on today's char-misc-next (ee64ed8153ab).

Thanks,
Mathieu

Arnd Bergmann (1):
  coresight: remove broken __exit annotations

Qi Liu (1):
  coresight: etm4x: Modify core-commit to avoid HiSilicon ETM overflow

Suzuki K Poulose (1):
  coresight: tmc-etr: Fix barrier packet insertion for perf buffer

 drivers/hwtracing/coresight/Kconfig           |   8 ++
 drivers/hwtracing/coresight/coresight-catu.c  |   2 +-
 .../hwtracing/coresight/coresight-cti-core.c  |   2 +-
 drivers/hwtracing/coresight/coresight-etb10.c |   2 +-
 .../coresight/coresight-etm3x-core.c          |   4 +-
 .../coresight/coresight-etm4x-core.c          | 102 +++++++++++++++++-
 drivers/hwtracing/coresight/coresight-etm4x.h |   8 ++
 .../hwtracing/coresight/coresight-funnel.c    |   6 +-
 .../coresight/coresight-replicator.c          |   6 +-
 drivers/hwtracing/coresight/coresight-stm.c   |   2 +-
 .../hwtracing/coresight/coresight-tmc-core.c  |   2 +-
 .../hwtracing/coresight/coresight-tmc-etr.c   |   2 +-
 drivers/hwtracing/coresight/coresight-tpiu.c  |   2 +-
 13 files changed, 131 insertions(+), 17 deletions(-)

-- 
2.25.1

