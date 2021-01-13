Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E8E2F46E2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbhAMIui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbhAMIuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:50:37 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3837C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:49:57 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id z21so1067091pgj.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=GmUxp2i9/ls4jbfKHAxa1rq9T2F6H/PzjNNAVFN28no=;
        b=Qx2TyElpWLNjYbk8m/+90E+AZnuXQ8WXuUpuX0eAPizIX/Mha1z7a6K6YofaVUWg2h
         T84cFo3H+Uv8POrtug45HUfPwwklSnYZ/LiHWEZiqg9ldhfOmuLzTlucKSEbeIxnJUtr
         em2v8fCzERnyXk1MMX0DirsvwWS1XOx4DdsQBZZIn2ERNBmMZx/qJ/GAlRHn/9Gv90hb
         NODDr/qA/2D/GlN6OzzmEbNrGqN9TsGu3EIHwXTF2ZyL95xdwHPqilukdQfz+VsFvrBb
         FeyBhtFHm5/UXuqzzS7kXPScpPwWYYJSfyl6qmT0YyQbX8+yWMlvW+9LS4HEp+AE2BtY
         UpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=GmUxp2i9/ls4jbfKHAxa1rq9T2F6H/PzjNNAVFN28no=;
        b=HCgpQEq/oKjo+0xi/mEselX0BNkrcLBhzRSBkr/rkjV9tCwCLJA+u+JacbLN+5fKwS
         tM7yopSaQ+NdJ9EWcpOlkDJn36HkSiJJMZIK995+0vL+aBRerH7Vn/Qk0pNRXNm3mogP
         5W9wIN8tFRMJ4Tx3Y7REZIDOM75JSNz7ShH1Z7UUfhocXV5weo8K6Y8q48dgeBY3tjpR
         JU7nnD2v3W/7YVTkXg2MSyWNMwOpWxoWc5fefWIzqPVTFe3UrMfHKkXLuppCe6GJnRGo
         kf5LdmOWqqe/0T17eM4+dvqvd/+4QpHPHe2cVS36xHke8PBAUa8gwNfzjo0nItoz7wMV
         jIPQ==
X-Gm-Message-State: AOAM532OjwkOAnrOik4v4IJnRDVeqKEZ/5s3GCQOcZSizpvp/cQATv4t
        gAoNUMaMyvTHUjldgGaqZOR59UX0VKSfKNFKnA==
X-Google-Smtp-Source: ABdhPJxp3EzdAAWpaHecQI2slXdclU8NBh50djNkVWJcuOamcVSQtVVNZIIysP17CnP+MP/jbURwpw==
X-Received: by 2002:a63:4d59:: with SMTP id n25mr1126715pgl.122.1610527796885;
        Wed, 13 Jan 2021 00:49:56 -0800 (PST)
Received: from [10.85.112.53] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id q23sm1736420pgm.89.2021.01.13.00.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 00:49:56 -0800 (PST)
To:     tj@kernel.org
Cc:     Steve Wahl <steve.wahl@hpe.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Zefan Li <lizefan.x@bytedance.com>
Subject: [PATCH 1/2] MAINTAINERS: Remove stale URLs for cpuset
Message-ID: <75494a75-a74b-3dba-9846-7f51d805023a@bytedance.com>
Date:   Wed, 13 Jan 2021 16:49:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those URLs are no longer accessable.

Reported-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Zefan Li <lizefan.x@bytedance.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 546aa66428c9..89140540aa8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4494,8 +4494,6 @@ CONTROL GROUP - CPUSET
 M:	Li Zefan <lizefan@huawei.com>
 L:	cgroups@vger.kernel.org
 S:	Maintained
-W:	http://www.bullopensource.org/cpuset/
-W:	http://oss.sgi.com/projects/cpusets/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
 F:	Documentation/admin-guide/cgroup-v1/cpusets.rst
 F:	include/linux/cpuset.h
-- 
2.25.1

