Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B8D2A8C11
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732680AbgKFB2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731111AbgKFB2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:28:15 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599E8C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:28:15 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id e7so2800764pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VvTyEH/5OPHkuR2uQBZQ7iKaDkYMP3ddbHbrnIA3UKs=;
        b=kexnuPe3sGqmGRossbXOUjkF7rcCGE7Rm/bT3CPgCE9rmTCIpnkXmw6izKxcBrU4VC
         4CyXFd0ajo1teg24dRKCnchR+gJG27gqnwv0ld35PV57gErZl/w0GF3s1nKSCEhOIsPg
         9vX1+HbL5fHlIFG5S3AHjEcErmlzekput1gjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VvTyEH/5OPHkuR2uQBZQ7iKaDkYMP3ddbHbrnIA3UKs=;
        b=VFKMMHnvNNegbDccgxrKbMRngguWSPJIAB5uHs6P9yoKLw0F/BGOkVr3Udzs3EATQo
         IVEH61Vb56TE6kz0S0hwsqXgx30fqZNHWuKxK38fdEb9dxAB7E6LLP5sKYhjxPj77Uan
         vQWNea4NqL7JE1OYwgpo/HGEp/paAFoPArymr4xiI1D4bPzPc8tlGSTHJmbosEjUsQZm
         z13LGWHl4Lq4MEOY5BKTHdFhvLbEPj86/3qaR2ZoaIVdELRxpcb+aJFtHF5k+3w2xC14
         4JxCL85L6Y2iUwOOkvXpyDfB1J8yIdC2U9sAn2DAaPqRA0IpfX1yj7ms5Clq8n9Lmv67
         Y9qQ==
X-Gm-Message-State: AOAM530rRurnMgzSO+l69lMonK3bcbERdbiPMQVWhRmqNlVAJ4G2vDFl
        ojsj9Tu+Li4U7hKYOnlfzYkim0Hzn+11LQ==
X-Google-Smtp-Source: ABdhPJwpENg1xxH+jg6K0ihpMdjRM2t/OxkSOaVsYmQBHgSl3+yRx2+PTlWixQRUz5ScplL1e5EZdQ==
X-Received: by 2002:a62:1603:0:b029:160:98fc:ad23 with SMTP id 3-20020a6216030000b029016098fcad23mr5180310pfw.47.1604626094618;
        Thu, 05 Nov 2020 17:28:14 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id e2sm3567887pgd.27.2020.11.05.17.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 17:28:14 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, dzigterman@chromium.org,
        alevkoy@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
Subject: [PATCH 0/6] platform/chrome: cros_ec_typec: Add cable registration
Date:   Thu,  5 Nov 2020 17:27:51 -0800
Message-Id: <20201106012758.525472-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series adds Type C cable registration to the cros-ec-typec
driver. The first few patches perform a few minor re-organizations to
prepare for the cable registration patch.

The last couple of CLs update the USB PD VDO header file to add a
captive cable connector for the Type C cable plug field, and then use
the added macro to add the corresponding field of the Type C cable
descriptor in the cros-ec-typec driver.

Prashant Malani (6):
  platform/chrome: cros_ec_typec: Make disc_done flag partner-only
  platform/chrome: cros_ec_typec: Factor out PD identity parsing
  platform/chrome: cros_ec_typec: Rename discovery struct
  platform/chrome: cros_ec_typec: Register cable
  usb: pd: Add captive Type C cable type
  platform/chrome: cros_ec_typec: Store cable plug type

 drivers/platform/chrome/cros_ec_typec.c | 148 +++++++++++++++++++-----
 include/linux/usb/pd_vdo.h              |   4 +-
 2 files changed, 123 insertions(+), 29 deletions(-)

-- 
2.29.1.341.ge80a0c044ae-goog

