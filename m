Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF242D93BF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 09:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438982AbgLNIAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 03:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbgLNH7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 02:59:37 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8C8C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 23:58:56 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id c79so11564261pfc.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 23:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6b+ZRS9DmsS/G5g6tIAbIZZ5jkvMPonBxDT5Cg03Glk=;
        b=Nalk0bAAuJ3WV19QHKjKi4zG8pypGhHMMREkEHawPxD2V7ZHzwtQv1+J46OjmOMrpS
         AaKdfU9aFRxwmIKyT3RchJwDuSInYGnvqrVI59Am0qlMkK1j3bqhV7BvCmre2azEtBUu
         N1aP2sU/qZYBXV9ZS7wG/R5Tgx/jUhPo+PIt29cd+Iaoegyx2g6u7q1kg26BQWbJlaPI
         rkNPRQkQcw+BdXDB3PbsAItyEPQSgs2vjcs26U4oPDi7dpUFsNx8WRiW62iD2vtfIt8/
         yQyFZUMzOQzCJAz4oBiY+fJbJpQgCLegYpqaZaHcJUzXhY3OZrzqKBpOpxpGTOl5jE4U
         sQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6b+ZRS9DmsS/G5g6tIAbIZZ5jkvMPonBxDT5Cg03Glk=;
        b=DTVLG6e9qAHrHQtl3kozJuJGOIENu4yZ4noyh6MM1HIVPOfwVy43uUyDn2QqPyYMMS
         X6V0ICgQZR0TiL6+mmM3KaDW+bLICO+tGUrSBt+wFtwLYpl1DvyTUfFH5wcDMBVSEtN/
         LCeKpzPQ+igqcEkgWJdUKQv8S+PD9Xv8xz4eTNSDvluSb+uywJqbtS7ug2Eoxk66HXGg
         EGNn0V+t1ZCuNF6353472VgIHtDTiEXiVOMK/zSV+LzrRzRzMc9m4Ehqp1pHBDacTKxB
         Ohpt0NjnjwyfQ5QNosE+lOdUsfBTlskMOwPWFqeBYyZawePT1ZetK1qy87MPYWhwneK8
         DJFg==
X-Gm-Message-State: AOAM533hgZpvC5R7KlxqzmTClcal/KzThT9HHvxKBRnwexBM4FnLTRGQ
        N53CZChTLbENRasNIpDulEh+qElg4RR9ct2Y
X-Google-Smtp-Source: ABdhPJwIe9vEHKO3l1Ki6rafHiT1gaw6D6oR7GhGBUtwGoOfMcJiDSRxR01jZR8/A8FuAfpVjyfLBg==
X-Received: by 2002:a05:6a00:1623:b029:1a4:e935:87a8 with SMTP id e3-20020a056a001623b02901a4e93587a8mr6056029pfc.26.1607932736312;
        Sun, 13 Dec 2020 23:58:56 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:68f8:3c95:3c1d:64ce:bfb7])
        by smtp.gmail.com with ESMTPSA id s10sm19042278pgg.76.2020.12.13.23.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 23:58:55 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        dwaipayanray1@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] scripts: add more corrections to spelling.txt
Date:   Mon, 14 Dec 2020 13:28:31 +0530
Message-Id: <20201214075831.34282-1-dwaipayanray1@gmail.com>
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
 scripts/spelling.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 953f4a2de1e5..cf2453ddb216 100644
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
@@ -801,6 +806,7 @@ intialise||initialise
 intialization||initialization
 intialized||initialized
 intialize||initialize
+intead||instead
 intregral||integral
 intrerrupt||interrupt
 intrrupt||interrupt
@@ -1151,6 +1157,7 @@ recyle||recycle
 redircet||redirect
 redirectrion||redirection
 redundacy||redundancy
+reenable||re-enable
 reename||rename
 refcounf||refcount
 refence||reference
@@ -1253,6 +1260,7 @@ senarios||scenarios
 sentivite||sensitive
 separatly||separately
 sepcify||specify
+seperate||separate
 seperated||separated
 seperately||separately
 seperate||separate
@@ -1334,6 +1342,7 @@ substract||subtract
 submited||submitted
 submition||submission
 suceed||succeed
+suceeded||succeeded
 succesfully||successfully
 succesful||successful
 successed||succeeded
@@ -1354,6 +1363,7 @@ suppoted||supported
 suppported||supported
 suppport||support
 supress||suppress
+suprising||surprising
 surpressed||suppressed
 surpresses||suppresses
 susbsystem||subsystem
@@ -1475,6 +1485,7 @@ unsinged||unsigned
 unstabel||unstable
 unsolicitied||unsolicited
 unsuccessfull||unsuccessful
+unsued||unused
 unsuported||unsupported
 untill||until
 ununsed||unused
@@ -1482,6 +1493,8 @@ unuseful||useless
 unvalid||invalid
 upate||update
 upsupported||unsupported
+upto|| up to
+uptodate||up-to-date
 usefule||useful
 usefull||useful
 usege||usage
@@ -1499,10 +1512,12 @@ vaild||valid
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
@@ -1528,8 +1543,11 @@ wiil||will
 wirte||write
 withing||within
 wnat||want
+wont||won't
 workarould||workaround
+wraper||wrapper
 writeing||writing
+writen||written
 writting||writing
 wtih||with
 zombe||zombie
-- 
2.27.0

