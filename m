Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5AA23EBD4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 13:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgHGLCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 07:02:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:53276 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbgHGK6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 06:58:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3E588AB3D;
        Fri,  7 Aug 2020 10:58:36 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, Stefan Berger <stefanb@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH] docs: update trusted-encrypted.rst
Date:   Fri,  7 Aug 2020 18:58:13 +0800
Message-Id: <20200807105813.59900-1-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameters in tmp2 commands are outdated, people are not able to
create trusted key by the example commands.

This patch updates the paramerters of tpm2 commands, they are verified
by tpm2-tools-4.1 with Linux v5.8 kernel.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Stefan Berger <stefanb@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
---
 Documentation/security/keys/trusted-encrypted.rst | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 9483a7425ad5..442a2775156e 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -39,10 +39,9 @@ With the IBM TSS 2 stack::
 
 Or with the Intel TSS 2 stack::
 
-  #> tpm2_createprimary --hierarchy o -G rsa2048 -o key.ctxt
+  #> tpm2_createprimary --hierarchy o -G rsa2048 key.ctxt
   [...]
-  handle: 0x800000FF
-  #> tpm2_evictcontrol -c key.ctxt -p 0x81000001
+  #> tpm2_evictcontrol -c key.ctxt 0x81000001
   persistentHandle: 0x81000001
 
 Usage::
@@ -115,7 +114,7 @@ append 'keyhandle=0x81000001' to statements between quotes, such as
 
 ::
 
-    $ keyctl add trusted kmk "new 32" @u
+    $ keyctl add trusted kmk "new 32 keyhandle=0x81000001" @u
     440502848
 
     $ keyctl show
@@ -138,7 +137,7 @@ append 'keyhandle=0x81000001' to statements between quotes, such as
 
 Load a trusted key from the saved blob::
 
-    $ keyctl add trusted kmk "load `cat kmk.blob`" @u
+    $ keyctl add trusted kmk "load `cat kmk.blob` keyhandle=0x81000001" @u
     268728824
 
     $ keyctl print 268728824
-- 
2.26.2

