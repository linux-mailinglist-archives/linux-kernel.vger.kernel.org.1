Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DB32B0ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 21:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgKLUJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 15:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbgKLUJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 15:09:48 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7217AC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:09:47 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 10so5569824pfp.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 12:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HlzNb4pK13Y32cyp+ePumv3+g3DVvwiDXlCyJDmMOcc=;
        b=gSefMmGnwMapYEAtZk9AyZgTOIzuZkVsJ9ewbfiNaCylEybtcHFmKefAO4+auhVoIx
         9ErY33tMtqOfp/KvZJCPONVnbC7VAxM5WbMMO5KiHK+osN54xexUCfKVG645KEU0fWSe
         Q1tlXO217th/ITMJqJ7X5jTR+JIFe4TnQI27A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HlzNb4pK13Y32cyp+ePumv3+g3DVvwiDXlCyJDmMOcc=;
        b=mOk9O8oIZ119pnw7gUal82kk2KUDF5zpRx59gpac3ry/00IVNBF+d4iNnBxCbm2ces
         1pUXiI8kv6tHZ42/7fMBz3LsFkA8c9wL/bNwI1Aequm2ZAxq0BZm6VS4UoxZg1zbe2JK
         JZPVYfd39rovN9JxuLdHf00Y5+f4gGsEJH2Le5dH+jvq2xtbPySU4pZn+sb+kVCaRXn0
         vT936XNistpM1E302vpdP6s8N7Sl3ZLkqApaAA2NaGF+9doIWD9C466u8tveb0IcCjlX
         SlCjzTfAb+6SbkD7nPP6YHsVGfppr4iZteroQrbPXyzwoopdn/2Dvmuwhr0aGt/dXr26
         OjEw==
X-Gm-Message-State: AOAM532R44zml/IXrjfQcARck11Q6Z4O4n5H4zvcxT3IKiJ3wdfLlreR
        kDbpF+SXgsUfOdxgj6bcROaZmcXtZsFUwg==
X-Google-Smtp-Source: ABdhPJwRWJ+1GrJ74JTL6+W7sqUQ70o4CpjRlVXDjOeHzUWuBxAvGHKlX7dugtjpWKuEkwObYvW09g==
X-Received: by 2002:a17:90a:178b:: with SMTP id q11mr892040pja.132.1605211787047;
        Thu, 12 Nov 2020 12:09:47 -0800 (PST)
Received: from kuabhs-cdev.c.googlers.com.com (152.33.83.34.bc.googleusercontent.com. [34.83.33.152])
        by smtp.gmail.com with ESMTPSA id gc17sm7590260pjb.47.2020.11.12.12.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 12:09:46 -0800 (PST)
From:   Abhishek Kumar <kuabhs@chromium.org>
To:     kvalo@codeaurora.org, pillair@codeaurora.org
Cc:     dianders@chromium.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org, briannorris@chromium.org,
        linux-wireless@vger.kernel.org,
        Abhishek Kumar <kuabhs@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH v2 0/1] This patch address comments on patch v1
Date:   Thu, 12 Nov 2020 20:09:05 +0000
Message-Id: <20201112200906.991086-1-kuabhs@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends ath10k_core_create_board_name function to support chip id
based BDF selection and not add provision for fallback_boardname2, thus
introducing lesser lines of code.

(no changes since v1)

Abhishek Kumar (1):
  ath10k: add option for chip-id based BDF selection

 drivers/net/wireless/ath/ath10k/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.29.2.222.g5d2a92d10f8-goog

