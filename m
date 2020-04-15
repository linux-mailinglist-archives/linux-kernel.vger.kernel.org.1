Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A547F1AAAB2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 16:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636816AbgDOOqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 10:46:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2636791AbgDOOpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:45:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B6FC21775;
        Wed, 15 Apr 2020 14:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961929;
        bh=QkaWjqtoLGkvp2WJ5RnsK/6VjKwgfJVizCADZA1WQTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t2dl/o1vyomKNq6Ky9P+qJvh/9SFHDwb/ZlF96siQtQ9TDKPw/ovKnsxOf4xtkk24
         YeWuhk45l8nE8QOeeuoEXqRvKJRGZkpYYxs4OmyOrkouzRJHrQeZiAyskH1B/hJkjl
         7HkizQsoUYbHCdwGiWdzpA0I6sJop5vhVP1nT3vc=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOjI7-006kZp-E5; Wed, 15 Apr 2020 16:45:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 09/12] docs: dt: minor adjustments at writing-schema.rst
Date:   Wed, 15 Apr 2020 16:45:23 +0200
Message-Id: <fe816c483db6e31359687c29a59622b54bd07b29.1586961793.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586961793.git.mchehab+huawei@kernel.org>
References: <cover.1586961793.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two literal blocks that aren't mark as such. Mark them,
in order to make the document to produce a better html output.

While here, also add a SPDX header to it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/writing-schema.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/writing-schema.rst b/Documentation/devicetree/writing-schema.rst
index 220cf464ed77..8c74a99f95e2 100644
--- a/Documentation/devicetree/writing-schema.rst
+++ b/Documentation/devicetree/writing-schema.rst
@@ -1,4 +1,4 @@
-:orphan:
+.. SPDX-License-Identifier: GPL-2.0
 
 Writing DeviceTree Bindings in json-schema
 ==========================================
@@ -124,9 +124,12 @@ dtc must also be built with YAML output support enabled. This requires that
 libyaml and its headers be installed on the host system. For some distributions
 that involves installing the development package, such as:
 
-Debian:
+Debian::
+
   apt-get install libyaml-dev
-Fedora:
+
+Fedora::
+
   dnf -y install libyaml-devel
 
 Running checks
-- 
2.25.2

