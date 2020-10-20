Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016F22944B2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 23:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438788AbgJTVpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 17:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392157AbgJTVps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 17:45:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A952C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 14:45:47 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kk5so43665pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 14:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5zb2k/yQhQ8oyMKadz8VKlRfv548LEmsWMcy3EDlZOI=;
        b=eJue/YhgqPzoAvHtxwGGnR1AAhL5nzuMGilf9kh6oUy0ZKG/UkcwvAbMmdP8Mw8joZ
         m+7t7pBo8T0Ns3AEP3PzVa5SlOKwT4UKfb3zAYVPkCbHB6tQcpKBzn0DrE3W0PsSAvMp
         AamR0ipjPf/3ltevlzpJBHc0w0KZmD5DNCea4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5zb2k/yQhQ8oyMKadz8VKlRfv548LEmsWMcy3EDlZOI=;
        b=tJ3b1RueAKeHJ/nR77O+wKOy3X1eDIxzxwqVKQL+0EBGOUa00TlkDgBVLpPbeRDNIo
         g1qIvx/Mxcc5g+rN51CX3KHi0JpsqVvqic0TVUeo1cHaysFqrtThFdLQdKLD/K4/CT2j
         b4+Xvdk8Ocnl2AHdeRGN95EfZyCL4hlmDs6/nBB1btShmUaFawxcG6E2cvI2XUetPuIC
         mnZ/DwqrBPfVemD8lC5R1AKxSDiem0iqb1rmYkoqAPk+tP2sp9+rHz909J7aixDa0E6V
         9tP7wdbdVSQtG1E52I7YIbEapfpU7gPmdH38QQcWYoHN+ojFbmHmzIh1YIqYGUMwlyUw
         J/og==
X-Gm-Message-State: AOAM532LGgEgbK0xRT4XqivlWRxFTPCUJYHKrUnqY66/V4Pc95vpLgq4
        T3+BT0f99QSFJR2ucYFhMGGMAw==
X-Google-Smtp-Source: ABdhPJzOOD53E9+RyIyrrpIG0jxFtoCxvbNHFdP6EwHmydJyw118zxPHplRgGT/cUCXCGu8J73L2Bg==
X-Received: by 2002:a17:902:6a8b:b029:d3:b4d2:11f0 with SMTP id n11-20020a1709026a8bb02900d3b4d211f0mr234847plk.2.1603230346663;
        Tue, 20 Oct 2020 14:45:46 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id j23sm130751pgh.31.2020.10.20.14.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:45:45 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Steven Price <steven.price@arm.com>,
        Marc Zyngier <maz@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 0/2] arm64: Fixes for spectre-v2 detection in guest kernels
Date:   Tue, 20 Oct 2020 14:45:42 -0700
Message-Id: <20201020214544.3206838-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch fixes a problem with spectre-v2 detection in guest
kernels found on v5.4 and the second patch fixes an outdated comment.

Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org

Stephen Boyd (2):
  arm64: ARM_SMCCC_ARCH_WORKAROUND_1 doesn't return
    SMCCC_RET_NOT_REQUIRED
  arm64: proton-pack: Update comment to reflect new function name

 arch/arm64/kernel/proton-pack.c | 7 +++----
 arch/arm64/kvm/hypercalls.c     | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)


base-commit: 38525c6919e2f6b27c1855905f342a0def3cbdcf
-- 
Sent by a computer, using git, on the internet

