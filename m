Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706FD303D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391215AbhAZMis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:38:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:41880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391883AbhAZKSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 05:18:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611656243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=T0XE+jSnmP3fjoVC4qwAc/ltZ6IZS0xpFA8YxfaCu/k=;
        b=OSl6oGE3bkmlrr5Ojj1FZ7/p72DfnoLstdnOdYAbhhlVK2/lqYNYBw+B6+/UW7ixv3TBjj
        UbuPc7MJ+5UgtqfwN4C/pQA5Jub+uGVnE5GPU1yLj+SLXxSTppADZTfTbL8fUo69Tpt8Xc
        vcBEYFuJboyh+WERjlFnSZdYkmfUlOI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 584E4AE40;
        Tue, 26 Jan 2021 10:17:23 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     peterz@infradead.org
Cc:     will@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] locking/rwsem: Remove empty rwsem.h
Date:   Tue, 26 Jan 2021 12:17:21 +0200
Message-Id: <20210126101721.976027-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a leftover from 7f26482a872c ("locking/percpu-rwsem: Remove the embedded rwsem")

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
V2:
 * Add reference to commit which made the file useless.

 kernel/locking/rwsem.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 kernel/locking/rwsem.h

diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
deleted file mode 100644
index e69de29bb2d1..000000000000
--
2.25.1

