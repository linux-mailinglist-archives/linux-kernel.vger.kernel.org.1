Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F90F267F6D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 14:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgIMMF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 08:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgIMMFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 08:05:54 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFCEC061573
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 05:05:54 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t14so9348511pgl.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 05:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Vsq2EpPAKnreG44my/rSP6OLukd3irJGMACNHFoXfQY=;
        b=HYmWTVRAYowkmPtIwoh8IMtZfBpEB+hW13kFz/ZbqJiDanEKc2ukG5aqno/ZP2drHO
         W6u2eDXPd7pvwPu9exeIuDbvm1V/ECO6BKGxbABqCr5RyexmTO+5IhLYTJYareQcOdd4
         aJdb7+z6xOcc91CXk9xCPUt04nUPYBKbI9vvRn7BNA5qYd6mFu6F2+GvRyPKL+o7kIkc
         giPNgHA9ReulRKDx4ZYY3FXR4HBR6axakt6J6ZvlT9/s4uDYetvGFtES1To27ub2FEvx
         /hk1BV3DrcZzA5GvXRlk2NTqSIFobUExVC2uggr07/pBU2Z1YD/O/QHwLcb6iNC6U25x
         3v+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Vsq2EpPAKnreG44my/rSP6OLukd3irJGMACNHFoXfQY=;
        b=lPUTb+3hkMlZadk4ay3QLIbChvLjkiv5cMMZB1uUY6basK4fE7WMP2yHwq57TovADS
         9E/uOv2APTihW7FYZJPELTQy2UyncjzmjB0RbIxNFcxOFBMJKWF+VECxRzJvIAsLDrtF
         vbwvOJHWe9y7if3JeHltLSQYHu7zZnAZhja8QJ7c7EvAlIjYGncqj1wHIMA+nL/nx8UF
         r4t1f9H4d2BfgIGZaxmVBmhvnJ8H1TBu9jzdLDL0z7m3JKQDK6ykmdI7A729RD7ZtNBI
         FegLeVH/w3JUVpkx0ixu5kRas6dLMBjD/6TQLKEBDhhSO+UZobFU8SPUFVHnIH0uJozz
         MdNA==
X-Gm-Message-State: AOAM5325ky/+VUHKcxltQK49HZ9FwctpZpKxK6n1erNV5lAxwaH//WKq
        tdJb5RJ6ltMw+84w+X5dp5hCYwCiDaP1mg==
X-Google-Smtp-Source: ABdhPJySzSYm5D7wRb8u9V4+TDj9iFszEPlnd4jXyNMOO7rk4GkoBvylg0Pnr8o5dywo6gWvv3XLlg==
X-Received: by 2002:a62:864e:: with SMTP id x75mr9419816pfd.60.1599998753546;
        Sun, 13 Sep 2020 05:05:53 -0700 (PDT)
Received: from adolin ([49.207.213.41])
        by smtp.gmail.com with ESMTPSA id x19sm5925722pge.22.2020.09.13.05.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 05:05:52 -0700 (PDT)
Date:   Sun, 13 Sep 2020 17:35:48 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] scripts: coccicheck: Improve error feedback when
 coccicheck fails
Message-ID: <20200913120548.bwl3elfl7ss66eyh@adolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, coccicheck fails with only the message "coccicheck failed"
and the error code for the failure. To obtain the error logs,
one needs to specify a debug file using the DEBUG_FILE option.

Modify coccicheck to display error logs when it crashes unless
DEBUG_FILE is set, in which case, the error logs are stored in
the specified debug file.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 scripts/coccicheck | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328210ac..dbeafa21f359 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -126,8 +126,14 @@ run_cmd_parmap() {
 	if [ $VERBOSE -ne 0 ] ; then
 		echo "Running ($NPROC in parallel): $@"
 	fi
-	echo $@ >>$DEBUG_FILE
-	$@ 2>>$DEBUG_FILE
+	if [ "$DEBUG_FILE" != "/dev/null" -a "$DEBUG_FILE" != "" ]; then
+                echo $@>>$DEBUG_FILE
+                $@ 2>>$DEBUG_FILE
+        else
+                echo $@
+                $@ 2>&1
+	fi
+
 	err=$?
 	if [[ $err -ne 0 ]]; then
 		echo "coccicheck failed"
-- 
2.25.1

