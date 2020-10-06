Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC53C284D58
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgJFOHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:07:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgJFODy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:54 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84182208B8;
        Tue,  6 Oct 2020 14:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993033;
        bh=LvfP0jOK13UuuLfelIbMUCsdO3bUxdpXbiy+j5C7Kks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w+pEXREIDqHDPL1X35yD4REc0Fxu87CsoHbTzWWDaJGwZdZ3vTZq48Ok0+ceE9XRB
         TVy4Fd+rS9cOvEpSKfreYN8dbvwvDuZFNVaKHxb/+tLGXaEMQzDA7McXLYwLTniL1S
         WMEhGcB86je+FM+v1bqf9v93JmvaA0/QF9cxbrHo=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZH-0019Ex-Cz; Tue, 06 Oct 2020 16:03:51 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/52] docs: kerneldoc.py: append the name of the parsed doc file
Date:   Tue,  6 Oct 2020 16:03:08 +0200
Message-Id: <2f563405fe85dc09dfaa8d27c34e92282bebefa1.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finding where an error like this was generated:
	../lib/math/div64.c:73: WARNING: Duplicate C declaration, also defined in 'kernel-api'.

Can take some time, as there's no glue about what kernel-doc
tag generated it. It is a way better to display it as:

	.../Documentation/core-api/kernel-api:171: ../lib/math/div64.c:73: WARNING: Duplicate C declaration, also defined in 'kernel-api'.
	Declaration is 'div_s64_rem'.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kerneldoc.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 1a1b12242a45..a3a5427130da 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -141,7 +141,8 @@ class KernelDocDirective(Directive):
                     lineoffset = int(match.group(1)) - 1
                     # we must eat our comments since the upset the markup
                 else:
-                    result.append(line, filename, lineoffset)
+                    doc = env.srcdir + "/" + env.docname + ":" + str(self.lineno)
+                    result.append(line, doc + ": " + filename, lineoffset)
                     lineoffset += 1
 
             node = nodes.section()
-- 
2.26.2

