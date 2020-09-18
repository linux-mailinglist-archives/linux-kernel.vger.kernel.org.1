Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C8C27000D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 16:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgIROlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 10:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgIROlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 10:41:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D4DC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 07:41:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k25so5330366ljk.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=N2cRR1bqs+5tj1of0U4CpX6EeJBhHim3bgiMhmU8VOo=;
        b=KObaMNjFxWPqr7Yolymu/lxSRIV3+LdKNPu5BVTKaKfS3JC/SvZK97LM5SFXPuloxR
         dIYlXIyuM+cU4LRoy9FdsB6dGbA8BPWUAqZsJRmXNbYzL8arCQgN7U9mAFRq6DtS8DsY
         DsVvP0Yz7lKzDni31/zz0akHosXS56jJ39JsQTFRmz+DFSt347VuiiVGlPMMw3ONChGB
         cw6RW7+ECDAcmwEjlepcBajumhOhX37zEtjRPqMD+owhuMNnE+HP4HceQ0PAMhqh7YkX
         0mN75Slaj6aPWOlHt0Lmxwwwrr0rCX2ia65LaFKX0oL9P0UeWL0eFhQrEhysgG/rEOAV
         9E2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=N2cRR1bqs+5tj1of0U4CpX6EeJBhHim3bgiMhmU8VOo=;
        b=izl0ViqM58NdsRR56554uyLadykOutSY29Kqzxs7yRv2HWCxWOZX2CVS5sajsAFaWV
         wn+u3urVj04rS3xggQHk+oflwd7FltN4cnpVf2rEMii1zaXxAivw/meX1/unNu2Q+ra0
         kWVgPF7Z8L3ZRDbx4IGsE7E5MvHa/CP8UtN1d42uEfGhtsPqk8jCDlH3P9JZWMFeR7BQ
         n1Emo7+GdAlzU2vePTCQbJ1lW/3GS3ZctxOV/4tJ/NjgEvxD+fbeEcroJ3vZeR9hYUE0
         TqY57T17zgBaYwYNUWVL+XN5qzvhetPO7WRVq2bIw/Gn8l+zVzdqlddFeXoael6STDew
         C3CQ==
X-Gm-Message-State: AOAM531fWdggXkWitIbE5oFkcJz8KChM0FwGSdjcAWXWiVRAHgPHsjhQ
        VFajYw2/Z6fU/KM7PxPTaHaF8DpgE5g6VA==
X-Google-Smtp-Source: ABdhPJz8InSl5HtAfRczk5FmvB0um+7TuFkwaNvrgPKaDbWpm3HfUfDODOZNA744WeQ6w/XBO13HHw==
X-Received: by 2002:a2e:9b15:: with SMTP id u21mr8180298lji.283.1600440092720;
        Fri, 18 Sep 2020 07:41:32 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id m20sm633031ljp.132.2020.09.18.07.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 07:41:32 -0700 (PDT)
Date:   Fri, 18 Sep 2020 16:41:30 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [GIT PULL] tee dev cleanup for v5.10
Message-ID: <20200918144130.GB1219771@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small cleanup in tee driver registration. There are no
changes in behaviour, just a reduction in number of lines due to
improved usage of the device driver framework.

Thanks,
Jens

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-dev-cleanup-for-v5.10

for you to fetch changes up to 8c05f50fe8452f9d3220efad77bef42c7b498193:

  tee: avoid explicit sysfs_create/delete_group by initialising dev->groups (2020-09-18 10:44:45 +0200)

----------------------------------------------------------------
Simplify tee_device_register() and friends

Uses cdev_device_add() instead of the cdev_add() device_add()
combination.

Initializes dev->groups instead of direct calls to sysfs_create_group()
and friends.

----------------------------------------------------------------
Sudeep Holla (2):
      tee: replace cdev_add + device_add with cdev_device_add
      tee: avoid explicit sysfs_create/delete_group by initialising dev->groups

 drivers/tee/tee_core.c | 40 +++++++---------------------------------
 1 file changed, 7 insertions(+), 33 deletions(-)
