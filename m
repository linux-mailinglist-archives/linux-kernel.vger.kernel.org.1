Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088CA277162
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgIXMqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgIXMpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:45:34 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92DDC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:33 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id d4so3383628wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d3SG2VuN6Q6yklPuf6I/qUniM4mC+6BL9uEaXLt4Seg=;
        b=O8ugPqVoKjSkoyIHv0pmcgxzGnb6Rq3vjXGX03phOhtG+E3eYC8JsCVNqWspS9B4sX
         DdVv0iJFtGt24aXWclxntzOIPgNPJyvjOhyd+/CM32cjHrfeeWAKjDiD2mQjZ9aNpioj
         V/u0PK5zCzGcmOSUiACXgCC4JdxGQe+rWOl9ZDszcd9o4smHYZxPLu/xCy8/hCk893tf
         njg00UpXcABFpQ9h8jwg0rlsSWU+ahvSWdsp5VuSiT+DnYjd4KnZsXXjimRK8PF9T7z1
         fx8ToxwUa2z++FtRYiGgmbE7H85dmfNS2N0hf9oJaUDf6W7N+vw/wvTylXCeqVl70Tjp
         kTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d3SG2VuN6Q6yklPuf6I/qUniM4mC+6BL9uEaXLt4Seg=;
        b=TvZ961L2iO+fq1gesOocjUnkGNZJcu2t2hfUO79FzGTdYpkEBTet5grN+/+Zc41pDx
         2vkYGTY9HNBllKUuP6IdBqeB7L4zbavpAJgZ/9EoXvvK8vxBuCZeZ67hVz1hHRfPr82i
         qX/pJBkaHFLBG8PjfuyVZWYfXH7374tsd1Pmw2jYYEFtOOi85sXcre5EfgaElvgW/MgW
         Mq8IVnIuR2CUKQ5ZAp4ynfgBpEOZ31sOqhMkl1rQzqJYehpxCA8FNpNIPHvK80rfS8Am
         7W56jXCH1rlXWgNjoiVJrBNkcfIHWufr+c2vyFJ/Z2ycgTdYL5mNFxk463POuQ0KcvGC
         CMGQ==
X-Gm-Message-State: AOAM530ssDZCG3UDNuS4AKLYiQ3IVxHvFOoO8WT5vM1Pr7iKIGnLVoLU
        HnA1gEM6bHI4uSFfTbd5AuBZoQ==
X-Google-Smtp-Source: ABdhPJy2EcyD2BCZhz5UC6zbjfnFvGtX/WNY6SwBOgBP6OjIPZsk0l8tc9aL2FyhAsdmLiz2wBSq5A==
X-Received: by 2002:a1c:63c1:: with SMTP id x184mr4675001wmb.138.1600951532403;
        Thu, 24 Sep 2020 05:45:32 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id 9sm3316834wmf.7.2020.09.24.05.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:45:31 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 00/12] samples: configfs: refactor the configfs sample code
Date:   Thu, 24 Sep 2020 14:45:14 +0200
Message-Id: <20200924124526.17365-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Over at the GPIO sub-system we have a testing module (gpio-mockup) which
uses module params to instantiate simulated GPIO chips and debugfs to
control them. We want to switch to a more stable interface using configfs
to instantiate chips and sysfs to control them.

For that we need the feature that's well defined in the docs but currently
unimplemented - committable items. I started working on this but it won't
be ready for this release cycle.

In the meantime I also refactored the configfs samples a bit as I'll be
adding sample code for committable items. I thought that it won't hurt
to send the refactoring patches now for v5.10 so here it is. No logical
changes really, mostly just code quality and removing usage of deprecated
functions.

Bartosz Golaszewski (12):
  MAINTAINERS: add the sample directory to the configfs entry
  samples: configfs: order includes alphabetically
  samples: configfs: remove redundant newlines
  samples: configfs: drop unnecessary ternary operators
  samples: configfs: improve alignment of broken lines
  samples: configfs: fix alignment in item struct
  samples: configfs: replace simple_strtoul() with kstrtoint()
  samples: configfs: don't reinitialize variables which are already
    zeroed
  samples: configfs: prefer sizeof(*var) to sizeof(struct var_type)
  samples: configfs: consolidate local variables of the same type
  samples: configfs: don't use spaces before tabs
  samples: configfs: prefer pr_err() over bare printk(KERN_ERR

 MAINTAINERS                        |  1 +
 samples/configfs/configfs_sample.c | 78 +++++++++++-------------------
 2 files changed, 29 insertions(+), 50 deletions(-)

-- 
2.17.1

