Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A882F8BC7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 07:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbhAPGAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 01:00:14 -0500
Received: from atcsqr.andestech.com ([60.248.187.195]:38725 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbhAPGAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 01:00:13 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 10G5thf2057676;
        Sat, 16 Jan 2021 13:55:43 +0800 (GMT-8)
        (envelope-from nylon7@andestech.com)
Received: from atcfdc88.andestech.com (10.0.15.120) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.487.0; Sat, 16 Jan 2021
 13:58:37 +0800
From:   Nylon Chen <nylon7@andestech.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <kasan-dev@googlegroups.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <aryabinin@virtuozzo.com>,
        <glider@google.com>, <dvyukov@google.com>, <nylon7717@gmail.com>,
        <alankao@andestech.com>, <nickhu@andestech.com>,
        "Nylon Chen" <nylon7@andestech.com>
Subject: [PATCH v2 0/1] kasan: support backing vmalloc space for riscv
Date:   Sat, 16 Jan 2021 13:58:34 +0800
Message-ID: <20210116055836.22366-1-nylon7@andestech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.120]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 10G5thf2057676
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1: https://lore.kernel.org/patchwork/cover/1364392/
v2:
    1) Fix checkpatch issues.
    2) Remove set_pmd and pmd_populate because it's not necessary.

Nylon Chen (1):
  riscv/kasan: add KASAN_VMALLOC support

 arch/riscv/Kconfig         |  1 +
 arch/riscv/mm/kasan_init.c | 57 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

-- 
2.17.1

