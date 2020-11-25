Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB6A2C42CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgKYPXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgKYPXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:23:49 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED232C061A4F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:23:38 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id x22so2326499wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2tAzY7WCaNY6Vvb3iCn3hNcrKN7+M/W71UmthXEquj0=;
        b=ahdV1J08h8ijqiIpyJ7lLCjZSxXDqfhGTm4u6jQFMjIK9AaOrjIm/KnjMGAclV0Je/
         da26aLlMx+70E6zhi53EH/ElutS0GekV0c/oIVLoGLmKA6zTiGkvQ7s6B29MvM0/Htd5
         PdVIuFOTS+aJSwlixZ42q2alN2v2qWqpeQuOqK7hwVfW6Csd5ys1oLsfy6Gq1751ZrBf
         GJ7fNiHRHdD7wUkekZJJlFec0txw5jDXl6OpRfat7wvqjdd8NDoapI0oypjsrBW/6hUF
         23TH8pCjUcxynvPYmRSpSIzovApGEhdLtJM7mppdoXHrFlZ5HXSh3WIev9er2Jb75VnN
         P+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2tAzY7WCaNY6Vvb3iCn3hNcrKN7+M/W71UmthXEquj0=;
        b=DqXt/67fhaXJ8NoaGsEaKxTauFtWu3oQ67YNdEngN2IRMgwemOAeQMPoAUMkpUjYEe
         WFDAy24RzTyzPX1VryCxP8k76iFaRVcASPCOXrMuK7bn1KeUH0P0egXyz5tzimf4XKaD
         vZAnQhQsqkSZppaitvcX8fNAQcVHgLCRuNHFjdXR9Xdea2PJCZI1cJBrW3DDR7J0aLLT
         JdoTqQakmbO7jYx2UtcRzoyuv2P3HBDurry4QVieTG99pcOIce2rtTkXahyKZ5EMwvS1
         enciB9bRkCvwsIrZZE6+FEh4/z1EscPN4S7CNLy7dh9HXAqVC7rOhgS9opcO+6RgugVu
         GfMg==
X-Gm-Message-State: AOAM533sU3S2EKkwedhtMJ8tOIIsUPS/GO8pJgiKX+VqFUaAwfyW5Hzu
        OZhMeQMOzXkWWtFXv3xsePhSGw==
X-Google-Smtp-Source: ABdhPJzMuX3OEQ69TChPMl3O5tQeOREoC/tcPHSTyQNeVl40zElt8TwQ3Wzj+Nq8Qz4+FC8hCh94lA==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr4587984wmk.4.1606317817738;
        Wed, 25 Nov 2020 07:23:37 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id 9sm4896731wmo.34.2020.11.25.07.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 07:23:37 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/4] configfs: increase the item name length
Date:   Wed, 25 Nov 2020 16:22:44 +0100
Message-Id: <20201125152247.30809-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201125152247.30809-1-brgl@bgdev.pl>
References: <20201125152247.30809-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

20 characters limit for item name is relatively small. Let's increase it
to 32 to fit '04-committable-children' - a name we'll use in the sample
code for committable items.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/configfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 2e8c69b43c64..4f76dcc08134 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -27,7 +27,7 @@
 #include <linux/kref.h>   /* struct kref */
 #include <linux/mutex.h>  /* struct mutex */
 
-#define CONFIGFS_ITEM_NAME_LEN	20
+#define CONFIGFS_ITEM_NAME_LEN	32
 
 struct module;
 
-- 
2.29.1

