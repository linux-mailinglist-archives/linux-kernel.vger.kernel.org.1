Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C681B7CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 19:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgDXRfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 13:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727033AbgDXRfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:35:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32420C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:35:44 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t9so4150822pjw.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HxWRIcftw699pfoYLFOd9KQSRKTjcr0K+Vl6dnQqheo=;
        b=JY2iMqtpGMtjtgZykQEtdEAOcMGg1lCyq4jnUDE4mD9vNJA1Y2JpzEYFyfcSUVEsG5
         ijnl/A8LkEPgt9cfJLgpo3icFeI5iiGHYymirf7Is8Yyqd87gliA/qIZd4paqhlRRvmR
         j0WeReztxucTmwFGAPfpPhLrBW2Fm9oGlsrDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HxWRIcftw699pfoYLFOd9KQSRKTjcr0K+Vl6dnQqheo=;
        b=rwfcznKqTPaJbNtdPFSGueERYWkes8aOW0hmcR8T4bSQpNgyaT2FHkcj8FisCckeZw
         YmTvq45pTI0d5+xQo9ssix67EpilxXBEBBeuoTwOG4RNF1hdOdscpccXxjT1ZQLYZ4h8
         OAzUXP4nT/aDGkHFlizR1NQmImDBxc6Oo6YnC01YIL6HklMyOLvsQR2PTEAuwopYtZMP
         ku5OdB7JE7qIdf6kyhPVdeAz6I0RNoDcdbX7YLeUvdrkv1jUGZ4XNviaVcSZcOV8C4/G
         ssVdQLmjlkk0zSAlKFcu6NiEfnaCIOTZivNO3itw153cSEsAKe5gqvAN6YJqG/zTvLlA
         5L+w==
X-Gm-Message-State: AGi0PuadryMYnGyJmUDX7s2rKbciA6qCGAK0cuWHtntlFwjkOyBvBKDp
        gvD4Y8pc5+rSfvJ/+SCo2XqauZ8Nph9q3A==
X-Google-Smtp-Source: APiQypJMZOjRtHulZ8Xf5jyjfh/qnsTS0b0q2JkqxsbT03TOoqfMbNtlgM4QwLwPe+adi1iZlf7u3A==
X-Received: by 2002:a17:90a:9b82:: with SMTP id g2mr7560800pjp.72.1587749743448;
        Fri, 24 Apr 2020 10:35:43 -0700 (PDT)
Received: from mathewk1.lan ([161.97.192.125])
        by smtp.gmail.com with ESMTPSA id t188sm5360641pgc.3.2020.04.24.10.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 10:35:42 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mathew King <mathewk@chromium.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 0/4] Cleanup power_supply_sysfs.c
Date:   Fri, 24 Apr 2020 11:35:29 -0600
Message-Id: <20200424173533.48572-1-mathewk@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few various patches to cleanup the power_supply sysfs implementation.

Mathew King (4):
  power_supply: Cleanup power supply sysfs attribute list
  power_supply: Use designated initializer for property text arrays
  power_supply: Add a macro that maps enum properties to text values
  power_supply: Add power supply type property to uevent env

 drivers/power/supply/power_supply.h       |   7 +-
 drivers/power/supply/power_supply_core.c  |   9 +-
 drivers/power/supply/power_supply_sysfs.c | 507 +++++++++++++---------
 3 files changed, 305 insertions(+), 218 deletions(-)

-- 
2.26.2.303.gf8c07b1a785-goog

