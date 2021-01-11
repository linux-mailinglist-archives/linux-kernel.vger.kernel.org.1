Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37322F1E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390716AbhAKTGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387578AbhAKTGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:06:41 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93A2C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:06:00 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id e2so325326plt.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ANBjRwqH1HoPchWIW+dbJvfbLYPMTGo/1NpZE7xk2Pk=;
        b=ctAuKNyW/b4XuZsUgM+xIQoeRnGzABubNTZ2QL9o59sKoo2JJo9C9AiBhBJUDvTt7R
         BzWYfEQwZtbEEO0eZ4ovwhNKyuieCI5+7oHhRvvJLPGUhspd+eXpcjKi4wRQJXm7TYK3
         jf8y1mPTcavtn5NMk2BECr2s4s3t30EyeFHjUH7O3CgauML1wEDZmepjaD2eCu1JWYPi
         JH/BoPKEC40rlfy7LSorzXcciIhs70XpsEJMvUNqacSNa4J+qMreDhx5q1N46aYzA5sw
         9iJC4Q5fPK80xl/ajiGK5pnsZPT2EHRMCUhu4MmpNuTS+WJitrz2XchqGximLT7pKDzh
         F/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ANBjRwqH1HoPchWIW+dbJvfbLYPMTGo/1NpZE7xk2Pk=;
        b=p2kFZSGpWk7dHpugx0NbwOYuwzM1hPzo40dYdMiD9+R3W4aSdSixH5VeT9pSu/pytT
         XSZNqsk3ohBsLuWiZS5K4zpy0nZm1bq/qra3IjDYSiOBZHDOcO+YrBAR+mK8+I1GyvMn
         tSXIrwS2Zejb52+l44U9zpTWQH8U8LiVzpo4B/IzoMMgUKnu4oQc2t95UlvvF7q/Pigf
         fOBTDBJlqyiSIpx3UjpHO6WS37WBtovX3reyR7dIVPVxDXFMndbJfq3i5vWelga3327K
         7zpqqnLxYJmWVcWyZjAdqSBtk+bZTawcZwJmfGCelv4P+tea3hv5X2a8kRrxTKcHxmgV
         CK6g==
X-Gm-Message-State: AOAM5315ZOIcrN+po1AaBMZGWHtxv2okO1uA/owq+R0CQ18O8ZPBGeqV
        fdQr1od5kdrTBuOLRyaPs+c=
X-Google-Smtp-Source: ABdhPJwWNGOgwovchwndU22WdKcsLn0ITUAiEQwHOmkGZw52WuV/NiJBK0nV28kcTbEsYCO6Aq9bxw==
X-Received: by 2002:a17:902:aa45:b029:de:2fb:995 with SMTP id c5-20020a170902aa45b02900de02fb0995mr1122547plr.81.1610391960420;
        Mon, 11 Jan 2021 11:06:00 -0800 (PST)
Received: from adolin ([49.207.206.164])
        by smtp.gmail.com with ESMTPSA id gg24sm144979pjb.32.2021.01.11.11.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:05:59 -0800 (PST)
Date:   Tue, 12 Jan 2021 00:35:54 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 0/3] Decouple config data for configfs
Message-ID: <cover.1610391685.git.sylphrenadin@gmail.com>
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

 Documentation/gpu/vkms.rst         | 12 ++++++++
 drivers/gpu/drm/vkms/vkms_drv.c    | 45 ++++++++++++++++++++++++------
 drivers/gpu/drm/vkms/vkms_drv.h    | 13 +++++++--
 drivers/gpu/drm/vkms/vkms_output.c | 13 +++++----
 4 files changed, 68 insertions(+), 15 deletions(-)

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

Changes in v5:
 - modify docs patch(Daniel)
-- 
2.25.1

