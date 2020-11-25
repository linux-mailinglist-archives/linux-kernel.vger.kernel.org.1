Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12822C42CE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgKYPXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgKYPXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:23:53 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D4DC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:23:37 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id w24so2517029wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/nqjuILf6kmx0MZe7cAUEaugBXSYSmokY24T3KrBU+0=;
        b=dYdV4mCUth5JHcnXV/T3D3rsP+YIJHBqyReikTaq4cZJramK4zU+0uWUTc+5lIr7p+
         zlUedoUfcb09F9ZVbwpUf8gHzEHEDnl2DaUm+4OIXU5OErUxOaSVD6KqxJmRe4H8+EOV
         Cfzc+9ju8GRIUWfi5M+5nB5bjXNVVX/RP2XA11OhF0So7+gEJCnMKTRMGW6LSqbPD/IW
         maMAGiMjNK47DDGEXMAYpU9bp1Hbx284f1ck3OSFXSDuq6BrXU1g5j7A+8B0dfh/pNiJ
         JJJkpxDMA/okF19bF58S9q7exPZdHW+TMGIoo07VPmKx4VLoE/43QxrxIFwzbMhvP1kn
         Rc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/nqjuILf6kmx0MZe7cAUEaugBXSYSmokY24T3KrBU+0=;
        b=bwZ7/oFxcLS5oWGfsUOGOXIykjWHmAI9mvJWGM22BPBU0ISBi0ylPf1hDM5uchlVHr
         BpUJ7vgMJGqMertAVAbofqsu873z5nLnWuAEY3yEu64RHM5HbtgZjNmBkdGQlKy/8KKI
         EWg2ML3drcEFxTI77tmyXdNQ5Epckn5UorDlMpN9aD1q2r4Xh9zRg/JkpFN3sLhOYkN/
         YeTkmtNBcDlZsdSLJWJKoZc6LKlzZm0JMivvPOX95XEvy1hFR6QjU0XuSSEWdnIw0m6j
         hNxYnZo6tVQns33TdUDewQSOzFLX+oiugUTkvFwohdcSzIFOdYaNqxAzGe+1COM9/UZG
         oo5g==
X-Gm-Message-State: AOAM532apKcoURGFfY6AaTQ1czPMNFSXt6Z+776RC8U8OWeo/QcxMRNJ
        dr1DYuonZzqyciPQFwjSpg6apfOVs6HUYQ==
X-Google-Smtp-Source: ABdhPJxHH7CggXOFHf3AM3chGt0CEDnrAa7zRtZKHnrrkMF1REG3KpBBxf3SGlBNPUVNTjDrD/s1Sg==
X-Received: by 2002:a7b:cbcc:: with SMTP id n12mr4530107wmi.115.1606317816565;
        Wed, 25 Nov 2020 07:23:36 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id 9sm4896731wmo.34.2020.11.25.07.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 07:23:35 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/4] configfs: implement committable items and add sample code
Date:   Wed, 25 Nov 2020 16:22:43 +0100
Message-Id: <20201125152247.30809-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Committable items in configfs are well defined and documented but unfortunately
so far never implemented.

The use-case we have over at the GPIO subsystem is using configfs in
conjunction with sysfs to replace our current gpio-mockup testing module
with one that will be much more flexible and will allow complete coverage
of the GPIO uAPI.

The current gpio-mockup module is controlled using module parameters which
forces the user to reload it everytime they need to change the chip
configuration or layout and makes it difficult to extend its functionality.

Testing module based on configfs would allow fine-grained control over dummy
GPIO chips but since GPIO devices must be configured before they are
instantiated, we need committable items.

This implements them and adds code examples to configfs_sample module. The
first two patches are just cosmetic.

Bartosz Golaszewski (4):
  configfs: increase the item name length
  configfs: use BIT() for internal flags
  configfs: implement committable items
  samples: configfs: add a committable group

 Documentation/filesystems/configfs.rst |   6 +-
 fs/configfs/configfs_internal.h        |  22 +--
 fs/configfs/dir.c                      | 239 ++++++++++++++++++++++++-
 fs/configfs/file.c                     |   8 +
 include/linux/configfs.h               |   3 +-
 samples/configfs/configfs_sample.c     | 150 ++++++++++++++++
 6 files changed, 408 insertions(+), 20 deletions(-)

-- 
2.29.1

