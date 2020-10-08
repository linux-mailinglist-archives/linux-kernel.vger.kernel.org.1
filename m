Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284BA286D10
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 05:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgJHDOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 23:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgJHDOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 23:14:08 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA8BC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 20:14:08 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id g10so2797641pfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 20:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EuG4K/XgsWE7fSCLSMhN/E2Bz00xDoJMv8ow9PGXGZw=;
        b=uC/9jTjXuRc1LMrueDNkrbZ5O3AN7FuWn6f23ip2GmClZz2jakQytrCBDjjRW4BL61
         I9/qmO4Ws7WYXP32ekb95jWWM6ms+BmmY+RGa0+m57LEQ9bn2596eNptVCcFM/afA5pu
         3hxvqzlYfO7R1STip7wODiY1fGX+VnrrzJRo2IQIlOp8AlO50IVEMdcWAi7JZie2qXcZ
         D3lBezVDMDFaBMku30HsN3CQ7hEZEYmK4Uusyajo6yxNZKuwZmSln1j29SnBAXTD28+2
         LMq9qpaMUIK4oIv78kdzXrP01r0mBZuWKmyocn25gQl23XaZcmGWIxu88/LUDb0coA21
         x99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EuG4K/XgsWE7fSCLSMhN/E2Bz00xDoJMv8ow9PGXGZw=;
        b=NgyM7TXXbW3Q3Mb0YuRTNu07KI8KbUbMv6J+vF/Mw0/h9L7uFmwVeASyUVmdBees29
         iNz2enujYRDUNFNnGyZQPGABLI4WmmQ31Xjc9VUXgZOV9jXAIbdzrLDOX47CGR7YYWXZ
         PLuCSmWjUJbhcddy9B/wxFxe6jjP9QAYtE1LBa+K9HxI/J+BOKfIRZ0iPLD7xlv78OwQ
         svHUsT2uYSHxxyKXYWDVJmeR8AA1CZ9X82leuVX8V1gP8V1569k9lXJN9d/eRx7MPL57
         r5WTo2l53hGoHlKuiF5cJoqhR6g9eTsvZUjcqyQWFm/976l/F1E0eweAn9CwkflawDJh
         +qJw==
X-Gm-Message-State: AOAM532uQO1kifT8LWR7kL1GNcvuE1hbsPC0ApETD3Uxuzdoo6gzEa5K
        8DLvHUnkVfqYt7s78DKykvc=
X-Google-Smtp-Source: ABdhPJyAQp45h8wLuFHKqernjek2ghg5Qgg2CCpucKOFa2rfw9HxPQ8Ed/VXTXSgb8reoHmtfYrXrw==
X-Received: by 2002:a62:1a4c:0:b029:152:706d:dabb with SMTP id a73-20020a621a4c0000b0290152706ddabbmr5540710pfa.40.1602126847521;
        Wed, 07 Oct 2020 20:14:07 -0700 (PDT)
Received: from localhost.localdomain ([154.223.142.197])
        by smtp.gmail.com with ESMTPSA id n125sm4924313pfn.185.2020.10.07.20.14.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2020 20:14:06 -0700 (PDT)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH V2] kprobes: Correct a typo in function kprobes_module_callback
Date:   Thu,  8 Oct 2020 03:13:57 +0000
Message-Id: <1602126837-32346-1-git-send-email-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 1.7.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a tiny typo in comment of function kprobes_module_callback.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 kernel/kprobes.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index e995541..9d2042b 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2432,7 +2432,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
 			     within_module_core((unsigned long)p->addr, mod))) {
 				/*
 				 * The vaddr this probe is installed will soon
-				 * be vfreed buy not synced to disk. Hence,
+				 * be vfreed but not synced to disk. Hence,
 				 * disarming the breakpoint isn't needed.
 				 *
 				 * Note, this will also move any optimized probes
-- 
1.7.1

