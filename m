Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BFA26DD3E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbgIQNzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgIQNym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:54:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4145CC061355
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:44:49 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k18so2115789wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4PE7StSGhWastnqfxjjT9Jz6sdzvLgqq+CZ5VNVeNqE=;
        b=VWZVsAgFJqSfcQSnyzFvlVkg4RexgAp+CN1gPAIU55rLt5JM6mglvVOqPkQ0wy7Mrs
         gG1apGAGTIuEaQjBUXaPt46EzDw168uZsEGnXzaYI8EBY7c8w7z8BQaz3zqDbs+qbmdC
         Dp2b9xnDb9VWkru7Ve+cHC02izf1VDuLz7US+9/zwFqofTV5H79aPd31FZQIRV5G3+M0
         V9jxd77Bl/dfp5iB9Ch7/M0AJRCguzgVjQOqc5mXAmHGvfhO36F5AyHI704IRzhgrGKl
         ss+raOUyktnBccIj/NI2m6FgdmpYOxJd87eKYlWKrSaI0+Y+JVGHrgi58nvGF+e0cm+j
         sREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4PE7StSGhWastnqfxjjT9Jz6sdzvLgqq+CZ5VNVeNqE=;
        b=JEA1yLGNt4h/9HleMhS5tLVa7ol0q4uszKbyINsOhZQu/UIoYTRm+M2g1TDvfYv8jq
         8sE1iLfsc7ZkqDlJ/ZfTjHOMc9/tiUeKAiMxCj5nQ206tTeCy0e4lEc+KAyXtElkNnHe
         T8bcNuBmWgERNFV8mwZ58p1cZFfJjWeiWM/SP1niBW9nPDsS2N6LVOpkatWOkkwqprTD
         OOwFwmFTAE54KGmtO9ojuAQc81J+cvPtjer0KVYgPYCQDJcWbNMFtzLnXMpaD29j9gtC
         8Ry8SWYy44SMVIJqgP525mGVtkCAm64VVa782GcJ7sspmug4fSth32U3JLstJZ/59JRr
         nZ1g==
X-Gm-Message-State: AOAM532VtAbzlYmpZ3j/C+J9JgqMwYexePZaCEygPAcEOCSWWQAlfgRG
        S+U49SREENGrLttWufKbUgdRC51EcXAOwg==
X-Google-Smtp-Source: ABdhPJwpBhAZmDWW0UNj/qWWGmZCi8iBacejXBa8WKPXXQbHZXXt5Os0tiLWRjQ6LtjIhMl2StZveg==
X-Received: by 2002:a1c:7514:: with SMTP id o20mr9865124wmc.76.1600350287743;
        Thu, 17 Sep 2020 06:44:47 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id q15sm36892406wrr.8.2020.09.17.06.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 06:44:46 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] nvmem: patches (set 1) for 5.10
Date:   Thu, 17 Sep 2020 14:44:33 +0100
Message-Id: <20200917134437.16637-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here is small set of nvmem patches for 5.10 which includes
- 2 enhancements to core using simple IDA and kobj_to_dev
- 1 fix in core w.r.t device tree node refcounting.
- removed write support for mtk-fuse.

Can you please queue them up for 5.10.

thanks for you help,
srini

Bartosz Golaszewski (1):
  nvmem: switch to simpler IDA interface

Chih-En Hsu (1):
  nvmem: mtk-efuse: Remove EFUSE register write support

Tian Tao (1):
  nvmem: core: Use kobj_to_dev() instead of container_of()

Vadym Kochan (1):
  nvmem: core: fix missing of_node_put() in of_nvmem_device_get()

 drivers/nvmem/core.c      | 17 ++++++++++-------
 drivers/nvmem/mtk-efuse.c | 14 --------------
 2 files changed, 10 insertions(+), 21 deletions(-)

-- 
2.21.0

