Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA8C28C4AD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 00:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389357AbgJLWVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 18:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389008AbgJLWV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 18:21:29 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A44C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:21:28 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 9so13495597pfj.22
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2FPAJ4JOdoCzsWC2I93Vw1itU3Hyew78gghPY3DsZ34=;
        b=J/TNk3ROP2i9NV5ARtO1ok14A61R1Sg80iF+SLTzg/Y2GSueMy7/R1Mybj0K4q/eKP
         j8tqmHDAphmeDThQ1XJrwgDIGrRl45hVbeWulOsh9GPzdMbgo6MINccRoxBhfoRnGQr7
         ATQz/SfDmvdTi3ZLxNjtWpBfLGEAEz+W/ANtM51fMq/AjVdC2mIsWX5NSo6XWWid2SVR
         X4fuqgCT5rNIST+KYNTBvo3Aw79QFU1kXh5UdpveLdVZz5YbljpeUkR+VCZoGeqItYrq
         K7JQ7Rhr6jl2bYYYNTiCd/hBjyjY1rd98VNs50mVLh2Us/aKsOX+a/apn3nqyPy+7cql
         jKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2FPAJ4JOdoCzsWC2I93Vw1itU3Hyew78gghPY3DsZ34=;
        b=Qsg8xSDokEcmTwti2Xqqx5steT6epzeN2O77+zORI0tPY98/o7F5dI+4nqHOO7U4Hv
         DQtoRxADZPsioE+t8tKf3jLGKzFMPM5Mpib2zdDUDDUh4/z+o3UznLnO0VJaFuqwTwT9
         mAfE8B4RxQI4ySlcvgUW1sNA8BtzvMGup0T7XqiSafrqGsp32i4QugtrxPSw3gqv5TcM
         u7IYcPdxHZu1g285Tl32Ix+S+ELOU3v1YyoYFxKNwHEgAmYzpXQfFi0pfvfM4rirjG8i
         W0dLAeimEy4QfGG8H5tZ7BTobnYSrT6qMAc34DVEwf85gbBRTKDhwJXIXc4NgTsINtHF
         WcsA==
X-Gm-Message-State: AOAM532v2DfChFrO9hTT67LX4+XmDET46/WYMsxDvzTfDqlrorfCaHkl
        UPuKuxMn9tMBQ0Fl0AtJCwcDDAjkCRWv2Q==
X-Google-Smtp-Source: ABdhPJzne7N1vHKS4tz8oSTlt6o6aJQMscjj3GawvyrILDpXPgDbP8dhDhW/mzIbUhLC95qpouzc/tRuzHZTcg==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a17:90a:f3d3:: with SMTP id
 ha19mr22246220pjb.58.1602541288393; Mon, 12 Oct 2020 15:21:28 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:20:44 -0700
In-Reply-To: <20201012222050.999431-1-dlatypov@google.com>
Message-Id: <20201012222050.999431-7-dlatypov@google.com>
Mime-Version: 1.0
References: <20201012222050.999431-1-dlatypov@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [RFC v2 06/12] kunit: expose kunit_set_failure() for use by mocking
From:   Daniel Latypov <dlatypov@google.com>
To:     dlatypov@google.com
Cc:     alan.maguire@oracle.com, brendanhiggins@google.com,
        davidgow@google.com, keescook@chromium.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mcgrof@kernel.org,
        sboyd@kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Being able to fail the test outside of expectations and assertions is a
requirement for new features, e.g. mocking, dynamic analysis, etc.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/test.h | 2 ++
 lib/kunit/test.c     | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 0eb3abb00da4..05330593243d 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -233,6 +233,8 @@ struct kunit {
 
 void kunit_init_test(struct kunit *test, const char *name, char *log);
 
+void kunit_set_failure(struct kunit *test);
+
 int kunit_run_tests(struct kunit_suite *suite);
 
 size_t kunit_suite_num_test_cases(struct kunit_suite *suite);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 4e8c74c89073..1ccf6dbecd73 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -15,7 +15,7 @@
 #include "debugfs.h"
 #include "try-catch-impl.h"
 
-static void kunit_set_failure(struct kunit *test)
+void kunit_set_failure(struct kunit *test)
 {
 	WRITE_ONCE(test->success, false);
 }
-- 
2.28.0.1011.ga647a8990f-goog

