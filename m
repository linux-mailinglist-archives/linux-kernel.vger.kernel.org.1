Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D1A2F077E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 15:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbhAJOCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 09:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbhAJOCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 09:02:22 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90785C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 06:01:42 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e2so8093911plt.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 06:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=lJZqOpZ8UmCzUAN84FCZjD7qVTQcxVbeporibxTdXVM=;
        b=KsYf+NIcLqDud3idfANJiGiW3dr0eOUA5X61g98JKJX1nQuzl9t7ciwbc9+xAArjYw
         dE38MzkzEAYejz3yVXkN6qgRulIz0Kw3wusq2BxChOScKonWrFmEpzOGIlaTpZv29Egx
         B3x0Ujc4B1CTa0r32tyCToUU1PD7Ma/cD9xkdvA/oOtYZTBV9vg9uewjiZLwhwSBqvvd
         YE5evSUCn3ipel+4R8MtakmJu+SGFjMQjYJ4QbiBH/f1VSGEXMMLZK4tnUoViGymd+mK
         fpYHT/7sNPUqPPRTQE+EftPk26gZyjAOb77IJZMgX/syDabuAevSl3mr2pvPb9kmmCrb
         pCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=lJZqOpZ8UmCzUAN84FCZjD7qVTQcxVbeporibxTdXVM=;
        b=KW6oFUvs3kVFtsqAT/10A3xGmrZvrGXA2K4kcc1w2Bi/wPu9J7fs0DjVtNI9JBTAar
         vWWovy82r8oJWy46ugLPYAzXlLGvzEjuvVU6OIdhximmVAN1/CO/JkJzKpYRvcpxnvgN
         ylxfgl7QMsbxdiNz7+oygac6yDGod1/x3t8GZsNSrZM0LkpPYV7DUT0cclEdnqun0XRm
         zwqJ/9sXOSIg6WMeitmZ5xxiIL43fKYUJx0I659QNkWantzYPIhMDI3ORo0fOb+F4vl2
         RN64vaF9oSHWJppiwPhkBuabnDAhlSrxhenTwXVLf/NBUfNNOOsZHu5oiCMP/sOhhOWQ
         Y+gA==
X-Gm-Message-State: AOAM532pOnZG6fa7aGFzBGKBK5jchEJS7K/XAv2LK1CuQBb0S/B3Vn4L
        3XgMI+S925lxGW61IxUoLPI=
X-Google-Smtp-Source: ABdhPJz5QGHT3Ab3PLEPEulwl2eWVQ3TxQm9G05D49mmkSNLO1MstUyYCQCnhPhwaQkAIFIag19JOQ==
X-Received: by 2002:a17:90b:107:: with SMTP id p7mr13350779pjz.216.1610287301979;
        Sun, 10 Jan 2021 06:01:41 -0800 (PST)
Received: from adolin ([49.207.199.194])
        by smtp.gmail.com with ESMTPSA id h12sm16662199pgs.7.2021.01.10.06.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 06:01:41 -0800 (PST)
Date:   Sun, 10 Jan 2021 19:31:36 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/3] Decouple config data for configfs
Message-ID: <cover.1610200411.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset aims to lay down some prep work before configfs can be
implemented for the vkms driver. The first patch in the series adds a
new type vkms_config to track device configuration. The second and third
patch add module testing support for writeback operations.

The first patch is developed by Daniel Vetter.

Daniel Vetter (1):
  drm/vkms: Add vkms_config type

Sumera Priyadarsini (3):
  drm/vkms: Add vkms_config type
  drm/vkms: Add support for writeback module
  drm/vkms: Add information about module options

 Documentation/gpu/vkms.rst         | 10 +++++++
 drivers/gpu/drm/vkms/vkms_drv.c    | 45 ++++++++++++++++++++++++------
 drivers/gpu/drm/vkms/vkms_drv.h    | 13 +++++++--
 drivers/gpu/drm/vkms/vkms_output.c | 13 +++++----
 4 files changed, 66 insertions(+), 15 deletions(-)

---
Changes in v2:
 - add Co-developed-by tag
 
Changes in v3:
 - correct usage of Co-developed by tag(Melissa)
 - add enable_writeback_feature(Melissa)
 - modify commit message(Melissa)

Changes in v4:
 - split previous patch into patchset(Melissa)
 - fix checkpatch issue(Melissa)
 - update docs(Daniel)
-- 
2.25.1

