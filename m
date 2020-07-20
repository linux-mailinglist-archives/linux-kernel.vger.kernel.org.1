Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD87D2260C4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 15:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgGTNXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 09:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgGTNXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:23:49 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE34C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:23:48 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y18so9679405lfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KrAss4lc00W6QNDjWbi871nOrYWlFTN1XCNqWDD3xTU=;
        b=VZyRZ8ObOiDkJFkElvWyTKxxdXm9e4MYZm9YE30BwMl//sSArnmaw3oRZYtDwIDQ4W
         ejftejyWE5IdHtL2TKM/WE9ZLPWjLCCq6uVgraHoDXor3gUZkpc1QuVkGtQQcxRyba6p
         No9blhxvD66qzWU42jf14Cmst1vtPBQr2pxjCyQIiRGjOAJYimFyCCI3Va5CplUKsHb6
         PSikL/IGq8hBhNKFmUV9IMAK2d33qQGDgNBrM2JierbC9C7M/CHi5rUmPVuYTaFztUYe
         C352eI/yIDaBkHKJG+K0GN/FFvAbSkitcVBsYFRvVDrRSr6aGCZxZWhbNDJZJomGmHs6
         L7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KrAss4lc00W6QNDjWbi871nOrYWlFTN1XCNqWDD3xTU=;
        b=l6aL9JAmFbdG9tIxJ92DyJBFC3ReUVYceECgN+LG2aNNV0kW5wtIKY2wjBpGB/yCeZ
         ScQQOxkK9VYB2Bv3//8JL2mOTF2RvZAirYMjrgF0pbn+J2TRUkoXtYBivN105Mb3H3nh
         /zO3GeZSU6Zf3MZVOZsU79rOMl1BcXjdQgJaGd0EmEN8BogIn41nR4kdsGcKsuYYVuyN
         wBcAxHp1R7xMP/e9UwB2+37TMT+CyRigEd3f/EJkDwt+hDuO0P7JGwI7cnFvWCpMp2aH
         ZJsLstllbtSDFsT6OX3SYRy7snOozWaSstCJ0hFWQghNIkS1iVcNXFN6300vYtiMruvt
         4Jzg==
X-Gm-Message-State: AOAM530Xnk4WIOiDnd/2TSRiabzGzTEEF3fKXJ3e6i8ijz+lg3fpGnq2
        gb4vWgIsQIGf+/jR3rt/SvcSuQ==
X-Google-Smtp-Source: ABdhPJwnQCUyckx2BckYhrK0HLOXPQ2J0bwLgJivl+wgL2+y7cZFqkZzofNiCa/h/g7WzB0ZtEKC7w==
X-Received: by 2002:ac2:4183:: with SMTP id z3mr7912099lfh.3.1595251427255;
        Mon, 20 Jul 2020 06:23:47 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id h6sm867829lfc.84.2020.07.20.06.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 06:23:46 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maheshwar Ajja <majja@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 0/6] Add new controls for CQ and Frame-skip
Date:   Mon, 20 Jul 2020 16:23:07 +0300
Message-Id: <20200720132313.4810-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a new series which adds Constant quality and Frame skip std
controls. The series is combined from two other series [1] and [2].

Changes:
 * added Reviewed-by Hans tag in 1/6 and 3/6.
 * fixed typos in 6/6
 * rebased on top of media/master

regards,
Stan

[1] https://www.spinics.net/lists/linux-media/msg171411.html 
[2] https://www.spinics.net/lists/kernel/msg3578260.html

Maheshwar Ajja (1):
  media: v4l2-ctrls: Add encoder constant quality control

Stanimir Varbanov (5):
  venus: venc: Add support for constant quality control
  media: v4l2-ctrl: Add frame-skip std encoder control
  venus: venc: Add support for frame-skip mode v4l2 control
  media: s5p-mfc: Use standard frame skip mode control
  media: docs: Deprecate mfc frame skip control

 .../media/v4l/ext-ctrls-codec.rst             | 48 +++++++++++++++++++
 drivers/media/platform/qcom/venus/core.h      |  2 +
 drivers/media/platform/qcom/venus/hfi_cmds.c  | 37 +++++++++++++-
 .../media/platform/qcom/venus/hfi_helper.h    | 10 +++-
 drivers/media/platform/qcom/venus/venc.c      | 20 ++++++--
 .../media/platform/qcom/venus/venc_ctrls.c    | 17 ++++++-
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c  |  6 +++
 drivers/media/v4l2-core/v4l2-ctrls.c          | 12 +++++
 include/uapi/linux/v4l2-controls.h            |  8 ++++
 9 files changed, 154 insertions(+), 6 deletions(-)

-- 
2.17.1

