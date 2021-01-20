Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB572FD900
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390160AbhATTCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbhATSt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:49:28 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12D0C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:48:45 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id d11so11383888qvo.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MVVhNU0jVxaFNlsItS1vMiG5qpQne1QXE2l8B2YUFJ4=;
        b=RBUMa/VVhCosudUS1Xhd3LCBqXpG0EbMVduHzbsWUTxuWnU881IQ4/EpiIqfunOnXt
         n7bU6qG6cqLN1pZPuNeCutdgGcp/d4co9OosvROdtYtpwpc/P03cTeQ8oi8xzi2Ucy93
         iRpIahG55q8YAePMvIAJvXzdPE4cQT7p0Ie309oWVXiSW2uYNaNeXZ0tTSidbw3Ku8gu
         2bYUGO1Pa6bfdGogQ6aqd4XSYF+xSpUBRUZTwLqG45rXIThQfkgZZnhjkBb5PxeIwpEi
         ElUJ5UOqXwh39jXt0OgWPGoB0G7+8/9leHDoSnwu9MCkrGljYEZ+Yn79ScEbQpMzNipD
         wNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MVVhNU0jVxaFNlsItS1vMiG5qpQne1QXE2l8B2YUFJ4=;
        b=eGppqA0qDjE+Z8lZNAMTH0ixgmyq6QtcQgD+rqH+dsnxZjqI6wTTK1jJVItHFgwQNg
         lRg3RlPrdYB8a3lbeQT+vaDcgTW6h/52BHGxgjVNBOGxJkpnXchtU/4JDTF1NJQ1o28f
         58MfUrl1+G4iz3dJlb8qaWrK/wMF5gzX85t2tnioVINf1pVgQtTlnR30fNGWGkpwGxQN
         uIvOJqtscNRAx6o61mSuyoR3RiH+wZyW8NcaJXDqvjiQb168fCNdX1O69jm9AkE8yjPO
         AOk7GkXdfxtO30BglRTfIv132MXD/IsU3MOmf8ROhiyqw7xs9l/1Bo3ztVKFgjkFg8e/
         HN8g==
X-Gm-Message-State: AOAM532GFR2ilZJicTVT1s0B3fJZLg4MNvCghUD1j0dIzxIA935EqRc9
        5DjNNBzgmSCjh0/2HLUXIaNdNA==
X-Google-Smtp-Source: ABdhPJwbGoPW2RScm/iTHnU362NqZqDFlvBtFyJotT7r8v6wwXX4OrJ+aC5+2yN5+D8FoVS9EQjPhA==
X-Received: by 2002:a05:6214:714:: with SMTP id b20mr10736065qvz.36.1611168525073;
        Wed, 20 Jan 2021 10:48:45 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id w8sm1769903qts.50.2021.01.20.10.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:48:44 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] Regression fixes/clean ups in the Qualcomm crypto engine driver
Date:   Wed, 20 Jan 2021 13:48:37 -0500
Message-Id: <20210120184843.3217775-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is a result of running kernel crypto fuzz tests (by
enabling CONFIG_CRYPTO_MANAGER_EXTRA_TESTS) on the transformations
currently supported via the Qualcomm crypto engine on sdm845.  The first
four patches are fixes for various regressions found during testing. The
last two patches are minor clean ups of unused variable and parameters.

v2->v3:
	- Made the comparison between keys to check if any two keys are
	  same for triple des algorithms constant-time as per
	  Nym Seddon's suggestion.
	- Rebased to 5.11-rc4.
v1->v2:
	- Introduced custom struct qce_sha_saved_state to store and restore
	  partial sha transformation.
	- Rebased to 5.11-rc3.

Thara Gopinath (6):
  drivers: crypto: qce: sha: Restore/save ahash state with custom struct
    in export/import
  drivers: crypto: qce: sha: Hold back a block of data to be transferred
    as part of final
  drivers: crypto: qce: skcipher: Fix regressions found during fuzz
    testing
  drivers: crypto: qce: common: Set data unit size to message length for
    AES XTS transformation
  drivers: crypto: qce: Remover src_tbl from qce_cipher_reqctx
  drivers: crypto: qce: Remove totallen and offset in qce_start

 drivers/crypto/qce/cipher.h   |   1 -
 drivers/crypto/qce/common.c   |  25 +++---
 drivers/crypto/qce/common.h   |   3 +-
 drivers/crypto/qce/sha.c      | 143 +++++++++++++---------------------
 drivers/crypto/qce/skcipher.c |  70 ++++++++++++++---
 5 files changed, 127 insertions(+), 115 deletions(-)

-- 
2.25.1

