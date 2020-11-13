Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B676D2B2863
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgKMWUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:20:21 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:35528 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgKMWUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:20:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7CACF607401E;
        Fri, 13 Nov 2020 23:20:13 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0eW4dMYwz31B; Fri, 13 Nov 2020 23:20:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E4A80607403B;
        Fri, 13 Nov 2020 23:20:05 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 77_eOgEagwAR; Fri, 13 Nov 2020 23:20:05 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1FA52607401E;
        Fri, 13 Nov 2020 23:20:05 +0100 (CET)
Date:   Fri, 13 Nov 2020 23:20:04 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <588878911.301948.1605306004530.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] um fixes for 5.10-rc4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Index: PPaAG+huxvv2MnISP1PSl1i9DDpfGw==
Thread-Topic: um fixes for 5.10-rc4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit eccc876724927ff3b9ff91f36f7b6b159e948f0c:

  Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2020-11-10 10:33:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.10-rc4

for you to fetch changes up to 9a5085b3fad5d5d6019a3d160cdd70357d35c8b1:

  um: Call pgtable_pmd_page_dtor() in __pmd_free_tlb() (2020-11-10 21:49:32 +0100)

----------------------------------------------------------------
This pull request contains the following bug fixes for UML:

- Call PMD destructor in __pmd_free_tlb()

----------------------------------------------------------------
Richard Weinberger (1):
      um: Call pgtable_pmd_page_dtor() in __pmd_free_tlb()

 arch/um/include/asm/pgalloc.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
