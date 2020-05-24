Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D681E0081
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 18:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbgEXQWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 12:22:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbgEXQWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 12:22:00 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C3ED20787;
        Sun, 24 May 2020 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590337318;
        bh=HlK2OPtTm9wvk1tXjxU/SgoVRJv4oXBqNylVAYmDI+8=;
        h=From:To:Cc:Subject:Date:From;
        b=MHPNkL8VSv3ZT3l9DoB+4KCe07GKUeO+viTzVGHwRY8/e5soRoJtoZt4xX3ahCGNa
         npgT5wYHzPmVbY+XoWvktEjasE6/o1zB4FPnSm+iAzhvHuQjFlSLjfyZiqjwKzxnTO
         2zdfU1AjmM8AGz7aATTMFteQl5pdupvQ2Su6/zTI=
From:   Mike Rapoport <rppt@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 0/2] sparc32: srmmu: improve type safety of __nocache_fix()
Date:   Sun, 24 May 2020 19:21:49 +0300
Message-Id: <20200524162151.3493-1-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

As discussed at [1] the __nocache_fix() macro in sparc's SRMMU can be made
type safe and so the compiler will yell anout misuse of pXd pointers for
which the __nocache_fix() is primarily used.

The first patch is an fix of such misuse that I've discovered after adding
type cast to __nocache_fix(), but to avoid breaking bisection I've made it
the first commit.

--
Sincerely yours,
Mike.

[1] https://lkml.kernel.org/r/CAHk-=wisORTa7QVPnFqNw9pFs62UiwgsD4C4d=MtYy1o4JPyGQ@mail.gmail.com

Mike Rapoport (2):
  sparc32: use PUD rather than PGD to get PMD in srmmu_inherit_prom_mappings()
  sparc32: srmmu: improve type safety of __nocache_fix()

 arch/sparc/include/asm/pgtsrmmu.h |  2 +-
 arch/sparc/mm/srmmu.c             | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.26.2

