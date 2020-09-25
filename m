Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9217D278EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgIYQf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgIYQf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:35:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA81EC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:35:56 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q9so3677241wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmounVMbkghHgQw2uLZEbV9nHVzbf0HPhUzVBFiceS8=;
        b=QXN0SmqSBLpJhF4hEknAPQ8enuiO8VPjiS9tRN9ap8b0aNsnIQWw3AhnnoAdsBdu0x
         2fymvW2WlHnWBNg0KykMkwPIRAGEdKGoroMfJ4P97tWY4og9k7YvybCGsaHL8g3w0UC3
         m3YeLXrjZAIHJ0Yr1aiY4YNjBOXyC2dN15/kjAfScHxlM5qy3Ovt4Agu8M3xM8me/TGA
         GllxG2ldZJ7UGrAsza6vVtW25uCYOYo2RvZHmnl3Zc6aFCWc0XH2pYgsgo/T/36pUSFu
         hxZFuJ/2B4W/xZDG3Ux52ZQfC0anhTeDCroW8GkbHU9SrKwYGW4jDldJkzPD5D3Ik6CA
         /O8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmounVMbkghHgQw2uLZEbV9nHVzbf0HPhUzVBFiceS8=;
        b=DYS/z0MKwo91LLiUrhIkR8iigHkFDJe3nz5hemxZVEmmBcQ6JjWBmSyLguZe0RMgMU
         TDq2Flx3JNp/OJ6VtAhSDnYT051fxegXws00VkaiJcHIyIRNBafa1XHBIHTveo7cL5i+
         K1KsQfp0izDqsFaluCFh3B9D4vPT3SPHAFXW65sduWDaCljkkm96t/3RtY9VdFgJzDei
         QPkvOjHsx60XsYxksIWVaNUGhbkbfuPx1zcWIhKtf/7HF3exOBbnbxdrXl+UVVfSKAOy
         GP8kUMDXVD4TxVDk+tTU6QDqw9eIroo2xKtRvf4a44RqfqDoQiba2prTLy+5el0/OuZJ
         1VTg==
X-Gm-Message-State: AOAM531TEUiyWgxP6BmS91vOkYK68rziboG8/ysLQysWpHv3xqOQzNmQ
        5wyv0XxmNll/w70rRdCvV5Co/w==
X-Google-Smtp-Source: ABdhPJxAXyw/Uff+CZFsPVEwnxt5gil9qvEfqgid+fiQzJHexwNZxXuvWrEkPU+tiETs5WCKuWMbdQ==
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr3968205wml.176.1601051755421;
        Fri, 25 Sep 2020 09:35:55 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id m4sm3733883wro.18.2020.09.25.09.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 09:35:54 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/2] ASoC: qdsp6: fix some warnings when build without CONFIG_OF
Date:   Fri, 25 Sep 2020 17:35:50 +0100
Message-Id: <20200925163552.20717-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are fixes for two warnings types discovered while building qdsp6 drivers
without CONFIG_OF and with W=1

One of them was reported by Intel kernel test robot on q6afe-clocks patch, which
equally applies to rest of the qdsp6 drivers.

changes since v1:
	- added ifdef CONFIG_OF instead of removing of_match_ptr

Srinivas Kandagatla (2):
  ASoC: qdsp6: add ifdef CONFIG_OF around of_device_id
  ASoC: q6asm: fix kernel doc warnings

 sound/soc/qcom/qdsp6/q6adm.c        | 2 ++
 sound/soc/qcom/qdsp6/q6afe-clocks.c | 2 ++
 sound/soc/qcom/qdsp6/q6afe-dai.c    | 2 ++
 sound/soc/qcom/qdsp6/q6afe.c        | 2 ++
 sound/soc/qcom/qdsp6/q6asm-dai.c    | 2 ++
 sound/soc/qcom/qdsp6/q6asm.c        | 6 ++++++
 sound/soc/qcom/qdsp6/q6core.c       | 2 ++
 sound/soc/qcom/qdsp6/q6routing.c    | 2 ++
 8 files changed, 20 insertions(+)

-- 
2.21.0

