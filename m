Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3458300112
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbhAVK7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbhAVKvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:51:39 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7711FC061788
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:50:59 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b8so2945554plh.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PuwWd5eA6p3dY7AgrjavmP5cmvVmC3ijlW6z53nJI7E=;
        b=DUgiZdV+iGgfJqja6zA0bbGFa0O/OMijUZOXcsGQ3eukmae3Un8i9t0w4ItT3H63Cv
         le5PyLNxsPvu9EDPmBOpLQeNJWxO5BWoGcrUKWO/hDuBUtMt+mgysSsPBDmDY1ZTRhEh
         R/fpAdxOXVg84jfBQ53awzLXwMMqquOKhh0S562hQLbwycf2WV0gYWjlAeDDCGE9Fom9
         hNnPr5+rtVszC6eyKUy68IXMSMnVhABiWVuZPhHcLaXSxPYB97NOV5jdnPpUuU1BxR9V
         Y23kJlK4hxUfOh83VU2kY+47DJQmULwjyINtkMm7CWOKkDVxzvUDxLi64w0h0rPhlkd4
         87lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PuwWd5eA6p3dY7AgrjavmP5cmvVmC3ijlW6z53nJI7E=;
        b=dt8zml14HxE3XGUYOLuBVmbHkouQsbvT/wmw39Al7RUmDIiZhmOf3/NWKutSuXpthD
         2tJUe1een5mnaw9vdqn66tw+B9tlahLLAWH55+FuDcrHjcPRWYPkfFUnaRYNeqUWXZZP
         CqZo4DKdTH1PRbyTUVHPh6KBovyJT0sVSsB7+LFb3i1LOsRyyOnJUwWpnOqpeDIw41dj
         TD7CntyJou3gjmauB1LAQEFSkgg800ALGfM4JbinXMLmO9JDMGBU9uKXksixPp+A/qGW
         X6evy0sAx1k8ZoZiui8y2LglE+Oj98vr+w5qkyViChWIHNevk7g1qE1/x8XW6WPBuzF0
         PZfg==
X-Gm-Message-State: AOAM531f0ZXNrxrYUtgjFV8rKuKHcHm+ldrZ30PCkV2ylu8G2kMb4tqx
        22koTtDRF3qPV+ep7BriQNmJjA==
X-Google-Smtp-Source: ABdhPJxqIPhYQksDYkM6roGKyJKmwpyizUIISOxol2yt6kqR07tlYnLJzTCe04O547qEdTCr5b3I6Q==
X-Received: by 2002:a17:90b:1046:: with SMTP id gq6mr4481021pjb.203.1611312658928;
        Fri, 22 Jan 2021 02:50:58 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id k128sm8613204pfd.137.2021.01.22.02.50.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 02:50:58 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, anmar.oueja@linaro.org,
        Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH V6 0/6] dt: build overlays
Date:   Fri, 22 Jan 2021 16:20:30 +0530
Message-Id: <cover.1611312122.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank/Rob,

This patchset makes necessary changes to the kernel to add support for
building overlays (%.dtbo) and the required fdtoverlay tool. This also
builds static_test.dtb using most of the existing overlay tests present
in drivers/of/unittest-data/ for better test coverage.

Note that in order for anyone to test this stuff, you need to manually
run the ./update-dtc-source.sh script once to fetch the necessary
changes from the external DTC project (i.e. fdtoverlay.c and this[1]
patch).

Also note that Frank has already shared his concerns towards the error
reporting done by fdtoverlay tool [2], and David said it is not that
straight forward to make such changes in fdtoverlay. I have still
included the patch in this series for completeness.

FWIW, with fdtoverlay we generate a new build warning now, not sure why
though:

drivers/of/unittest-data/tests-interrupts.dtsi:20.5-28: Warning (interrupts_property): /testcase-data/testcase-device2:#interrupt-cells: size is (4), expected multiple of 8

V6:
- Create separate rules for dtbo-s and separate entries in .gitignore in
  4/6 (Masahiro).
- A new file layout for handling all overlays for existing and new tests
  5/6 (Frank).
- Include overlay.dts as well now in 6/6 (Frank).

V5:

- Don't reuse DTC_SOURCE for fdtoverlay.c in patch 1/5 (Frank).

- Update .gitignore and scripts/Makefile.dtbinst, drop dtbo-y syntax and
  DTC_FLAGS += -@ in patch 4/5 (Masahiro).

- Remove the intermediate dtb, rename output to static_test.dtb, don't
  use overlay.dtb and overlay_base.dtb for static builds, improved
  layout/comments in Makefile for patch 5/5 (Frank).

--
Viresh

[1] https://github.com/dgibson/dtc/commit/163f0469bf2ed8b2fe5aa15bc796b93c70243ddc
[2] https://lore.kernel.org/lkml/74f8aa8f-ffab-3b0f-186f-31fb7395ebbb@gmail.com/

Viresh Kumar (6):
  scripts: dtc: Fetch fdtoverlay.c from external DTC project
  scripts: dtc: Build fdtoverlay tool
  scripts: dtc: Remove the unused fdtdump.c file
  kbuild: Add support to build overlays (%.dtbo)
  of: unittest: Create overlay_common.dtsi and testcases_common.dtsi
  of: unittest: Statically apply overlays using fdtoverlay

 .gitignore                                    |   1 +
 Makefile                                      |   5 +-
 drivers/of/unittest-data/Makefile             |  51 ++++++
 drivers/of/unittest-data/overlay_base.dts     |  90 +---------
 drivers/of/unittest-data/overlay_common.dtsi  |  91 ++++++++++
 drivers/of/unittest-data/static_base.dts      |   5 +
 drivers/of/unittest-data/testcases.dts        |  17 +-
 .../of/unittest-data/testcases_common.dtsi    |  18 ++
 scripts/Makefile.dtbinst                      |   3 +
 scripts/Makefile.lib                          |   5 +
 scripts/dtc/Makefile                          |   6 +-
 scripts/dtc/fdtdump.c                         | 163 ------------------
 scripts/dtc/update-dtc-source.sh              |   3 +-
 13 files changed, 187 insertions(+), 271 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_common.dtsi
 create mode 100644 drivers/of/unittest-data/static_base.dts
 create mode 100644 drivers/of/unittest-data/testcases_common.dtsi
 delete mode 100644 scripts/dtc/fdtdump.c

-- 
2.25.0.rc1.19.g042ed3e048af

