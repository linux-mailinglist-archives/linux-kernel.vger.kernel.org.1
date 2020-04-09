Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C87031A3BB4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 23:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbgDIVKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 17:10:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24159 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727001AbgDIVKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586466654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=77s3qEqZUXwYYItZCoNg0WQiFcIAKlBUF4mxWQL3Gog=;
        b=H3p+GdSTBswd8CXO5Kaj3eaaVtcczzwyit34fp8iQJ1Uj5dpR/PNzLK6scU/nFPiiloDJs
        h86cqnVykiPdjLmXGqIeDR0v2xGrGNxzhhzx69trAcDLLTqXTPZ+3SOc/bCKO6aS+ulqtW
        Oz84F9otIF9tOiH8sx9hRhJu5EWpIxk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-KOMyornROvGVbPdNlsZKWQ-1; Thu, 09 Apr 2020 17:10:52 -0400
X-MC-Unique: KOMyornROvGVbPdNlsZKWQ-1
Received: by mail-wr1-f71.google.com with SMTP id h95so7286463wrh.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 14:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=77s3qEqZUXwYYItZCoNg0WQiFcIAKlBUF4mxWQL3Gog=;
        b=plRTj0Feg8vWmRe4Kxxr949Z+zcxwdCVBme/V8pZ3XJks3dpFR6p470IoS+kjnR5gx
         XLy7AujH+kGQkrdlbq4YqmvrdN8PSPgFdi7Ds4oyiI0PDAI+f+hnfvCzT0w03mpMptlT
         qP+d6ErF7ccRa7pGLknZGFreRaR65WbV9pvYHY1texwly+V1Isp8Qksp0EzTN763bc/P
         fkykiZSzr5T+mFtNYJngF2JudJwkAhPtGuV8f19VFB+wVfQSSsKd0B3OkxNwSfYcJugA
         +w9EAUYnKtM9kHNYImSjK7m0PA68H6wr9EwvtZ32+RvmhuBmxCCn3h4IEB0l+anh/1oZ
         9mlw==
X-Gm-Message-State: AGi0PubISPxBa4NkI/mvTJddul7UXwaW/q1ezKACVh6NWbgJnMzJMr5Q
        VUYg3bVfvTJdqu27/npuSONlFp+0SiVlKgd5aElcmI2iDYYsIQ6Oljf3dYRZ5WE6z9THHCOo8Fs
        PKNwmlQmog0gmYWBAaxkaq21i
X-Received: by 2002:adf:e409:: with SMTP id g9mr1046824wrm.51.1586466651230;
        Thu, 09 Apr 2020 14:10:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypLy4PXbKq8mbP7kwgtN1Q+giosGvjsros8EbCALYN5EyYBQyGeYWvZCX+ftIrPSN/+taBS7uA==
X-Received: by 2002:adf:e409:: with SMTP id g9mr1046809wrm.51.1586466651031;
        Thu, 09 Apr 2020 14:10:51 -0700 (PDT)
Received: from redhat.com (bzq-109-67-97-76.red.bezeqint.net. [109.67.97.76])
        by smtp.gmail.com with ESMTPSA id f2sm6047650wro.59.2020.04.09.14.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 14:10:50 -0700 (PDT)
Date:   Thu, 9 Apr 2020 17:10:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] rpmsg: pull in slab.h
Message-ID: <20200409211045.12025-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to virtio header changes, include slab.h directly as
this module is using it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/rpmsg/mtk_rpmsg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/mtk_rpmsg.c b/drivers/rpmsg/mtk_rpmsg.c
index 232aa4e40133..83f2b8804ee9 100644
--- a/drivers/rpmsg/mtk_rpmsg.c
+++ b/drivers/rpmsg/mtk_rpmsg.c
@@ -8,6 +8,7 @@
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
 #include <linux/rpmsg/mtk_rpmsg.h>
+#include <linux/slab.h>
 #include <linux/workqueue.h>
 
 #include "rpmsg_internal.h"
-- 
MST

