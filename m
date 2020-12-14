Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78592D93C2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 09:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439031AbgLNIC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 03:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438993AbgLNIC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 03:02:58 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99872C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 00:02:18 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id m6so1835453pfm.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 00:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GjJyoj6HEnn8S41rMLrhQESVG/OibfeqXfc4YY2wvNg=;
        b=gmJFyvLRjkZKf5B4WcUqx9uRzIFrei+BT1jX95Tpg1FZIgOU+sz7v8vDxjVcvzwvrH
         IJc4j85T4fOJhBlu9bfD+yNMYlBch3IB+0yU7oQrZnAIzc8JFMoa2XdlC65khbmvCrIg
         B/P7QX1u2+74gz1ldeTzJTexKgpPiwCNz1HagQn5vtGypCV8j1j43ISuDpRpwToKxzSW
         G41O4WC2kG/yxz164/nR9M+KqjKzE7pE6i3FJODjmmoWnu2WB9bcp8BxEaDhI8KVQTY1
         ak5pB8tdZIZnSIpC1hnMsX4t0mIk5KRJAldrbXwOq3uWXPozah8ikuzhJQs4MQaYxwn+
         yjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GjJyoj6HEnn8S41rMLrhQESVG/OibfeqXfc4YY2wvNg=;
        b=eZc7hfjrKw5nUUW//wvl8wgzalagN+dlW3dKjaBsc0eB2H/KrWbABrwGfZm31ZDRiZ
         3hnwdRtmTAb8Mfc8vVJxaOdrQHJpBsTMVkrL071yneyikl/HHs1g14RKD/Fz/J77w4JD
         0RLZIIFIvM24SfHFb4U2AbUagwWe/rlO3lCGppNY5Jvbsr4hKPjj5ZDv1dtEbJrbIguN
         q6E6DO1uzX7ma5jZGvUpwBdCjFc/EcoMGJ9v1p9GW+/+jYzrOhEj4xpD5Y/vBDrPwaqH
         I8v41gJbno9mo7Qb3PHNWjlHUQ6MZ7/Iik+aDB+Fdz4T7qFZMsB47+m1PMYwEq0tlf4X
         LqYw==
X-Gm-Message-State: AOAM530t0NByVRfDLS9EnblfU7Ccaaa8xZvbKG7awOfNs4P2mTJLC4B+
        /VFBMAIdzzj+7mD1ZKga+3Q=
X-Google-Smtp-Source: ABdhPJxjA4Nmo5rAaQa/vV8917Z0AYXTrx37DzCtfWush8Yx6bCndQLfMbXs0NDiM1Y/ovPIGpcP3g==
X-Received: by 2002:a63:65c5:: with SMTP id z188mr7863980pgb.332.1607932938079;
        Mon, 14 Dec 2020 00:02:18 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:68f8:3c95:3c1d:64ce:bfb7])
        by smtp.gmail.com with ESMTPSA id a142sm14396932pfa.188.2020.12.14.00.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 00:02:17 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        dwaipayanray1@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] scripts: add more corrections to spelling.txt
Date:   Mon, 14 Dec 2020 13:31:56 +0530
Message-Id: <20201214080156.35072-1-dwaipayanray1@gmail.com>
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
Changes in v2:
- Fix additional whitespace before "up to"

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
+upto||up to
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

