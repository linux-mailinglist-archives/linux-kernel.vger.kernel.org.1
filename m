Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F83276FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgIXLXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgIXLXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:23:23 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABE5C0613CE;
        Thu, 24 Sep 2020 04:23:23 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id q12so1493308plr.12;
        Thu, 24 Sep 2020 04:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=0Yw4y12mYXqqzBAefSKmQPErnuJA8Bd/3bClQhft1f4=;
        b=rMBUvIGc+BcQpRaPLrLivcdmH5/cNfPYvjpayM+lekuyx8VuxAhksOC6eg4D/J9YEe
         Mx4Xx3+Ru6ERuUByDfqCq5nDbZfyAoWjwZkapKrhQ4x20ah5C+kkeds3Op/Ip+IHxR0K
         eYZs1Sts6KLRBwFzGasrN1PUVPZylc+Su+BsvPnXeR9qjCakGD5GttsJKcS1SPdWL0aN
         jBup4W2fDsIe+iqtQmc2Ts8DDrtg5QekDonZnvDcfwKFkZlJUszutBsiIJRThNxgjmXs
         i8czb5FnZOoyVWEHlafhNN3qbPx9ZBcwhkTu6qJhUzFwsDw20o4i+nzfkVXynAWn0fJq
         nS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0Yw4y12mYXqqzBAefSKmQPErnuJA8Bd/3bClQhft1f4=;
        b=nI/qoArTWMzBfsFEYYVlQGcE2FTL38T8iJ3Upb7FRMHLmU0kipiaTRoh4kxzLmkRH6
         jqi+HhbUdE/TaWN3qwb+7SlQtS3tClxwqvDjuXcuKJf6iYNLhp9zQMB3kVKUED6+Vzk2
         2asS+8P9kf0A7xv1oZcYg50LkDIMN1aQjuG9Kl6t8Zi4qDg5XpyaYj4iMUD9p14UJJkT
         Z4l+CJXB1GoPqgCgkYADd4Pm8wOaqiNazaHrDOP9F5ymTcb254IjyY2m6HkWScbiaG2h
         0rzcZsfp/UwA1F4svLAVmBg/zHWuXRpBSr0H4e1Rd7WxjGLK87g7G7yocPzBXrm1cU5M
         q72A==
X-Gm-Message-State: AOAM533eCA1DfvxB0yG+jvhGb7C2SVaJaB0fwz4ufQoijdujTLJoUHhI
        UFEQfoGTr/zufA0Tdju10On7eietA3ofXPDA
X-Google-Smtp-Source: ABdhPJxNrpc1T1RzR987qCLYFRPoqeSupCopENIpU/JLVTz9WxgvLwLNb59t0zxAPzjfTznserHVnA==
X-Received: by 2002:a17:902:82c7:b029:d2:2a0b:f0c7 with SMTP id u7-20020a17090282c7b02900d22a0bf0c7mr4053217plz.30.1600946602591;
        Thu, 24 Sep 2020 04:23:22 -0700 (PDT)
Received: from adolin ([49.207.208.43])
        by smtp.gmail.com with ESMTPSA id k3sm2768096pfp.41.2020.09.24.04.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 04:23:21 -0700 (PDT)
Date:   Thu, 24 Sep 2020 16:53:16 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     corbet@lwn.net, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 0/2] Improve Coccinelle Parallelisation
Message-ID: <cover.1600945451.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinelle utilises all available threads to implement parallelisation.
However, this results in a decrease in performance.

This patchset aims to improve performance by modifying cocciccheck to
use at most one thread per core by default.

Sumera Priyadarsini (2):
  scripts: coccicheck: Change default value for parallelism
  Documentation: Coccinelle: Modify parallelisation information in docs

 Documentation/dev-tools/coccinelle.rst | 4 ++--
 scripts/coccicheck                     | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.25.1

