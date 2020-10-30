Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B98329FB2D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgJ3C0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3C0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:26:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB12C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:26:04 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y12so4827890wrp.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yFzxhyb3nLK2fRbNQ6gME5zHkWsuyomDuw38FJHECsg=;
        b=nwBNL/0/nLX9P0oMVDk9hbq2+Nn+JCKItGnIS9DQCFbKUSA3KAezCLY8fdU6YyMWtm
         EZrdNORYYiX62XDaVikhegNScld0lQmXqsONRGV63nnnBBd5aXK3mjxjTCfUgQ6jDK30
         z3QE3rYVn8gnJX8RCl8TLtpNUkG3IAnTWATxmck/kIQd7LK24Jr+4yw3YcyaDlbcUhlB
         lPgMDhiZ9UuFFaNZqtkL0ZehNYFpT6snJtwVvk9GJNa2bRYP9l2nvkGj1tSe2iatOxBm
         vVq7LzdXsG1AnfErg1/CyTAavjTM8zUkwPxW48eWawUvCBxbmZacHtNSRJ1GSQAN+9CQ
         Eigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yFzxhyb3nLK2fRbNQ6gME5zHkWsuyomDuw38FJHECsg=;
        b=mLdWDE2PAldVQCCC80t3nxepwSdissWXWrUfXDK/nTfv+kWvJ9qMQdj626yxiKQmwk
         kpQLHYmUslG7bra4hMmEKJ6u2/zV2BGWZEC+1B1e/iCs2Z6yVB3FcOnsdf0jE910pV2E
         RN3Ck9DFR1c+1OODOg+YYBw36VZl6gTlSSY4dCQPBYITtGzB29V9HsiIIoX5kxNQww0z
         msYG/UYmfF6/cf1eI0EBxa3nLQtnO1LGYo6C0ONG56tkBWHKCJ0dOlkXroihO7H1saDy
         c1mYR2gn/uFmbWEBUkGPPYjYYcTOTZOD3o5t2s6mIqDHEUctI+iXEEgGCI9mLz4FHKI3
         GKgw==
X-Gm-Message-State: AOAM532rzELok/zjt8E6+0KlxuQt0tCSB0WOaw8isEsYiG+/Br5qmIfT
        gf2OW7y/vrjberULVkiUVGJsCG0RIyjAQkqN
X-Google-Smtp-Source: ABdhPJwO0OzT66WL2IB5tQji/aDCSeBdwm6by4A9533PkDSTCekpwS4oaZw7HtdnrMlQgxUe9CIbuA==
X-Received: by 2002:adf:cd81:: with SMTP id q1mr91760wrj.410.1604024762575;
        Thu, 29 Oct 2020 19:26:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i14sm2757170wml.24.2020.10.29.19.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 19:26:02 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        syzbot+a7e701c8385bd8543074@syzkaller.appspotmail.com,
        syzbot+c43831072e7df506a646@syzkaller.appspotmail.com
Subject: [PATCH 0/3] xfrm/compat: syzbot-found fixes
Date:   Fri, 30 Oct 2020 02:25:57 +0000
Message-Id: <20201030022600.724932-1-dima@arista.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() for XFRMA_UNSPEC translation which likely no-one except
syzkaller uses; properly zerofy tail-padding for 64-bit attribute;
don't use __GFP_ZERO as the memory is initialized during translation.

Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Hillf Danton <hdanton@sina.com>
Cc: netdev@vger.kernel.org

Thanks,
         Dmitry

Dmitry Safonov (3):
  xfrm/compat: Translate by copying XFRMA_UNSPEC attribute
  xfrm/compat: memset(0) 64-bit padding at right place
  xfrm/compat: Don't allocate memory with __GFP_ZERO

 net/xfrm/xfrm_compat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: 07e0887302450a62f51dba72df6afb5fabb23d1c
-- 
2.28.0

