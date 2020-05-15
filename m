Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F361D5B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 22:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgEOU4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 16:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgEOU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:56:44 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6264C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 13:56:44 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s69so1444325pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 13:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZaKdPWICHrxeaJbcoZswmrKCh+nf/OKEqhO0mqkBL0o=;
        b=fToAM0kiMpq2dR+CH7durVFF8CEZAkoYW5Ajg9aw+A6JVRq6NUDQ/2mUM4aTJeGWhM
         igUxe2lGMdSch78wRSDUQgegsr6mtTz52bCm8HKGuW20nxKomwLEz8Nm8Rhxgv7JG4mO
         Nz88xGftWDBFbs3f6ShvzXABvkeBKzkR/JCxbOhcBEK1vhioTn4f3oCbF2zlAWxH3hK5
         fWwSDe8dq+3dht/1R/ITLr4dyAQHcs92NFKxlDE1+yG9TEb+j3erLnuv3ZWyg3J/btm5
         cg1D3nw4v6zjwBbcjVrv1fggMD/jtgcPj/m9esPp+v5nyqoQqvPlWAfAENV4+j7ykNWL
         Tb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZaKdPWICHrxeaJbcoZswmrKCh+nf/OKEqhO0mqkBL0o=;
        b=jGverpwlvRhIrKCEsWkWi91ZuPaBPuVe+5OMgJwz1ZQn4wrxHsYSTVz8DTYhR2lmq4
         7vCtAm+vTJuSzoBY7JX5RJLeFcfvJyzMkWI9htvlnqZb6GifL4pVkXGzRnp/hKntLHz2
         ksQmal7UtEFvO64f81G4KmJkd6fuk4sS4/ZqGNvUB2QxnmGjMeHSdr4umhKJf3/JbtLU
         8yy9xNyi914ClDolxryBn6hxxwTDuu2KTwEMy9EsU2h0/LnQrlUJI0X6WF6o35QMJEan
         pwd6YZ2+/i+6LVJDdTgvMrP4tBpbyq+qWPros9G0qrz+K4eTJINetbERdLOYqEZNUM3e
         GKgA==
X-Gm-Message-State: AOAM5334Wl9eDiylMUYMi5LUgumJgsH3jbvyQRR8odMiVZRtJ1iOj+VX
        6nAK7kx3EwXnwjzM7oih97fCrA==
X-Google-Smtp-Source: ABdhPJxH1V+FMWeIMxm/3315pKLxhQfiK+9ClID6F/TqaIZyHMTMQTS7TTEXJmC2UjSoxRPUCo1Irg==
X-Received: by 2002:a17:902:6b05:: with SMTP id o5mr5085512plk.274.1589576204401;
        Fri, 15 May 2020 13:56:44 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z13sm2208903pjz.42.2020.05.15.13.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 13:56:43 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     arnaud.pouliquen@st.com, s-anna@ti.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] rpmsg: core: Add support for name extension 
Date:   Fri, 15 May 2020 14:56:39 -0600
Message-Id: <20200515205642.13529-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the capability to supplement the base definition
published by an rpmsg_driver with a postfix description so that it
is easy to differentiate entities that use the same name service.

Applies cleanly on rpmsg-next (4f05fc33bebd).

New for V6:
- Added example on how to use the new API.

Thanks,
Mathieu


Mathieu Poirier (3):
  rpmsg: core: Add wildcard match for name service
  rpmsg: core: Add support to retrieve name extension
  sample/rpmsg: Print out RPMSG device name extension

 drivers/rpmsg/rpmsg_core.c          | 115 +++++++++++++++++++++++++++-
 include/linux/rpmsg.h               |  13 ++++
 samples/rpmsg/rpmsg_client_sample.c |   5 ++
 3 files changed, 132 insertions(+), 1 deletion(-)

-- 
2.20.1

