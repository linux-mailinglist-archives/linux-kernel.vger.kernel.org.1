Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB1725E210
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 21:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgIDTlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 15:41:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55047 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726265AbgIDTlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 15:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599248476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMKjbUdhIVST6o3H3+0+skCoVkiZxquiNwTivuQ2ZEc=;
        b=eVaCyeKHCW6z5RabB5EXQeW62llyjWi0OUAlG/ha/T+H66p/iBGnhQgt/A0VhTk28haM9r
        rGEw4VeNX9VLXTh/ttsFJ1z3ooDa9dcnAp0XjhB/3d69Vyz42PrbcTj5peTJYKrGNKZBU+
        vRGkKfyhPCSDlzjlCGUf8ODeolSBNmg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-zLBI8lbqNiKbUAemSP9glQ-1; Fri, 04 Sep 2020 15:41:12 -0400
X-MC-Unique: zLBI8lbqNiKbUAemSP9glQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0945425E1;
        Fri,  4 Sep 2020 19:41:11 +0000 (UTC)
Received: from localhost (ovpn-116-173.gru2.redhat.com [10.97.116.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EA2610027A6;
        Fri,  4 Sep 2020 19:41:08 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2 1/4] ima: add check for enforced appraise option
Date:   Fri,  4 Sep 2020 16:40:57 -0300
Message-Id: <20200904194100.761848-2-bmeneg@redhat.com>
In-Reply-To: <20200904194100.761848-1-bmeneg@redhat.com>
References: <20200904194100.761848-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "enforce" string is allowed as an option for ima_appraise= kernel
paramenter per kernel-paramenters.txt and should be considered on the
parameter setup checking as a matter of completeness. Also it allows futher
checking on the options being passed by the user.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 security/integrity/ima/ima_appraise.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 372d16382960..580b771e3458 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -31,6 +31,8 @@ static int __init default_appraise_setup(char *str)
 		ima_appraise = IMA_APPRAISE_LOG;
 	else if (strncmp(str, "fix", 3) == 0)
 		ima_appraise = IMA_APPRAISE_FIX;
+	else if (strncmp(str, "enforce", 7) == 0)
+		ima_appraise = IMA_APPRAISE_ENFORCE;
 #endif
 	return 1;
 }
-- 
2.26.2

