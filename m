Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9872FFD88
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbhAVHnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbhAVHnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:43:18 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F1AC061786
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 23:42:38 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 3so5479691ljc.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 23:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=nVvrd/4gPehvCF1j59+Xexug3ddL/zOX6NDGUcJwgnA=;
        b=T8m1a84twNCsjiFCdRXVr+AliLEZ0NT1IUG0uFOYs6b4CTpDZyDNk8B+ZxpziV6TNb
         Rk84Zr8oOhv0+x6+XymTDp2nedh88MAfMQPJagT4V0tiLJsO3mU76PeCZS6AmrZBFS0P
         fLRzkxlXYrAbyMflhrFIbO0tgtLsyWm4SWKrA0ZLZhYNxtiTUu7ROwvkrS+N6fIid1X9
         7QOM1KMH26+IKhEUwKTdXXLwE1BwW8uhm+8SyivDAW43K7evLXGQv/QrFGCe/Pv12lw5
         Rb+xa5UHiyvIgxGA9N7UpYn5b1ipLYGBnYnZzS7iEeF4AQ9dKGAvfmy4wdBsf8xeQHOj
         GcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nVvrd/4gPehvCF1j59+Xexug3ddL/zOX6NDGUcJwgnA=;
        b=h3CNyorHkc7Sn5UyWYk65+grsIwvSNk5WEKzh9QpBuTV3gS8ullLOX115mR+eQY+je
         uyr4SS/Z4aaQlKdHqtLGFabSFdwS5cdvJxffxfIPT7mdhc1k9V5anT+4lCggL2X+SRjh
         A8uzD9P4z+GvViKr7iz9OMviglP53ThFCDNta/wenqf6+bgoQ+4pWdmifycHTiE4VxFn
         P47x4oGLGvAT4A46gDlOs+P2ThJgM52iqJZKuSMUKYfRr20pJTjEk2X/VK3gSI+WV2Af
         iz8p6TsqJGZhxY2NKYhhV2etdMZ7JURLlnf9V6jM0eM16NyT3ugY1Zm31zqsstJ7Hl0e
         jslQ==
X-Gm-Message-State: AOAM533b6hvhc58REZVV0+3+96D1JwB56S6a2N8wHrMTP7HhyS4p4H0/
        k9YbWWMWF7LU0JJ3Syfi8YcCIBoCo0CFIA==
X-Google-Smtp-Source: ABdhPJyz7Ix+zgmc7bZkms0yQWWIpAnIgekw7RmjQEOk+bEuvZBV774uADhHu+N3XM8H8ImsiobPhg==
X-Received: by 2002:a2e:8118:: with SMTP id d24mr1718148ljg.105.1611301356768;
        Thu, 21 Jan 2021 23:42:36 -0800 (PST)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id r29sm850730ljd.54.2021.01.21.23.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 23:42:36 -0800 (PST)
Date:   Fri, 22 Jan 2021 08:42:34 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>
Subject: [GIT PULL] OP-TEE driver fix for v5.11
Message-ID: <20210122074234.GA1074747@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small patch taking care of a rcu_sched trace in some
corner cases when OP-TEE is invoked.

Thanks,
Jens

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-rcu-sched-trace-for-v5.11

for you to fetch changes up to dcb3b06d9c34f33a249f65c08805461fb0c4325b:

  tee: optee: replace might_sleep with cond_resched (2021-01-21 10:36:48 +0100)

----------------------------------------------------------------
Fix rcu_sched trace from OP-TEE invoke

Replaces might_sleep() with a conditional call to cond_resched()
in order to avoid the rcu_sched trace in some corner cases.

----------------------------------------------------------------
Rouven Czerwinski (1):
      tee: optee: replace might_sleep with cond_resched

 drivers/tee/optee/call.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
