Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29932C44FB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbgKYQZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730835AbgKYQZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:25:27 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240F2C0613D4;
        Wed, 25 Nov 2020 08:25:27 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y10so2902288ljc.7;
        Wed, 25 Nov 2020 08:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8tUmyfZuKCBKqXKF3o2cj2CwedLbltQ8tnlPWo78TEo=;
        b=hLuxMUEdMa6FCqj2AEOmuZzSpDiZ6ore+amjYLc6vfzXoyPrRxGTNie0XjE+lxMWeW
         b+ID1gmGZmDQHmZ8exvLvJgdtFN+zgicO6HVxSxZX0YsF1ptrAAOj06cPJi9vUiteuGL
         R8Y/rLu29Ool8btnen0BXGN13Jxml6cYEK6DPXkv26M+6VZI6Ks9CE2fw926RfLZWMzr
         yJPTLEI1jxl6TOi2M5HHlPDXIlPhrDUqN3SfMpXWI2E1FCEHVg68RhroLVX7EDZxg3m5
         vw1TBe7K7IzUF599X2SB7Skmildj0o1alZ/qCz4w+mSijj2UviQ6DPxwwoJkYK+mU3Kn
         Ay+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8tUmyfZuKCBKqXKF3o2cj2CwedLbltQ8tnlPWo78TEo=;
        b=EUwDVHaxK7PHYk+mgu+YXcVHQFgZIAOQx+oADj1PpnReRjZh21+3fPrKnl2sngbNnp
         dh3/MHIncV/21OsF8Y3bYGOfLFXc+MuE8etIaEYs9kaNNi7ILqWopv1eGNCZSjgUymwC
         BGj1/b3vc6L77nfiyTdNorP8F+5vnatygv/l1CIuYYqWCtb6LIu4W/0kYfh0a5lm40wZ
         MAuuEQAOIwqDFJJD3GbFTUFE3gV9v/bvQ7h4EmmhAYqWY+vhHc9p8CA4DhF/KJ3LKfC0
         TDbJjCumnh66KDGeUPIoKzMT0LEuLrIY+5ZoMA5JQNvstMB/ZNT+LTFnlw0iSHyoOgzF
         tXCA==
X-Gm-Message-State: AOAM530Hk39oLSH5vU7D1fi6jXuyKBpWr4btJdrM1ZxEn9pv4FUrQI+d
        dVYfakZghhDf0WfP08imMwt4aEwRSsxVCg==
X-Google-Smtp-Source: ABdhPJxoMN5LMQpUlRO8iTthkd7NgjDkUfUnI6iASTOWLdX/HNgDl46Ud1msRfGHT8jWszNW+n0btQ==
X-Received: by 2002:a2e:b0e6:: with SMTP id h6mr1650820ljl.196.1606321525650;
        Wed, 25 Nov 2020 08:25:25 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-6.NA.cust.bahnhof.se. [158.174.22.6])
        by smtp.gmail.com with ESMTPSA id z131sm313881lfc.56.2020.11.25.08.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 08:25:24 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        chenqiwu <chenqiwu@xiaomi.com>,
        Zeng Tao <prime.zeng@hisilicon.com>
Subject: [PATCH 0/3] drivers/usb: Constify static attribute_group structs
Date:   Wed, 25 Nov 2020 17:24:57 +0100
Message-Id: <20201125162500.37228-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify a number of static attribute_group structs. Typically, the
structs either have their address stored in an array of pointers to
const attribute_group or have their address passed to functions that
have pointers to const attribute_group structs as input arguments.

With these patches applied, all static struct attribute_group in
drivers/usb are const.

Done with the help of coccinelle.

Rikard Falkeborn (3):
  USB: core: Constify static attribute_group structs
  usb: typec: Constify static attribute_group structs
  usb: common: ulpi: Constify static attribute_group struct

 drivers/usb/common/ulpi.c   |  2 +-
 drivers/usb/core/endpoint.c |  2 +-
 drivers/usb/core/port.c     |  4 ++--
 drivers/usb/core/sysfs.c    | 14 +++++++-------
 drivers/usb/typec/class.c   |  8 ++++----
 5 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.29.2

