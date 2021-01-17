Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497EE2F91A9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 11:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbhAQKON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 05:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728521AbhAQKK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 05:10:26 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F37C061575;
        Sun, 17 Jan 2021 02:09:45 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id dj23so11758316edb.13;
        Sun, 17 Jan 2021 02:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OPo7hvP+/MUBks3VqSm4dG2egtcdKq2kmsQrfS7xhVg=;
        b=cqXQ6qamS92GRPLU79BnLNTsDZ3ocUffXSfH6PCqSW7T3C6O9qceUZ+qoGEsDZG92J
         TV1aJkSwZ66IsVoidRpdjX3ss884fKAF6QG69x6LS0TysJPXDNQ2bioyRzXUQn3frGxH
         9jtYJP8gEf0tk0h+gDsuwfyjSJN/YPvRv07qWJuGlcp2ae5CpJYgljE5DyPl+HV2S+SC
         5ooX+JkKJ33/GOxEB5P/3+LlPp3E0tc9IqTpzJy3LvIvWVnIwKQKONrCAlGPq2Wuq/kz
         QuP4Zsxn3ODVTnB62ODrSfYFvNpvw7j2aafffcOri4s5j2JyZxT1GRVDL46flegoX2av
         QR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OPo7hvP+/MUBks3VqSm4dG2egtcdKq2kmsQrfS7xhVg=;
        b=A5sAhhcJlZsNNV8rY/raYCK8VvcVecbtUR3ZDJ/++kaDT6GkbBoxTC6ccUq470ogPF
         dRgmzAktHSYKFj00FVAQK5XI44fAr4TZCAciBMnJ5XTJkWtgr2NF/nhAGhjClsI7ll7/
         GqoBKcJM43nA9O9pZITA/DXB/LPbsm4MUEr6I/7DEl6n9bPy4DhsXJBnWv/qAnzTZKXf
         41UewTQ52pKa87savmr48ljWWDYC1SUv6Jk7MmulQgj3XhDqEMoCOtqa6711I1F1eD0t
         q5pTySJllCekJninNR2FXwFHbQogf7k1qxhTUCv9FxfTCWzG2R6n1A5PiCf28IyUjuBF
         r+Cg==
X-Gm-Message-State: AOAM5301Xoi+hlakV7AQyiH2px/C+/O7eENoUe9UqWKApG8swp/PFOa8
        ICg4yOnNoiU37RkSp/Fjw2c=
X-Google-Smtp-Source: ABdhPJxBXptt7u94Tc/xLmhouSJ8/f1HhLFn/cB1tCyX5lDxv/++BpbPvQblUzSNQRFPk5sXuqfu3w==
X-Received: by 2002:a05:6402:697:: with SMTP id f23mr16160920edy.318.1610878184474;
        Sun, 17 Jan 2021 02:09:44 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:c06a:642a:2af4:1e16])
        by smtp.gmail.com with ESMTPSA id s19sm9277855edx.7.2021.01.17.02.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 02:09:43 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net
Cc:     SeongJae Park <sjpark@amazon.de>, paulmck@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Documentation/kokr/howto: Replace HTTP links with HTTPS ones: Documentation/process
Date:   Sun, 17 Jan 2021 11:09:29 +0100
Message-Id: <20210117100931.9347-2-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210117100931.9347-1-sj38.park@gmail.com>
References: <20210117100931.9347-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Apply this commit to Korean:

    e7b4311ebcac ("Replace HTTP links with HTTPS ones: Documentation/process")

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/translations/ko_KR/howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index 240d29be38f2..0a42ffdea918 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -583,7 +583,7 @@ Pat이라는 이름을 가진 여자가 있을 수도 있는 것이다. 리눅
 
    "The Perfect Patch"
 
-    http://www.ozlabs.org/~akpm/stuff/tpp.txt
+    https://www.ozlabs.org/~akpm/stuff/tpp.txt
 
 
 이 모든 것을 하는 것은 매우 어려운 일이다. 완벽히 소화하는 데는 적어도 몇년이
-- 
2.17.1

