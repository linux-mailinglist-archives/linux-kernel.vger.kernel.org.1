Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D72D28F320
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgJONYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728521AbgJONYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:24:03 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D163C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 06:24:02 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a17so1850343pju.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jYuzIwCRS9pZSK357zkhOg+tDHbQrJtmv7n2zdpfdrI=;
        b=oJYV+Rh4Mmr55dw0tRMxCWxI7R7mMGtvBj3U5p6Abb1zsKz01k0r51JnDGRfXqL/za
         Kk1dAiuZI8b6qOQ79N93ewCPB58a6cfCL3uHuj7/BCh3OTGSQ9JjsxYxbxi9UwBh5R2C
         76/PJhRAMNqH1Q3+FMSfhRT5j5DZrzcvcP8AcEXDZ6RKaCC3Hy86yWZ0KowiHzh7wI+N
         X9NbYoo2WqP8bjt+Ep8d/ZHDaRSm3of8hbBxhksEAAqYbPx3QcnNGXLtIjw4Wdj06aSW
         4tDtfv8bX+GY5Wtw2bpPDXX4vm7i3SsIH2BejbDY4GQ5fWskuxFsmCb6pHkORMSz4fdD
         /DLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jYuzIwCRS9pZSK357zkhOg+tDHbQrJtmv7n2zdpfdrI=;
        b=J8jpdBiBJLZblpOwDZta/asTIYG7wL1JHFvKUHHUdDbmBylCrvPhFS6RRdc9OScWun
         qxS+ZnIvPROvGrOWuxxKw/0p11i3zPWFK2UnkHSZPcHxFvAV4xPJnJdkX6/pG6/Ggiyx
         GWuJBht9m6hfQDBD57viz7xWh1o8yqft4ZqQONyEcWLBBY67L2re3slqlXlgMjRT+SvY
         zRo2qSmT7SiOdBDmHGb1dCCHY+Hbrpy1iaG4/J8emaaDM33qOyt4yRyJUzT5okTfy4W2
         mCoNkt49M/hu/aQwjtIZ4iMz7QB/nLqB9ec03u2GI0wMoyU0ZPhxr4RSCPATmPW982xQ
         NU7A==
X-Gm-Message-State: AOAM532zDAoKjJUkC+DsJhkeDcgYO8nT0wLAasunxSFhJ9hwj3qd8Blb
        xP3fBazfEnyHSES8MmPMS4M=
X-Google-Smtp-Source: ABdhPJxAzg7ArMvwk5z4LV1/2HMpbk8rNxd1bwCnuKIu3WiqWrkucLoaHh0hSl1DcAr3G+3tlvQQ3w==
X-Received: by 2002:a17:90a:ca95:: with SMTP id y21mr4275894pjt.68.1602768241960;
        Thu, 15 Oct 2020 06:24:01 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id g4sm3320912pgh.65.2020.10.15.06.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 06:24:01 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     akpm@linux-foundation.org, colin.king@canonical.com,
        sfr@canb.auug.org.au, wangqing@vivo.com, david@redhat.com,
        joe@perches.com, xndchn@gmail.com, luca@lucaceresoli.net,
        ebiggers@google.com
Cc:     linux-kernel@vger.kernel.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] scripts: spelling:  Remove space in the entry memry to memory
Date:   Thu, 15 Oct 2020 18:53:36 +0530
Message-Id: <20201015132336.1770828-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the space in the middle in below entry.

memry||memory

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Joe catch it...so, incoporating..

 scripts/spelling.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 5d1e49821413..ceed51f5e4d8 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -885,7 +885,7 @@ meetign||meeting
 memeory||memory
 memmber||member
 memoery||memory
-memry ||memory
+memry||memory
 ment||meant
 mergable||mergeable
 mesage||message
--
2.28.0

