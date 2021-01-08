Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9D92EF13B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbhAHL1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbhAHL1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:27:35 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B9FC0612F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 03:26:55 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id g25so6548167wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 03:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8iSB46QJ7GR0iFj4N1tg0BS6VjpMGk9aciUGDqcP8e0=;
        b=sJp9UAhZWX6VTu3fDEM5+bctcbwMD6IdHs2Lc0cD6w9aIdrrBQFjyDaAk5EqXcsQU1
         cpeupP59QN4NJvUCreuqdeTIXV6jzxIaMqXvl87y510MYLwNaAVGPN3Mgfl8k/7Kxh8Q
         /OWApSaJipIqFFsSC2DWSLQwambWRQk+7DDs1iJubxzJ+neFsTctL/kNSUhLnpIX0pde
         EQvYaR0LjNrLaizNIoGjU8OrOFjrUMQfuYtDnrbj6kP/IbhNdNFZtMrzuOJnYsbyTw3r
         vxb3NgXpzFDelEzmOEfUVhUExgnCzDHgRNHzscxNO3sGZS6Jl5AXvRrS3PMA3vYjZNRt
         CPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8iSB46QJ7GR0iFj4N1tg0BS6VjpMGk9aciUGDqcP8e0=;
        b=iR2QJmH81xEnVwej/z5Y1PRFk9FOB3w80rWb6Y1hUk+AsuSbo14Wpd9ErBj/ozBgFA
         V4NflygmLi0I/j7IyzzAr31aHYy8njuNmuvlCJkSgkNvsuYC2IywPsY+ZOHvv6XtPTbm
         v5NXblUzHh7SgS96Nsl09jVgPNlmX7P8AD83va61LUyWI8We8lQy2gW66tNA4nGrgIwf
         7aiMBve7OY0cE2OmD86K6FgNX80CtFwpPDiFkZyvFpRkjPj8vEougxLyjpjw+6batZjE
         lQ2ZnTr+AxfzV91kUrHxGIFjQ9AX4ls+qdGl3SkjWkU1tn3NTdYLvxmFBYjHwEZVB1wk
         7UFA==
X-Gm-Message-State: AOAM532gYnUvqRPTOX3JkcTztCbJqKDlMn2Ww5wi5YbOSKupFA7fp8Lx
        17lrD13IFRsShcOycMXbTmPMsEpJXrGtsA==
X-Google-Smtp-Source: ABdhPJxXPkjWUGw7YH9O8YHSC4gaUW6bUWWjiHomIYXRVbSXGcHBhBuX0ZBm/1Ky4nB1S65on02yCA==
X-Received: by 2002:a7b:c10e:: with SMTP id w14mr2612103wmi.161.1610105213478;
        Fri, 08 Jan 2021 03:26:53 -0800 (PST)
Received: from pc-sasha.dev.local ([146.120.244.242])
        by smtp.gmail.com with ESMTPSA id j59sm13874117wrj.13.2021.01.08.03.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 03:26:52 -0800 (PST)
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>
Subject: [PATCH] ver_linux: Eliminate duplicate code in ldconfig processing logic
Date:   Fri,  8 Jan 2021 13:26:26 +0200
Message-Id: <20210108112626.8623-1-alexander.kapshuk@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code that acquires the version strings for libc and libcpp is
identical, as is the printversion call. The only difference being the
name of the library being printed.

Refactor the code by unifying the bits that are common to both libraries.

Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
---
 scripts/ver_linux | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/scripts/ver_linux b/scripts/ver_linux
index 0968a3070eff..a92acc703f9b 100755
--- a/scripts/ver_linux
+++ b/scripts/ver_linux
@@ -15,7 +15,7 @@ BEGIN {

 	vernum = "[0-9]+([.]?[0-9]+)+"
 	libc = "libc[.]so[.][0-9]+$"
-	libcpp = "(libg|stdc)[+]+[.]so[.][0-9]+$"
+	libcpp = "(libg|stdc)[+]+[.]so([.][0-9]+)+$"

 	printversion("GNU C", version("gcc -dumpversion"))
 	printversion("GNU Make", version("make --version"))
@@ -37,12 +37,10 @@ BEGIN {
 	printversion("Bison", version("bison --version"))
 	printversion("Flex", version("flex --version"))

-	while ("ldconfig -p 2>/dev/null" | getline > 0) {
-		if ($NF ~ libc && !seen[ver = version("readlink " $NF)]++)
-			printversion("Linux C Library", ver)
-		else if ($NF ~ libcpp && !seen[ver = version("readlink " $NF)]++)
-			printversion("Linux C++ Library", ver)
-	}
+	while ("ldconfig -p 2>/dev/null" | getline > 0)
+		if ($NF ~ libc || $NF ~ libcpp)
+			if (!seen[ver = version("readlink " $NF)]++)
+				printversion("Linux C" ($NF ~ libcpp? "++" : "") " Library", ver)

 	printversion("Dynamic linker (ldd)", version("ldd --version"))
 	printversion("Procps", version("ps --version"))
--
2.30.0

