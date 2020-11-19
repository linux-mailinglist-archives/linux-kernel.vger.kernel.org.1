Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0773A2B9A13
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgKSRxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbgKSRxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:53:34 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07772C0613CF;
        Thu, 19 Nov 2020 09:53:34 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id t8so5190229pfg.8;
        Thu, 19 Nov 2020 09:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q5bokItvl+fmuIZW/0y8NwDSrtKawLhWKURQ2+FWucA=;
        b=EUXaa1+dR5q61YJ40WibXLDQtMqjkX2z3HUPNxZCT4F0baHJnL4zDsSFOkfKHK7gEt
         x9BUpxhQo3dAQ9WrWmssEC5Ntrgu8Eg1fudHqtbpRvgrfuE20rdjVHJtSQ3cXgPe/Ykm
         A5W+9KONVdkO4ETFuaZDyE4DQCPQnhj7iM4EMMUzmXfLsSK1GCYA+JqJuCNV5Baydt3R
         s0RkufpD308s5/h3HHxHG4Ly2Gy8m3qfzuKdhLmIFfFZmQkDgMRQ+P4OmtSw1LOmYZEv
         t5EJuTzTDyQbelOQZs8gvgy2AsuMRaapOPwJPVLZzmpcGxiayd+bASsj7a3A9jSOX5Vp
         WAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q5bokItvl+fmuIZW/0y8NwDSrtKawLhWKURQ2+FWucA=;
        b=Yq7ddsT1ZaIwBxnE2UItxDN/3gUVPP68/HGzhPda7KewNH7n8ZwD8PbifnU19OZzb/
         jik0qB6DxVzN7+UglUbUIKrFkahRPx7YLR/EKCRAqoki9NQR6PPiHVIq2UFRHeJ08X11
         cV4KyDhRJBRg5FVLzGf2jb0i9+pytMz+7FZUfbejHYQAYXDzx2AjUoDp1GDC1hENI7nb
         D/5jA2ddT2c8bb9EzvwxnQXChJj32WHxd/wC0UxMYdohtCB2Ql28gWj8ATSgzNS2FMOF
         56aDg6IgOISDBJTMPTV2Du7VQlUuuo70JxSM31OfwObdrw3bOPgeKV6M+3hU+RrRubq/
         wlPg==
X-Gm-Message-State: AOAM530NPJUiXeDD+ET8z6rw1z4Ki5VVFB4jZDBqEAeo0lGL9BPqZkBL
        wyiCspe2ynJCw4sBseZRGT4=
X-Google-Smtp-Source: ABdhPJzpp2pD+waX4s/GGGEVKwpsDvaGKkli/44tFNmwJvveZ6gIWvD46Y+t/gxjlnuxyxifYbo7hQ==
X-Received: by 2002:aa7:9198:0:b029:18b:3835:3796 with SMTP id x24-20020aa791980000b029018b38353796mr10893256pfa.9.1605808413518;
        Thu, 19 Nov 2020 09:53:33 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id 144sm482858pfb.71.2020.11.19.09.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 09:53:32 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com, mikechoi@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v3 0/2] hwmon: (max127) Add Maxim MAX127 hardware monitoring
Date:   Thu, 19 Nov 2020 09:53:22 -0800
Message-Id: <20201119175324.22472-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

The patch series adds hardware monitoring driver for the Maxim MAX127
chip.

Patch #1 adds the max127 hardware monitoring driver, and patch #2 adds
documentation for the driver.

Resending the patch series (v3) with XDP maintainers removed from to/cc
list to reduce noise.

Tao Ren (2):
  hwmon: (max127) Add Maxim MAX127 hardware monitoring driver
  docs: hwmon: Document max127 driver

 Documentation/hwmon/index.rst  |   1 +
 Documentation/hwmon/max127.rst |  45 +++++
 drivers/hwmon/Kconfig          |   9 +
 drivers/hwmon/Makefile         |   1 +
 drivers/hwmon/max127.c         | 346 +++++++++++++++++++++++++++++++++
 5 files changed, 402 insertions(+)
 create mode 100644 Documentation/hwmon/max127.rst
 create mode 100644 drivers/hwmon/max127.c

-- 
2.17.1

