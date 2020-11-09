Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E586F2AB22E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 09:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgKIIIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 03:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKIIIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:08:14 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B611BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 00:08:13 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id d17so7742098lfq.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 00:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=YPIO337ZqmTg7mGl8r87VRhd1YWWw1c5ZttCJTJ/hp4=;
        b=LrjCD4vqs7Sxqm4LFrF1+p7XmZeyTUv23gOTsx5IW+7jx9YCWXx7K2N+mIczDcUZcu
         nFW8idSrK+rQh7AidldUN/u9HP05YFDwYi8IEd+oz1SvKlePaWpfdjJNIJnxM7qdluZb
         0LkwaCYyKD7N1fqkt0SF7WFI4C7Mhvl/wnaQRKwHjsIml2L9GSvweimMuytfRyIKO4ND
         +WUNf685Rp4l+35l2ApO2R8uPDJcWGEMkq+DaLifIEjanWq9uT6Qhk0ZmU0bNpenWpWj
         X05Bh0jli/xoP2oPwjraPKV20CpnNGwR96UcIRr1xeQ2VbuzX5URoMaNFCO13UbzpdSn
         O15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YPIO337ZqmTg7mGl8r87VRhd1YWWw1c5ZttCJTJ/hp4=;
        b=lGnDH4VdQ+edtwO/C084Ma1UBcdQjTZev2hMN7aNxYu+qa90tevp5vaI0Ui4uadY3C
         TUVTMl47gKErunTNgcWGOgfe1AZBekUxFKvjpkrqAS9/UZihjZm2SOoTnjNskpr5Dzww
         nmNMQQaInPMKYH7d7OP7eMXGPwVYBUsfFaA0TgpAtqTA4BMVVjTamcIZP//+mPLF122R
         cXgLLqWCwwk0cuXNGBEG1YlCP4LLbbrDGPXZaun1ktYbVfN8yVNefdfM/AFQ3EssMjLm
         66CCAeUAZTKggtI/rLh+K7MczfKZ/Kg/314x3KcOp15wUEl3aOTHI83LgO1InThkk9q7
         j8vQ==
X-Gm-Message-State: AOAM531hds9gowQK0PlKw4X3uuPgSy/l3W9Oj4vPvKZ+fBrVD730mzqq
        n9viLgbgrXD+FqonjVtw7kwyyw==
X-Google-Smtp-Source: ABdhPJy7uTWVdp8lizHDfGVhQOGWlLkeWorzX2GI0IyF9rL0sSfiw2mMJJ3Kr9w+ml6DdZDawGHHZQ==
X-Received: by 2002:ac2:4474:: with SMTP id y20mr5699257lfl.160.1604909292192;
        Mon, 09 Nov 2020 00:08:12 -0800 (PST)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id t138sm1351538lff.183.2020.11.09.00.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 00:08:11 -0800 (PST)
Date:   Mon, 9 Nov 2020 09:08:09 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Subject: [GIT PULL] AMDTEE driver fixes for v5.10
Message-ID: <20201109080809.GA3862873@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull these AMDTEE driver fixes which are needed when opening multiple
contexts or file descriptors.

Note that this isn't a usual Arm driver update. This targets x86/AMD instead,
but is still part of the TEE subsystem.

Thanks,
Jens

The following changes since commit bbf5c979011a099af5dc76498918ed7df445635b:

  Linux 5.9 (2020-10-11 14:15:50 -0700)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/amdtee-fixes-for-5.10

for you to fetch changes up to be353be27874f40837327d9a39e3ad2149ab66d3:

  tee: amdtee: synchronize access to shm list (2020-11-09 08:59:00 +0100)

----------------------------------------------------------------
AMD-TEE driver bug fixes

AMD-TEE driver keeps track of shared memory buffers and their
corresponding buffer id's in a global linked list. These buffers are
used to share data between x86 and AMD Secure Processor. This pull
request fixes issues related to maintaining mapped buffers in a shared
linked list.

----------------------------------------------------------------
Rijo Thomas (2):
      tee: amdtee: fix memory leak due to reset of global shm list
      tee: amdtee: synchronize access to shm list

 drivers/tee/amdtee/amdtee_private.h |  8 ++++----
 drivers/tee/amdtee/core.c           | 26 +++++++++++++++++++-------
 2 files changed, 23 insertions(+), 11 deletions(-)
