Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A102CCFD1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgLCGuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:50:16 -0500
Received: from exmail.andestech.com ([60.248.187.195]:56804 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbgLCGuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:50:16 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 0B36nZGV099083;
        Thu, 3 Dec 2020 14:49:35 +0800 (GMT-8)
        (envelope-from tesheng@andestech.com)
Received: from atcfdc88.andestech.com (10.0.15.120) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.487.0; Thu, 3 Dec 2020
 14:49:20 +0800
From:   Eric Lin <tesheng@andestech.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <walken@google.com>, <vbabka@suse.cz>, <peterx@redhat.com>,
        <akpm@linux-foundation.org>, <penberg@kernel.org>,
        <aou@eecs.berkeley.edu>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <hch@infradead.org>
CC:     Eric Lin <tesheng@andestech.com>
Subject: [PATCH v2 0/2] Let illegal access to user-space memory die
Date:   Thu, 3 Dec 2020 14:48:24 +0800
Message-ID: <20201203064826.30832-1-tesheng@andestech.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.120]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 0B36nZGV099083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accesses to user-space memory without calling uaccess routine
leads to hanging in page fault handler. Like arm64, we let it
die earlier in page fault handler.

Changes in v2:
    -Add a die_kernel_fault() helper
    -Split one long line code into two

Eric Lin (2):
  riscv/mm: Introduce a die_kernel_fault() helper function
  riscv/mm: Prevent kernel module to access user memory without uaccess
    routines

 arch/riscv/mm/fault.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

-- 
2.17.0

