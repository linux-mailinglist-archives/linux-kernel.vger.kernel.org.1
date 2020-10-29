Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C5629F7EE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 23:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgJ2W1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 18:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgJ2W1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 18:27:49 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D6CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:27:48 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j18so3594100pfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+sR0ETQQjC3OcYTYIpUiaVXOya/h0TrbznMrV+Jdso=;
        b=C3YmEM4lmBP3Nt0Oz2iF19e9JJ4+NL2IE2Uef28Npc1RDs3PnAmxSxWXpzDmaK8O2T
         ahDw1X9fU+QfOb7BZU6kNmDYktF976qiNcIAEJBlTICIcgigel/gOUxMXSWmu/74ToHo
         S/9Q+ahygEm0+sL28Z6Fv/mdRGyv7Rx5HbQUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+sR0ETQQjC3OcYTYIpUiaVXOya/h0TrbznMrV+Jdso=;
        b=U2JgAZX3YQcg/zPMPFwBA0Ik5BfPfVPvmCuVae+uI8HmJucaI45HhFmB/zOSzMpAvn
         lY8KR37N7XC09Ts4WTrTC/7mkaP+yjaouSS3rdcDfqHW30RY5ZLUNjmWotY2s1RxWe4x
         o8UrqPPMadBJpGSOScKfztiUAijj7OiIaaqVeN4CMhwL4k+bjk6mEUo+bvpe8SwlZqvQ
         NKksALmLeqbl6EXy2aysBIJTsRyOFCvZzqoCMvvdZ4AFG/VBF7q9LkKBtUYPrCBtr+Jy
         0HK3lqh7wHo85mMrzPpQCJ2uuZTDiFJTbEHIQPyjBGk/clqS9OD8rD6e2RKXUCuTVe3k
         OV9Q==
X-Gm-Message-State: AOAM532v4/Ka+FFn1pcg33J4ybHpWrsuFVVKdlEed4nxpKNkk5G8Txsh
        LVSxvOLxw74MYd/8KX/x0KQZlYRwxF4Z/w==
X-Google-Smtp-Source: ABdhPJzlUfIIKaLDKPgoEm1wPeh6QiY/njx5mjoKVwBkElb3mcXF4635MKdrk7u6miw4L+abvI9J5w==
X-Received: by 2002:a17:90a:b28f:: with SMTP id c15mr2006602pjr.230.1604010468153;
        Thu, 29 Oct 2020 15:27:48 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id f5sm3573886pgi.86.2020.10.29.15.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 15:27:47 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, dzigterman@chromium.org,
        alevkoy@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>
Subject: [PATCH v2 0/7] platform/chrome: cros_ec_typec: Register partner PD information
Date:   Thu, 29 Oct 2020 15:27:28 -0700
Message-Id: <20201029222738.482366-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support to retrieve Type C PD(Power Delivery) Discovery
information from the Chrome OS EC, and register this information with
the Type C connector class framework.

There are also a couple of patches which fix minor bugs with the
existing cros-ec-typec driver.

v1:
https://lore.kernel.org/lkml/20201021205317.708008-1-pmalani@chromium.org/

Changes in v2:
- Added missing static to function definition.
- Changes alt mode list traversal based on review comments.
- Rebased series on top of chrome-platform-5.11.

Prashant Malani (7):
  platform/chrome: cros_ec_typec: Relocate set_port_params_v*()
    functions
  platform/chrome: cros_ec_typec: Fix remove partner logic
  platform/chrome: cros_ec_typec: Clear partner identity on device
    removal
  platform/chrome: cros_ec: Import Type C host commands
  platform/chrome: cros_ec_typec: Introduce TYPEC_STATUS
  platform/chrome: cros_ec_typec: Parse partner PD ID VDOs
  platform/chrome: cros_ec_typec: Register partner altmodes

 drivers/platform/chrome/cros_ec_typec.c       | 329 ++++++++++++++----
 .../linux/platform_data/cros_ec_commands.h    | 155 +++++++++
 2 files changed, 415 insertions(+), 69 deletions(-)

-- 
2.29.1.341.ge80a0c044ae-goog

