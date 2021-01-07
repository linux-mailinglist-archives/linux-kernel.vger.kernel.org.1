Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4533E2ECCB8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbhAGJ2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:28:36 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58328 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbhAGJ2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610011714; x=1641547714;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5ByP4Y2MXebg7K5MMh53/5S5y8lmTDokOMvG6dAOPT4=;
  b=M4XmFjiU4UGtF4tsQK0BWysLa29g6saJH5hKrjKXtdNrp48yv1i/M9JL
   T9lNwl1H2Org1tc3vlPoS4IDn4J+f1vRnd0SfQb0vul4H62mjIkrtvpA2
   PBRCYA6i/9AuK75RtI8IccbU3TCIBo6+777CxQlYPVFEQIwvPyss9i7O4
   nB5BLJshvOvWXjMnN85Ar8KKw63q42k5BXQ5odIDrCYnQbLXFxEeBGGmz
   UgYIfyz3rbf5mov6bRkcj5+d1GGkc163FeZ4NyMElWtBYquLhkNBdRkPn
   +vJ3O5QEecZoS9h6JJH9cezgKAX2X/ZMb2cvtzrSCAGl+0t6AP1IJwnOc
   Q==;
IronPort-SDR: TBN8uceBJfBqgTN8BDLGg5JyjIjNBErK/ArvXvcTrtrkrx9IXEQZez/fUJYRm5/sQMFsPUT9Vo
 JWiEcj5IQKLeu/7cGhp+KWxFQV8+CCuqBcJb5z5XbO7BqN2AH3qcnqG69aIEQwoQ7JiWzhhwkX
 UDTqVWTGcd4WJKiMtComRiUFh39Iz8DZ6Fvgu6lcv6ZPYTHfO1d4JiIkeJJdAZb5LpgLfS9NFy
 ask8d5LR8lRoJEB40hd0QYbLXNXdeTq/CWsyhSewKbTbm5088SQxlR0XO6yAgEqg5eIgbsPmSf
 YPY=
X-IronPort-AV: E=Sophos;i="5.79,329,1602518400"; 
   d="scan'208";a="156695566"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2021 17:27:29 +0800
IronPort-SDR: esQUOBfZaAFklhD2kaAnV6MyMFH+LAz2ATTiIAMC+fOQlz5LrlMOY47ecbhClG+ZPe9GKZZOMh
 uMh3Bb2sk9PmHFinlzRJd/IVmveHjvbjxA4GFYalesgMbPIhCv9Pyd4zMbt2QNqRqdxHb5r5x5
 5R3i1hB7cvyvj1en9rZ8BuBthuZkdA+RA5pLg+DX2F2fDDRS5/fzWsBdymSmRNAYNI98QHwgTN
 8bqeT8hx4Il/hw1vQ6WPqZZLeHRr274Hl+9BRn+IbzBgCR3Ma+K4HghalRdCya2f6UDSz7dMHB
 PlYKGuDOa4NCxhLAYsYT56PU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 01:12:20 -0800
IronPort-SDR: kr+h0ka0huc4Zv/VwhAr08nh9zKSBr1QFmPF6J/ILRbhiEAuciNDSDeD1XDQur+VG4aW80gEtd
 37xIVRq2k1FM9HxvDxtH9T4PgP3LYXUyn5nbwORH5Ja+Y9JqVMelPfPZU5BpngIlF/dY87HOFy
 WfI/DUTQKcynW1cilYC5nkbAWFsKOWfcxPnTThA40fbD+bdg752WTQfN4KJSPKRCS+YD7ezBz+
 9tdbb+oH3vrBho4n7sZhiM96RCSCCYBeuxUeEc0JRp0PUM5IDFHDRULp/xBme2aU6K3ksAAzbc
 4o8=
WDCIronportException: Internal
Received: from usa002483.ad.shared (HELO jedi-01.hgst.com) ([10.86.62.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jan 2021 01:27:29 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nick Kossifidis <mick@ics.forth.gr>
Subject: [PATCH 0/4] Assorted fixes for RV32
Date:   Thu,  7 Jan 2021 01:26:48 -0800
Message-Id: <20210107092652.3438696-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes various issues observed in latest kernel on RV32.
The first two patches fixes an resource tree introduced in 5.11-rc1
while the last two fixes the case where 2GB physical memory is used
on RV32.

There are may be better way to fix the issue pointed out in PATCH 3
as it seems a generic kernel issue where kernel pointers can not use
last 4k of addressable memory. I am open to other better alternate
suggestions.

Atish Patra (4):
RISC-V: Do not allocate memblock while iterating reserved memblocks
RISC-V: Set current memblock limit
RISC-V: Fix L1_CACHE_BYTES for RV32
RISC-V: Fix maximum allowed phsyical memory for RV32

arch/riscv/Kconfig             |  6 ++++--
arch/riscv/include/asm/cache.h |  4 ++++
arch/riscv/kernel/setup.c      | 24 +++++++++++++-----------
arch/riscv/mm/init.c           | 16 ++++++++++++++--
4 files changed, 35 insertions(+), 15 deletions(-)

--
2.25.1

