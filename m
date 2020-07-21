Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D522286B5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 19:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbgGURDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 13:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbgGURAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:00:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0BCC0619DA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:00:14 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id j18so3534942wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xJrlFMWKxatZWph59ICW46ox2+7HmmvvIn3EeO3FeI=;
        b=PVIhzoPM3gEKKNEvTDPU2WIGtUhV/u/A5vb8GkfStZQGTn5fcZQkHF6bSvbbjOFuHE
         PNG8+7cf3SGbqoCPqe/L8csJj60z6FNPKmFUdUwcrqda34gCifbx293ULH1RaGg9ckO4
         Eu60QSn4tK2vo6FgCVTTnenXJbXQfJ65WcIAC0yGHxPc0FNte+6/QtoFx9rQj33rZhMO
         hiz1AFhtgOSevd/zk7EZopgPPPMW16xbfBtwwUXW4ehgOHzRqLHcnfauSatP+DALT6Vj
         RHSSmYa+I43Xew+DutleOWZYfiNZqnpDUecTJ9nAz+VAlBB/770ICyBDps78iz5cstTF
         /swA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xJrlFMWKxatZWph59ICW46ox2+7HmmvvIn3EeO3FeI=;
        b=NQsPNHO8VCmTI/YEn6TJqD7c1Y1DW6sj1QavHEzrjoPh86j/9y1RbvRYLf9mdC1LwC
         01+tEwyM/2pt7cpSd0TiwcNdVlKMcbAXddzU4CPFuqgdnDG9zWoq23fUkMTsI8WEispB
         QhrA5FRp2M1+DZgdvgBUw02zFsB6EzMpnrP3//iN4bCFRHRfW0MfS+LZXgVIRHxnS6a6
         ZHXkLnf44By5S6HKlCv5y1equRjV9cmb+22xsGJgDvgz9sMVjoveEdCGbyfuH70Wz8kt
         b0lFYM4SQAbcOR+VFhdPzWIiYVuqIOXk9Q7/4SEK2/emRDXGsVtmYBKyY+aQBCNhlOE0
         47dQ==
X-Gm-Message-State: AOAM531uZCG4sk8dmNrRMQj3FxUaIcob3v0kMxSN1VCUCL6BsgDQa5ay
        DEqcXUCn0/lHvDdU099n/ncDCw==
X-Google-Smtp-Source: ABdhPJyYZBuQBKApyeCyxRx1114Gjkuf5aLBbKXX19WAtdt2tYwrr6tlGYAxkvYG3bw+HoqMbUAAAQ==
X-Received: by 2002:a1c:7311:: with SMTP id d17mr4798367wmb.60.1595350812765;
        Tue, 21 Jul 2020 10:00:12 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id h11sm15526327wrb.68.2020.07.21.10.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 10:00:11 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH v2 0/6] ALSA: compress: add support to change codec profile in gapless playback
Date:   Tue, 21 Jul 2020 18:00:01 +0100
Message-Id: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For gapless playback it is possible that each track can have different
codec profile with same decoder, for example we have WMA album,
we may have different tracks as WMA v9, WMA v10 and so on
Or if DSP's like QDSP have abililty to switch decoders on single stream
for each track, then this call could be used to set new codec parameters.

Existing code does not allow to change this profile while doing gapless
playback.

This patchset adds new SNDRV_COMPRESS_SET_CODEC_PARAMS IOCTL along with
flags in capablity structure to allow userspace to set this new
parameters required which switching codec profile, either for gapless
or cross fade usecase.

thanks,
srini


Changes since v1:
- split patch into smaller chuncks,
- bump up the version
- added flags in compress capablity structure 
- added user for this new functionality.
- add this new call in Documentation.


Srinivas Kandagatla (6):
  ALSA: compress: move codec parameter check to a function
  ALSA: compress: add new ioctl for setting codec parameters
  ALSA: compress: add flags to snd_compr_caps to expose dsp caps
  ASoC: compress: add snd_soc_dai_compr_set_codec_params()
  ALSA: compress: bump the version
  ASoC: q6asm-dai: add support to set_codec_params

 .../sound/designs/compress-offload.rst        |  6 ++
 include/sound/compress_driver.h               |  5 ++
 include/sound/soc-component.h                 |  3 +
 include/sound/soc-dai.h                       |  5 ++
 include/uapi/sound/compress_offload.h         | 10 ++-
 sound/core/compress_offload.c                 | 72 +++++++++++++++++--
 sound/soc/qcom/qdsp6/q6asm-dai.c              | 33 +++++++++
 sound/soc/soc-compress.c                      | 30 ++++++++
 sound/soc/soc-dai.c                           | 14 ++++
 9 files changed, 170 insertions(+), 8 deletions(-)

-- 
2.21.0

