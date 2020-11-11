Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEA02AF454
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgKKPDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:03:43 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:35694 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726204AbgKKPDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:03:40 -0500
X-UUID: 30355211906544528f53fdcd50d8470c-20201111
X-UUID: 30355211906544528f53fdcd50d8470c-20201111
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 724828493; Wed, 11 Nov 2020 23:03:34 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Nov 2020 23:03:31 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Nov 2020 23:03:30 +0800
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: [PATCH v14] binder: add transaction latency tracer
Date:   Wed, 11 Nov 2020 23:02:41 +0800
Message-ID: <1605106964-25838-1-git-send-email-Frankie.Chang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <X6uT941IJ3uf/7aE@kroah.com>
References: <X6uT941IJ3uf/7aE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B1ED88A0B987608692B24CA3DEE33F7F1644EAC36682E78CB94541803D0442B92000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change from v14:
  - prevent from directly print transaction info to kernel log.
  - give up doing the date math in the kernel.
  - track msec only instead of both sec and msec.
  - change EXPORT_TRACEPOINT_SYMBOL to EXPORT_TRACEPOINT_SYMBOL_GPL.

Change from v13:
  - modify patch subject.

Change from v12:
  - rebase.

Change from v11:
  - rebase.

Change from v10:
  - replace timespec64 with ktime_t.
  - fix build warning.

Change from v9:
  - rename timestamp to ts in binder_internal.h for conciseness.
  - change timeval to timespec64 in binder_internal.h

Change from v8:
  - change rtc_time_to_tm to rtc_time64_to_tm.
  - change timeval to __kernel_old_timeval due to 
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c766d1472c70d25ad475cf56042af1652e792b23
  - export tracepoint symbol for binder_txn_latency_* which binder_transaction_latency_tracer to be ko needed.

Change from v7:
  - Use the passed-in values instead of accessing via t->from/to_proc/to_thread
    for trace_binder_txn_latency_free, when trace_binder_txn_latency_free_enable() return true.
  - make a helper function to do the above.

Change from v6:
  - change CONFIG_BINDER_TRANSACTION_LATENCY_TRACKING type from bool to tristate
  - add comments to @timestamp and @tv under struct binder_transaction
  - make binder_txn_latency threshold configurable
  - enhance lock protection

Change from v5:
  - change config name to the proper one, CONFIG_BINDER_TRANSACTION_LATENCY_TRACKING.
  - change tracepoint name to more descriptive one, trace_binder_txn_latency_(alloc|info|free)
  - enhance some lock protection.

Change from v4:
  - split up into patch series.

Change from v3:
  - use tracepoints for binder_update_info and print_binder_transaction_ext,
    instead of custom registration functions.

Change from v2:
  - create transaction latency module to monitor slow transaction.

Change from v1:
  - first patchset.


Frankie.Chang (3):
  binder: move structs from core file to header file
  binder: add trace at free transaction.
  binder: add transaction latency tracer

 drivers/android/Kconfig                 |   8 +
 drivers/android/Makefile                |   1 +
 drivers/android/binder.c                | 430 ++----------------------
 drivers/android/binder_internal.h       | 414 +++++++++++++++++++++++
 drivers/android/binder_latency_tracer.c | 108 ++++++
 drivers/android/binder_trace.h          |  46 +++
 6 files changed, 601 insertions(+), 406 deletions(-)
 create mode 100644 drivers/android/binder_latency_tracer.c
