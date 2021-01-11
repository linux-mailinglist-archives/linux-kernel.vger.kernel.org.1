Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1822F1EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390836AbhAKTJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387727AbhAKTJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:09:07 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D9DC061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:08:27 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id e2so329252plt.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=59nxlB8VZ+hnhNiWW6MUdoxkOzActMtX+5zF/bfPh1Y=;
        b=BtHHfhFFehHqijgd2JLtWspyu1TNSHowLc8fSW3rAWzcqy6xsNKgsAhQvOrpbpqQGb
         MXhlAdjtFzXin3c+3JG0FeKcznojdvFnGryg6bBCalkNcW1hAGp352mHCOOqJ3J680aG
         1wbKLVVdmHBfvhCdSjdEyL6TBHnwApIUA70rNCENHPcQ2zUg98i7jS/t6aIt853CTidc
         trm1GssAYCUqOP4MHs5SPfZE7PbMsxdvxirfzVryCLwtxU8+0icOtsf7ld7mVrbOi4Iw
         Sx82XPsr1PYt3jpH7/lIlfne40Xw2XGTZ3r5n5udYSkR6MoOj5S8LfJ92gV7GKQ3Dif/
         obtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=59nxlB8VZ+hnhNiWW6MUdoxkOzActMtX+5zF/bfPh1Y=;
        b=A4rtduPN+Nrdpa9Oh+s+IrOE3/BC4Rl+vWdxkHSOkq3wnaqmfpVhpSelmNkVyE0iW4
         uNWiRSHUtM3soJIfzrmG3Ch3lPub42rjVP0rK3XhlIjQ+O00PIW5mrjrbLDKMfag/Zaa
         mggYl5/sCrCQjI3NfdpndEha1sgDbAnuv6TJEcDnrTsNn/v0Or5pvmLpB4JGHoCIOpKf
         3Pd/LAsJGf6gJ0S5LDRhBi4ciZ78h+gKaHMlf2VkDliFER3V+phgwjE9SI4bMY/fRiwD
         8n7UszwX208xRGfninBJBD5ipnuOKXw+wQPpLPQ6CMTuvxTYSD60HHPs14CxsZkYfDaw
         4tIw==
X-Gm-Message-State: AOAM532/F+d/sFvKM2lN1LZk+CvOZcbO3gDpGJ+eDvJFF5A5Nwa5H8g4
        QDaHF5XApSk21kJcvTgztBA=
X-Google-Smtp-Source: ABdhPJzvMZhgRoL6SXI9kfx/HNdUrpg4WN0yhU39irWcBBSkyBHwtbvDQt0vKFcFLjncu6yDuiwLOA==
X-Received: by 2002:a17:90a:9483:: with SMTP id s3mr29595pjo.85.1610392107222;
        Mon, 11 Jan 2021 11:08:27 -0800 (PST)
Received: from adolin ([49.207.206.164])
        by smtp.gmail.com with ESMTPSA id y9sm133083pjt.37.2021.01.11.11.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:08:26 -0800 (PST)
Date:   Tue, 12 Jan 2021 00:38:22 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 3/3] drm/vkms: Add information about module options
Message-ID: <4fbc6459377c1dcbe8e6648718453d5693f6451c.1610391685.git.sylphrenadin@gmail.com>
References: <cover.1610391685.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1610391685.git.sylphrenadin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update vkms documentation to contain usage of `modinfo`
command and steps to load vkms with module options enabled.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 Documentation/gpu/vkms.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 9e030c74a82e..2c9b376da5ca 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -35,6 +35,18 @@ Now, to load the driver, use::
 On running the lsmod command now, the VKMS driver will appear listed.
 You can also observe the driver being loaded in the dmesg logs.
 
+The VKMS driver has optional features to simulate different kinds of hardware,
+which are exposed as module options. You can use the `modinfo` command
+to see the module options for vkms::
+
+  modinfo vkms
+
+Module options are helpful when testing, and enabling modules
+can be done while loading vkms. For example, to load vkms with cursor enabled,
+use::
+
+  sudo modprobe vkms enable_cursor=1
+
 To disable the driver, use ::
 
   sudo modprobe -r vkms
-- 
2.25.1

