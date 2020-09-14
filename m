Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D283269918
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgINWlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:41:20 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:19710 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbgINWlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:41:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600123278; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=3trGlBAsrqKw/gr2Zpkc3eqT35HTCBYAGTjHtSXQM0Q=; b=nlL/4RplCbT0z8RWdCF4vJHkBFT1e7gyFaZAIW/pF+Xq0eBIw00BlMGX6O6ecL6HWRunjdUA
 eKlvLxLSL5dVrT2glWNqmYhvKCm4BLUJJKHKxCDmwXvQYfpWyZE1494E7KtZb+DUPzoyT7MI
 ebKQu1uzsTakQCK5KTbQi6AyaZo=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f5ff160be06707b34dc5b65 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Sep 2020 22:40:32
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 444E8C433FF; Mon, 14 Sep 2020 22:40:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1351FC433CA;
        Mon, 14 Sep 2020 22:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1351FC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     Akhil P Oommen <akhilpo@codeaurora.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.velikov@collabora.com>,
        Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] drm/msm: Add support for the WHERE_AM_I opcode
Date:   Mon, 14 Sep 2020 16:40:20 -0600
Message-Id: <20200914224023.1495082-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The microcode in linux-firmware has been updated to 1.87.01 for a5xx
1.77.01 for a6xx [1]. These microcode versions support a new opcode called
WHERE_AM_I that takes the place of the hardware RPTR shadow and enables the
microcode to update the RPTR shadow in privileged memory so it is protected
against the user.

This patch series re-enables the RPTR shadow and preemption for a5xx and older
versions of a6xx if the WHERE_AM_I opcode is available. Newer a6xx targets
(starting with a650) have automatic privileged protection so the hardware RPTR
shadow can be renabled for those targets too. If any of the needed dependencies
aren't met then the RPTR shadow will remain disabled (along with preemption on
5xx).

This stack is bsed on https://gitlab.freedesktop.org/drm/msm.git msm-next-pgtables
as there are some minor dependencies on the reorganized code in the pgtable
stack.

Jordan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=f48fec44127f88ce83ea1bcaf5824de4146ca2f9

Jordan Crouse (3):
  drm/msm: Allow a5xx to mark the RPTR shadow as privileged
  drm/msm: a6xx: Use WHERE_AM_I for eligible targets
  drm/msm: Get rid of the REG_ADRENO offsets

 drivers/gpu/drm/msm/adreno/a2xx_gpu.c       |  65 +++++++++---
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c       |  77 +++++++++++---
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c       |  82 +++++++++++----
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c       | 108 ++++++++++++++++----
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h       |  12 +++
 drivers/gpu/drm/msm/adreno/a5xx_power.c     |   2 +-
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c   |   5 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c       | 100 +++++++++++++++---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h       |   9 ++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c     |  81 +--------------
 drivers/gpu/drm/msm/adreno/adreno_gpu.h     |  81 +--------------
 drivers/gpu/drm/msm/adreno/adreno_pm4.xml.h |   1 +
 drivers/gpu/drm/msm/msm_gpu.h               |   1 +
 13 files changed, 377 insertions(+), 247 deletions(-)

-- 
2.25.1

