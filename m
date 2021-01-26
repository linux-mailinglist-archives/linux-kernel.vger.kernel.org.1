Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71099304554
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389184AbhAZRaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbhAZHfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:35:54 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EB0C061788;
        Mon, 25 Jan 2021 23:25:33 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u15so116016plf.1;
        Mon, 25 Jan 2021 23:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=exoaYFCYrI1Kapbl0247/VMsceScMtEx+1JSl3RbtM0=;
        b=rC9JpwUwVKNFrvZw2yKfzrFvW2/SphbDJvjQXkWM7BpoSeXE1CEaRMIDDRAtBsg1PR
         x16z00FnWKMVb5sEF0XLjZu1y7kk4N62RIbzT4VqDMuWaEwpw22XQiGfCUeSVEz1UsL6
         MMM4q48fybEv8giwc8M3nuhXET09XPPhF+Ud71yvL+XmYIb9VIGm0izs7EQZPWfyTv6t
         nAgGJHhkZdZwiU4Eoig+8HXEiLS1Fj1ozQ2e/uwyPdClid8CD7G57MKOkAaL092CcOoR
         RIdqKplGp71unbVk3vQxIfRYlRDQCAEynPP4ALElP+jOZZ5UEW6U7nbLfknPfjnUWM5w
         SQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=exoaYFCYrI1Kapbl0247/VMsceScMtEx+1JSl3RbtM0=;
        b=TJDtdeiuyett/uva6DUS7wv/JNlcMHyt9AylILhoYmkKV0vw+GXtBw1CYVgTi1xt7Q
         NpNc71QuTfVjOjVYhzcaTXhqY8mfnQkfCcwpUBF/iE9TXdEiWUaxSu5lsO0HfcZw+nZ9
         CdGJesUr3nv5Kwjal556yTZmugqrqLA32e1buS+D7uGDkdHmoUuwvlfd0B9Alfrwlvfe
         Vm9hLDJJIWz0OBYhFhZ/AAYdPJIQqiUL2ZXIQPM0EBXxbzi+/lTySp27UvpXfUUg7JOw
         J2Yw4ju3SUM2nDlKRiWoYinOfxmT58HmdkAfYRkWuNVoBf+mp29BmoyPmtb7y1l+2g9Y
         9hbQ==
X-Gm-Message-State: AOAM530xy2/HzvZAP8AEtFyvwIh2k/iLvCcNIRgVg4h3e0yeLTlBq2OR
        R94BCfKxfO3lSdWvLQQTo94=
X-Google-Smtp-Source: ABdhPJzHNj7oVxZamieAaa6afql/shnLl7aTfjCyDznI7JKvjd0X356aJu8odMDX48Ep/NKC07St4A==
X-Received: by 2002:a17:90a:c404:: with SMTP id i4mr4756979pjt.57.1611645932777;
        Mon, 25 Jan 2021 23:25:32 -0800 (PST)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l12sm1320256pjg.54.2021.01.25.23.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 23:25:32 -0800 (PST)
From:   Fox Chen <foxhlchen@gmail.com>
To:     corbet@lwn.net, vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] docs: path-lookup: Add macro name to symlink limit description
Date:   Tue, 26 Jan 2021 15:24:37 +0800
Message-Id: <20210126072443.33066-7-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126072443.33066-1-foxhlchen@gmail.com>
References: <20210126072443.33066-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macro name MAXSYMLINKS to the symlink limit description, so
that it is consistent with path name length description above.

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index bc450e0864d6..25d2a5a59f45 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -994,8 +994,8 @@ is 4096.  There are a number of reasons for this limit; not letting the
 kernel spend too much time on just one path is one of them.  With
 symbolic links you can effectively generate much longer paths so some
 sort of limit is needed for the same reason.  Linux imposes a limit of
-at most 40 symlinks in any one path lookup.  It previously imposed a
-further limit of eight on the maximum depth of recursion, but that was
+at most 40 (MAXSYMLINKS) symlinks in any one path lookup.  It previously imposed
+a further limit of eight on the maximum depth of recursion, but that was
 raised to 40 when a separate stack was implemented, so there is now
 just the one limit.
 
-- 
2.30.0

