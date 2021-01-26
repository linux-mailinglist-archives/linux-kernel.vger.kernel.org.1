Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F9030454B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbhAZR1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731671AbhAZHfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:35:54 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9895C061786;
        Mon, 25 Jan 2021 23:25:31 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id w14so9971252pfi.2;
        Mon, 25 Jan 2021 23:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkMx6uN8lWmUtLYO71VDmI1JwvTBB6dIeGricBGrvCs=;
        b=A5hMOm9Zzv2RPOifACzF35w2IH2GIqjlUIxbYdD1F7Df8ghNm+vH3BGwuPyR/WoST4
         blfAKqFV+UbPYnIvmStn0NOjYOsG+U3/JN5KVaJTKhRELveBdqNeIHq86mI1xhYbCL+k
         Jk3jZxla0qq/7YFT8aL7jVsvbk8p4VbL6eq71JJ9BCwchfnKjiopIX3OEetvgL/kFLki
         jd+d5lOQz3pAyXIW8a2WLvhKz63J9X7ngQin347MQZdp96YQA/mHgQy0W+iXasRohbVs
         bgHAiG2KgskLIkgIu/Ae0IFu2LAMTxM41aEIoZ523LA1EcSL5fLpTmRurhwNOvrpigER
         o7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkMx6uN8lWmUtLYO71VDmI1JwvTBB6dIeGricBGrvCs=;
        b=MBux7Iro00j/piEa1mazcLgSu/rjaLnzcY2imfwKvyHS80iEK+P1x0ZNcvJtV83VDB
         A4GfiGQutfv3j+ys/vdVMetCg/6GJj+TR9BQPGAiOm0YxU6a5qydD9KYXB53Q5cnUka6
         Utzpn9FB85Do1bAoda3JmCGJKe65FRHOX2YctTVj/wfZ4qEetBLFfeVf9WB800yMj6OV
         8fGZlaXdlTmMWSdVFSS2My07TbCID/9aSQOS76zfYyBLvTtI/nu6em93nRuTVsECnbVu
         bEorgkEiuFKdTsS8MNFGPIsrwd787lngEAGdChUOMeVbLPGHMiUqRCI5CtGY/gTNyZSY
         HYVg==
X-Gm-Message-State: AOAM531GIhc0viykhBzlfg5ihf6XPvWrLFrbVaQ5D6cdlq9od7YV2erf
        76OHDTaL7hmBMRSaYPbWb/KXALo6KKMqvgTyX/4=
X-Google-Smtp-Source: ABdhPJzErTS7B0J3JC5yvFkVtN+x92V62I7LmJlgpzQHPGWJq8JZ0DLcFZeG11pyabiYUJ7tBu0xBw==
X-Received: by 2002:a63:605:: with SMTP id 5mr4417532pgg.144.1611645931385;
        Mon, 25 Jan 2021 23:25:31 -0800 (PST)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id l12sm1320256pjg.54.2021.01.25.23.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 23:25:30 -0800 (PST)
From:   Fox Chen <foxhlchen@gmail.com>
To:     corbet@lwn.net, vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de
Cc:     Fox Chen <foxhlchen@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] docs: path-lookup: remove filename_mountpoint
Date:   Tue, 26 Jan 2021 15:24:36 +0800
Message-Id: <20210126072443.33066-6-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126072443.33066-1-foxhlchen@gmail.com>
References: <20210126072443.33066-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No filename_mountpoint any more
see commit: 161aff1d93abf0e5b5e9dbca88928998c155f677

Without filename_mountpoint and path_mountpoint(), the
numbers should be four & three:

"These four correspond roughly to the three path_*() functions"

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 Documentation/filesystems/path-lookup.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 1f05b1417a55..bc450e0864d6 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -654,9 +654,9 @@ restarts from the top with REF-walk.
 
 This pattern of "try RCU-walk, if that fails try REF-walk" can be
 clearly seen in functions like ``filename_lookup()``,
-``filename_parentat()``, ``filename_mountpoint()``,
-``do_filp_open()``, and ``do_file_open_root()``.  These five
-correspond roughly to the four ``path_*()`` functions we met earlier,
+``filename_parentat()``,
+``do_filp_open()``, and ``do_file_open_root()``.  These four
+correspond roughly to the three ``path_*()`` functions we met earlier,
 each of which calls ``link_path_walk()``.  The ``path_*()`` functions are
 called using different mode flags until a mode is found which works.
 They are first called with ``LOOKUP_RCU`` set to request "RCU-walk".  If
-- 
2.30.0

