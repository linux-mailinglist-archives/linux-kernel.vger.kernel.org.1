Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79F3250991
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 21:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgHXTng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 15:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXTng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:43:36 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F1AC061573;
        Mon, 24 Aug 2020 12:43:35 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id y65so749250qtd.2;
        Mon, 24 Aug 2020 12:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AzOJico8/qMqh5XrPOsBzo3DODlYYxJ8T6teXje2stc=;
        b=j5cAOFhjod3Jr4iibRyDFaFNcAGyUZV4DEIiverC/4HNQKQ4AlEFy19TPJLBIVOPJ3
         F6c92KKdQrQharBINQ+/EozCRZ6tiXj6aluWbEjFeytQhMSEt6/hnZGVtxipX5DiyYGl
         riipWPFZvjzCtoUZQOksGIXpEmjfTetgDKOaVsnpUsfBDY8GugrNlaYKrpXhfhCeJLRN
         mWhRZ+krwq/fVUIt7pkITmZ1Gnq0U8+YzkwdSA0Gh9DwIH3IQAAC9Mr1nXIggm0UxiRr
         1QdIqijmey7tgK+hXWBve5fY8X7KHN+iB4Qtx0mYAhrMztCvVKv8qcpzTALyid7FqpN0
         dfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AzOJico8/qMqh5XrPOsBzo3DODlYYxJ8T6teXje2stc=;
        b=t028sGzs8EYoeUmjBAhtQaNAMcOMGhRbF7JZYXzRhi7kMFcgiRXl8CAa/wVSVOB4KQ
         o6FH6QIy3n/Ri48lsutTmnoOeM5VEKpK/p4PLgn32svWm7BJ9REIMiilbf76sgA3nf1F
         VU8SGL9W53cXHfMCJOTsQo86Oy6T6VdoIaWdKkA4eCvhUV+AT4jvKbGfUXoFZQJNJGz1
         jkjZJFVf06nQDqh3/T5yoZtt1FxHBMvCm0Un8hqkxlZ/5YNF9TOnLah9nLgQZDCMykQM
         Mv9PlhFhGmO8gSGWYNxSUS5Ki4Vr4xn7BSZbEP+dkjXkA71xTg/0VG8jM8Xbmr4T4OMZ
         7gdA==
X-Gm-Message-State: AOAM532XzWB2//B7T18KacHSryekTaeKBeaZEvD8OOaK/VHFZWTkqZhC
        uaB0Ov5NKI8AmlUlayiEgkA=
X-Google-Smtp-Source: ABdhPJx7RYuLiqsmBWZHFWpJqzjlDjAw/4dsdLEDJoihvKFGWjfDbYY5A29vkYSn8+MZK6cEp+O4WQ==
X-Received: by 2002:ac8:2a6f:: with SMTP id l44mr6324506qtl.278.1598298214884;
        Mon, 24 Aug 2020 12:43:34 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c100:b9d:e9aa:e42d:21e4:5150])
        by smtp.googlemail.com with ESMTPSA id c9sm10085584qkm.44.2020.08.24.12.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 12:43:34 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ztong0001@gmail.com
Subject: [PATCH] rnbd: fix uninitialized variable
Date:   Mon, 24 Aug 2020 15:43:22 -0400
Message-Id: <20200824194322.337375-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

variable err is uninitialized when bio is an error code

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/block/rnbd/rnbd-srv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 0fb94843a495..818eff323825 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -149,6 +149,7 @@ static int process_rdma(struct rtrs_srv *sess,
 	bio = rnbd_bio_map_kern(data, sess_dev->rnbd_dev->ibd_bio_set, datalen, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		rnbd_srv_err(sess_dev, "Failed to generate bio, err: %ld\n", PTR_ERR(bio));
+		err = bio
 		goto sess_dev_put;
 	}
 
-- 
2.25.1

