Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195C41F49C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 00:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgFIW6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 18:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbgFIW5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:57:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FEEC00863B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 15:57:32 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b16so202498pfi.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 15:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I8ffuKnAI6ePp72FbTqXndKW4mWsmd4YfaiykgykUjE=;
        b=ggaIRQep0r9gJKaPKzz5zfk2jSKqaYojEj7TqbGTeEGhi6jnwUsuWWBXbsRvtVLUIa
         4t9J+N5/UNu4Ti1R2tXux1oeDcnxz5wd5BEz6mgmzNx5+DLrPeUulrM/iklcpFFBvvKL
         Cmc2f9h0KIN4UoLrbP5IHbVNb5+Vg8MBFIH0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I8ffuKnAI6ePp72FbTqXndKW4mWsmd4YfaiykgykUjE=;
        b=oWxbxC9GLBD9wtXrmc4TRJoZBqlWrgVaspCzDOJSa81Hd0DX2rp98GF6blXevGe5Rm
         +CAaUxOCnrJnwtjDbAwWTkZHLl8mdu8JS1fXNIuSZdIsX5kY4so40EXOf6BTu5m5zh1s
         jDsr/MlA7F0hoxEV14mQpTTYVwcxqoe+Cn4j/p9HxaJ3OZAB6LxdKGEx5PsqAs4IlDrS
         1eYtiaIBj18sP+Pxj60HjpSh30AEQuY22xb7RFHRQieyqtrOeqGke4qRCM4LUF0aud0B
         98pziqoL8S2eKjI5EQU9pjR5dFsSSp2/rfhJArkQCaQ7wi/1VMnOfuRVMQXqeXsD7NZs
         g7aA==
X-Gm-Message-State: AOAM530bTXdsmufUnWBgvtBtDVcpFY97mWqWvIzyHK7sS3o/YH90s4yD
        OwIyOlPb4agcizVlvOg774dlOQ==
X-Google-Smtp-Source: ABdhPJwrq+BbJyVNoQDQIQYM/E9dbeyvZqllAsieA1UQyWozBug/ETQFIesWoN1TqS1km0emwF07RQ==
X-Received: by 2002:a63:4b4a:: with SMTP id k10mr217449pgl.135.1591743452273;
        Tue, 09 Jun 2020 15:57:32 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p8sm9104978pgs.29.2020.06.09.15.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 15:57:31 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v8 7/8] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Tue,  9 Jun 2020 15:56:55 -0700
Message-Id: <20200609225656.18663-8-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609225656.18663-1-scott.branden@broadcom.com>
References: <20200609225656.18663-1-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainer entry for new Broadcom VK Driver

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5985a7847316..28e3dc1d3244 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3656,6 +3656,13 @@ L:	netdev@vger.kernel.org
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

