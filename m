Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215BF275ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgIWOuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgIWOuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:50:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E315A21D7D;
        Wed, 23 Sep 2020 14:50:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kL66b-0027Rk-Ld; Wed, 23 Sep 2020 10:50:49 -0400
Message-ID: <20200923145012.819775042@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 23 Sep 2020 10:50:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/4] tracing: A few more updates for 5.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Head SHA1: 2f5fb555637eff4a3e5579f2323cd358c77efdc8


Masami Hiramatsu (4):
      lib/bootconfig: Fix a bug of breaking existing tree nodes
      lib/bootconfig: Fix to remove tailing spaces after value
      tools/bootconfig: Add testcases for repeated key with brace
      tools/bootconfig: Add testcase for tailing space

----
 lib/bootconfig.c                    | 38 +++++++++++++++++++++++--------------
 tools/bootconfig/test-bootconfig.sh | 25 ++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 14 deletions(-)
