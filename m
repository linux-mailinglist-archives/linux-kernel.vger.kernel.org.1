Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028C828C8AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 08:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389519AbgJMGgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 02:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389353AbgJMGgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 02:36:16 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E41C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 23:36:16 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c21so19156619ljn.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 23:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=f/vgJ5tZy59f3G2+ZFDN7Jz5qqqhrRIyIT59xyu6f5c=;
        b=VurKTq4rgp5xS31EfSVEMi3VVWnmwKjdM3DFbV9rSsz8Yz/49ZmvOwMzsk3v7qa+s/
         MvmDZ2boQ6Qdck58C8ms2jUgqb5FbJcvLeObhEFKEvjyt2KLeuJmYiXrazIVNX/bj19g
         UahdaXUEJKOlbfiSsZGw6zZvk8OQlDkvEFIWdsLgGcoG7EoTdZKKU4KOfoiMBqjHttWO
         j2DalfK305bac6/RFBAtRvh+n7rU0gmKXythGYThz1xDoD8qOg1E4Od2FERDxJhZwAR7
         HfFfN7NK15s4e/6Z6rN7BelvDhnRAA4ivcNiWZDqJxURR+52/I4bQW61fZEJII4lR30F
         mHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=f/vgJ5tZy59f3G2+ZFDN7Jz5qqqhrRIyIT59xyu6f5c=;
        b=G8rpfvhObDqjCNqTuIgg42hEuJ3jCX3hhfy9PsWfebil2h8Q973UutNIN4uDCWXVyl
         lmxMVzhEYfR4PDsnrhSysw3CM+OgUTogBNnxUIRcsJfa8jID7PVg0dnsgC4osQ+IeQ0I
         Va+yP9eb/mPh2D5+wViP1kyAbh3OuTToeamoCuzlq9SCHT0W0iNiEdPCNiyyQ8jGGRth
         eKJzb1HeOeySV7P0wMYi8LHNgf6BVcVQcA8XGgzy56Zffi6lDY/i5UHuvFlVQaZjQTu3
         DDC2oeQUB2Pd0AdxRi0WrStl2oj5xNXwlYZMvs2tnSJBf1L3oNOsaahOf5HjTUClYGvn
         T7JA==
X-Gm-Message-State: AOAM533dpsL0IvB7INT6YFBBxTzf19TDh8ajQIhmjSvu8KB/DoFVwBYp
        M2DxolmQOCEUWsChmDsM7Lac13FQOAGueA==
X-Google-Smtp-Source: ABdhPJxm/XsKE6p9Hy7y4sJgvTLXvYTu5iUNX+bmtQILZWmZ+vyUZEovSYmy3b2YUrfUQFn0vDEhWw==
X-Received: by 2002:a2e:80c2:: with SMTP id r2mr6871608ljg.402.1602570974954;
        Mon, 12 Oct 2020 23:36:14 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id p8sm4048802lfe.11.2020.10.12.23.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 23:36:14 -0700 (PDT)
Date:   Tue, 13 Oct 2020 08:36:12 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [GIT PULL] OP-TEE use UUID API for v5.10
Message-ID: <20201013063612.GA3325842@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small patch which allows to hide uuit_t internals from
the OP-TEE driver.

I know it's a bit late for v5.10, if it's too late please queue it for
v5.11 instead.

Thanks,
Jens

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/optee-use-uuid-api-for-v5.10

for you to fetch changes up to 57222a1be27e06ecb81cc2f945e897814d5f461c:

  tee: optee: Use UUID API for exporting the UUID (2020-10-13 08:03:18 +0200)

----------------------------------------------------------------
Use UUID API to export the UUID

Uses export_uuid() to export and uuid_t to an u8 array instead of depending
on the internals of uuid_t.

----------------------------------------------------------------
Andy Shevchenko (1):
      tee: optee: Use UUID API for exporting the UUID

 drivers/tee/optee/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
