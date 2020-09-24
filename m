Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A3D276615
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 03:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgIXBz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 21:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39516 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725208AbgIXBz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 21:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600912572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZExNcN9ug5K0DhQpYE9MsyS6I+rIfh6W0FuHaXr8nI=;
        b=WTbYKMoLJi11FzkY2zrvZNFJqc/9GF8Ek4cFYXUZlSJx2CQVKBtnrjLKjHXSNDj9TAQ4xr
        2yT1OAYG6fyXAbsmpy5/pyzeQEzNBjrlXjgOlmcYyyCdbS9+DirMnIGoanjI6LorLmzw9c
        ccWTEQhdk3rlPVWEBSO3Msy6+FZRrxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-R52empJPOZOb-kKhpFX5xg-1; Wed, 23 Sep 2020 21:56:08 -0400
X-MC-Unique: R52empJPOZOb-kKhpFX5xg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2C8E10082F9;
        Thu, 24 Sep 2020 01:56:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DB6C1001901;
        Thu, 24 Sep 2020 01:56:05 +0000 (UTC)
Subject: Re: [PATCH v2] docs: admin-guide: update kdump documentation due to
 change of crash URL
From:   lijiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bhe@redhat.com, corbet@lwn.net, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, vgoyal@redhat.com
References: <20200918080958.19841-1-lijiang@redhat.com>
Message-ID: <a088bff5-1174-25fa-ac26-6e46795f4085@redhat.com>
Date:   Thu, 24 Sep 2020 09:56:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200918080958.19841-1-lijiang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since crash utility has been moved to github, the original URL is no
longer available. Let's update it accordingly.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 Documentation/admin-guide/kdump/kdump.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 2da65fef2a1c..75a9dd98e76e 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -509,9 +509,12 @@ ELF32-format headers using the --elf32-core-headers kernel option on the
 dump kernel.
 
 You can also use the Crash utility to analyze dump files in Kdump
-format. Crash is available on Dave Anderson's site at the following URL:
+format. Crash is available at the following URL:
 
-   http://people.redhat.com/~anderson/
+   https://github.com/crash-utility/crash
+
+Crash document can be found at:
+   https://crash-utility.github.io/
 
 Trigger Kdump on WARN()
 =======================
-- 
2.17.1

