Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CBC1AD50C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 06:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgDQEFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 00:05:35 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:37842 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgDQEFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 00:05:34 -0400
Received: from oscar.flets-west.jp (softbank060142179096.bbtec.net [60.142.179.96]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 03H44vZD014012;
        Fri, 17 Apr 2020 13:04:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 03H44vZD014012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587096298;
        bh=qN43PMkS5NKTugSiCouk5snU8lM3THH2z0nBNU4+ChA=;
        h=From:To:Cc:Subject:Date:From;
        b=D807E+U+/foQCrY9gVuyE9DKueGFRYT5XW/w5j92iEoLZHVaINRTw7LYDo5/x2Q4c
         Y9oWZ4at0kvzW3Vmc2YCnIK3qAAm4dx5COQTrGVwU9NnRxlPbmJcEDsBvkFPPHbgco
         SwVOawZR2tJO2VmwJM2++vBQSvTUeDoWyGVHuVI5ZEryWxxJi9Y8XRjFLbsReTGAK3
         sWRaUIAj2cC+q2e0DLyGXmAbmp//5rk1KBQg82og6MjBy8UjUSykwpOVZ+obnKQKuv
         60U/3raubsSpwReVelOKxFvYVQY+3QwTFWiyQ/0or8zWpdwjH8j7ku2ZBPdMJsJdrM
         MUK+0Qj6aSNLQ==
X-Nifty-SrcIP: [60.142.179.96]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: check libyaml installation for 'make dt_binding_check'
Date:   Fri, 17 Apr 2020 13:04:55 +0900
Message-Id: <20200417040455.763892-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you run 'make dtbs_check' without installing the libyaml package,
the error message "dtc needs libyaml ..." is shown.

This should be checked also for 'make dt_binding_check' because dtc
needs to validate *.example.dts extracted from *.yaml files.

It is missing since commit 4f0e3a57d6eb ("kbuild: Add support for DT
binding schema checks"), but this fix-up is applicable only after commit
e10c4321dc1e ("kbuild: allow to run dt_binding_check and dtbs_check
in a single command").

I gave the Fixes tag to the latter in case somebody is interested in
back-porting this.

Fixes: e10c4321dc1e ("kbuild: allow to run dt_binding_check and dtbs_check in a single command")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/dtc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 2f3c3a7e1620..ef85f8b7d4a7 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -13,7 +13,7 @@ dtc-objs	+= dtc-lexer.lex.o dtc-parser.tab.o
 HOST_EXTRACFLAGS := -I $(srctree)/$(src)/libfdt
 
 ifeq ($(shell pkg-config --exists yaml-0.1 2>/dev/null && echo yes),)
-ifneq ($(CHECK_DTBS),)
+ifneq ($(CHECK_DT_BINDING)$(CHECK_DTBS),)
 $(error dtc needs libyaml for DT schema validation support. \
 	Install the necessary libyaml development package.)
 endif
-- 
2.25.1

