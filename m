Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802C72958A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 08:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504439AbgJVGy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 02:54:26 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17624 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2504408AbgJVGyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:54:25 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603349655; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=oDNHuL678KAN8vCxYEcSE+qoKBS93k6+OMtdkqx7xkEU28Vj1FAE58HCmI0rL6Ni1Y26E42tMZr+xR0e09W9qCMzfNXQ+YoOd+AzaUKXYiUb9EHfCrfCjBEgsqIYNTgdM9WLk99m4Gv4TapTXW8Zo+OZ640aJ0GqbdUKDZ9/lYo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1603349655; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=8HkcIApH2XGAw613nYELsdpdxuTMNJg7WEHRD5D0fbE=; 
        b=d5E85dfm3/H101wHTh1docnsnlWbjlc3akL1KhmZ7DNP3NKTFGgj3VlJcqzod8KrScZ9/hBzmYlqqB6giWGZROO89UUJb6OysSRmczi6E+RGOLSaf79uu7fwwytAUMH6uBdCnR7qQCgQs4pArC/NFo6hhzBFkma+O7XVvDX/60I=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=euphon.net;
        spf=pass  smtp.mailfrom=fam@euphon.net;
        dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1603349655;
        s=zoho; d=euphon.net; i=fam@euphon.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=8HkcIApH2XGAw613nYELsdpdxuTMNJg7WEHRD5D0fbE=;
        b=J6V/ito/0qcCAEBlcagj3arAv7CB9G3SVmI5NLf48acqPjuE7VD4MOfqoJN2qGzQ
        I4ALoT7oo6+/BtI8Vum1VTqIsqjVEdOi8IENy1tFE7s/Q0v9ZdvCxWjf1UlYhCWijau
        6Ptg3VRhZwmszEyZzyglDBZAdJ9fpHlMLTAK874I=
Received: from localhost (ec2-52-56-101-76.eu-west-2.compute.amazonaws.com [52.56.101.76]) by mx.zoho.com.cn
        with SMTPS id 1603349653028970.2826506913174; Thu, 22 Oct 2020 14:54:13 +0800 (CST)
From:   fam@euphon.net
To:     linux-doc@vger.kernel.org
Cc:     sfr@canb.auug.org.au, fam@euphon.net,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Message-ID: <20201022065403.3936070-1-fam@euphon.net>
Subject: [PATCH v2] docs: Add two missing entries in vm sysctl index
Date:   Thu, 22 Oct 2020 07:54:03 +0100
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fam Zheng <famzheng@amazon.com>

Both seem overlooked while adding the section in the main content.

Signed-off-by: Fam Zheng <famzheng@amazon.com>

---

v2: Add sign-off.

---
 Documentation/admin-guide/sysctl/vm.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-=
guide/sysctl/vm.rst
index 4b9d2e8e9142..f455fa00c00f 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -27,6 +27,7 @@ Currently, these files are in /proc/sys/vm:
 - admin_reserve_kbytes
 - block_dump
 - compact_memory
+- compaction_proactiveness
 - compact_unevictable_allowed
 - dirty_background_bytes
 - dirty_background_ratio
@@ -37,6 +38,7 @@ Currently, these files are in /proc/sys/vm:
 - dirty_writeback_centisecs
 - drop_caches
 - extfrag_threshold
+- highmem_is_dirtyable
 - hugetlb_shm_group
 - laptop_mode
 - legacy_va_layout
--=20
2.25.1


