Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E6E281DA5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 23:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgJBVZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 17:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgJBVZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 17:25:13 -0400
Received: from mail-ua1-x964.google.com (mail-ua1-x964.google.com [IPv6:2607:f8b0:4864:20::964])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D0EC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 14:25:13 -0700 (PDT)
Received: by mail-ua1-x964.google.com with SMTP id o64so760449uao.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 14:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v8C+xMzu19xnyurAfDoVjIHgPVGUTo7XJO7a449p2G0=;
        b=bz2XJfhTqewVONYQP57SYcXydOAIdRQTmOBlqjqIq9SGxh7JNCIq98VFBrfwRled1G
         UJ2s87Pf5e65RmoP4c9JDrkVR2s8YOGXiSTZ26h0uu2oEb5i4caeCIKlWzxztzzLkh49
         1MO+UI8FIdVwqSO+oZvs4gCkpUUpHVnguhaEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v8C+xMzu19xnyurAfDoVjIHgPVGUTo7XJO7a449p2G0=;
        b=t3YVn7ZZvLytuWqjNdrtu6jtIehIhqezzBkyT/ee9NHBhr8J0f41+ekMCKGmS1vT1U
         UjTMksXaTCQuR17n3x5ro6iovHV2xV9U9dmhtrbIxcZ78L8/NZ8XkWOKAYEMn4P/pvB3
         4+eQ6jF0P6x8Q1z3s5d4/LWZ3nRnYum3APp9JgGn0J3bxro0P4TQoRRIVUgyJy+Iwy6+
         SlYzSKLmERKwrU7aZ1p1T4WSGvgleWNfMtmV8Wm9vhV7hUC4xg1t+f1kS8pU6/jn8yBC
         HOcqLINFbuKU1k1tp2nbLfb2FnSfyWqjyoVvmUqfkxSKPc3C284hc0KrwH3wnheUEbXa
         sqKQ==
X-Gm-Message-State: AOAM531Kf+5VABJNZOvPX/VHg+MAMZvVcydekS09xlBJkcWIjxNW50hr
        QW6U2wX0NeJ7VhdYIrQNvrRGQfl6XnKKyELnJ2UDNFc9Xe8M
X-Google-Smtp-Source: ABdhPJzzxOOD4eTOKWO5ifr0rfYKt9t3nJOl6E+owSyfjlef9S1kpwEiKGFFNT3Zrf7BdvZ15hnzCwFsnsRB
X-Received: by 2002:ab0:71cb:: with SMTP id n11mr2342402uao.4.1601673912380;
        Fri, 02 Oct 2020 14:25:12 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id x2sm327292vsn.4.2020.10.02.14.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 14:25:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v6 13/14] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Fri,  2 Oct 2020 14:23:26 -0700
Message-Id: <20201002212327.18393-14-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002212327.18393-1-scott.branden@broadcom.com>
References: <20201002212327.18393-1-scott.branden@broadcom.com>
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

