Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FBD215F05
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 20:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgGFSuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 14:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbgGFSuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:50:09 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C93C061755;
        Mon,  6 Jul 2020 11:50:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l63so18772096pge.12;
        Mon, 06 Jul 2020 11:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zAMnwEL/tvrQbQoilRczoLI0yzSxDe94r+ZB0fk0iKI=;
        b=pPzgZ6lctESCf4yNSZvocgda48XgdgEV9pxgJHB43CKb5fzBDvle7NpL9VgmCQrYIA
         oh2sEwrVWxY364GuCglJI9bhVz1ua/hgc6RSIWmOEMWhGe1n2OA2PpbXAHw69+b2IblE
         PXhHhG8/KmmNf08+MKwIpafaTZWbt6apgzLrZx/AXAkltuBjukuCGgm4CAJ/HKXhhXyq
         a/K6N8vgTIaitj8ddbqWy2cSTnGcEPNfre7rcta8F+/FZeITOAE66/pkCTsy2jbmTpVY
         6FZpzSZwa6ibK5uc2hXCODkLBR9tbBssojMJklECyNE19TRIK4xpzkSaYnU9q8HC86YY
         c6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zAMnwEL/tvrQbQoilRczoLI0yzSxDe94r+ZB0fk0iKI=;
        b=FfbSu8FmdP8827eNI+h2Hw8ZKnO4c4mO/PoY9Wd76jjpqghFb/AUtSW6fznLPjuMF0
         pu9DTgp3ODAspfLXIxMUmJJx9QwqoJ+U/hBSM8pz4yDxAFhevXaBf4AJuOz48PBQtd+u
         YQkJzDAHSJwHWTwKp4jfmaj60gP5mTVDP+2973ZqnYHtLInhXcl7hnHNLp9FvqRaVTdZ
         o88eeT2dFTLTEbspIQVkv09G5FQRcy852TWSsgNfnHmWuvxxQMCqXELcMnMCr/ZO98mK
         3bsuHZA49FLhcK5ieU2rQ9iqTTy5d7BbLB6hk1XiNhMzj4CNJIlstwVbInUOovwinZgK
         OAYQ==
X-Gm-Message-State: AOAM531tsJUDWb70LzghBcmgytHDcEcD+GSsT9F9nfLuIhgrZ3ELpKxO
        97krwSW+Pz6Hpvlw/lH/iCxeL8n7rlM=
X-Google-Smtp-Source: ABdhPJx8jqUNnxr33Dd0Sxj14TdJZMYzGKpNHJEeiBKN9vydCiKtSnozIg/wxuZYz3AvERlasC5j3Q==
X-Received: by 2002:a63:4521:: with SMTP id s33mr33563250pga.388.1594061408416;
        Mon, 06 Jul 2020 11:50:08 -0700 (PDT)
Received: from localhost.localdomain ([210.56.100.149])
        by smtp.googlemail.com with ESMTPSA id f131sm20634923pgc.14.2020.07.06.11.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 11:50:08 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Security: Documentation: Replace deprecated :c:func: Usage
Date:   Tue,  7 Jul 2020 00:19:56 +0530
Message-Id: <20200706184956.6928-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace :c:func: with ``func()`` as the previous usage is deprecated.
Remove an extra ')' to fix broken cross reference.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
V2: Remove ``quotes`` around function names
V1: Change the subject line and remove deprecated :c:func: usage
---
 Documentation/security/credentials.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/security/credentials.rst b/Documentation/security/credentials.rst
index 282e79feee6a..15175b11336c 100644
--- a/Documentation/security/credentials.rst
+++ b/Documentation/security/credentials.rst
@@ -453,9 +453,9 @@ still at this point.
 
 When replacing the group list, the new list must be sorted before it
 is added to the credential, as a binary search is used to test for
-membership.  In practice, this means :c:func:`groups_sort` should be
-called before :c:func:`set_groups` or :c:func:`set_current_groups`.
-:c:func:`groups_sort)` must not be called on a ``struct group_list`` which
+membership.  In practice, this means groups_sort() should be
+called before set_groups() or set_current_groups().
+groups_sort() must not be called on a ``struct group_list`` which
 is shared as it may permute elements as part of the sorting process
 even if the array is already sorted.
 
-- 
2.27.0

