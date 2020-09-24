Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AC9277160
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgIXMqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbgIXMpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:45:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AF1C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id s13so3382935wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aGwLdcvj6Ahf469gIHa2La7giDt0xQpNJNeb3LZxHKY=;
        b=s2/CSrd5AP3ygCQjNwYK3TB2P7QahdZupBRG6+zKM01DhKdbyGJc9ihPAJXX6JDlOK
         3Q6KNCiNVVN8sD/Trv78tzxbff2zQjdHB1FvqhUtKPPaOq57xodLdzMfqSBfH+O030A0
         An1nc1pvevGMn8z4D0XhWDW2b6MxnmHT3a85QOEOEYfm6mXFMWr2FSrICGyH+mfNUh4l
         gQ1NNfM4+g6E+pQoFRukUht8awhqEwwGCzAYMsXgyEaEw/dmoC9Q5rUnz2/ltBUwXBR7
         +OUyWk8FvDbk8ko5yHbp33QtPGwtzbo+IJxZ/CbIAUIyc3zzS5wqh4aPl1sIA7Fbsusv
         DXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aGwLdcvj6Ahf469gIHa2La7giDt0xQpNJNeb3LZxHKY=;
        b=GlEPaj1rOlfev1m/EGm/bgsSwDd6Xs9q2k6sYV44Be1tkuirl+9VhH1wL0/KpTEgY+
         JJ9VSXc5bkW5ixyR0tafO0ZaruHzf75g4N58QzInJ/zyh+GZoRHCL3NKY810MqL8Cpe0
         LRQk1mCVaj8lgIdSMYsecuRh5liiSRo2mT9Sc7bj8fcE0QqBJrBFT29YtB2c/jUtlTxG
         U2rQN3DDlNdtS2ACoY2fpz51+UeuFH5pLRedlwYuTFjmMBTNzA6CySAVP2gOOuAqVXJr
         Cunl1M+KmGPM64LPioBjXxoSDNwXssUYCm0eIEnb7z7CvGiSXPpSKh1/PYePlOMUkc4D
         beyA==
X-Gm-Message-State: AOAM530HM728InOtktBU+gwzILMr2bvJc9wTCCsVZHmAHV/KvWynldLc
        1QrDwHDf0qrUaHdoGu6tii9cAGOgOqmXPw==
X-Google-Smtp-Source: ABdhPJw/jrQmyqY1AVqMdbnQqjS2UwxtZ2omNvLI5cf/h1mAZ3kSGYtOFVHueeIjHCU7lSdcLrBeZA==
X-Received: by 2002:a1c:2403:: with SMTP id k3mr4430501wmk.153.1600951534383;
        Thu, 24 Sep 2020 05:45:34 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id 9sm3316834wmf.7.2020.09.24.05.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:45:33 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 01/12] MAINTAINERS: add the sample directory to the configfs entry
Date:   Thu, 24 Sep 2020 14:45:15 +0200
Message-Id: <20200924124526.17365-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200924124526.17365-1-brgl@bgdev.pl>
References: <20200924124526.17365-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Code samples for configfs don't have an explicit maintainer. Add the
samples directory to the existing configfs entry in MAINTAINERS.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d746519253c3..6bbe4cb67331 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4407,6 +4407,7 @@ S:	Supported
 T:	git git://git.infradead.org/users/hch/configfs.git
 F:	fs/configfs/
 F:	include/linux/configfs.h
+F:	samples/configfs/
 
 CONNECTOR
 M:	Evgeniy Polyakov <zbr@ioremap.net>
-- 
2.17.1

