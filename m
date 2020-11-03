Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16EB2A5AB3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 00:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbgKCXt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 18:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbgKCXt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 18:49:56 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70A6C061A48
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 15:49:55 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w4so19734154ybq.21
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 15:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=/cu3FeQS2O8Lz6S9sSrj78vp3KVX+NcuSsdaqJSggY0=;
        b=Fwu2+C4Dx+f+IXf8ZA+5sH1P84M8IsACzDvcYafsQmNlINACCTvKfdKZi5taVl8dzv
         DEBQVHuJuEgJZ+MKct2TG0UikfzzjTdF6DPGjitVOaIGrOzAE0Kf1vpS4tuyc3jKXvyF
         eDRvJ+p8FQwo9MgQ5Y8iiDFCQmRGJrL8iXvPVrqCYckzJhg2/5GMBL0QrP7RQVMz/Gi3
         WGrVui3l6/W2zOz0KYpdUpN1seLRzjFwBpzge5PihPaeZHwxzr9wOWle1yCnHAPkB7NI
         RUyBrH0mPhZWFhr8v51xci0DBhuvo6MApT0WbWeak1kTUfnh29Zt5niTXpdU2JQEp7Du
         8KmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=/cu3FeQS2O8Lz6S9sSrj78vp3KVX+NcuSsdaqJSggY0=;
        b=FX9zKF8ub1dlZjOX8sAIy5s9UUGwwqYt2C8xqvPCeJnbJIxb0/NNiaulAbN4PVHvzY
         xtJ1Rsr4cjQj1hGc/429ex/pfHp0+xh3v000Yr3MqpmKQM7NTn4gBdmG/COPn/bLqWXj
         i834JDzcYtiYiQzPUJXHeWIQS5GRebvQff2r7jPzbNzQANNlxZWkIMSqM2nJ3A2kaLk/
         UvnYiNwwiKINP7MXhSYBkhv8SQJXLB4UQm6sLiLQuDZ3Q0ON6/mz2TrpPWh0KzAfdltn
         atwbW5LQw01XXx6AFODWjwZaT0RucZm3d8ezRWb5AWjAxbiMBh8hZSpwcWsF8DA4Bq1W
         tQtA==
X-Gm-Message-State: AOAM533xp0gT5miOSr7R/ogG6M0suDoZHJpbpK4vSvncwla1gudwW51w
        hDAYjlHT4dJYOXInBjzsNP2HyycQ48WapPullbNYiRt8Hiuho+Pd9SLAlWVETYmjjFi5mKQ4GTp
        J6fKv+HTUmtA8P7ibWTwMZCG7BkQEgYF4RrU54xTlabuC3K3Jl3vmj6wq6wqziDv6iQPWmnA9
X-Google-Smtp-Source: ABdhPJxeFN2tpViTDExAnXIdBh+gL3Mrr/FOyn4zOu32Uoy29GCFiuUTwYsUmqKOIyRxFyG53sKXWnB1dai2
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a25:d081:: with SMTP id
 h123mr33023214ybg.160.1604447394920; Tue, 03 Nov 2020 15:49:54 -0800 (PST)
Date:   Tue,  3 Nov 2020 15:49:47 -0800
Message-Id: <20201103234952.1626730-1-bgardon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2 0/5] Add a dirty logging performance test
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Feiner <pfeiner@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently KVM lacks a simple, userspace agnostic, performance benchmark for
dirty logging. Such a benchmark will be beneficial for ensuring that dirty
logging performance does not regress, and to give a common baseline for
validating performance improvements. The dirty log perf test introduced in
this series builds on aspects of the existing demand paging perf test and
provides time-based performance metrics for enabling and disabling dirty
logging, getting the dirty log, and dirtying memory.

While the test currently only has a build target for x86, I expect it will
work on, or be easily modified to support other architectures.

This series was tested by running the following invocations on an Intel
Skylake machine after apply all commits in the series:
dirty_log_perf_test -b 20m -i 100 -v 64
dirty_log_perf_test -b 20g -i 5 -v 4
dirty_log_perf_test -b 4g -i 5 -v 32
demand_paging_test -b 20m -v 64
demand_paging_test -b 20g -v 4
demand_paging_test -b 4g -v 32
All behaved as expected.

v1 -> v2 changes:
(in response to comments from Peter Xu)
- Removed pr_debugs from main test thread while waiting on vCPUs to reduce
  log spam
- Fixed a bug in iteration counting that caused the population stage to be
  counted as part of the first dirty logging pass
- Fixed a bug in which the test failed to wait for the population stage for all
  but the first vCPU.
- Refactored the common code in perf_test_util.c/h
- Moved testing description to cover letter
- Renamed timespec_diff_now to timespec_elapsed

Ben Gardon (5):
  KVM: selftests: Remove address rounding in guest code
  KVM: selftests: Factor code out of demand_paging_test
  KVM: selftests: Simplify demand_paging_test with timespec_diff_now
  KVM: selftests: Add wrfract to common guest code
  KVM: selftests: Introduce the dirty log perf test

 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   7 +-
 .../selftests/kvm/demand_paging_test.c        | 231 ++---------
 .../selftests/kvm/dirty_log_perf_test.c       | 381 ++++++++++++++++++
 .../selftests/kvm/include/perf_test_util.h    |  51 +++
 .../testing/selftests/kvm/include/test_util.h |   2 +
 .../selftests/kvm/lib/perf_test_util.c        | 166 ++++++++
 tools/testing/selftests/kvm/lib/test_util.c   |  22 +-
 8 files changed, 661 insertions(+), 200 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/dirty_log_perf_test.c
 create mode 100644 tools/testing/selftests/kvm/include/perf_test_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/perf_test_util.c

-- 
2.29.1.341.ge80a0c044ae-goog

