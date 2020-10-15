Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3186528F2E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgJONFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgJONFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:05:53 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D60FC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 06:05:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gv6so2007320pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yO4STEJZ6Kg5+u47OEW2bdZIDGWsePVOJIcWHRXTcl4=;
        b=A2AOGsexYnYllNq6L1+36L+sjiMprVWm/cvGiYNlCIXtG6MpUKdGHI/4so4Xubf2DY
         f7My5IjCnneV1ML3Land7Jii8YJERPf90uelVL7nhWu5S0DjeuR28pGL03Nm8+DgTNcC
         qQlkVIn7Nt2KGpAUCxaDsp9XiZFlyIKLJbiudd/LpwH2V0aPuOljct/SMzS1Jn/D4ikC
         nZIWyWl/s0/MfiRk9qfMgTDE2nSUkqwXA4FpUb2fBpT5d08AXqUZVBL6h/MjbtDKGSPw
         zOYovg2LgTDViwFhLdlcXJAAnpjayg6W2moKl6hpJw0NKB1fpZ0k+KTu6efJXxPJY6b/
         goEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yO4STEJZ6Kg5+u47OEW2bdZIDGWsePVOJIcWHRXTcl4=;
        b=Rc8w4QTWbD6D/+W3/hAa1kG37AO84Jm0MXoiy8/4IPWQxTWonBHvFm1iXJZFlu3KJs
         oL5GlzxCPZBWiDxI2bTH0B3wdb5ukmZIJaUcmGogQN5Ct42tbKAaKDx24xpR5P2oOTvI
         d9HFd/COpqxWB1FbrzuxOM9sL7v+S6aZGQhqEnE51l8cDglH4bPooVOQKMscD8Vi+miC
         HICIC5ZEVvf6LSyUoqekm+wkLzsZgEm6PWah262QZw1RAPOSIkyixl2vIfmkeZTpgCOr
         ET/tIFeoohVUoFyHpVdnusr2PeJ9fzrhoT72I5bVDy/IHchRlMIqMLiZnNxKrPywc7Mq
         Mb1A==
X-Gm-Message-State: AOAM531WWjypj2KD4oVVH7zgV0mxAaNkZu2/BvUe8vW+t/nVnlcv0Inf
        +hToym2esWkEaFM/6Ia8wDY=
X-Google-Smtp-Source: ABdhPJy0C84oMar88xXL20g6YfnkbuBcOTTt3vmN8cJYvx5OD0kyJfD9tY5okBf4bnNwDjhFu/ycSA==
X-Received: by 2002:a17:90a:a81:: with SMTP id 1mr4431279pjw.174.1602767152499;
        Thu, 15 Oct 2020 06:05:52 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id c187sm3400427pfc.153.2020.10.15.06.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 06:05:51 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     akpm@linux-foundation.org, colin.king@canonical.com,
        sfr@canb.auug.org.au, wangqing@vivo.com, david@redhat.com,
        joe@perches.com, xndchn@gmail.com, luca@lucaceresoli.net,
        ebiggers@google.com
Cc:     linux-kernel@vger.kernel.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] scripts: Spelling:  Fix spelling memry to memory in /tools/nolibc/include/nolibc.h
Date:   Thu, 15 Oct 2020 18:35:25 +0530
Message-Id: <20201015130525.381818-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/memry/memory/p

In the file /tools/nolibc/include/nolibc.h

One of the comment line.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 get_maintainer.pl shows me bunch of people for this file and I
 not sure it is important to all of you, but still included for
 the sake of protocol.

 scripts/spelling.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index f253681e7e2a..5d1e49821413 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -885,6 +885,7 @@ meetign||meeting
 memeory||memory
 memmber||member
 memoery||memory
+memry ||memory
 ment||meant
 mergable||mergeable
 mesage||message
--
2.28.0

