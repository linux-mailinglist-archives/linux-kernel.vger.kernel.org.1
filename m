Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C222C7543
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbgK1VtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53015 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729741AbgK0TrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606506421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=V+fxQ+9ZE4mMvoPeeRpISpaVS5sv+7iMxFHbjI4wlvg=;
        b=Qt8Boa+UprtWzusbLN9qGVZmjCcM0FhlVinjmLaM/yfzqVnWfJ8v0yjr3UmpoQ6gagORjN
        JUH0V5mgHXZyS4ACORArIZM9u14JASQoDGOjZey1lhzDBsOOzXIXbQPA+gdg2U9bJH5IGM
        x10e+2mmfyL8afqaVqp3z67XHDwYgo0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-SacEDdguM3efa66HEpDVdw-1; Fri, 27 Nov 2020 14:43:37 -0500
X-MC-Unique: SacEDdguM3efa66HEpDVdw-1
Received: by mail-qk1-f199.google.com with SMTP id s29so1525729qkm.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 11:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V+fxQ+9ZE4mMvoPeeRpISpaVS5sv+7iMxFHbjI4wlvg=;
        b=V9Q83lKsn1k2UaL5BcyB8EoG0vcYSiXRMygd5rMwGx0v3VVZED1414n80eniql+DUv
         c9Cw9RzL97Rvek+Lu12RnQTC4kg1l8Y1wtsAXcxxmqC93//yZZbgH9y/8UI5V5fp6phX
         lDTOL0miglPy5ZvFz3GgLGkc1nEBytYAoBDsrM8wUtnBC2HLusChJPWsBzz12GDcEbRH
         Cep6o1s65Ieie6AQkW42hwlEpntSZvqCqy4Umi7eCcrJM9SBgeJdLWFi9XBAwVRv4zlY
         S7HTxbvR3JZkf0X7fsWQgxpOq4oLCsKMh031ILmt2ITc2doX0/LTdSmilWnKQ5oT6D7P
         YRvA==
X-Gm-Message-State: AOAM530PlSg2AoBqMcc3487D6hvat8tRAxcTTVY7ebsiU/CDHdQJfVLA
        r+FEakRU+DbnKuG1R3ltY68bTcsScARJAYgtx61DbWs81R893Cz+NyKqizkUZ9JZ40sp+zeJT17
        Jxmx45D0F1VUVmCXj+qUBKoW5
X-Received: by 2002:a05:620a:a90:: with SMTP id v16mr9957744qkg.479.1606506216891;
        Fri, 27 Nov 2020 11:43:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6lodK6voISGIkjg9/FPTLrFucmHCETDXMNpIo6ewNM+fOmDKlJ1dM4RCPu/VocOlLLHaAVg==
X-Received: by 2002:a05:620a:a90:: with SMTP id v16mr9957714qkg.479.1606506216683;
        Fri, 27 Nov 2020 11:43:36 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l7sm6906770qtp.19.2020.11.27.11.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:43:36 -0800 (PST)
From:   trix@redhat.com
To:     bfields@fieldses.org, chuck.lever@oracle.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        davem@davemloft.net, kuba@kernel.org
Cc:     linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] NFS: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 11:43:25 -0800
Message-Id: <20201127194325.2881566-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/sunrpc/auth_gss/gss_generic_token.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/gss_generic_token.c b/net/sunrpc/auth_gss/gss_generic_token.c
index fe97f3106536..9ae22d797390 100644
--- a/net/sunrpc/auth_gss/gss_generic_token.c
+++ b/net/sunrpc/auth_gss/gss_generic_token.c
@@ -46,7 +46,7 @@
 /* TWRITE_STR from gssapiP_generic.h */
 #define TWRITE_STR(ptr, str, len) \
 	memcpy((ptr), (char *) (str), (len)); \
-	(ptr) += (len);
+	(ptr) += (len)
 
 /* XXXX this code currently makes the assumption that a mech oid will
    never be longer than 127 bytes.  This assumption is not inherent in
-- 
2.18.4

