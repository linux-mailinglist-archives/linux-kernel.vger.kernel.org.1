Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4452329F7F4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 23:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgJ2W20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 18:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgJ2W2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 18:28:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED610C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:28:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id e15so3576453pfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cQPEBSc4NVlgojJS5i+BxDjUviZYgnAfwhTdgWlQWYU=;
        b=eHaTZz0d34yFHVskjhumAcjieq7bkhdku+eRWXeaSBtw9YM3r5QnmjniW42FXGtUk4
         LPefxZrgcgI43gzHJbcLAOBfQjOrDUh0XodHLjbW4HIpEpMkxBi250ut1tB/B85C0Uf+
         1GPZnlnJ+I56CJ+VfGGQRlLrnW5y8jhHFwv54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cQPEBSc4NVlgojJS5i+BxDjUviZYgnAfwhTdgWlQWYU=;
        b=Q9NS+ea+DZxQHufX9VhBJOvO6OS/nQjV6wQS01/eeGEH7TOWbkueU09hpoKx0B5Kkf
         IRWSXAzj69b/+PFQyD1Z7h1nbIZuzPSrP9dkevxWJHbgWjWdu4GP5qCK5Vq6INE4O6gF
         6xo4mFZGv6Ifjzp1Z2Hk596cQf5Ke82hCJDSNVeRiYRJK8fV/+eley1OxiitXfHdR1Es
         qk1kvkeGF37PGXD2skOgjXBQdLAWRt3zZ3pXjQxkgH/RcnpUxb+8Q/E15qsVmwQtZL2Q
         gXWMacyYlMkLbqHaClB2WQL7Q1D2mauaiGteZXUo3/eGaa9pqLJCjX9lhLO6so+83BRL
         MmDw==
X-Gm-Message-State: AOAM531VwoU8A68FxmAxl4JJ3leogKyqjsaYZArXeWueotzc+lxcC/vW
        TzYjGlZFLJGAoUyZ6pfQs0govF/lu3tuUg==
X-Google-Smtp-Source: ABdhPJzsQlGxjIm6YACRQaqn4jx3aGY9+8JEp+MI+QTixtszRA6lL0IGMj0TQeLDiyL4iLSXBqBk+w==
X-Received: by 2002:a62:aa0f:0:b029:162:ecc2:4d44 with SMTP id e15-20020a62aa0f0000b0290162ecc24d44mr6461645pff.52.1604010505314;
        Thu, 29 Oct 2020 15:28:25 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id f5sm3573886pgi.86.2020.10.29.15.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 15:28:24 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, dzigterman@chromium.org,
        alevkoy@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 3/7] platform/chrome: cros_ec_typec: Clear partner identity on device removal
Date:   Thu, 29 Oct 2020 15:27:34 -0700
Message-Id: <20201029222738.482366-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201029222738.482366-1-pmalani@chromium.org>
References: <20201029222738.482366-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The partner identity struct isn't reset when a partner is removed,
meaning a subsequent partner can inherit an old partner's identity VDOs
before discovery is complete. So, clear that struct when a partner
removal is detected.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- No changes.

 drivers/platform/chrome/cros_ec_typec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 2665d8125910..faef56bcb9c5 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -181,6 +181,7 @@ static void cros_typec_remove_partner(struct cros_typec_data *typec,
 
 	typec_unregister_partner(port->partner);
 	port->partner = NULL;
+	memset(&port->p_identity, 0, sizeof(port->p_identity));
 }
 
 static void cros_unregister_ports(struct cros_typec_data *typec)
-- 
2.29.1.341.ge80a0c044ae-goog

