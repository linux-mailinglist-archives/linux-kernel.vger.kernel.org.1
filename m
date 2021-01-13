Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189782F4E64
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbhAMPVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:21:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:50342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbhAMPVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:21:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610551224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wafTGmF0BGjFmoTJCCo9EJPBeRLvwh5nyS90+ByJdVQ=;
        b=KeKhoFb4je9LBr74mQAO/HGcZS97lqLh8o4lp8epYE5yDOBePA0KmFiAqkOAtYktwztwLR
        ewpFRQPz3qBUr2dWI0JqTG8NsfpmrV9IwjcpClnUSTwtnG5+3ZOy7Oy+uU+4NzznWZZkL3
        ZNBalVfaG/bOvLjY6yrqq/v1O//VvSI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24BEDAB92;
        Wed, 13 Jan 2021 15:20:24 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] locking/rwsem: Remove empty rwsem.h
Date:   Wed, 13 Jan 2021 17:20:22 +0200
Message-Id: <20210113152022.772555-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 kernel/locking/rwsem.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 kernel/locking/rwsem.h

diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
deleted file mode 100644
index e69de29bb2d1..000000000000
-- 
2.25.1

