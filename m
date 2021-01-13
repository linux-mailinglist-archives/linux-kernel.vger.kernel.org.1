Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DF22F4D10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbhAMOYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbhAMOYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:24:37 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93D8C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:23:56 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 190so1770991wmz.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Td/hCZTImHCFfn7I9NMHTC6SnVd0rI2LHAoKiSHSGRI=;
        b=fbUDkDP/slYttuIBNGNx8xoUSvoR+GMLiLuH2zv7hH5Lz6XJ5uxT9Rdgo+baCX7UB7
         /ZtFGVuBLNBh+WGpl2RheTIAbcAeAo1eRavxM4TiOD791jlkjeJ0EAMY1pFO0jJWp4Tx
         Q5V9Jvz2nw60MpFa21p8RLn1ixt4K3x5pz6P56FpuKjgugBYYvTqZNK3fdJvesfmkGa8
         iCsiGzaKotvl7w0/y9w0ELTSz7xUDVd+VjmtflpPc0SL0TTXfG9yPXWtZAx1G7jAkrsl
         GG0f2ZqICZkBltMPuQFWSUZYhdt7lhHay7x0Nxnc4Ouff+joHuZVDlBhufN1JyZmWtLT
         ssZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Td/hCZTImHCFfn7I9NMHTC6SnVd0rI2LHAoKiSHSGRI=;
        b=iz0fk0srtPxZihlypm5hFYgduuVhC3TrEodAAl4kLPIyRMQHb/XTpEVyv4DvOKviud
         JY3CvgWFvPtrFP/8f0Hy2/RLY/1vvhOy1NhlSwKiXzTmgsKPLNjO3dY/mvw6SychEfZ9
         JtUc8Hzv7CtB/aFEM1BCGLEtF4PpQVtkJXiDke7TK7jQmIaUjD/MDVk5ywBHbJ7Q/PcY
         +SWuFIBCYVF7hrClzFhqj/6dMJAPmPhzgjm0KlMEKZIMwIpq1L0/b98z19DcNb9DGzvZ
         9EDvwD4kma0PW1WMtKXpX9M4JLdFtXabQtY/9bRdT4eJARwM9vwoainn4P3w3WZMNfV/
         tGlA==
X-Gm-Message-State: AOAM531RHM7QAORQHDkMRtdlCaNDjw5eHmX3Z8Y1yr7q43yGMo0d3xL0
        NQxoGL0K931ZsywHtM5xeVbOk+0BMtQCQDOC
X-Google-Smtp-Source: ABdhPJzf6LUGgt0M3eLLOrgKTAxF2rSt7rUSZxEbwj/IsnQ0A/emTAD1L+zAf9mwLdeCF3eSZczSaA==
X-Received: by 2002:a1c:bc41:: with SMTP id m62mr2487304wmf.46.1610547835745;
        Wed, 13 Jan 2021 06:23:55 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id b9sm3636523wmd.32.2021.01.13.06.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:23:55 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 1/1] docs: submitting-patches: Emphasise the requirement to Cc: stable when using Fixes: tag
Date:   Wed, 13 Jan 2021 14:23:47 +0000
Message-Id: <20210113142347.1263024-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear-up any confusion surrounding the Fixes: tag with regards to the
need to Cc: the stable mailing list when submitting stable patch
candidates.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/process/submitting-patches.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 7c97ad580e7d0..636ef067c1565 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -554,7 +554,8 @@ is used to make it easy to determine where a bug originated, which can help
 review a bug fix. This tag also assists the stable kernel team in determining
 which stable kernel versions should receive your fix. This is the preferred
 method for indicating a bug fixed by the patch. See :ref:`describe_changes`
-for more details.
+for more details. Attaching a Fixes: tag does not replace the requirement to
+Cc: stable@vger.kernel.org on all stable patch candidates.
 
 .. _the_canonical_patch_format:
 
-- 
2.25.1

