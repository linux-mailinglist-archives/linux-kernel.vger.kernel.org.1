Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A652AE6BF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 04:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgKKDCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 22:02:50 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:32868 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725867AbgKKDCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 22:02:50 -0500
X-UUID: 607825743d054c0c9004058fcda282ae-20201111
X-UUID: 607825743d054c0c9004058fcda282ae-20201111
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1397354604; Wed, 11 Nov 2020 11:02:47 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Nov 2020 11:02:45 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Nov 2020 11:02:44 +0800
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: [PATCH v13] binder: add transaction latency tracer
Date:   Wed, 11 Nov 2020 11:02:41 +0800
Message-ID: <1605063764-12930-1-git-send-email-Frankie.Chang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <X6quBb28IVvyRhox@kroah.com>
References: <X6quBb28IVvyRhox@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5FF7BD0736A20E5F14C7EA94924EBE248B4BDB21866E02A1836B673DD20C81532000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Frankie.Chang (3):
  binder: move structs from core file to header file
  binder: add trace at free transaction.
  binder: add transaction latency tracer

 drivers/android/Kconfig                 |   8 +
 drivers/android/Makefile                |   1 +
 drivers/android/binder.c                | 430 ++----------------------
 drivers/android/binder_internal.h       | 419 +++++++++++++++++++++++
 drivers/android/binder_latency_tracer.c | 107 ++++++
 drivers/android/binder_trace.h          |  49 +++
 6 files changed, 608 insertions(+), 406 deletions(-)
 create mode 100644 drivers/android/binder_latency_tracer.c
