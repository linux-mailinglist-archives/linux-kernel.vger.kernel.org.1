Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2748250F0F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 04:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgHYCb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 22:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgHYCb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:31:58 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25E5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:31:58 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e5so8011184qth.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uyaJ/4wPgeTokW25lNh+HoQXlbWu4TVCiFbX0XTVmIc=;
        b=oqEIjJ8mhmnROX/s/ZQ8KcY4WMfYQXKM8S+FMYiPOLv4aSYasxWJ63WAsrc7HXYD22
         zH292Bw0r3zPVUYEP2L2MaY9GwmpcXnPMteLe2GPpe2aSBpkaZswOi+D3ku2ysalRGSN
         vEqwumOTLuXRWHD6FHTC6RXqZS04wEpZfQflHRwrb3jq2OT8xSlKsODoMHwTEP65CR/y
         OLuq8h93XDJL/+vBKcKPrq6KUf+FNL5lsSDXDv1tRrqOdXVaTcljOz9nI1dXd7guCpsp
         /fgg/F+BxaLZswUKwoR8Kul3/es9KwCLwAIk0Oog+lLo90n+BwkK9/ZXjv+NMjE3O5Ot
         EZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uyaJ/4wPgeTokW25lNh+HoQXlbWu4TVCiFbX0XTVmIc=;
        b=KByEJv0QHugO7BpRltaWV3ADYY7TueexABI5QUiZltm57LOMKdD4R2py22NVBgDvq8
         I3haMpRTsbzFd1kzZnRhWLAIbvxMhx/Ht5aaOIAjgxQ2r9XXcWc9Fzy2QMiytYJuyE34
         OPZVlJ85rbcvlI6qolEgach550oLsiDr3+pzNfZOC7aMTu2bgBa1n29QbQyeAskAoRRq
         qUW0WP5P+ktuqp3tUYJrJHoUj3iFUwi2Bqp7IvJHG/SfPM5btJOJvSI3/j1worDBiAlC
         SQXiX5pXtepIQZ12GIabNhm7I9e5YDuwlVVck8OMn0IhQx1foyxHj0yufkDX1WrgfMGt
         cJwg==
X-Gm-Message-State: AOAM532Deb7uKAlpwi2bcV9AZO3RXQXaFYldQAo6PzOBvvsI1tCfDI5j
        MxaGB+y1xubEgw8F0rZ8S4YWLjSICY4=
X-Google-Smtp-Source: ABdhPJyDJLKURHKOSKzQLquxgUG4q1/h2802N8eWgjpa/ztBYYCG0o5hp7R4i31DiWqtomBZW7629g==
X-Received: by 2002:ac8:42ca:: with SMTP id g10mr7849427qtm.219.1598322717679;
        Mon, 24 Aug 2020 19:31:57 -0700 (PDT)
Received: from atma2.hitronhub.home ([2607:fea8:56e0:6d60::2db6])
        by smtp.gmail.com with ESMTPSA id x137sm11095372qkb.47.2020.08.24.19.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:31:57 -0700 (PDT)
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Leandro Ribeiro <leandro.ribeiro@collabora.com>,
        melissa.srw@gmail.com, daniels@collabora.com,
        Emil Velikov <emil.l.velikov@gmail.com>
Subject: [PATCH v5 0/3] drm/vkms: Introduces writeback support
Date:   Mon, 24 Aug 2020 22:31:39 -0400
Message-Id: <20200825023142.2561220-1-rodrigosiqueiramelo@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the V5 version of a series that introduces the writeback support
to VKMS. The first two patches of this series are a pre-work for the
latest patch that adds the writeback connector, this patchset can be seen
in two parts: 

* A pre-work that aims to make vkms composer operations a little bit more
  generic; these patches try to centralize the vkms framebuffer operations.
* The final patch enables the support for writeback in vkms.

In the previous review, Emil suggested multiple changes in the series. I
tried to apply most of the recommendations except for some suggestions
which I was not able to incorporate due to compilation issues, or other
suggestions that may complicate this series review. I left some changes
for future patches for keeping this patchset simple with the hope of
landing this feature soon in order to support VKMS user's requirements.
Emil, let me know if you want me to change any other thing.

It is important to highlight that from the previous series to the
current version of this patchset we had some changes in the VKMS that
made it unstable.  In particular, our previous writeback series stopped
working properly due to changes in our commit tail.  Thanks to Melissa
working in the instability issue and her latest fixes to VKMS, I finally
could update writeback and make it work again. The main update in the
latest patch is the use of vkms_set_composer when the writeback work
starts (enable composer) and after the writeback end (disable composer).

Best Regard

Rodrigo Siqueira (3):
  drm/vkms: Decouple crc operations from composer
  drm/vkms: Compute CRC without change input data
  drm/vkms: Add support for writeback

 drivers/gpu/drm/vkms/Makefile         |   9 +-
 drivers/gpu/drm/vkms/vkms_composer.c  | 102 +++++++++++-------
 drivers/gpu/drm/vkms/vkms_drv.h       |  11 +-
 drivers/gpu/drm/vkms/vkms_output.c    |   4 +
 drivers/gpu/drm/vkms/vkms_writeback.c | 143 ++++++++++++++++++++++++++
 5 files changed, 231 insertions(+), 38 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_writeback.c

-- 
2.28.0

