Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C331CDAE5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 15:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgEKNOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 09:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726687AbgEKNOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:14:21 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC03C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:14:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id c21so2854683lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5G2udOSHaQZv+/vRn9bY4n/DXBHSBdIm8Dj9bPbJOA=;
        b=hIRznpXq1Mi0E8mpdkPnk3hmCkIkEdeRf6pMnebUkb/1CDDnNzap+KPo0X8tCEvAHM
         xux9V5R+UKSG7LTlNhow80b5oSyz4xu9EjSrj8Pt40WjDISGvgcW8IJY/kKUaLIARklB
         EbZt05Xvxf090qFRJbw+YxVv3z4tehsHGxa7zVsxhhW7/b1rCSP3K5Fg5ihZdeS3Uwns
         dc/rCGAp97V3cXOpMFrs3ekRGUiaufkpPWfCoOFWPi0BgV3Ve2ztEHzwmtpn1PC4zUsJ
         +32zH47SoxY/QYEMo58iwTYlsCsokYNHuIVcee4mk2XUGMQNnJfdWs6oP8a3HdQdYGEO
         lBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5G2udOSHaQZv+/vRn9bY4n/DXBHSBdIm8Dj9bPbJOA=;
        b=GMzGtkDpLqFM68QXeRGblmxhKk3xAqiVx9kA9rG1zwxHiRIjzN4VhNdnGjhclmE2rI
         +V4U6V6BVT3XW7DUlu+4yJucpytYEzKmpE+gK1aDZ+32TpzUpQK/xp1AAkd+kghCyjhW
         ZQT2FmmU6w7bAYuGgQ+fIeVqOIoB0WaCo4h95IHlbEuie+D7ebrgroQUY+C1tEBAkl8v
         0wC8jKNzZFVSJUZ2vUpAzYa96CO7ja3fx9f+WnQmZrNBd3CzqiFR0eUClbKn9F+OHBzs
         ca0nN8iaACWtXEEjOsJ5G9X6h0bM9mFrsJN+AJ46xj8wqi07NAjXQfVgSTqU2Irftfjj
         f9cw==
X-Gm-Message-State: AOAM532IWPmYbcaLMbjQUDWYLCjsYozLpo7CgZuRUKIeCxkSBE1aJSox
        D/mZq3NVi2NEtfSCkoJqG/pZLg==
X-Google-Smtp-Source: ABdhPJyxP3hgaWRGIbs7CbiGxBLMK1Agzv2v0iWSsVIzG1UmL0wwG1g4ObOsnQjUF+BkJb3I4c3vbw==
X-Received: by 2002:a19:cc92:: with SMTP id c140mr10986211lfg.34.1589202859704;
        Mon, 11 May 2020 06:14:19 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id f24sm11918890lfk.36.2020.05.11.06.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:14:19 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     brendanhiggins@google.com, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, john.johansen@canonical.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-security-module@vger.kernel.org, elver@google.com,
        davidgow@google.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v3 0/6] Enable as many KUnit tests as possible
Date:   Mon, 11 May 2020 15:13:50 +0200
Message-Id: <20200511131350.29638-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset will try to enable as many KUnit test fragments as
possible for the current .config file.
This will make it easier for both developers that tests their specific
feature and also for test-systems that would like to get as much as
possible for their current .config file.

I will send a separate KCSAN KUnit patch after this patchset since that
isn't in mainline yet.

Since v2:
Fixed David's comments. KUNIT_RUN_ALL -> KUNIT_ALL_TESTS, and he
suggested a great help text.

Since v1:
Marco commented to split up the patches, and change a "." to a ",".


Cheers,
Anders

Anders Roxell (6):
  kunit: Kconfig: enable a KUNIT_ALL_TESTS fragment
  kunit: default KUNIT_* fragments to KUNIT_ALL_TESTS
  lib: Kconfig.debug: default KUNIT_* fragments to KUNIT_ALL_TESTS
  drivers: base: default KUNIT_* fragments to KUNIT_ALL_TESTS
  fs: ext4: default KUNIT_* fragments to KUNIT_ALL_TESTS
  security: apparmor: default KUNIT_* fragments to KUNIT_ALL_TESTS

 drivers/base/Kconfig      |  3 ++-
 drivers/base/test/Kconfig |  3 ++-
 fs/ext4/Kconfig           |  3 ++-
 lib/Kconfig.debug         |  6 ++++--
 lib/kunit/Kconfig         | 23 ++++++++++++++++++++---
 security/apparmor/Kconfig |  3 ++-
 6 files changed, 32 insertions(+), 9 deletions(-)

-- 
2.20.1

