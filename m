Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E23304569
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391957AbhAZRfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389573AbhAZHkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:40:06 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C9AC06178A;
        Mon, 25 Jan 2021 23:25:34 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id t29so9955497pfg.11;
        Mon, 25 Jan 2021 23:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V6thmsZF+JSK8J3bk0cVuqjQv0k5voA6tdBnKPzmfG8=;
        b=f1Xm9VEsCYj7he6Gv4PqXWMB6/xRk0mXdfrIovCJTY3P8DupHkgZJ9QDGnrDkw9yJE
         6KWCQ29wyJ2pxfFxslHNrf7qTp9FPdGTiHj+XGNHRhXGL7yp8mfkPOUZzmNsp1cDF2AM
         xSBMcdoffXm1/CPhERMv2gHVHJTURwEfUWcBZptTq5YyPnO8ZMoCjhac+A6+3fDAsQKS
         6Q4YDXoxSS7v5QO+mOJf0HIM4+rmMbmxZrQWlPcj10Lqafp0xQhCR3HYXTUVPMxL3eT1
         WiESmp6oWHptYa2ZB0DY/subvX0oRjXfU4FwZ43wqj77LLKScnyt0C/y7FAVK3gomypS
         wNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V6thmsZF+JSK8J3bk0cVuqjQv0k5voA6tdBnKPzmfG8=;
        b=T7Sk47GIz0QDdm63/OP7IvFTl/xeFbOWK33hdegU3+pBIqhCUT7Dl/fYpq6SCbllNo
         NKoGgS3DOAdAnL1PIhEGgz1DYL4dikkdYmDvPXWQ16RtmvXGRsTMFeKKo0YrUKIRYvHK
         UcxQNb33DH9ljoYfEDk8+gkE++zFDAePzHRKc/cggl4bZO35KuY3Xu6/lJ4o/dZZF6JZ
         7cqfAfVhLgPSBGvDObar68mZ+EwtmVfSIQeynzYlnPcei8hILo5f+rOVpo7IC6GSdh7A
         5upT1E6dSr26Af0KWLvOnxUd6dEvQGd9Fodh3BTHb08ClqYxYil94A/OJLjlwXlJ1NiM
         qRAQ==
X-Gm-Message-State: AOAM531ufEMwGgbJKz5Lcnib0YE2/41Devk2OQlWgOVvthg652dSjfH1
        pwBtXXRd3AIF5o0++eFraa9vXUdMTSGl/GMBZp4=
X-Google-Smtp-Source: ABdhPJx0mRPTO4Aa+qPF/q69Pcz0w1+TKsGZvdmMBil2ZLkFl3/qoRf8ipEvyPRV7OGu7gyIe6HsKA==
X-Received: by 2002:a63:fb49:: with SMTP id w9mr4481865pgj.403.1611645934146;
        Mon, 25 Jan 2021 23:25:34 -0800 (PST)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l12sm1320256pjg.54.2021.01.25.23.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 23:25:33 -0800 (PST)
From:   Fox Chen <foxhlchen@gmail.com>
To:     corbet@lwn.net, vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] docs: path-lookup: i_op->follow_link replaced with i_op->get_link
Date:   Tue, 26 Jan 2021 15:24:38 +0800
Message-Id: <20210126072443.33066-8-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126072443.33066-1-foxhlchen@gmail.com>
References: <20210126072443.33066-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

follow_link has been replaced by get_link() which can be
called in RCU mode.

see commit: 6b2553918d8b4e6de9853fd6315bec7271a2e592

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 25d2a5a59f45..0a362849b26f 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -1062,13 +1062,11 @@ filesystem cannot successfully get a reference in RCU-walk mode, it
 must return ``-ECHILD`` and ``unlazy_walk()`` will be called to return to
 REF-walk mode in which the filesystem is allowed to sleep.
 
-The place for all this to happen is the ``i_op->follow_link()`` inode
-method.  In the present mainline code this is never actually called in
-RCU-walk mode as the rewrite is not quite complete.  It is likely that
-in a future release this method will be passed an ``inode`` pointer when
-called in RCU-walk mode so it both (1) knows to be careful, and (2) has the
-validated pointer.  Much like the ``i_op->permission()`` method we
-looked at previously, ``->follow_link()`` would need to be careful that
+The place for all this to happen is the ``i_op->get_link()`` inode
+method. This is called both in RCU-walk and REF-walk. In RCU-walk the
+``dentry*`` argument is NULL, ``->get_link()`` can return -ECHILD to drop
+RCU-walk.  Much like the ``i_op->permission()`` method we
+looked at previously, ``->get_link()`` would need to be careful that
 all the data structures it references are safe to be accessed while
 holding no counted reference, only the RCU lock.  Though getting a
 reference with ``->follow_link()`` is not yet done in RCU-walk mode, the
-- 
2.30.0

