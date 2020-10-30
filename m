Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A55E2A0854
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgJ3OsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgJ3OrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:47:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E38C0613D5;
        Fri, 30 Oct 2020 07:47:18 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v5so3097701wmh.1;
        Fri, 30 Oct 2020 07:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yv878rTp+0D5cIZqocum8pL6tSDhQfB1mTNsXlZia/Y=;
        b=Qf9/fa8h74YiCbs7zwnGcwOpz6o1PwzN9PTPXA3VPMQQtAIYjMHodiQhCPfMn0eiIC
         qFpqraDXJB+/hCxq7GMciGXKTYoVEYi5nnzshZblc0tRtbfgpCETM1tTa55FVrRjdM+K
         /4fC5b+uNyDEc+ShErN/X2rHwA62jn4WaIBbjKqt3HJVeQoBSnm3iBbvVd8Iku33E6eU
         +2QTdSmIHXXbC1C9iP3F9OKZBoLrawGVLfnrB+wpR9T+01a5wZ//eLHI+hh5KyJ0wOLk
         PSOxSuKEUfCsOFIAT1lLiKdMzUMCZQyvH3WME8RVNZaFNiMWLNxh59wlGRWIVwnk2lRm
         S+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yv878rTp+0D5cIZqocum8pL6tSDhQfB1mTNsXlZia/Y=;
        b=XB1RHv+LhqoQM6foVwQio5BQPmsnPNImwtbMyjAEFEtv+/wyFU/e3fwNpUL1naGu8K
         eVs8qleedAVlqSs+1zgoyKxiHsZcjwVG4XtJ3D5uuhDJMry4lCYykSB/lUxo5N/BpHtU
         iF6CjV22K1sVLyokFeBspSdRL8QuqAU8AgpOahoV2qHkYV04XoToczqelO7irbC0bBvG
         TSOFnwyDXmCeeqxoYpzjYIIpdjh2O235BEb0VbLSORtgo3Aq32EBuWnWO2IuNdcFbyXG
         x+V0EGg0U6GNlBUhuApJC+IDoHKmQtRmnC5mm9By8AquHaPxXXB05tUJ4xDu0Xwl4ZfJ
         PBlg==
X-Gm-Message-State: AOAM530uQt381fNUJR2USHG7htl/BktZQPwUoCI8tnvXDKsY8E9gG+iP
        MsVvwdjPa+hCj63xH1inFML8D4tpjIo=
X-Google-Smtp-Source: ABdhPJzTTKLP1QTAVhwJcksp2JlOiPZqM+tT7gG7SIRUNgDcbllgwaXbp91W+jyVullmRTprpvNu0w==
X-Received: by 2002:a7b:c7c9:: with SMTP id z9mr3069054wmk.136.1604069236541;
        Fri, 30 Oct 2020 07:47:16 -0700 (PDT)
Received: from avogadro.redhat.com ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p21sm5058785wmc.28.2020.10.30.07.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:47:15 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net
Cc:     Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 1/2] kernel-doc: Handle function typedefs that return pointers
Date:   Fri, 30 Oct 2020 15:47:12 +0100
Message-Id: <20201030144713.201372-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030144713.201372-1-pbonzini@redhat.com>
References: <20201030144713.201372-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eduardo Habkost <ehabkost@redhat.com>

One example that was not being parsed correctly by kernel-doc is:

  typedef Object *(ObjectPropertyResolve)(Object *obj,
                                          void *opaque,
                                          const char *part);

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/kernel-doc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index f68d76dd97ba..5b5caa7642f7 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1302,8 +1302,8 @@ sub dump_typedef($$) {
     $x =~ s@/\*.*?\*/@@gos;	# strip comments.
 
     # Parse function prototypes
-    if ($x =~ /typedef\s+(\w+)\s*\(\*\s*(\w\S+)\s*\)\s*\((.*)\);/ ||
-	$x =~ /typedef\s+(\w+)\s*(\w\S+)\s*\s*\((.*)\);/) {
+    if ($x =~ /typedef\s+(\w+\s*\**)\s*\(\*\s*(\w\S+)\s*\)\s*\((.*)\);/ ||
+	$x =~ /typedef\s+(\w+\s*\**)\s*(\w\S+)\s*\s*\((.*)\);/) {
 
 	# Function typedefs
 	$return_type = $1;
-- 
2.28.0


