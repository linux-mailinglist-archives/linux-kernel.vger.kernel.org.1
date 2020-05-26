Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007811C528A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 12:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgEEKFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 06:05:03 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:22071 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgEEKFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 06:05:03 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 045A4LUQ013670;
        Tue, 5 May 2020 19:04:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 045A4LUQ013670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588673062;
        bh=ztaf4XmzJ46pYJuwLpQpZMgBiKK3q2BP8zbpETm6hxY=;
        h=From:To:Cc:Subject:Date:From;
        b=0UwOLFB4Gkr9J1W+hvRmzLgW3eES7+OTb3KyEPta0vOSTzkwI6rhq7og9CUFOrH4s
         6Zj4SFnzA3GAm/yoSLFUeR4DRhXrZd3KC2DFWHjotFRBCapqLYsNKBYjZC3hfirD4j
         iAClt9A5w9eXWLruTeUWBwiaH7dbDxWbwZKexy2p5u56OroErkKD+T5W6hFFhz7tot
         baX7ipr0egE6H7t7sw/M+lMMvjVCpY2YomZErn7TJrsG6G5QLv+vIGoaAFXzZchGVJ
         JBUQ9d7kyq8Vh0N8KlVydyNdbFb+oy3P9GbMKNeY8qako8xOhPb5EZo/UzI0grTzSz
         B++qDMlcj3Bjg==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] scripts/dtc: use pkg-config to include <yaml.h> in non-standard path
Date:   Tue,  5 May 2020 19:03:19 +0900
Message-Id: <20200505100319.741454-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 067c650c456e ("dtc: Use pkg-config to locate libyaml") added
'pkg-config --libs' to link libyaml installed in a non-standard
location.

yamltree.c includes <yaml.h>, but that commit did not add the search
path for <yaml.h>. If /usr/include/yaml.h does not exist, it fails to
build. A user can explicitly pass HOSTCFLAGS to work around it, but
the policy is not consistent.

There are two ways to deal with libraries in a non-default location.

[1] Use HOSTCFLAGS and HOSTLDFLAGS for additional search paths for
    headers and libraries.
    They are documented in Documentation/kbuild/kbuild.rst

    $ make HOSTCFLAGS='-I <prefix>/include' HOSTLDFLAGS='-L <prefix>/lib'

[2] Use pkg-config

    'pkg-config --cflags' for querying the header search path
    'pkg-config --libs'   for querying the lib and its path

If we go with pkg-config, use [2] consistently. Do not mix up
[1] and [2].

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/dtc/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index ef85f8b7d4a7..0b44917f981c 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -20,6 +20,9 @@ endif
 HOST_EXTRACFLAGS += -DNO_YAML
 else
 dtc-objs	+= yamltree.o
+# To include <yaml.h> installed in a non-default path
+HOSTCFLAGS_yamltree.o := $(shell pkg-config --cflags yaml-0.1)
+# To link libyaml installed in a non-default path
 HOSTLDLIBS_dtc	:= $(shell pkg-config yaml-0.1 --libs)
 endif
 
-- 
2.25.1

