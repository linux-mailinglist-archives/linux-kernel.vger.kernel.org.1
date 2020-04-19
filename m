Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C35B1AFA12
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 14:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgDSMgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 08:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDSMg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 08:36:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7500C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 05:36:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h2so7759053wmb.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 05:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NO2BQW6T1noQfECm0T8lcV7QErjlTf0XvFH0gH2fMyE=;
        b=mPeLXDI7ExRIl6dkw0GFkdIrXMCTjblemuKsHbatY8cf3K9D045CQlKLX525gPVzCV
         SWqC/HL7rP3qISK4L2ZW/AsYHYMtmmc4xeMJtmyx00gmZrSxIvdYLgc235B/wiZGhu1+
         pPCnm95F69RePudoSq8XgAckdziyJGufh0nzQoKRTJC0K1IMLIXFSxiCypmz2SuhW5jW
         skF033WQs85npAMgyVjJ1La/SPdKCs0zJQnPw3yhF5veJUNRFNazi00kS9Jl+n6T07R6
         stChjpLc7TT+g4vj8Io0gyA6SPHleFses+zDF6aJmYNbrsoMy/sdHUDyOuBt0heSOcU0
         hDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NO2BQW6T1noQfECm0T8lcV7QErjlTf0XvFH0gH2fMyE=;
        b=DIbbixT7oSIixGobtip4PqQKEf+dF/hHCXf9ejjUYVABPT2/8DHcVDjhCXsAjyuTHy
         pevqNXbaKTAOXqDWpgTRKYH2Vo1BT3ESgjNjT7tXZ2X1GQd1BWWlj4TOfn/Tgto+8hE8
         3e+rJkaU2+Rc9rQQXHoq6Si4N4Q79oWGnx9oyz4COyT0Hxih1uA+kdtW1ZWSpzjL6RR/
         yf9w6Af0+sh5PU1O0vI4/xsUZEOEpMw2Q2TXGinMA0d9lUrMFWY+F+Sl81YzChFREOBQ
         0l+QZYBCTfYOFYJzQXz1ANALIWaD9Jw3cgl57BYiq0mD49DSMds8rmc9mluxNf2PfyMH
         Hk8A==
X-Gm-Message-State: AGi0PubYd8cUlkb8/hAK2afhuXSbuNuiEoX5aLpxR+LYO3ZMmSuYGkE5
        sBwXTk9kOUEk0lh0Gg7/A7M=
X-Google-Smtp-Source: APiQypI41I9+IjrOHYvbz5qPYuUrXSV10LBkXmyyG9fEbFE2T4boTJRbdY4+eE3uhY6Ihr1Us0Iv1Q==
X-Received: by 2002:a1c:7d04:: with SMTP id y4mr12492390wmc.10.1587299787388;
        Sun, 19 Apr 2020 05:36:27 -0700 (PDT)
Received: from localhost.localdomain (x59cc9bd1.dyn.telefonica.de. [89.204.155.209])
        by smtp.gmail.com with ESMTPSA id 68sm42508323wrm.65.2020.04.19.05.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 05:36:26 -0700 (PDT)
From:   Sedat Dilek <sedat.dilek@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tejun Heo <tj@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH] kbuild: Set CLANG_VERSION only when Clang is used
Date:   Sun, 19 Apr 2020 14:36:12 +0200
Message-Id: <20200419123612.173187-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do like GCC_VERSION is set when GCC (see CC_IS_GCC) is used.

Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 9e22ee8fbd75..c23f9d3d6d6c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -25,7 +25,7 @@ config CC_IS_CLANG
 
 config CLANG_VERSION
 	int
-	default $(shell,$(srctree)/scripts/clang-version.sh $(CC))
+	default $(shell,$(srctree)/scripts/clang-version.sh $(CC)) if CC_IS_CLANG
 
 config CC_CAN_LINK
 	def_bool $(success,$(srctree)/scripts/cc-can-link.sh $(CC))
-- 
2.26.1

