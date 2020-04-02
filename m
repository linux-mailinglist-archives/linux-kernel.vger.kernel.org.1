Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37CA019C2E4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 15:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgDBNoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 09:44:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44721 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgDBNoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:44:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id m17so4225719wrw.11;
        Thu, 02 Apr 2020 06:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Wp4L7uJK5SurqL9J1O4zZL/b4dks4+Z+A5rqEGo9+BU=;
        b=HjHIpmnrao09l+sfHu46xNdLDNeGracVhuSu3Bxb2smX2xFpT68A2qYf+WYwCZZqIr
         6AaTP3S4uTaqxaRrjP5kFgUISkWBXx7TIOX9Y3U8QYk2bReuI+pDMjyz6gMj17o61TQp
         AGJOel4TRgYeZnfsGUMEYFlhuWJ2H63sE48ENdbJS8pBOA3hdXkLmB6NuYOQSKICxCFp
         /WiVmEykh3+imqDewXa2uWG+kAON7bUjCdYvEs4YjbWEov+cWJChs/GenaMb0i6SQn4X
         D/2s7JAfYc7jCJv1HEFaxnu4uoUSqEgaZwgob0gjLpro6J3+Rxh+dlJENgdq/OzAhQq9
         RHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wp4L7uJK5SurqL9J1O4zZL/b4dks4+Z+A5rqEGo9+BU=;
        b=OQT2LGxK/RNBCcempZKhpAMRBFQK3dZn+8H0JgvTK8aOtBL0SGK9HG6QPaVnwbebzk
         41HIqtud0ytCLuVyRcscYVPWY8wBkoCQSvdPdw9WTWJ5shNeqXIOmKDXlKYOTho8ZrKr
         CGFWgjg0sLDN8nbYnmu1YQQVONRClZmQOL5uyjv2qC+zMhubig0jxqtynZmTuxMEK2+f
         GV78rP7QUIiWTUVuSX9ofPoBqAHNJ7780P0YUOomBg5DMtuTQVestipFFqCz5T+CtHln
         0ywxQR9Pp76krUP/opwMnlAVi4g46qDIodFsYIpmNwOvuAswmAkp47VFnjFC8opwGXir
         n4WQ==
X-Gm-Message-State: AGi0PubeDImueOc994xT6Z81d8awPT4AQ/QIGNzxkr/+0uf99OzaJRgx
        N8KZhsy13b74XMD2zt2ca6lQmsU/
X-Google-Smtp-Source: APiQypJAkXoXv8XH9rRAeegKGeeGARwZr8RvuFQd+0dRo6g6SDHMo65n53RH/d6DZXqkxEwurO4jiw==
X-Received: by 2002:a05:6000:10c8:: with SMTP id b8mr3446059wrx.138.1585835093520;
        Thu, 02 Apr 2020 06:44:53 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2db9:4c00:958a:939d:c15f:43cb])
        by smtp.gmail.com with ESMTPSA id j11sm7568469wrt.14.2020.04.02.06.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 06:44:53 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: remove entry after hp100 driver removal
Date:   Thu,  2 Apr 2020 15:44:42 +0200
Message-Id: <20200402134442.4709-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a10079c66290 ("staging: remove hp100 driver") removed all files
from ./drivers/staging/hp/, but missed to adjust MAINTAINERS.

Since then, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches F: drivers/staging/hp/hp100.*

So, drop HP100 Driver entry in MAINTAINERS now.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Greg, here is a minor non-urgent patch for staging.

 MAINTAINERS | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index be43f1e37902..1c1abe8229af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7721,11 +7721,6 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Orphan
 F:	drivers/platform/x86/tc1100-wmi.c
 
-HP100:	Driver for HP 10/100 Mbit/s Voice Grade Network Adapter Series
-M:	Jaroslav Kysela <perex@perex.cz>
-S:	Obsolete
-F:	drivers/staging/hp/hp100.*
-
 HPET:	High Precision Event Timers driver
 M:	Clemens Ladisch <clemens@ladisch.de>
 S:	Maintained
-- 
2.17.1

