Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99961234B88
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 21:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgGaTUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 15:20:52 -0400
Received: from foss.arm.com ([217.140.110.172]:36314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgGaTUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 15:20:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39FD31FB;
        Fri, 31 Jul 2020 12:20:51 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D0AB83F71F;
        Fri, 31 Jul 2020 12:20:49 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        Quentin Perret <qperret@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/3] sched: Document capacity aware scheduling
Date:   Fri, 31 Jul 2020 20:20:13 +0100
Message-Id: <20200731192016.7484-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This stems from John Mathew et al's documentation efforts; see the brief
exchange between Dietmar and I at [1].

This is written as a standalone documentation bit, the emphasis here being on
the "why" and "what" rather than the "how". I can try to rebase that on top of
John's series, but I think this could go in on its own.

[1]: https://lkml.kernel.org/r/b974b959-7b9a-2874-dca6-674b74ad5b42@arm.com

Cheers,
Valentin

Valentin Schneider (3):
  sched: Document arch_scale_*_capacity()
  sched/doc: Document capacity aware scheduling
  sched/doc: Factorize bits between sched-energy.rst &
    sched-capacity.rst

 Documentation/scheduler/index.rst          |   1 +
 Documentation/scheduler/sched-capacity.rst | 439 +++++++++++++++++++++
 Documentation/scheduler/sched-energy.rst   |  12 +-
 include/linux/sched/topology.h             |  10 +
 kernel/sched/sched.h                       |  10 +
 5 files changed, 462 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/scheduler/sched-capacity.rst

-- 
2.27.0

