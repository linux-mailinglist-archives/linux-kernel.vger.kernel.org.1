Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695602B412B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgKPKbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgKPKbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:31:09 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590F2C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:31:08 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id w142so24372669lff.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EeFwfXRkZ5mTFjbHPs+YdFt7GCH/z/SaefTbs/c6Zps=;
        b=WlESugNPPAE0O9BzfishSL57brpam42kEsA3MWVOk6NEKIbAHTUQwGHOH2teWuciY2
         6qNKZBZLRdehN3trbNX+kfhocGVjmHP3nA0d6Sg+ZIGFvtr9z6HHZOxq5QKd+CPKY2TR
         sCgkcq0ormE+6a/qb5YtiaP9ToU1U4Czs5q0RecotrEMEPBIr25W8gDuzfZvby7pqRoZ
         mk47MFzyGHhlLLETVZtge+wlABQ6jHASM1lxm1f1/Rv7UdlSRZOMZQecm1QbPfgWf+l2
         6aHBVvB/N51m+bEoo5K11D4da8aB9q+nvIIxUYvMUaN7uH7GqnvSsAmNMYmeH2mHEdGu
         9T3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EeFwfXRkZ5mTFjbHPs+YdFt7GCH/z/SaefTbs/c6Zps=;
        b=iV/z2C5cterxnA3Ll9xSicYwzMyP2XDMABnL/yBMgPNHsP9Na9IIVAQFJiNoGP6yq6
         PVu5XgP3n35nKLXWU/hsEUt/8saM5aI+yjQlN8o5QhqOqToAyksDPesG5fwBM7nIWurX
         TNF1eXr799DCgdNr5ECgORjVOyrwLr0DYJ0d0BM1nI7WCJ4Fq5+BsM/RvZrEfq+YDo/v
         DQe1b03NaqqfDV612sXuA/W9Cv/aOWWVK036fU8ybNsjk0AuP0ytBZ1dvX/4UKxlefh3
         hBqHV1pzX9T2/rW/xxM7zLOyNvVax2I1mFyvxFN2QGNjGHdw1V6R2nwEvGWNXsjXxpM9
         dMjA==
X-Gm-Message-State: AOAM531W5tUUevEF0DgfNB35/pYqsMJi7owPr6dt3QaNCuciR3a9fcZK
        6gpbx7eTCPEyAg5YWEgNeQU=
X-Google-Smtp-Source: ABdhPJzFhbUr1wqUW26Rv41Zcv05XdjU9AYHaExE1SYwnkP3q92Epc8CKegki+1XzXiFg2jmCxn19g==
X-Received: by 2002:ac2:5219:: with SMTP id a25mr5105145lfl.264.1605522666908;
        Mon, 16 Nov 2020 02:31:06 -0800 (PST)
Received: from octofox.metropolis ([5.19.183.212])
        by smtp.gmail.com with ESMTPSA id f1sm2687362lfm.184.2020.11.16.02.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:31:06 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/2] xtensa: cache aliasing fixes
Date:   Mon, 16 Nov 2020 02:30:56 -0800
Message-Id: <20201116103058.5461-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series changes TLBTEMP region placement and disables preemption
around all cache alias management calls. This fixes TLB miss and
multihit issues in the TLBTEMP area seen on cores with aliasing cache.

Max Filippov (2):
  xtensa: fix TLBTEMP area placement
  xtensa: disable preemption around cache alias management calls

 Documentation/xtensa/mmu.rst      |  9 ++++++---
 arch/xtensa/include/asm/pgtable.h |  2 +-
 arch/xtensa/mm/cache.c            | 14 ++++++++++++++
 3 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.20.1

