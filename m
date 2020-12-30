Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D39C2E7CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 22:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgL3Vq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 16:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgL3Vqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 16:46:51 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDFBC061573
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 13:45:56 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 190so6021181wmz.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 13:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/kbVtG9+aGsr44Zrtbqkbn+LIP6L6fp4kSH2R8701XE=;
        b=Cr1Y17z/exiurhuFY6Pbw763XwbO2cQtAmhdoKUuvXpfxnQ2AJlJxQnN8tZcPVfvwI
         BBlsVX/TWEBzgPFF5+Uf2aMsMP//MxFjBRv3fYLtv4sdYc83z0bRB0rTzMnXBv6oeCVI
         ss+pYhxZ2KcPMItt+ZnzcDzRo78F4xr/xO1J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/kbVtG9+aGsr44Zrtbqkbn+LIP6L6fp4kSH2R8701XE=;
        b=SqEEQeZvt8+KTfdbHlw4Ig6zUQYjBKpjxFM/WxMnz3CAAl74X1Sxa6noXnTsZ99Z7Q
         zKw9JacPdxiaHztJe638Q5Z1fXAHZb+DqTcPEHS624VklgmJkl0xBr0VHQ9sGAwyGDt/
         Oe8X9oP5PZ4a+Tpiw6p32wS2+YWeE36T7KubMot3df5cJlsdRxkucUkpTKViC+RAYVxM
         SzXIKaa3B7iqvLQS3fqddzeEsbkW1RO3C4+xjfZtmaFk6Ic8h8clrQVubHB+eoCSVIe0
         XfUJB/PuRWpZM1O2Ky3qsEnrW+vhmh6qjBqh9syminxWk7DL79Ta6W3H2fe6YGp/99RH
         R/Vg==
X-Gm-Message-State: AOAM530ktnwpJzwIxWrD4qWUlT9sVxBmXVLMHjkZL7A6nvmgDdIHGXu9
        FaUnrFECgEgFan1xwETRGQNGU2EGsd22Qm6cYSwDXw==
X-Google-Smtp-Source: ABdhPJwmWH9sv8kVx66i/Zig3WzfuPqiSDd5ysSSfSorYVgQ2t4wrzU0rEZtrhkOUVb/l94N+FDjPw==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr9373821wmj.61.1609364754774;
        Wed, 30 Dec 2020 13:45:54 -0800 (PST)
Received: from dev.cfops.net (165.176.200.146.dyn.plus.net. [146.200.176.165])
        by smtp.gmail.com with ESMTPSA id r7sm8749894wmh.2.2020.12.30.13.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 13:45:53 -0800 (PST)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        dm-crypt@saout.de, linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, ebiggers@kernel.org,
        Damien.LeMoal@wdc.com, mpatocka@redhat.com,
        herbert@gondor.apana.org.au, kernel-team@cloudflare.com,
        nobuto.murata@canonical.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        mail@maciej.szmigiero.name
Subject: [PATCH v2 0/2] dm crypt: some fixes to support dm-crypt running in softirq context
Date:   Wed, 30 Dec 2020 21:45:18 +0000
Message-Id: <20201230214520.154793-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1:
0001: Handle memory allocation failure for GFP_ATOMIC

Ignat Korchagin (2):
  dm crypt: use GFP_ATOMIC when allocating crypto requests from softirq
  dm crypt: do not wait for backlogged crypto request completion in
    softirq

 drivers/md/dm-crypt.c | 135 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 120 insertions(+), 15 deletions(-)

-- 
2.20.1

