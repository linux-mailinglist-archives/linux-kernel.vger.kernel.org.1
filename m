Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C072F5014
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbhAMQeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbhAMQeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:34:06 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5070C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:33:25 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id y23so2175290wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NGCZdsFKJWiEc3OQrxZt2hriTeRVybh3qyvM4UrUMLU=;
        b=x3xpkOkvIcybs/NjofIbtLA2wckcmEtmgx28mmK4aHpHBI1BXWLI8pZz0WzZzEGFCt
         lqb9OIvHhexUD4mfWZkNC9HKNG4u8r61+UT7vidDQ0USw4CtFRv7wOoZ6yawwktboz0B
         DtZnuCRPZssp9KwlxS+mZqPDoMk3HNCYWYXoCcDCC0uwRKeUH+uxsfeVFkIRv535v65r
         JAimaSzUkpIbn6vCwFp6MtfvJKog/6oDVS9WPVbk3Sx20lonky2prbv4H+zmmIwdifH4
         oUK4UcIyPRBNGtnj4urBndpJEoWpqfaFyPIZ9E9d9mnjVf/crprAtUUS58FUdvTa3dcG
         1ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NGCZdsFKJWiEc3OQrxZt2hriTeRVybh3qyvM4UrUMLU=;
        b=eWz9Zh+2lIvfFsjP9nBYKqyuhDnV4sKGRI3YhF+kj8lRK6VJQVBX2JlDraEVOkPrVI
         RmkbifauBuO5WqnDu9xDW3vQQZWLEpZh3AmBzQ1+JV3ei3zgg5VfqxJzC847AhpLmEcQ
         yLD0XC9ZyWlxPXUmgCOyy3so2Fu8C3yKG4XWJG/tuUtmfguqtcvKTOhzvlm3mRMqiU6E
         QSeBsO08imQK582Vj9RMrd9K+ywIBX66X0jnKktOgnd5bt2FKcMyqS1S7aTc6xN/igw9
         +3r/9HoGJnYNpcyyYQ0WHL4WuhJt9o9CbjxI+/9a7d+jsp6bSKU9UwNiEcaq38zY0f28
         lBQw==
X-Gm-Message-State: AOAM530WEU34iM9/o6s3rynS+drwpLvCud0CdgXDorQlU/b+VQqw/qNw
        az94l4SE+PytcKjpSJOvFfAiSAN/NXUEW9qx
X-Google-Smtp-Source: ABdhPJw2UGtEIs7agh31VQ/lw0viAuHQ+FpVDBi2NZ21ev+oHKJCh93ldbkuXql/kl2iO9+0gcM2mw==
X-Received: by 2002:a7b:cc8e:: with SMTP id p14mr70691wma.69.1610555604648;
        Wed, 13 Jan 2021 08:33:24 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id q7sm3843912wrx.62.2021.01.13.08.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 08:33:23 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v2 1/1] docs: submitting-patches: Emphasise the requirement to Cc: stable when using Fixes: tag
Date:   Wed, 13 Jan 2021 16:33:15 +0000
Message-Id: <20210113163315.1331064-1-lee.jones@linaro.org>
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
v2:
 - Link to the 'stable-kernel-rules' document as per Greg's request

 Documentation/process/submitting-patches.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 7c97ad580e7d0..7f48cccc75cdf 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -556,6 +556,11 @@ which stable kernel versions should receive your fix. This is the preferred
 method for indicating a bug fixed by the patch. See :ref:`describe_changes`
 for more details.
 
+Note: Attaching a Fixes: tag does not subvert the stable kernel rules
+process nor the requirement to Cc: stable@vger.kernel.org on all stable 
+patch candidates. For more information, please read
+:ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
+     
 .. _the_canonical_patch_format:
 
 The canonical patch format
-- 
2.25.1

