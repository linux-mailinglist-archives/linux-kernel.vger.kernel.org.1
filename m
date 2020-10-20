Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE9E292A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgJSPaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:30:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33508 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgJSPaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:30:19 -0400
Received: by mail-io1-f66.google.com with SMTP id p15so127287ioh.0;
        Mon, 19 Oct 2020 08:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7+X9u3rO6Y8sg8vHPYHcEW8Y6MyKG/RFyLn61r58hQ8=;
        b=NznpAyJ7+jiJt1QA/Zc/GYpUpF3VwY9CeccvfmHyH7Z2DpXEFZITq4Rf2cDOwq4pRx
         KstI8FzI11WV8sdi4kxKIdmy7pDNvAAb+FjzobdYmB1GKomCpiicthhK08Zjo/ubpIfo
         WqDR5cwKMSX8cq6kJwHxknFQIgkjBXMsou6Tluh255Nm6cPiZUuI46c6xr5ErV0s4nsf
         wHxre/k9o1y9wnEmtneDu6OeWjB8HPA5xJoUpenycTdC95/3BuPetLS+cpWUmcMQedmZ
         1mlcEAMeqEPLqVJ3tGfRn7swYs4Ok7kNcDsA4aBREMbSDjoRFnFItnU3uqJRzUiA8afP
         2WKg==
X-Gm-Message-State: AOAM531nVvPNRXwSgl49fJd8E9qu7T8eARpEyCqSuIn8ql+xAYQsdji1
        gw27YtDfBAjAHFaG7dZgK6e1GNgHBXWUog==
X-Google-Smtp-Source: ABdhPJw0NTLTMT/HvrmRbJrrvIh3ewr13cE1ZoOHAKBYHtRVsUDQiq+4dt4x81RPBEky/nQCsZ16Xg==
X-Received: by 2002:a02:3093:: with SMTP id q141mr416117jaq.88.1603121418177;
        Mon, 19 Oct 2020 08:30:18 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m86sm20898ilb.44.2020.10.19.08.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 08:30:17 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] crypto: lib/sha256 - cleanup/optimization
Date:   Mon, 19 Oct 2020 11:30:11 -0400
Message-Id: <20201019153016.2698303-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 -- Use memzero_explicit() instead of structure assignment/plain
memset() to clear sensitive state.

Patch 2 -- I am not sure about this one: currently the temporary
variables used in the generic sha256 implementation are cleared, but the
clearing is optimized away due to lack of compiler barriers. I don't
think it's really necessary to clear them, but I'm not a cryptanalyst,
so I would like comment on whether it's indeed safe not to, or we should
instead add the required barriers to force clearing.

The last three patches are optimizations for generic sha256.

Arvind Sankar (5):
  crypto: Use memzero_explicit() for clearing state
  crypto: lib/sha256 - Don't clear temporary variables
  crypto: lib/sha256 - Clear W[] in sha256_update() instead of
    sha256_transform()
  crypto: lib/sha256 - Unroll SHA256 loop 8 times intead of 64
  crypto: lib/sha256 - Unroll LOAD and BLEND loops

 include/crypto/sha1_base.h   |   3 +-
 include/crypto/sha256_base.h |   3 +-
 include/crypto/sha512_base.h |   3 +-
 include/crypto/sm3_base.h    |   3 +-
 lib/crypto/sha256.c          | 202 ++++++++++-------------------------
 5 files changed, 62 insertions(+), 152 deletions(-)

-- 
2.26.2

