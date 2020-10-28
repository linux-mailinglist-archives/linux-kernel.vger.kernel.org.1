Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCAC29E05F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgJ1WE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729492AbgJ1WCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:02:01 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75503C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:02:01 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x203so1145808oia.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AA5sUxQC0TzvMvztNTsNBiS9hjaPWFs3L0pV2RCeVCQ=;
        b=cFu3RROb8HerV91637dahb959/v3zGz12qdohaw3CbVXjHgtbTl4pb4FtyA1TBxsFh
         ARFWODSeeyRdDxK1bzEgNFQ/eu43eOjB1n7I3cHgGL4IOgpB+59Iow0IxXXLEc3WLdjW
         DQ/boZvA9BPx+qADnLsfaqMWNNfFTFh7RgfBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AA5sUxQC0TzvMvztNTsNBiS9hjaPWFs3L0pV2RCeVCQ=;
        b=Ywf4MbLsIolleauyD+V/ApEWmLPq/r0GiGuwDbe4+hRfOtV/XMbn1E0Jqy/tdkXS7l
         Vo7omP/bFF3+3P30GeyW8RDpQh4PvBBJAAfLCvUeuP05xKJ80Iq4NbgnWPJjEHzrTjTW
         TJ/p/Kmw1Mr/MXY2uT9VrTvvr0kX8b+Pji0xREUw8iBio4cmk3bK9D3DGMONMgQcIxpb
         fsdSip+eNoYNXma0ep/7oHiZVwYxNhrR5pB5cUAAcEgcxx+QGRjvi4Zra3tvf9Jh4xFp
         xtd05KMDq3h9osEEcc6QfJnRh+UdbHMOx4WI3Cr2+1oyrkr4go+iJdfRkt8RhBU3Xa+Y
         lSLw==
X-Gm-Message-State: AOAM531419KNyhOefEniSGyfDDyWKilIM9PRZMcsAs59DNKGUL98jqb0
        cpBr4xvI3JYA+n/ASMedZAF+9MBq2Ejocg==
X-Google-Smtp-Source: ABdhPJyH8tNmpEDjJqnb6yRxcQoJKk39+PzVY1/Hv1jqc6NQbytsBeAMKVuiVn9Y/vZO8OxKrxSHsQ==
X-Received: by 2002:a17:90a:d3d5:: with SMTP id d21mr4169030pjw.168.1603844405743;
        Tue, 27 Oct 2020 17:20:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d26sm3453969pfo.82.2020.10.27.17.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 17:20:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <yifeifz2@illinois.edu>
Cc:     Kees Cook <keescook@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] seccomp: Add arm and arm64 bitmap support
Date:   Tue, 27 Oct 2020 17:19:58 -0700
Message-Id: <20201028002000.2666043-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I took a quick look at arm64 and arm for enabling bitmaps, and figured
I'd send these patches to show it. I'll take this via the seccomp tree
if no one sees a problem.

Thanks!

-Kees

Kees Cook (2):
  arm64: Enable seccomp architecture tracking
  arm: Enable seccomp architecture tracking

 arch/arm/include/asm/Kbuild      |  1 -
 arch/arm/include/asm/seccomp.h   | 11 +++++++++++
 arch/arm64/include/asm/seccomp.h | 15 +++++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/include/asm/seccomp.h

-- 
2.25.1

