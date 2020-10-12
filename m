Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BA428C49E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 00:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388816AbgJLWVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 18:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388682AbgJLWVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 18:21:03 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D28AC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:21:02 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id r4so13255625pgl.20
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=kKRoFuTiEqTnO54yX/Z4jVdaiC2DU26pFFAEeweQEpw=;
        b=InnYARZEi+W7gIM39a8oDBXumH9E/S+G4+iTHogC7IWaC8eeY45xUD6debtN9hMF1p
         4XtDkMPhFNYscUJiJv4mPzN5Bhw2FEXXbHkDn/7YrelDTSOLVYFeo3jb9Ny20JqGk92x
         +xCmrmnNG9lXZOOyNTUZLSab2eV6rJ9g0GVUV/Kg4vKEBBtRxPVYtInobKlNnsLpaBYg
         59wUrIcdV8+TCcHxrug1jAXQ5zUzq/ZViz/k8/1JUHyW2Wg5B/e5gpiKe4OaH9JocGVg
         l/m08/hVI0r3fjfu4dB32bHjPQgITHt3FvWMdOd4giROhjCNePa/eap78NFvLjWe44pc
         CUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=kKRoFuTiEqTnO54yX/Z4jVdaiC2DU26pFFAEeweQEpw=;
        b=nd+Wb5IUjUHeg+IKPMyvGRnvNYmVCvWM5ZE8pKZlzcG34O60K38O3+aFgRtf5Eibqy
         ldXv8tYq+5+qr04gKhsV2xBzcP099ILICZzLsONC0tFgcHkxFrRfXRaKXe90rlwGZcW8
         4abj3UNiKndFkPQicp3cY7PjDbJNSlFQTGPiz64tiFXGNSve89vLHBe+T+kRzrfsLeN1
         A5+EiHfa+UD0IZ9N/wcSi1elWMFoPtPLuY9bF73p6p4j9w5Lq/qvwBhtiY8+DwBZeORj
         z9Vb1PJnwDgFhXuMLS/UPH0j7v55lQFrSH17XBxfI/Nq8eig3wDX4pM4BJGVAfHguhg3
         z83A==
X-Gm-Message-State: AOAM532XMUbZ2XDK3ygslzXrHFqbc8YNKGayK5G9X2x7i/AmByYGpxS4
        FDybKcB9t+yOXLgBqclbDm4iBDLdK9OtbA==
X-Google-Smtp-Source: ABdhPJzUrVKr+mzamRTaLzkeLip1zoVFBmINqer7dbQV3X16Ga7hCT6KXUlbADykH+ryPxsDlISBfkEROgQdVQ==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a17:90b:4c0c:: with SMTP id
 na12mr21426056pjb.25.1602541261593; Mon, 12 Oct 2020 15:21:01 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:20:38 -0700
Message-Id: <20201012222050.999431-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [RFC v2 00/12] kunit: introduce class mocking support.
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

# Background
KUnit currently lacks any first-class support for mocking.
For an overview and discussion on the pros and cons, see
https://martinfowler.com/articles/mocksArentStubs.html

This patch set introduces the basic machinery needed for mocking:
setting and validating expectations, setting default actions, etc.

Using that basic infrastructure, we add macros for "class mocking", as
it's probably the easiest type of mocking to start with.

## Class mocking

By "class mocking", we're referring mocking out function pointers stored
in structs like:
  struct sender {
        int (*send)(struct sender *sender, int data);
  };
or in ops structs
  struct sender {
        struct send_ops *ops; // contains `send`
  };

After the necessary DEFINE_* macros, we can then write code like
  struct MOCK(sender) mock_sender = CONSTRUCT_MOCK(sender, test);

  /* Fake an error for a specific input. */
  handle = KUNIT_EXPECT_CALL(send(<omitted>, kunit_int_eq(42)));
  handle->action = kunit_int_return(test, -EINVAL);

  /* Pass the mocked object to some code under test. */
  KUNIT_EXPECT_EQ(test, -EINVAL, send_message(...));

I.e. the goal is to make it easier to test
1) with less dependencies (we don't need to setup a real `sender`)
2) unusual/error conditions more easily.

In the future, we hope to build upon this to support mocking in more
contexts, e.g. standalone funcs, etc.

# TODOs

## Naming
This introduces a number of new macros for dealing with mocks,
e.g:
  DEFINE_STRUCT_CLASS_MOCK(METHOD(foo), CLASS(example),
                           RETURNS(int),
                           PARAMS(struct example *, int));
  ...
  KUNIT_EXPECT_CALL(foo(mock_get_ctrl(mock_example), ...);
For consistency, we could prefix everything with KUNIT, e.g.
`KUNIT_DEFINE_STRUCT_CLASS_MOCK` and `kunit_mock_get_ctrl`, but it feels
like the names might be long enough that they would hinder readability.

## Usage
For now the only use of class mocking is in kunit-example-test.c
As part of changing this from an RFC to a real patch set, we're hoping
to include at least one example.

Pointers to bits of code where this would be useful that aren't too
hairy would be appreciated.
E.g. could easily add a test for tools/perf/ui/progress.h, e.g. that
ui_progress__init() calls ui_progress_ops.init(), but that likely isn't
useful to anyone.

---
v2: 
* Pass `struct kunit *` to mock init's to allow allocating ops structs.
* Update kunit-example-test.cc to do so as a more realistic example.
v1: https://lore.kernel.org/linux-kselftest/20200918183114.2571146-1-dlatypov@google.com/
---

Brendan Higgins (9):
  kunit: test: add kunit_stream a std::stream like logger
  kunit: test: add concept of post conditions
  checkpatch: add support for struct MOCK(foo) syntax
  kunit: mock: add parameter list manipulation macros
  kunit: mock: add internal mock infrastructure
  kunit: mock: add basic matchers and actions
  kunit: mock: add class mocking support
  kunit: mock: add struct param matcher
  kunit: mock: implement nice, strict and naggy mock distinctions

Daniel Latypov (2):
  Revert "kunit: move string-stream.h to lib/kunit"
  kunit: expose kunit_set_failure() for use by mocking

Marcelo Schmitt (1):
  kunit: mock: add macro machinery to pick correct format args

 include/kunit/assert.h                 |   3 +-
 include/kunit/kunit-stream.h           |  94 +++
 include/kunit/mock.h                   | 902 +++++++++++++++++++++++++
 include/kunit/params.h                 | 305 +++++++++
 {lib => include}/kunit/string-stream.h |   2 +
 include/kunit/test.h                   |   9 +
 lib/kunit/Makefile                     |   9 +-
 lib/kunit/assert.c                     |   2 -
 lib/kunit/common-mocks.c               | 409 +++++++++++
 lib/kunit/kunit-example-test.c         |  98 +++
 lib/kunit/kunit-stream.c               | 110 +++
 lib/kunit/mock-macro-test.c            | 241 +++++++
 lib/kunit/mock-test.c                  | 531 +++++++++++++++
 lib/kunit/mock.c                       | 370 ++++++++++
 lib/kunit/string-stream-test.c         |   3 +-
 lib/kunit/string-stream.c              |   5 +-
 lib/kunit/test.c                       |  15 +-
 scripts/checkpatch.pl                  |   4 +
 18 files changed, 3099 insertions(+), 13 deletions(-)
 create mode 100644 include/kunit/kunit-stream.h
 create mode 100644 include/kunit/mock.h
 create mode 100644 include/kunit/params.h
 rename {lib => include}/kunit/string-stream.h (95%)
 create mode 100644 lib/kunit/common-mocks.c
 create mode 100644 lib/kunit/kunit-stream.c
 create mode 100644 lib/kunit/mock-macro-test.c
 create mode 100644 lib/kunit/mock-test.c
 create mode 100644 lib/kunit/mock.c


base-commit: 10b82d5176488acee2820e5a2cf0f2ec5c3488b6
-- 
2.28.0.1011.ga647a8990f-goog

