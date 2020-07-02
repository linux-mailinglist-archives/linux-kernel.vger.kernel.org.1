Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8196213031
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 01:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgGBXjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 19:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGBXjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:39:20 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F99EC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 16:39:20 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p20so31816551ejd.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 16:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XNqOuyS2SSVizWbbVfENAG37e8e6fv0yRn51lqXxdcI=;
        b=qcxEMI5ewjUpjIvmDsU9x3UNR4KiAnf/r23QP21ObQwfDnsLaO4enRv27WMjp0P4uO
         b+keSnN2g8DyPcn6MFLc8kQ76CD+JhkH5KM0mFbjWAasUxWikgxRQz1bCf3sc4fnSsPr
         qe6lVpeO/o90R+sVNKs4ViM75j/9e2Si+Ssc0qiRiAakGChn1grpb4eZTlBQJ5VUe4xd
         N0FzM0JMcgPeKLJQOn2QTqwPwim7Y42sJDw0HWyEQjV+eAL9AqMTLT8hF0fFz5CMek88
         GhlSuYJ1bB0DEqk53857NPmo/dkJr9CGQ48/1jSPbfjnhIBoWDGWHDrCCXaTdZFA2xTW
         0H0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XNqOuyS2SSVizWbbVfENAG37e8e6fv0yRn51lqXxdcI=;
        b=BlBMTMZBhOVYZM10BSnZI3jZzGSHAMwhiJvUjeAlc4RnVCwJHPBH4iSpUEBIBGm1K9
         /3+dYeGT3OSYIg4OiY2M4sGw4YXiJnlSbbbUmaKn2VyNMAkzW4kiHTZYdDQdj1mBUadG
         HdzgggXx4m0TALGMCYHi9oAQo2HS9up0XLGiVXAatDUYorJmWRz3K2rxYC5wAEiC938N
         lfwMlOZt28g/tnEinmRlJlYz83Rchel/ukNi552J6PX6CLb+y0iewFb08l6MiNmfab0L
         b0vqRpJf50uAvkRT6rEMyUny9p+HD89P6VWuMINCaqijnfUJQJLYmQgMV6vuX/Zi8z6i
         EKPw==
X-Gm-Message-State: AOAM532u34CV8N//Xv1Ns7aYHynvcPD2ScbnHkXMT6Dk77DnGbsdcmYZ
        kC4UFOXWsHcVYlbLZeWdq+4PZNHd
X-Google-Smtp-Source: ABdhPJxuoPS2Hb/2dq/DGb3ZKLmbIkmhVSxkthKhmTmBXhWXqX0v/KxTvXzSPLxCDFkZww2IwxHypg==
X-Received: by 2002:a17:906:1187:: with SMTP id n7mr24542488eja.161.1593733158690;
        Thu, 02 Jul 2020 16:39:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:bd38:c82d:5283:9f1])
        by smtp.gmail.com with ESMTPSA id q24sm12109181edg.51.2020.07.02.16.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 16:39:18 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] testsuite: add new flag '-p' to subcommand 'format'
Date:   Fri,  3 Jul 2020 01:39:12 +0200
Message-Id: <20200702233912.55351-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag facilitate the creation of testcases for preprocessing.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/validation/test-suite b/validation/test-suite
index d351ebf3c428..f7d992dc7c8c 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -458,6 +458,7 @@ echo "options:"
 echo "    -a                         append the created test to the input file"
 echo "    -f                         write a test known to fail"
 echo "    -l                         write a test for linearized code"
+echo "    -p                         write a test for pre-processing"
 echo
 echo "argument(s):"
 echo "    file                       file containing the test case(s)"
@@ -483,6 +484,9 @@ do_format()
 		-l)
 			def_cmd='test-linearize -Wno-decl $file'
 			linear=1 ;;
+		-p)
+			def_cmd='sparse -E $file' ;;
+
 		help|-*)
 			do_format_help
 			return 0
-- 
2.27.0

