Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A18E2EC0AC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 16:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbhAFPwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 10:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbhAFPwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 10:52:47 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3978C06134D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 07:52:06 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id g17so1492424wrr.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 07:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=0QeHafaN+6pva6XnlDmaJHR7Sw5XHBtBnuyuxZTaO/k=;
        b=mTK7oXr4IVYP2JsFQR9Q/8mLdfi9OxywhsKdo/JeZLzUYaqEgbyBm++04dMvQo921c
         cxuiHV3l5BcGtABo8zKr68L9vN6CA2zX9jTjIMiCrJ15DPbGGCypB7N+2Usqy20dlzO6
         A/kmCUEMrZts8I/3cZZuLE/s/8xZQdRgpgcYjYbC0oZ5ltKVV5getwcnajMK2bNtClNK
         VXMxg6QXeezfOGPaT4FNkA+MrYccRnEaOSkCejwhOKWdhV1PD1Tje1/EOzFL5DZY6P0F
         5zFKMFmQCfA8uBYw2V0gt6m/RHqPfFDgZRl60gigSIY095J/fW3g0BYTBcnALOQNfZmF
         Z/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=0QeHafaN+6pva6XnlDmaJHR7Sw5XHBtBnuyuxZTaO/k=;
        b=cyMLyoqCNY4QBKiXL4l9jbJezqX8auB7m0etvAL2Uv3lcaBUVvbejjZMQd4CrunWM9
         hz26boUH+3s24xBVWT79KTijbXyTE90T7o4xeOXYm+Uvy90zdlfbtIqm2AASDrI3XqlJ
         RXf200TEPkkXPZT/Lz3lQgxVMo1JrrLGlitqHig1i16N7nZJZ/1SR5rITrE3ex673dlw
         cKkEB4di/xExTbkJ8OMrgNm+OOA4PogI2h8Vj6T1AdyLsK/o0lV43E2xh/BQt4umjKyM
         1bzvAc5b8t2ADEiPf0TJt+zJvLPnf58pOfv2VvJAjN81BeQH8yXME77TYOqbbn0woOvO
         7n0A==
X-Gm-Message-State: AOAM531ZtR4P5eeRE29xZdyzUCkrjOOsdI92HcIVJu6lbI8tzgiBndu6
        nMF19NO8r3opv9AUV1Ix6GMB5vAFjmPdmWJ7JnruYId6nXQxFS5Lv68NSdDIDK5yCs+ox9o98kG
        r8G90tb2hix9xN32fS7ZZcQ3DvIm34so5M6Mt9RTGiPVUVwwO3EVfMqt/MGK7GL8GjhCrJUOeV9
        w=
X-Google-Smtp-Source: ABdhPJwKN7FUiRc2rONR/HNbHQBFWfLJA4/YW6ZFOnVKiisHTsbeCAG+QftF3R6YIhFKG8RpFCA1eJaKEifo6A==
Sender: "maennich via sendgmr" <maennich@lux.lon.corp.google.com>
X-Received: from lux.lon.corp.google.com ([2a00:79e0:d:210:7220:84ff:fe09:a3aa])
 (user=maennich job=sendgmr) by 2002:a5d:4d4f:: with SMTP id
 a15mr4856061wru.315.1609948325216; Wed, 06 Jan 2021 07:52:05 -0800 (PST)
Date:   Wed,  6 Jan 2021 15:52:01 +0000
Message-Id: <20210106155201.2845319-1-maennich@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH] staging: ION: remove some references to CONFIG_ION
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        Rob Herring <robh@kernel.org>, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit e722a295cf49 ("staging: ion: remove from the tree"), ION and
its corresponding config CONFIG_ION is gone. Remove stale references
from drivers/staging/media/atomisp/pci and from the recommended Android
kernel config.

Fixes: e722a295cf49 ("staging: ion: remove from the tree")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Rob Herring <robh@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: devel@driverdev.osuosl.org
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 .../media/atomisp/pci/atomisp_subdev.c        | 20 -------------------
 kernel/configs/android-recommended.config     |  1 -
 2 files changed, 21 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_subdev.c b/drivers/staging/media/atomisp/pci/atomisp_subdev.c
index 52b9fb18c87f..b666cb23e5ca 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_subdev.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_subdev.c
@@ -1062,26 +1062,6 @@ static const struct v4l2_ctrl_config ctrl_select_isp_version = {
 	.def = 0,
 };
 
-#if 0 /* #ifdef CONFIG_ION */
-/*
- * Control for ISP ion device fd
- *
- * userspace will open ion device and pass the fd to kernel.
- * this fd will be used to map shared fd to buffer.
- */
-/* V4L2_CID_ATOMISP_ION_DEVICE_FD is not defined */
-static const struct v4l2_ctrl_config ctrl_ion_dev_fd = {
-	.ops = &ctrl_ops,
-	.id = V4L2_CID_ATOMISP_ION_DEVICE_FD,
-	.type = V4L2_CTRL_TYPE_INTEGER,
-	.name = "Ion Device Fd",
-	.min = -1,
-	.max = 1024,
-	.step = 1,
-	.def = ION_FD_UNSET
-};
-#endif
-
 static void atomisp_init_subdev_pipe(struct atomisp_sub_device *asd,
 				     struct atomisp_video_pipe *pipe, enum v4l2_buf_type buf_type)
 {
diff --git a/kernel/configs/android-recommended.config b/kernel/configs/android-recommended.config
index 53d688bdd894..eb0029c9a6a6 100644
--- a/kernel/configs/android-recommended.config
+++ b/kernel/configs/android-recommended.config
@@ -81,7 +81,6 @@ CONFIG_INPUT_JOYSTICK=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_TABLET=y
 CONFIG_INPUT_UINPUT=y
-CONFIG_ION=y
 CONFIG_JOYSTICK_XPAD=y
 CONFIG_JOYSTICK_XPAD_FF=y
 CONFIG_JOYSTICK_XPAD_LEDS=y
-- 
2.29.2.729.g45daf8777d-goog

