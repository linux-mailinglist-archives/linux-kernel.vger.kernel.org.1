Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E012D9435
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 09:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439322AbgLNIjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 03:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbgLNIjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 03:39:09 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E773EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 00:38:28 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id iq13so5887025pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 00:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lvKgfsEIEyxuChtKkWhGyGLQfPdT3sP1diYgIoXENPY=;
        b=ajMrkZeUF1ypossfsoD3Ej0u9TH/m5nqvoQPNACncE5ycvDkhFgYzOdwEJ8Nr0ZgiP
         MhldUdIATR17iTs2XmBCQ9AfpiY6nKklB8uwF8su70VgaVhT2OpmU+D620FdkYgv4oO6
         BQAsoBgAvQo1ZUcOOylU6hTb3SX3l9tGtkF1e97U7KZDSPlDhzBFZGRQK9IGZVOCM2gg
         6iz0ET8tPtBggJh8/AAogMsbBOq9E5FZkb2S0vwORAqg2Q56w/ZDs5gvLuBluqUhoJDw
         B0TK8zo0pQtP865Q0aYf441yJs2QjlgmnKmAZeJGhUy5ATClkEEOLSCbwZgvjjcjO/05
         ipGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lvKgfsEIEyxuChtKkWhGyGLQfPdT3sP1diYgIoXENPY=;
        b=J2OH46Brbf0eEFvx1isjMLP4gZHDuYAx7M60m2AHrVsPp981v8LO2d+adoiGiSoRgV
         o+MRJzdKdqt/MiC2Kk3BlSXkJUj0IReB8+RtTsAtB/EePVlt6Pb/REJeYCmcvLg9GSS5
         LLgFQrRT4loqKJTjVAAt23uIuaJMI5JGTk3b8fubsg1AcAPIQjdsVmjjsRiCf7Zb7pdE
         jthcd1W4rjht3BVcj2zRgSrSlgnqECj/7AES/lMmBHWOu2Eo3gkiY7gVKFCHYgWH72v8
         5r7KmfTIh98QKpG9G//PiZx0ACrsEaEWjhpnUY2FGlwHjbNGbD4iQzkoEuDqwb8W2UHm
         UTPQ==
X-Gm-Message-State: AOAM531yNwwRvzAGnqWr6ukoj+uFi2s/jIlwmMcIEQ0lsQSw+/n08fEg
        UEAalbDKyruSUrgCiUARzrupZJUCK6gXqiPK
X-Google-Smtp-Source: ABdhPJwDMcwgLhbgVOQ16UCfHzsAMDZ/7WoPBUrtDFoRElS6SiqNxU2gqfq+VLpG/z+FmI3eC40eJg==
X-Received: by 2002:a17:90a:4cc5:: with SMTP id k63mr7678027pjh.202.1607935108347;
        Mon, 14 Dec 2020 00:38:28 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:68f8:3c95:3c1d:64ce:bfb7])
        by smtp.gmail.com with ESMTPSA id d4sm18527963pfo.127.2020.12.14.00.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 00:38:27 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        dwaipayanray1@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3] scripts: add more corrections to spelling.txt
Date:   Mon, 14 Dec 2020 14:07:05 +0530
Message-Id: <20201214083705.42093-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Analyzing misspellings over the past 10k commit messages,
a few more corrections are added to spelling.txt

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
Changes in v3:
- Remove duplicate correction for "seperate"
- Remove corrections for "uptodate", "wont"

Changes in v2:
- Fix additional whitespace before "up to"

 scripts/spelling.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 953f4a2de1e5..8b27dcf67d0c 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -315,6 +315,7 @@ commited||committed
 commiting||committing
 committ||commit
 commoditiy||commodity
+comon||common
 comsume||consume
 comsumer||consumer
 comsuming||consuming
@@ -347,6 +348,7 @@ condtion||condition
 conected||connected
 conector||connector
 configration||configuration
+configred||configured
 configuartion||configuration
 configuation||configuration
 configued||configured
@@ -437,6 +439,7 @@ dependant||dependent
 dependend||dependent
 depreacted||deprecated
 depreacte||deprecate
+derefencing||dereferencing
 desactivate||deactivate
 desciptor||descriptor
 desciptors||descriptors
@@ -608,6 +611,7 @@ failue||failure
 failuer||failure
 failng||failing
 faireness||fairness
+falg||flag
 falied||failed
 faliure||failure
 fallbck||fallback
@@ -722,6 +726,7 @@ implemntation||implementation
 implentation||implementation
 implmentation||implementation
 implmenting||implementing
+improvments||improvements
 incative||inactive
 incomming||incoming
 incompatabilities||incompatibilities
@@ -772,6 +777,7 @@ instal||install
 instanciate||instantiate
 instanciated||instantiated
 insufficent||insufficient
+intead||instead
 inteface||interface
 integreated||integrated
 integrety||integrity
@@ -1151,6 +1157,7 @@ recyle||recycle
 redircet||redirect
 redirectrion||redirection
 redundacy||redundancy
+reenable||re-enable
 reename||rename
 refcounf||refcount
 refence||reference
@@ -1334,6 +1341,7 @@ substract||subtract
 submited||submitted
 submition||submission
 suceed||succeed
+suceeded||succeeded
 succesfully||successfully
 succesful||successful
 successed||succeeded
@@ -1354,6 +1362,7 @@ suppoted||supported
 suppported||supported
 suppport||support
 supress||suppress
+suprising||surprising
 surpressed||suppressed
 surpresses||suppresses
 susbsystem||subsystem
@@ -1475,6 +1484,7 @@ unsinged||unsigned
 unstabel||unstable
 unsolicitied||unsolicited
 unsuccessfull||unsuccessful
+unsued||unused
 unsuported||unsupported
 untill||until
 ununsed||unused
@@ -1482,6 +1492,7 @@ unuseful||useless
 unvalid||invalid
 upate||update
 upsupported||unsupported
+upto||up to
 usefule||useful
 usefull||useful
 usege||usage
@@ -1499,10 +1510,12 @@ vaild||valid
 valide||valid
 variantions||variations
 varible||variable
+varibles||variables
 varient||variant
 vaule||value
 verbse||verbose
 veify||verify
+vender||vendor
 verisons||versions
 verison||version
 verson||version
@@ -1529,7 +1542,9 @@ wirte||write
 withing||within
 wnat||want
 workarould||workaround
+wraper||wrapper
 writeing||writing
+writen||written
 writting||writing
 wtih||with
 zombe||zombie
-- 
2.27.0

