Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7FC2DDD37
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 04:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbgLRDRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 22:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgLRDRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 22:17:48 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ECDC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 19:17:07 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h75so962667ybg.18
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 19:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=tFsp6CH4m43xFAZz/38v7JzYiv1DTpcXEDDEsiEkpXE=;
        b=tDe0ASi54Tv7G07RldVhCqkUsWK32D6bMs0uxW4Un41XoPdSo+geG6Cn0h+95C0Gum
         ppDl0HU33qGgqLEsFg9hzICvzZSE7t87DGpzvakZdHU+iCYx0WfBOiqzYROI3R1aAn9C
         MYx3h4JtATcVi08xOVdnCqiJw6qLaJkirw0qVmDpt4t2M/E2atBZ9TENz0Vb2N5bNPx8
         xCmGRcQn+vu7n0Gx18ArGLOVyWhlGMxycKo5y/7anBgEZceaz0DTciPi/TtjTXLCArIX
         Bn9Jc01D+W6rmBBplpDENbBqBXf1EEf+rFjHOA7I2qCe4Q8dT7CbkphH4VsvdH7tur7K
         DvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=tFsp6CH4m43xFAZz/38v7JzYiv1DTpcXEDDEsiEkpXE=;
        b=L+Lq2ruB4REQB5oYZXQVcagBOFhjVuO7MF1qUuIIh4ODYTAUDedgQUXtX92Ok4L5uC
         G4YVpJ1H7vsFdLSBF7gnqyZFSqEmovSlM4bsHxvcfTMLffZNQhTvLX3AOLTvWcgp/ZwU
         3bKeNq1dE4Se31qZihsOh9vSeUyMl6Co97+crM4izMuld21lSktjnPrnKdmtwHdjpfn3
         WriDet+LtddOx4qQG6y5fUXya/UJJVU8SMwARnFe2pH4wPCALEQ15ApzVbg0G1ZJhzC0
         hMKAOxt+dSewAkPigjPdxFMTeviYTeT08WQ/KsOZwMJE8dmYEt/2SAtlWfEi4+YkM6QM
         fi4A==
X-Gm-Message-State: AOAM533dn7lZskQLS3kTwJ1PVdJdwS6pFdt3s5TZG6ocCEBvwKSKuuc9
        D6nLUGuDaCkdI2HkgHbVjDzivkz+ESIsV7c=
X-Google-Smtp-Source: ABdhPJwXYDCs0xOa27xaFklH0qHkL/POwlXVjtGUooXF52Cf5F27MOwP6alBJYKDRfomuklQ12ykzhCwbIW3wis=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a25:818e:: with SMTP id
 p14mr3302026ybk.425.1608261427017; Thu, 17 Dec 2020 19:17:07 -0800 (PST)
Date:   Thu, 17 Dec 2020 19:16:58 -0800
Message-Id: <20201218031703.3053753-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH v1 0/5] Enable fw_devlink=on by default
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed in LPC 2020, cyclic dependencies in firmware that couldn't
be broken using logic was one of the last remaining reasons
fw_devlink=on couldn't be set by default.

This series changes fw_devlink so that when a cyclic dependency is found
in firmware, the links between those devices fallback to permissive mode
behavior. This way, the rest of the system still benefits from
fw_devlink, but the ambiguous cases fallback to permissive mode.

Setting fw_devlink=on by default brings a bunch of benefits (currently,
only for systems with device tree firmware):
* Significantly cuts down deferred probes.
* Device probe is effectively attempted in graph order.
* Makes it much easier to load drivers as modules without having to
  worry about functional dependencies between modules (depmod is still
  needed for symbol dependencies).

Greg/Rafael,

Can we get this pulled into 5.11-rc1 or -rc2 soon please? I expect to
see some issues due to device drivers that aren't following best
practices (they don't expose the device to driver core). Want to
identify those early on and try to have them fixed before 5.11 release.
See [1] for an example of such a case.

If we do end up have to revert anything, it'll just be Patch 5/5 (a one
liner).

Marc,

You had hit issues with fw_devlink=on before on some of your systems.
Want to give this a shot?

Jisheng,

Want to fix up one of those gpio drivers you were having problems with?

Thanks,
Saravana

[1] - https://lore.kernel.org/lkml/CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com/

Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Marc Zyngier <maz@kernel.org>

Saravana Kannan (5):
  driver core: Add debug logs for device link related probe deferrals
  driver core: Add device link support for INFERRED flag
  driver core: Have fw_devlink use DL_FLAG_INFERRED
  driver core: Handle cycles in device links created by fw_devlink
  driver core: Set fw_devlink=on by default

 drivers/base/core.c    | 101 +++++++++++++++++++++++++++++++++++------
 include/linux/device.h |   2 +
 2 files changed, 90 insertions(+), 13 deletions(-)

-- 
2.29.2.684.gfbc64c5ab5-goog

