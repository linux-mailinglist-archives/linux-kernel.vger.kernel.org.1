Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E4C26D91C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgIQKcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgIQKcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:32:15 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7FCC06174A;
        Thu, 17 Sep 2020 03:32:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b124so922601pfg.13;
        Thu, 17 Sep 2020 03:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jvpNYNAsaR7K96Y60w87EdlSXbMa7+RvJY5zUTthDhw=;
        b=gYbxZm60aTUJ4yKI84QVXJx5brg3Q8+j2HY76breh36GHdifS628uTGNpbs90WoUtu
         fKWdWtQwVH+KR9PhgtXsUSsTsUIf/H9CE8IscTVf6Lwbxx+Fb3RDUQZ6tsHUuxkjRCdn
         pAwttlzwMRrSaSI7sm3Hks09g+XTz5Ait2ei0eQht86VBxHQb/N9nSGH+AYeLy7XbHxG
         lrXrnRe5PaEiW2DAr2TR9DgAWwZBnM4V740Kxe1IEmR3Wv47zBnTZ1SZ29l0URkYOivg
         nrWB+5rQc9kLAMSnCE2dtS9nnPee3cQqegqzWxkTH4OYHtHE9kGhS+B6mbQX6J9s0K5m
         9x7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jvpNYNAsaR7K96Y60w87EdlSXbMa7+RvJY5zUTthDhw=;
        b=kZDlQaFJxLQ1KCofsSRFP4XElhnGsp7CRLIvl+0FNU5NuwvyJiV63Lw3H/H5WP91p/
         6/DIIDs34lngn7LyiKqiOIEpYFB1FSoZzJtxcT4/78qHx45s/FHEiNLbeArpNLz2b0II
         3fj+q5WXgCJH4nRpt5Vc71ReLT81FvFhfux38zyotlsEKRwoPItCZPWkrgxhpsmJmGin
         Ca/LeUWKbbOEQjpVhyOXoCzs8IWwJ2eoRITmy6uK0krUlMx8BhHRm0THCPbHeRnwRIaK
         /e6gKXezvWF2PsNeBc+uOxRXuzPuEC49Cj5738dE0VpNC+XVcMsBMQCVyY3iK3rwowO8
         Qtbg==
X-Gm-Message-State: AOAM530LTHRspgUMTNYevDgJup4Iuy9LgvNO8lBTZV2WUDjgKIIqNtQe
        GdnnNpJv87o94OzI1SJCXiG5vG3Ans5Qig==
X-Google-Smtp-Source: ABdhPJyDjOBrsuQv56DyQy222e9LwNBmZfGsdl9qUb4oVJ9ZCONmzKGW5Nyc6i2QDajCI6xnSzGP7w==
X-Received: by 2002:a62:7c43:0:b029:139:858b:8033 with SMTP id x64-20020a627c430000b0290139858b8033mr26410974pfc.3.1600338732145;
        Thu, 17 Sep 2020 03:32:12 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id e207sm21781927pfh.171.2020.09.17.03.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 03:32:11 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 2/4] docs: fb: Remove matroxfb scrollback boot option
Date:   Thu, 17 Sep 2020 15:56:13 +0530
Message-Id: <e5187e70faf8237825a142313802983a6c214baa.1600333774.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600333774.git.unixbhaskar@gmail.com>
References: <cover.1600333774.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 50145474f6ef ("fbcon: remove soft scrollback code"), the
framebuffer scrollback mode was removed, but the documentation was not
updated.  Properly update the documentation by removing the option that
is no longer pressent, and removed the particular scrollback option.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
Change since V3:
Following Willy's and Greg's suggestion ,in this version removing the not relevant 
hash and commit from the changelog and put a proper one.
 Documentation/fb/matroxfb.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/fb/matroxfb.rst b/Documentation/fb/matroxfb.rst
index f1859d98606e..6158c49c8571 100644
--- a/Documentation/fb/matroxfb.rst
+++ b/Documentation/fb/matroxfb.rst
@@ -317,8 +317,6 @@ Currently there are following known bugs:
  - interlaced text mode is not supported; it looks like hardware limitation,
    but I'm not sure.
  - Gxx0 SGRAM/SDRAM is not autodetected.
- - If you are using more than one framebuffer device, you must boot kernel
-   with 'video=scrollback:0'.
  - maybe more...
 
 And following misfeatures:
-- 
2.28.0

