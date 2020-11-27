Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980232C6BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 20:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgK0T3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 14:29:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730301AbgK0TNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606504338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=/OfSRiSdXUFrNn7G7mwPl2JALGJnETCzdil67iB91AE=;
        b=fiHRRxxZUy+UfTxvH2fnOL73eE/AeaouI0wPoJXr8lKKJxabv9zTNriBtaD44UedTrvo8i
        tCexWOgvBBMJredL7oAkgUuYOfUdqgTF8/Q0ME8KwWcLFSd4s5fJro8uMT3lMPFEgxaWih
        G9AEvi6ezE4TGlAqlqaxwmQ6JfCk5g0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-3wecfdUGOKyMDjJv5UX7mQ-1; Fri, 27 Nov 2020 14:12:16 -0500
X-MC-Unique: 3wecfdUGOKyMDjJv5UX7mQ-1
Received: by mail-qv1-f70.google.com with SMTP id v8so3552902qvq.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 11:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/OfSRiSdXUFrNn7G7mwPl2JALGJnETCzdil67iB91AE=;
        b=ZUIjXh+OnEFjaiAqpDu7rpbdVhUIPhd4vqV0fBSRKpPKhGI42xGC3/kvDC2WuKovCw
         +icJeqWql56mJ8RBpzDen/TLi2oVbr0eayeFKf41XyCeY8ssKhQowiXo2feU89W5AFyM
         7uTbV9lpEhKw1tvQ0mwl/uXLJIvm9RHtblnb5mA5li40OJ7N0UVkTHEwaaBgz3iYVCzC
         5a67qAglxw5XJnCzgPqk0X4wUlahHP4j4P2V+akoy/rU/PrRQwo1pitGwnhkwnu6UUsz
         pRMUVsjCr/1LPbsLcRsEYJy9kxe5cKlgXidoYB+obUqc8tF53c0bGenkYqYx4h3gUZRN
         pyzA==
X-Gm-Message-State: AOAM532SlEMQ5LMMLo9UX1M9d4Yhbnze7ZM7lzsbZmV+137s9FfygY8P
        kKdU9VbH3zWYIbUVgMtkB7gcUSbbcMYE5NAdK5x9+iY06HIwAHBlO3H8RMV7zLi63uHx1T1yiS1
        4tgxTPXVeILm6Dq3i2KitD/uU
X-Received: by 2002:a05:620a:11ad:: with SMTP id c13mr10107611qkk.399.1606504335594;
        Fri, 27 Nov 2020 11:12:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTxu7hFBg6fRSAhPiAUlYAUojVzSfjok+SdyqO5ystGrlFnNwWp/2495RDw2iPRZv78PWATg==
X-Received: by 2002:a05:620a:11ad:: with SMTP id c13mr10107591qkk.399.1606504335419;
        Fri, 27 Nov 2020 11:12:15 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i9sm6688165qtp.72.2020.11.27.11.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:12:14 -0800 (PST)
From:   trix@redhat.com
To:     rpeterso@redhat.com, agruenba@redhat.com
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] gfs2: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 11:12:09 -0800
Message-Id: <20201127191209.2850758-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/gfs2/util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/util.h b/fs/gfs2/util.h
index d7562981b3a0..493020393ceb 100644
--- a/fs/gfs2/util.h
+++ b/fs/gfs2/util.h
@@ -162,7 +162,7 @@ void gfs2_io_error_bh_i(struct gfs2_sbd *sdp, struct buffer_head *bh,
 gfs2_io_error_bh_i((sdp), (bh), __func__, __FILE__, __LINE__, true);
 
 #define gfs2_io_error_bh(sdp, bh) \
-gfs2_io_error_bh_i((sdp), (bh), __func__, __FILE__, __LINE__, false);
+gfs2_io_error_bh_i((sdp), (bh), __func__, __FILE__, __LINE__, false)
 
 
 extern struct kmem_cache *gfs2_glock_cachep;
-- 
2.18.4

