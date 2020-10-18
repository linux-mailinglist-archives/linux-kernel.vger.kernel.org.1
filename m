Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B272917FA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 17:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgJRPEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 11:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJRPEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 11:04:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE9FC061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 08:04:48 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n9so4462999pgt.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 08:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Mlwqwgy4S8TKVUm+/mFsmd3kgYowZeJtENAHzl7eX9A=;
        b=gv4TflUJUJF5TxCgq3GO9ASf7Bs+rAVbEIxTXsEwb711f9EOLKhdcO8VwMn5LXuVrP
         +8sIORGdO7LehFAFAmmC0eeG+9dTugxzzAF2MZf+i2UfMIMV4AF7Hk6gOjyiAEnL/kkx
         RimCklXTVtvjds1FQN8DWuRxJPfO5CScAECA/GQqnP5hhrR3rwThjIv8DPYOQOOSoq6T
         obK1ZGTKu7ur/zX+fH+Pz/UaAGJiczMqcxNeIQVcYwhWTalsXv+pgJKzR4U9jE4ty+fx
         rf2CMTRT+llMj9GhgA5zwJzvSncp9Xr2Psd+0L+qlnriR7NIt4DrT3NFJtEkV8hqx/KV
         Nu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Mlwqwgy4S8TKVUm+/mFsmd3kgYowZeJtENAHzl7eX9A=;
        b=VHgUsQFOAEDPxTqFGhQFTVoHWMxRJ8ErvjrCTifdvwNRWLpcuaePhg2Q+spfJCw9RJ
         CucgcQIe7FqwU3QpRYDmdRwi1nvKkKHUALkFWZg6ZuKjhK4Kg4uUfgaewjCO/e5j9x0P
         DNvKYUMHg+JlIcx8calnMopAmb26x9qNyzxfDn6R3qCYCvSpYuripZn98+RF5gULMVbd
         1QWij8xSt7IaNgfZa8TvKo8E5+Gi0roOIaKhefcnvaVQ8Gfkb1HXcM6A6P4KbRASNloV
         11PRK9FDsyAi8RC4QiVyW9M+eywmkC+HCCVkwkseKOkOkoABLsF1+r1R/8O6JqGVSXdO
         I+6A==
X-Gm-Message-State: AOAM532rUlNEghXp5pdL0aJkjgEtjtrACuJLJ7NXyF2T/n65iliQEksa
        ozsQ/4pILsmnV43ZwonHzUnNHfpR7pQa0Ug=
X-Google-Smtp-Source: ABdhPJzYB4/SNeSSYPSuR3TkP8K8Lz6rZV/PUkGslXlRbMwTDJVjxQI7JjV8vhOTN2Lu454SUkYCJg==
X-Received: by 2002:a63:541:: with SMTP id 62mr10546036pgf.53.1603033488426;
        Sun, 18 Oct 2020 08:04:48 -0700 (PDT)
Received: from ubuntu ([116.68.78.80])
        by smtp.gmail.com with ESMTPSA id z12sm9174082pfr.197.2020.10.18.08.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 08:04:47 -0700 (PDT)
Date:   Sun, 18 Oct 2020 20:34:42 +0530
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     jic23@kernel.org, wsa@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        alexandru.ardelean@analog.com, matt.ranostay@konsulko.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com,
        vaishnav@beagleboard.org
Subject: [PATCH v3] iio: light: vcnl4035 add i2c_device_id
Message-ID: <20201018150442.GA219064@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i2c_device_id table for the vl53l0x-i2c driver,
helps in device instantiation using i2c_new_client_device
or from userspace in cases where device-tree based description
is not possible now (Example: device on a gbphy i2c adapter
created by greybus)

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
 v3:
	-modify commit message for readability
	 as suggested by Jonathan Cameron
 v2:
	-fix commit message
 drivers/iio/light/vcnl4035.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 765c44adac57..73a28e30dddc 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -652,6 +652,12 @@ static const struct dev_pm_ops vcnl4035_pm_ops = {
 			   vcnl4035_runtime_resume, NULL)
 };
 
+static const struct i2c_device_id vcnl4035_id[] = {
+	{ "vcnl4035", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, vcnl4035_id);
+
 static const struct of_device_id vcnl4035_of_match[] = {
 	{ .compatible = "vishay,vcnl4035", },
 	{ }
@@ -666,6 +672,7 @@ static struct i2c_driver vcnl4035_driver = {
 	},
 	.probe  = vcnl4035_probe,
 	.remove	= vcnl4035_remove,
+	.id_table = vcnl4035_id,
 };
 
 module_i2c_driver(vcnl4035_driver);
-- 
2.25.1

