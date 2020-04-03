Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 636EC19D253
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 10:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390291AbgDCIf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 04:35:59 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:38112 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCIf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:35:59 -0400
Received: by mail-wm1-f44.google.com with SMTP id f6so6743591wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 01:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mRJmfrAvw3hZK/dzikYvn8LxvigwSPyPeAJmfpeRQtA=;
        b=dCuaY8iL0f7qnWV3v9Khnx4Dy/K2mFxwFRMjjSby0XDM/NQwjWw11dO8mCS+EKCp8l
         87im2l3YVD7RwfjeYQYRsqi5J77/GZXquw4gFoTw8OFmoqr30qq2S1fMhhid6uUCoxt/
         ku3lFblCk5yJW5vDlUOwuDoiFoDTTOUl4YEW6tXZJqJOl29+3BJoza9cUL2z5c8iVlST
         Pscofk48/Nt9PB8rE6luFMLFcySiWKG5UOwYx9NRMzi/+PQ25BxAzHrSUpiwUGhtIOox
         xbeKy2ZyBpYR+4BoUGU8gQt4GODE3cdJIuDmMtLV0JzNt4gr+9Z6aHiZkbSNsY2n7n3X
         IEWQ==
X-Gm-Message-State: AGi0Puap+8jmp/JKMbPanuFaGVd2T+X0+nf5+rT5vejFmqMhSQMppphP
        GFDId8t6V1HUTMOp1afKMcE6N56S
X-Google-Smtp-Source: APiQypJzcgBGFMYTUv9EzVsbcU62Ng6im7w10ckZE05sJa5IbLlYugpC6K89+r7pDiG5EvAEfJfIgw==
X-Received: by 2002:a1c:7e43:: with SMTP id z64mr7179238wmc.45.1585902957455;
        Fri, 03 Apr 2020 01:35:57 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id v7sm11010275wrs.96.2020.04.03.01.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 01:35:56 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Neil Brown <neilb@suse.de>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] mm: few refinements to gfp flags documentation
Date:   Fri,  3 Apr 2020 10:35:41 +0200
Message-Id: <20200403083543.11552-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
while discussing [1] it turned out that we could be more explicit in gfp
flags documentation. The following two patches do that. There are no
functional changes introduced.

[1] http://lkml.kernel.org/r/20200331131628.153118-1-joel@joelfernandes.org


