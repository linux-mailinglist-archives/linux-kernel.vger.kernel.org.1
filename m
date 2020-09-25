Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872F7278657
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgIYLyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgIYLyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:54:51 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69181C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 04:54:51 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so2994154wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 04:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fJiQtctcNXBXh9qT9CsxSpdBmaOAAcN7q8VKxTKjhaU=;
        b=S/0MsNcBf6z9nBBvhntFcfWhRa8Njb3YJt+R7C91VoWSkZIdBuCIRQEjM/nBmsrQVi
         G53IB3NSvKjEBH/XC5d854Q+FH1fw4FwDZkBq7xco39cbCmxfAZEnZTcFr7ajynYZcvz
         1VLnxXrUZoikLnOXqq0yRpmb4f0UZvmtscFX2CGlgl4YEKWkq359mKzLRiqSW+d0MBJo
         yitugr4cZxKEgXQJEsccq3LMYRx8mznOvlat24ZUUzZB9Xwp3R+uitpcz/fjxkUysy2d
         E3S9m2XHjQHcO07TcX32i3KToMN+yfvqjO7wR0G9BNzQtLOCO5oCoU4VtNuD2WXM+h0G
         fWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fJiQtctcNXBXh9qT9CsxSpdBmaOAAcN7q8VKxTKjhaU=;
        b=YLNUnyvQAr49f6fCyZWHG8mqZI26oKNhgSLIX8HzKNZzGgSqi34Cm1vd7N2UhDCcR+
         YID9M/gjjRx3su9HURCLfCdg5F7Kq6Y9tpQZdD/p9fSYzek4lgYUF77Ly2xt7hMCpvHx
         NSeuXwZNVWovsBI4Uy44cPqOEd5scfKIR1m3UHHYWuUcSHc2c/sRZ70+BbXxtrJ1AC3M
         1hYOn5gSMVTbtsBKNuGwZXKa3wBVHPcKRhNRy+yapjdzPyobdm3dyh6K0nlsErCXwO/U
         JuIO65lQBAtZ7/p6nrqgJ86pwtieGmMVX/lBXKK3mtjRlfFmW0WhfvIoFCdyYd3wBrDO
         oAcw==
X-Gm-Message-State: AOAM533DVuc40gHFUmu4OrlyVMXaD2dfom/OCvezwuWxwoIkHQZ53h7q
        i6A8yJr+Pu5RLekdddStz7UaoktV5zg=
X-Google-Smtp-Source: ABdhPJwocQd2+b0Q+AdxAsEP44KNbkvGJtE8N8U930DR4GlTWGZmcwM5oTHPJ5S/t/1mWs+3cpuEUQ==
X-Received: by 2002:a1c:6607:: with SMTP id a7mr2736836wmc.142.1601034889924;
        Fri, 25 Sep 2020 04:54:49 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id q18sm2586075wre.78.2020.09.25.04.54.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Sep 2020 04:54:48 -0700 (PDT)
Date:   Fri, 25 Sep 2020 14:54:47 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs second pull request for kernel 5.10-rc1
Message-ID: <20200925115447.GA2256@ogabbay-VM.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is habanalabs second pull request for the merge window of kernel 5.10.
It contains an important fix to our ASIC reset flow and a few other minor
changes. Details are in the tag.

Thanks,
Oded

The following changes since commit 9eb29f2ed95edda511ce28651b1d7cdef3614c12:

  Merge tag 'icc-5.10-rc1' of https://git.linaro.org/people/georgi.djakov/linux into char-misc-next (2020-09-24 15:15:11 +0200)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2020-09-25

for you to fetch changes up to 25121d9804b8421851e3ccb88d1d35a5d93692b8:

  habanalabs/gaudi: configure QMAN LDMA registers properly (2020-09-25 14:44:21 +0300)

----------------------------------------------------------------
This tag contains the following changes for kernel 5.10-rc1:

- release the kernel context object after we reset the device. This is
  needed to prevent a race where the firmware still has some in-flight
  transcations that require the kernel context (and its memory mappings) to
  be alive.

- replace constant numbers with defines in QMAN initialization of GAUDI

- correct an error message text and add a few debug messages to help debug
  issues that happen during context open and close.

----------------------------------------------------------------
Oded Gabbay (4):
      habanalabs: correct an error message
      habanalabs: release kernel context after hw_fini
      habanalabs: add debug messages for opening/closing context
      habanalabs: add notice of device not idle

Ofir Bitton (1):
      habanalabs/gaudi: configure QMAN LDMA registers properly

 drivers/misc/habanalabs/common/context.c | 13 +++++++
 drivers/misc/habanalabs/common/device.c  | 13 ++++---
 drivers/misc/habanalabs/common/memory.c  |  4 +--
 drivers/misc/habanalabs/gaudi/gaudi.c    | 62 +++++++++++++++++++++-----------
 drivers/misc/habanalabs/gaudi/gaudiP.h   |  8 +++++
 5 files changed, 70 insertions(+), 30 deletions(-)
