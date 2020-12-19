Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B75A2DECE2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 04:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgLSDbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 22:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgLSDbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 22:31:10 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BA2C06138C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 19:30:30 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id n142so4175441qkn.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 19:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mhZcFwLFRD+URmub2//MI05HplvVJx4QbRaR8OH4h8M=;
        b=kNMDArYGKcAQi1SqMcKucSUTa8jSF29GBvUP02lPMlTvlfkN8CBTGQs7kzVz62Jmp4
         k2Yl+c1rQGM8a42aABnObYOLZoOgUAHk2kGEAr5UOZJzJJZ1JzsoyOVvsNgifgarEnKW
         DSzXc47S36ZwyRrADIcfuiEJF/H7aMcSDhKJnF/nB+gFNOPIIFPpGINfFV9ybF1fj2vc
         GvJj3fuClRh7gAEB3iS4LjNViO/gZFeSmaHg2QcV0l7jtMKdi46yC6PWgbxh4aCJvaTb
         XC/EZdQ1xuKtdDTjdalX2Zjx96LhHA/0vRFSffwiaxXyQil6xB6TczkSZ5Dv6IU1AXbO
         EADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mhZcFwLFRD+URmub2//MI05HplvVJx4QbRaR8OH4h8M=;
        b=saXhmHTcNiiv/Uyq3cUEcSCuU1ay6nfrvs3TJVhOHQS3tn3Y1ybBtcgk97c/ybk6kE
         +kVJg8xzjEs/YpkYg/TvWffBYS6O7qaYxrj6VnInzX8Xg+yC3QdQnv9RhnjsnuJFLaLC
         npptx7rjkqG7ghpOiCwhUUeKyjzZdV1Ml3fiMjV0kcf0sIUd8RgXZsJspxj9beovlV4P
         pozVZr2uISEcS8XDVOJAv6ighmzy4rOhGUoHa+4y7dagBKcaonb4Ir+GTsNXVaVRScPD
         FNs2t89DtEWmCdFhmxlfWDxFZ5/a/ksr7VHNATxoTj3ANVicahjBLEbcEQRh7kDa8mO7
         EB7Q==
X-Gm-Message-State: AOAM533U/3F2hGw36D4fD16+aYbZowhwJraRBIhRmbLL0ploCxUeXt6e
        n102xW2g5gJ/XKQz9x5yXrzwkg==
X-Google-Smtp-Source: ABdhPJwgkY239niSvCN3KKmY2ZM0t5B0knYn9CcFe7lxAWx+UQDieuaav6EyPEd2wMiNPqIyjPKvpA==
X-Received: by 2002:a37:a893:: with SMTP id r141mr8268623qke.459.1608348628917;
        Fri, 18 Dec 2020 19:30:28 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id y16sm4376045qki.132.2020.12.18.19.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 19:30:28 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Regression fixes/clean ups in the Qualcomm crypto engine driver
Date:   Fri, 18 Dec 2020 22:30:21 -0500
Message-Id: <20201219033027.3066042-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is a result of running kernel crypto fuzz tests (by
enabling CONFIG_CRYPTO_MANAGER_EXTRA_TESTS) on the transformations
currently supported via the Qualcomm crypto engine on sdm845.
The first four patches are fixes for various regressions found during
testing. The last two patches are minor clean ups of unused variable
and parameters.

Thara Gopinath (6):
  drivers: crypto: qce: sha: Restore/save sha1_state/sha256_state with
    qce_sha_reqctx in export/import
  drivers: crypto: qce: sha: Hold back a block of data to be transferred
    as part of final
  drivers: crypto: qce: skcipher: Fix regressions found during fuzz
    testing
  drivers: crypto: qce: common: Set data unit size to message length for
    AES XTS transformation
  drivers: crypto: qce: Remover src_tbl from qce_cipher_reqctx
  drivers: crypto: qce: Remove totallen and offset in qce_start

 drivers/crypto/qce/cipher.h   |   1 -
 drivers/crypto/qce/common.c   |  25 ++++----
 drivers/crypto/qce/common.h   |   3 +-
 drivers/crypto/qce/sha.c      | 114 +++++++++-------------------------
 drivers/crypto/qce/skcipher.c |  70 ++++++++++++++++++---
 5 files changed, 101 insertions(+), 112 deletions(-)

-- 
2.25.1

