Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326602A084F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgJ3OsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgJ3OrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:47:21 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6704C0613D6;
        Fri, 30 Oct 2020 07:47:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k125so2721568wmf.0;
        Fri, 30 Oct 2020 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zUO5L8kmRzG695X/RNL/pM4ak1YR1L4D/l4ZGPiKS4s=;
        b=MwEdcgHri63X6/zT4qETBnCFUxXPSOp0QZQDn7N6gV2mUSRWqaX2Sl86N7s73XyyX/
         hVmmLdPeRjWMq0ECnGE9KITW3ub00SdtWXfTXXdrB5RQK12j2C6D5tSXM/uK874jB3g/
         frrogVDPPf+Xd+5V1pU5vnZlLA/NqTc/64xwFY8XT7aOlEQbS4P8ONrT8UwzzM+vpGbO
         0QmlFr8qAuQ18WVIGORA1ydY2RjPJxK5wrIT7a3pJXu/UEg8rJz1gujho/NxvUjq4NCa
         GllFFVgFOae3txoe4peuW6LKIxNVy+YDh3xC2LyOE868W9DKSq6udM6KeaUH3CoRRYc0
         v64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zUO5L8kmRzG695X/RNL/pM4ak1YR1L4D/l4ZGPiKS4s=;
        b=D7rc1mzUpkXsQk62zjwRn2idCy4KUpXR/KdjPJy+7AKFJ6cpe/ondZ0Dcjlx48XVre
         ILFC/IKautH9zT+dbFbACeLOrV6Zu1FqVD4uS8SRflB1KK5CxrDE0d2VEQ9wCZPtFyxE
         3NmST4loSV/CdaVUayFsAUbs1mQYrnhrMVF+huEkDhzJJui+ALceP/WydPiFewlCSFEA
         2U7ZDP2fiGnUbp4qrpwAQVrE+Oi+6O2agQSh5nivW5/bHof4+ZQPaUQW4pVEtybtCfKc
         WkDO6a/Sx2zeitmY1vQqCo3iwWFfeM2jwdSvhsbqIYQUod0CWUo2lXwMJHqfABWEAx6o
         vnrg==
X-Gm-Message-State: AOAM532LQjiwRN/kQ0jZpLphZW8U5/w34xKtsDleHD7vymUlkbWjHCey
        ZJLCiZGIOOzZw9XvheQyY0CXYfDge0k=
X-Google-Smtp-Source: ABdhPJyzxDkBZiBsJYDrfCsgqEI1far515sbaNTQRxLUQe6vYaik0FWVX68HwfGKp4i6KXSJvOJO9Q==
X-Received: by 2002:a1c:9e12:: with SMTP id h18mr3080430wme.11.1604069238122;
        Fri, 30 Oct 2020 07:47:18 -0700 (PDT)
Received: from avogadro.redhat.com ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p21sm5058785wmc.28.2020.10.30.07.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:47:17 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net
Cc:     Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 2/2] kernel-doc: Handle function typedefs without asterisks
Date:   Fri, 30 Oct 2020 15:47:13 +0100
Message-Id: <20201030144713.201372-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030144713.201372-1-pbonzini@redhat.com>
References: <20201030144713.201372-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eduardo Habkost <ehabkost@redhat.com>

Example of typedef that was not parsed by kernel-doc:

  typedef void (ObjectUnparent)(Object *obj);

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 5b5caa7642f7..1a9c918aa653 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1302,7 +1302,7 @@ sub dump_typedef($$) {
     $x =~ s@/\*.*?\*/@@gos;	# strip comments.
 
     # Parse function prototypes
-    if ($x =~ /typedef\s+(\w+\s*\**)\s*\(\*\s*(\w\S+)\s*\)\s*\((.*)\);/ ||
+    if ($x =~ /typedef\s+(\w+\s*\**)\s*\(\*?\s*(\w\S+)\s*\)\s*\((.*)\);/ ||
 	$x =~ /typedef\s+(\w+\s*\**)\s*(\w\S+)\s*\s*\((.*)\);/) {
 
 	# Function typedefs
-- 
2.28.0

