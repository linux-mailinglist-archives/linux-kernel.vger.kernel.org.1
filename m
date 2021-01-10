Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20032F0785
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 15:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbhAJOG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 09:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbhAJOG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 09:06:26 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D8AC061794
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 06:05:46 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id t22so9384869pfl.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 06:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PwUU1YKTRto1wQfZpKpX1jWiTQDtu3Oih3JGe/RizdY=;
        b=JJAczVYOJr2piove4sRN5rNQ5PwlhTMnhuEoiIVroZAG6Kje6V7y/pzjfw9iOFLPxb
         AdEwHEzOXTodscnF6Ex7EEL3VZTFdTGgQFz+XC8uD1+n8/J7FOtI2yz5SSjgHXLnTG6r
         f3+tWuWtUv9Tmdfqg67aS6UErR5yoIUyGhcqNsW4HaYGKEIzGA/tUNPVyZDdlBFW9jsw
         RdkOWj0pk7Sjo29ywJW3P8rnDWxGv4SYObrExO8M1k6kSDbkzet6HaAsPHwJ3lIJFvHU
         /qGcaRY8BwXymij38uC13l4wgzaCtLeGPrAi2bY7FDY0iGnRmC9/SteIJxVjUZAg4983
         BEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PwUU1YKTRto1wQfZpKpX1jWiTQDtu3Oih3JGe/RizdY=;
        b=qwD/1eWnKYueBUO3Te4P01r+TWrpGEDgiPKjBXZpEMkVgw3PUOSOditCGnZXci9Cl5
         CkUA/4aWSNX78KnFRYpvkDNF5h227tZnSOYKvnAUmj2ptAGZ3D2aHFKdhnyP0XV4DNxO
         RWn0jbro5zaGR2hd1hKC749fM+AUxJDlsv0bbURUXk4FMOgTig+mN+Yt+eLx3AvCllxR
         b0glZzXanAMwPhDF8hU/qmXx4UvyW6RFuH8RynQ9I8/D2Zz8iP9jiXTGwwoDVyPOtXLI
         1YH2XTw4cpgoqW06/nZoXFNJu7k02GCiXuVgM9m7FBiUhPJtQUaaVe+0xAi5R/0NPwO4
         a8aA==
X-Gm-Message-State: AOAM532791BI61AokSQUMyQwJ3mLCC4l5YX0mYMBzmRD1C5ILqSyOhXJ
        wO6TurLIR3u7o4svECUm6d8=
X-Google-Smtp-Source: ABdhPJxGzAwaLioVlxKIni4tPEBYRHzS+nPpywLkNSMnCzjcbzKfrhgLhTld4VFrP3s1WKMAZuIabQ==
X-Received: by 2002:aa7:9633:0:b029:19d:d05f:4964 with SMTP id r19-20020aa796330000b029019dd05f4964mr12246859pfg.23.1610287545891;
        Sun, 10 Jan 2021 06:05:45 -0800 (PST)
Received: from adolin ([49.207.199.194])
        by smtp.gmail.com with ESMTPSA id ay21sm11828629pjb.1.2021.01.10.06.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 06:05:45 -0800 (PST)
Date:   Sun, 10 Jan 2021 19:35:41 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/3] drm/vkms: Add information about module options
Message-ID: <68b521bc789640a5f6437bcaa5d5960799be59c9.1610200411.git.sylphrenadin@gmail.com>
References: <cover.1610200411.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1610200411.git.sylphrenadin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update vkms documentation to contain usage of `modinfo`
command and steps to load vkms with module options enabled.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 Documentation/gpu/vkms.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 9e030c74a82e..45fe02f643a8 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -35,6 +35,16 @@ Now, to load the driver, use::
 On running the lsmod command now, the VKMS driver will appear listed.
 You can also observe the driver being loaded in the dmesg logs.
 
+You can use the `modinfo` command to see module options for vkms::
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

