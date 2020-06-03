Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8268A1ECC7D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 11:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgFCJXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 05:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgFCJXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 05:23:44 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B206C05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 02:23:44 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 64so1219799pfg.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 02:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sRW5SDnwIIr3cbppv0Ovv932qqur7lY5ZkGh2JacUsk=;
        b=SrC6qUm/64CLgN3/RvGv1EbqL2YSyzHZIpP6OHKPon7X0WlfEKShW4M8gx5w8aMmOU
         dZddmkrbX9131LFUbWJoZo5VU+WARINRbsQHUTPweB2EwruDc7vnM+v1WTUiU+fYigsU
         GwV0LiOA55GXJEP5TJV8WlhiOK+BBjpAVo0XCxcL2TrjBpxTzRwbdLGw68MtzEDiQJAB
         mNEzcygjYmM2vbT8bwlrd+jeFsb1JkhY0g4O80GQNtU9OyW4h23ov8J6cTOcyGbSPOkM
         R0AM3Jg4DDM+I6iMEmtRdcgcy9tqJ8xJAoUOC9vtoh20S2qMk4tb5RuC8pCRyjLeeibm
         uRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sRW5SDnwIIr3cbppv0Ovv932qqur7lY5ZkGh2JacUsk=;
        b=AOeKjrIYFsbqtTAZSG1H1WvvwrfeomELohOU55yQQaFUW6ZY4QQsv9tgqmPmSDKddc
         Xn3yDDCZ6X9ORRrzUuenmiPzI1HKAMlp48VS9oN83eDZLu1cAA+b6ToUaLDWpZk3sCxu
         g52bnF7xUC+eWYes+DgCmtRpAY8Y+dSBh0UKXaHyw7UnoUmkkLYcFST1gJlEbk5F5DV5
         aqWOozugGblOiCPu/KHJ5AasEXnu91LpoCIK5VeeRCrtGTIcpuA06tRflYvJSRxRyF9+
         6/bbi/3ED6xMGGw87ntZVccuq6Trlk09AXIYlRoIkjPY5pYtnfvYwEgwEQ4ihfP/Se+n
         WIwg==
X-Gm-Message-State: AOAM532D0+D77/bzdlquGdggx+KNHgyeH2eiCo5em09we0FStWxY+kp6
        byVTDL+IcmeUggKN3+TWXo8=
X-Google-Smtp-Source: ABdhPJyDo2fa0sS2MRLPdXgs/OGzNP9/ZnQfPHnPnHRSdq0RnJSa0rQFN7bQJH8W+muWs2lOpKgt+g==
X-Received: by 2002:a17:90b:1244:: with SMTP id gx4mr973127pjb.136.1591176223846;
        Wed, 03 Jun 2020 02:23:43 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:400:e00:7571:e536:944d:12bc])
        by smtp.gmail.com with ESMTPSA id h20sm1313260pfo.105.2020.06.03.02.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 02:23:43 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/5] xtensa updates for v5.8
Date:   Wed,  3 Jun 2020 02:23:29 -0700
Message-Id: <20200603092329.10427-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following Xtensa architecture updates for v5.8:

The following changes since commit b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce:

  Linux 5.7-rc6 (2020-05-17 16:48:37 -0700)

are available in the Git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20200603

for you to fetch changes up to 3ead2f97bd44a9a106572d306cb04a878c569cb2:

  xtensa: Fix spelling/grammar in comment (2020-05-25 16:11:43 -0700)

----------------------------------------------------------------
Xtensa updates for v5.8:

- fix __user annotations in asm/uaccess.h
- fix comments in entry.S

----------------------------------------------------------------
Chris Packham (1):
      xtensa: Fix spelling/grammar in comment

Max Filippov (4):
      xtensa: add missing __user annotations to __{get,put}_user_check
      xtensa: fix type conversion in __get_user_size
      xtensa: fix error paths in __get_user_{check,size}
      xtensa: add missing __user annotations to asm/uaccess.h

 arch/xtensa/include/asm/uaccess.h | 32 ++++++++++++++++----------------
 arch/xtensa/kernel/entry.S        |  4 ++--
 2 files changed, 18 insertions(+), 18 deletions(-)

-- 
Thanks.
-- Max
