Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7207E1F9772
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 14:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbgFOM6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 08:58:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46566 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729826AbgFOM6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:58:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49lrwN3hbzz9v1fd;
        Mon, 15 Jun 2020 14:57:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Mt02zgRfRhQ2; Mon, 15 Jun 2020 14:57:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49lrwN2bq2z9v1fM;
        Mon, 15 Jun 2020 14:57:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B54988B792;
        Mon, 15 Jun 2020 14:57:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id gAwaiMFxQKLE; Mon, 15 Jun 2020 14:57:56 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 645BB8B75F;
        Mon, 15 Jun 2020 14:57:56 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id F187565B0E; Mon, 15 Jun 2020 12:57:55 +0000 (UTC)
Message-Id: <cover.1592225557.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 0/3] Fix build failure with v5.8-rc1
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Date:   Mon, 15 Jun 2020 12:57:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2ab3a0a02905 ("READ_ONCE: Enforce atomicity for
{READ,WRITE}_ONCE() memory accesses") leads to following build
failure on powerpc 8xx.

To fix it, this small series introduces a new helper named ptep_get()
to replace the direct access with READ_ONCE(). This new helper
can be overriden by architectures.


  CC      mm/gup.o
In file included from ./include/linux/kernel.h:11:0,
                 from mm/gup.c:2:
In function 'gup_hugepte.constprop',
    inlined from 'gup_huge_pd.isra.79' at mm/gup.c:2465:8:
./include/linux/compiler.h:392:38: error: call to '__compiletime_assert_222' declared with attribute error: Unsupported access size for {READ,WRITE}_ONCE().
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                      ^
./include/linux/compiler.h:373:4: note: in definition of macro '__compiletime_assert'
    prefix ## suffix();    \
    ^
./include/linux/compiler.h:392:2: note: in expansion of macro '_compiletime_assert'
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
  ^
./include/linux/compiler.h:405:2: note: in expansion of macro 'compiletime_assert'
  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
  ^
./include/linux/compiler.h:291:2: note: in expansion of macro 'compiletime_assert_rwonce_type'
  compiletime_assert_rwonce_type(x);    \
  ^
mm/gup.c:2428:8: note: in expansion of macro 'READ_ONCE'
  pte = READ_ONCE(*ptep);
        ^
In function 'gup_get_pte',
    inlined from 'gup_pte_range' at mm/gup.c:2228:9,
    inlined from 'gup_pmd_range' at mm/gup.c:2613:15,
    inlined from 'gup_pud_range' at mm/gup.c:2641:15,
    inlined from 'gup_p4d_range' at mm/gup.c:2666:15,
    inlined from 'gup_pgd_range' at mm/gup.c:2694:15,
    inlined from 'internal_get_user_pages_fast' at mm/gup.c:2795:3:
./include/linux/compiler.h:392:38: error: call to '__compiletime_assert_219' declared with attribute error: Unsupported access size for {READ,WRITE}_ONCE().
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                      ^
./include/linux/compiler.h:373:4: note: in definition of macro '__compiletime_assert'
    prefix ## suffix();    \
    ^
./include/linux/compiler.h:392:2: note: in expansion of macro '_compiletime_assert'
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
  ^
./include/linux/compiler.h:405:2: note: in expansion of macro 'compiletime_assert'
  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
  ^
./include/linux/compiler.h:291:2: note: in expansion of macro 'compiletime_assert_rwonce_type'
  compiletime_assert_rwonce_type(x);    \
  ^
mm/gup.c:2199:9: note: in expansion of macro 'READ_ONCE'
  return READ_ONCE(*ptep);
         ^
make[2]: *** [mm/gup.o] Error 1

Christophe Leroy (3):
  mm/gup: Use huge_ptep_get() in gup_hugepte()
  mm: Allow arches to provide ptep_get()
  powerpc/8xx: Provide ptep_get() with 16k pages

 arch/powerpc/include/asm/nohash/32/pgtable.h | 10 ++++++++++
 include/asm-generic/hugetlb.h                |  2 +-
 include/linux/pgtable.h                      |  7 +++++++
 mm/gup.c                                     |  4 ++--
 4 files changed, 20 insertions(+), 3 deletions(-)

-- 
2.25.0

