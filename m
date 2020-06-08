Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663AE1F149B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 10:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgFHImA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 04:42:00 -0400
Received: from mail1.windriver.com ([147.11.146.13]:59737 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgFHIl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:41:59 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 0588fu6J007444
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 8 Jun 2020 01:41:57 -0700 (PDT)
Received: from pek-lpggp2 (128.224.153.75) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.487.0; Mon, 8 Jun 2020
 01:41:50 -0700
Received: by pek-lpggp2 (Postfix, from userid 20544)    id A10AB723B44; Mon,  8
 Jun 2020 16:41:17 +0800 (CST)
From:   Jiping Ma <jiping.ma2@windriver.com>
To:     <frowand.list@gmail.com>, <jiping.ma2@windriver.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dtc: also check <yaml.h> for libyaml
Date:   Mon, 8 Jun 2020 16:41:17 +0800
Message-ID: <20200608084117.4563-1-jiping.ma2@windriver.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yamltree.c includes <yaml.h>, If /usr/include/yaml.h does not exist,
it fails to build.

Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
---
 scripts/dtc/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index b5a5b1c..b49dfea 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -18,9 +18,13 @@ $(error dtc needs libyaml for DT schema validation support. \
 endif
 HOST_EXTRACFLAGS += -DNO_YAML
 else
+ifeq ($(wildcard /usr/include/yaml.h),)
+HOST_EXTRACFLAGS += -DNO_YAML
+else
 dtc-objs	+= yamltree.o
 HOSTLDLIBS_dtc	:= $(shell pkg-config yaml-0.1 --libs)
 endif
+endif
 
 # Generated files need one more search path to include headers in source tree
 HOSTCFLAGS_dtc-lexer.lex.o := -I $(srctree)/$(src)
-- 
1.9.1

