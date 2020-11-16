Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C692B5215
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732054AbgKPUMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbgKPUMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:12:03 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF32C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:12:01 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c20so15201363pfr.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HITzTjgTL+ns/6ovuW41Vsq2GdzLFmOErnmQRXkbgUg=;
        b=n7jAlUVsg4U4IvNEQPQKvDPUVSbq0c/UWeoKLRYp06Pt8qYTyGwCR1ETEUy8IuCqJO
         3SEZ37HJ8d5zbaf3SnReG9dFgFsoH+ywbtARtGRYKId+Qrn9VZ/rLeHV3iXxDYAn2cfv
         qAgYGsidd0NGvSruikCq2UMsnp+NPoWxyi41I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HITzTjgTL+ns/6ovuW41Vsq2GdzLFmOErnmQRXkbgUg=;
        b=bAygFXOns+k4sESnGbJ1K7ipzZb5eQO7GpfHv8xmQ8OI4gQYso3fRTzs8F7D9MFold
         acR3MvMRyk0OAMDzMFpWkvDBKKqbX4KZX7dYCAVMlNIiMVivCtmlcgE8xC56e51E9SRk
         9TCsQ02OQmY0eBamzbDKQcWuAu4kdtTSnz5M6JpN5iG/epa2VbTDEb/tRmYbtmsc9AtL
         eJ8fFiGq99A0He9YMy8Xy9yASDTH8CDc2MlBp/hY+lpU/U2v8GWn7sE1exXJxFkd9kHr
         eb6z9ZqNUdtG8W5eJw6QZZPC0lJYxO6fdBa9p5rrSMQ7Hl7GB5KCoZKAUqQ8ShH7joDf
         b7pA==
X-Gm-Message-State: AOAM533uTD8mbOLp5motSrfRSjyHp2vxC5N2ndPHzFBmJR8vjNLyH7DY
        /Aoe7WMcpqnxts2sv6NbIKtsMrwgX0jF9A==
X-Google-Smtp-Source: ABdhPJwL5MhwEOkkQqa/mJGhE/geuKqPyxMIqajClVinDTtN5wZYnM+ZTfW60Q+YOFFkAZwPs5W3TA==
X-Received: by 2002:a17:90a:fed:: with SMTP id 100mr638868pjz.65.1605557521165;
        Mon, 16 Nov 2020 12:12:01 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id a12sm234577pjh.48.2020.11.16.12.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 12:12:00 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        enric.balletbo@collabora.com
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v3 00/11] chrome/platform: cros_ec_typec: Register cables, partner altmodes and plug altmodes
Date:   Mon, 16 Nov 2020 12:11:36 -0800
Message-Id: <20201116201150.2919178-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the following bits of functionality,
parsing USB Type C Power Delivery information from the Chrome Embedded Controller
and using the Type C connector class:
- Register cable objects (including plug type).
- Register "number of altmodes" attribute for partners.
- Register altmodes and "number of altmodes" attribute for cable plugs.

The functionality was earlier part of multiple series ([1], [2], [3]), but
I've combined it into 1 series and re-ordered the patches to hopefully make
it easier to peruse. I've maintained the patch Acked-by/Reviewed-by tags where
they were received.

Patches 1/11, 2/11, 3/11 introduce the changes needed in the USB subsystem (PD VDO
header update, sysfs attribute additions) and hence the first three patches
can go through Greg's tree.
The others are users of the newly introduced USB changes and can go through
the chrome-platform tree.

Of course, the above is only a suggestion, so I'd be happy to follow
another means of integrating the patches if available.

The series is based on the following git branch and commit
Branch: chrome-platform for-next [4]
Commit: de0f49487db3 ("platform/chrome: cros_ec_typec: Register partner altmodes")

For reference, the patches in this series which are yet to be reviewed are
Patch 3/11, Patch 10/11 and Patch 11/11.

Version history:
- No v2 or v1, as mentioned earlier these patches were uploaded as separate
  series [1], [2] and [3] but have now been coalesced.

[1]:
https://lore.kernel.org/lkml/20201106184104.939284-1-pmalani@chromium.org/
[2]:
https://lore.kernel.org/lkml/20201110061535.2163599-1-pmalani@chromium.org/
[3]:
https://lore.kernel.org/linux-usb/20201112012329.1364975-1-pmalani@chromium.org/
[4]:
https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/log/?h=for-next

Prashant Malani (11):
  usb: pd: Add captive Type C cable type
  usb: typec: Add number of altmodes partner attr
  usb: typec: Add plug num_altmodes sysfs attr
  platform/chrome: cros_ec_typec: Make disc_done flag partner-only
  platform/chrome: cros_ec_typec: Factor out PD identity parsing
  platform/chrome: cros_ec_typec: Rename discovery struct
  platform/chrome: cros_ec_typec: Register cable
  platform/chrome: cros_ec_typec: Store cable plug type
  platform/chrome: cros_ec_typec: Set partner num_altmodes
  platform/chrome: cros_ec_typec: Register SOP' cable plug
  platform/chrome: cros_ec_typec: Register plug altmodes

 Documentation/ABI/testing/sysfs-class-typec |  17 ++
 drivers/platform/chrome/cros_ec_typec.c     | 219 ++++++++++++++++----
 drivers/usb/typec/class.c                   | 139 ++++++++++++-
 include/linux/usb/pd_vdo.h                  |   4 +-
 include/linux/usb/typec.h                   |   2 +
 5 files changed, 343 insertions(+), 38 deletions(-)

-- 
2.29.2.299.gdc1121823c-goog

