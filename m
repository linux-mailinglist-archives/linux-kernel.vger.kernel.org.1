Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A4227F767
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbgJAB3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730715AbgJAB3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:29:06 -0400
Received: from mail-vs1-xe62.google.com (mail-vs1-xe62.google.com [IPv6:2607:f8b0:4864:20::e62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDDBC0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:29:06 -0700 (PDT)
Received: by mail-vs1-xe62.google.com with SMTP id a16so1844210vsp.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v8C+xMzu19xnyurAfDoVjIHgPVGUTo7XJO7a449p2G0=;
        b=aaLp9F1latX8O++aG+T597D7u5dIyffesbCVwsGqIcz1qs/qWWlBvBK40p/rFOzZ1N
         THoGliczyLiru+Yx5nODMGZmR3r6T/mGvX95KI0tXFkiGLyKP0Q4ZXInGIWskH9HsxN0
         ncWF2f4yfH3Yq2N5qnd+0ocRBiPjIAJIs9U2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v8C+xMzu19xnyurAfDoVjIHgPVGUTo7XJO7a449p2G0=;
        b=X63CgZLAabTWATab6S5YzUiy8JWHyeGvvHZa6lL6nby6lsI+rv8wZ1LCtsqupWWwrM
         NdOS7lfWc/8HZqLeq8kSuCZcTxRaKs3RcgoRZYxOpe3ozNJW42O1nl09TThwoDdBB1KO
         cjrjzTVR+I1dOBP1Ko9VSVPlJSuU6knPUoEtsnaymPKowU4ET+2W1ZXj22By/cEWkeLl
         NMbWy5L/o6qH/lWhDSvdOQm44c8GscuguQdouQJhhDCaQugSVvFe/Xt/urV/wA6Hxfzp
         ltQdErK7ClQuy7knmZnzqpT1fekldwP+juhtoz0PQcxe/XFHCihTZRNqEs26jYvXAWhD
         jJjQ==
X-Gm-Message-State: AOAM5327hSyku2DjqGxUEE73ipP91NOFPCjmuuQE7nXr1MSQilkFhirC
        +U+pXEzuCzopI77ENZYoSCWn6NjJ4NIVwmfuvhHbbqj1B9bi
X-Google-Smtp-Source: ABdhPJz3ZmJQzQRSKPdsscEPaQPFGg+WUYllQPOsP/oWJqC2xpW0mcYDsRID5Ptvy4NXTYcSemsXFqyUqbMn
X-Received: by 2002:a67:2645:: with SMTP id m66mr3570459vsm.16.1601515745660;
        Wed, 30 Sep 2020 18:29:05 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id r25sm520472vkq.14.2020.09.30.18.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 18:29:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v5 14/15] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Wed, 30 Sep 2020 18:28:09 -0700
Message-Id: <20201001012810.4172-15-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001012810.4172-1-scott.branden@broadcom.com>
References: <20201001012810.4172-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainer entry for new Broadcom VK Driver

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 190c7fa2ea01..ce88e423547f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3714,6 +3714,13 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/tg3.*
 
+BROADCOM VK DRIVER
+M:	Scott Branden <scott.branden@broadcom.com>
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Supported
+F:	drivers/misc/bcm-vk/
+F:	include/uapi/linux/misc/bcm_vk.h
+
 BROCADE BFA FC SCSI DRIVER
 M:	Anil Gurumurthy <anil.gurumurthy@qlogic.com>
 M:	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
-- 
2.17.1

