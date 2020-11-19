Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AC82B8D36
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgKSI3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgKSI3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:29:17 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE6CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 00:29:16 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z29so6161965ybi.23
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 00:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=81mSmqAt+DDKbAEgLE/Wz5sPpfws9ggf7r+1ve0W/Wk=;
        b=E0aZcpxN2P2AVWhKSW6to7t826wYwxN2CGTKh0jlSZ901IvKkL1SD/LA4PuvwCOwjx
         usZhKMy1RBhEOeg2S17DjOk7VLen/MDrogsMuB5TcyAQe/lmau8naLmkciQM5oueDU4j
         H9gzsKWRve4WARBlmMsJyd+6GNRrKkm/u/Gbgy6K+fLggV6sea1Ij5x8uKmUlpA7zBAY
         Jt+T8iq6LTvaylImilgj/R2DZ9/9mdVjP2RQbIjS0pjpWzJ38yI1jJ/6yx1/d2oKc+H/
         22diMlbN0GvTKl+aPU2ZUCbB9TMUYJjXKDELUbfAiOXkBst3UYBwFL9ZeColpxu8tf+l
         Iz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=81mSmqAt+DDKbAEgLE/Wz5sPpfws9ggf7r+1ve0W/Wk=;
        b=Hi28fa3F0txP9lZg7YITnx8CCKA1aNn/qVLpnLyi+MyKD8ePiAu5/i2Rxrgq29j/eb
         ayxe62m7BTb3S3nvvduA7n2JHmSi/08GnsqYYSMFJkyKmMwAnwHDTjg7ac57izzINFZO
         B2X56nnNnlKf0MlUctyKWgmnlEp3aF5OJjd64rUDmEiTF0zP65/P9ez89eW0FuIpMSZx
         2/fqGYeOGU6dpjkaWa4wRSzC0iZuRwGbOFoIHczvSgbsDgKKA46U+tri8C3W5SUY9H4N
         hG0xwspO/v6IY7YWVV1O7bTd4it/fZFp5TF2+XHsdudos6OP+SoCgnkmS/eP8ewWs4kt
         0S3Q==
X-Gm-Message-State: AOAM530OkxwMS6BDTIADRUSLGLclgfemA6pSy13fUQ2VMEN0OtAlUt3a
        W28WOOwS4iBi4huhbaLjKf67tChSnvo4hg==
X-Google-Smtp-Source: ABdhPJx4nHRJ9HBK0xGsF349VilqjBdUds2kPWTNILQ3mVJ7qMYLaGPDTbfU1Jm6LFL+Sf/pntsdHR1i+rj2PQ==
Sender: "davidgow via sendgmr" <davidgow@spirogrip.svl.corp.google.com>
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:a25:4686:: with SMTP id
 t128mr14653855yba.109.1605774555483; Thu, 19 Nov 2020 00:29:15 -0800 (PST)
Date:   Thu, 19 Nov 2020 00:29:03 -0800
Message-Id: <20201119082903.3601758-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH] staging: hikey9xx: Specify HAS_IOMEM dependency for MFD_HI6421_SPMI
From:   David Gow <davidgow@google.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MFD_CORE is selected by MFD_HI6421_SPMI, and MFD_CORE depends on
HAS_IOMEM. If HAS_IOMEM is not set, this can cause a conflict in Kconfig
resolution, yielding the following error:

WARNING: unmet direct dependencies detected for MFD_CORE
  Depends on [n]: HAS_IOMEM [=n]
  Selected by [y]:
  - MFD_HI6421_SPMI [=y] && STAGING [=y] && OF [=y] && SPMI [=y]

By specifying HAS_IOMEM as a dependency for MFD_HI6421_SPMI (as
SPMI_HISI3670 already dows), this issue is resolved, and no such warning
appears when building on architectures without HAS_IOMEM.

Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/staging/hikey9xx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/hikey9xx/Kconfig b/drivers/staging/hikey9xx/Kconfig
index b29f5d5df134..2e48ded92a7e 100644
--- a/drivers/staging/hikey9xx/Kconfig
+++ b/drivers/staging/hikey9xx/Kconfig
@@ -25,6 +25,7 @@ config SPMI_HISI3670
 # to be placed at drivers/mfd
 config MFD_HI6421_SPMI
 	tristate "HiSilicon Hi6421v600 SPMI PMU/Codec IC"
+	depends on HAS_IOMEM
 	depends on OF
 	depends on SPMI
 	select MFD_CORE
-- 
2.29.2.454.gaff20da3a2-goog

