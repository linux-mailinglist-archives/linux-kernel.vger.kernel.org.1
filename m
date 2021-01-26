Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28570304FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbhA0DTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390784AbhAZUmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:42:11 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7103DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 12:41:28 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id n7so6063841qkc.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 12:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GRY+rPPVuRaHrY8RsVGw1AGMMa5eVfXj/aze8+hv+pg=;
        b=Frks06YstVhnxy6ZbiHQlKwUQQvMe8nMDM3CdZ3zSfMA75UuXn4G1GhCDylJUYxI0f
         +o/mG51Yssji5VDOlm2WPBfMqkG4Ai7kr/qEkj6ZXDZr8Tt5YnG346mepUplkk9sSusx
         0Ix9GZXULjHSumMbSKH5xh8Y+RLxfwvBwZv/IQ4cu/5ApToOTkHXjXJkbOAxr/UARc3c
         tPtCAk+JDxhg1cld6gX1+eRsciPpqUev+SGZpuA9saQl1z8xzDA8h+0dnxNd8lrpHsgK
         jwRM0mC0BaX7KbnqmqvCOBwHi5yNErWBMRANLLjB7yElTh+od/jBMyeqmQF2Jx/pG5A0
         dv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GRY+rPPVuRaHrY8RsVGw1AGMMa5eVfXj/aze8+hv+pg=;
        b=nZf9PmegCyrbMN+75bgsDkin5Wy7p6cHDlpyjtsWTcjFBraNp+N9mXftOuQQEguEVM
         rVvg+3Xh146CrMNx/Sfy38uJf4jyfKwdT9BjD8mk3dt0XovlFHaehGpguDxbajlc4/69
         bHTOX2yYjj+OfqoLVFWSeLd7sd8an7pBD4YP8IQC+Y+gPfXfAh65wtUyqy/V2JGM2xFl
         kbKsN8J0f6Yl9m6fTCXSE5utpDEB7gP1slJ4FtiNVOKmI/N5GZiGh4NjkFFgfS9skqMt
         S3Brp3prXEjxV/mh6hkmLdxLAkP/lD+vDeeur6dwBLd5o3gZtAawhPr0G/Axi+qFWCpz
         OhXQ==
X-Gm-Message-State: AOAM531GHLREDwXPbIfkz/Opnqj2ir0lSfWnIAb1svXj0yyQ25y/zQk0
        zYHE14lQAJn5K6vfVZOqFza5lkux9y+HEYh2
X-Google-Smtp-Source: ABdhPJzXAipQdIAs49yTYVd//ZamzJ8AJBvyMym3mC2Jf+kmNC2YG4tS4wZHmgfg6NFyBuHSjJ2w2Q==
X-Received: by 2002:a37:9d53:: with SMTP id g80mr7657533qke.307.1611693687579;
        Tue, 26 Jan 2021 12:41:27 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 203sm15228216qkd.81.2021.01.26.12.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 12:41:26 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        tyhicks@linux.microsoft.com, pmladek@suse.com,
        ebiederm@xmission.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] dump kmessage before machine_kexec
Date:   Tue, 26 Jan 2021 15:41:24 -0500
Message-Id: <20210126204125.313820-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
v2
	- Added review-by's
	- Sync with mainline

Allow to study performance shutdown via kexec reboot calls by having kmsg
log saved via pstore.

Previous submissions
v1 https://lore.kernel.org/lkml/20200605194642.62278-1-pasha.tatashin@soleen.com

Pavel Tatashin (1):
  kexec: dump kmessage before machine_kexec

 kernel/kexec_core.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.25.1

