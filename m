Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5AC30107B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 00:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbhAVW7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbhAVWzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:55:25 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7690EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:54:45 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id u67so4799382pfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C89gw6YvNATURTK9LTqx+RBcivfIy7/zRAMs6G4Hk8A=;
        b=PsvLEMzbpQV8uTWCDWCZe12J/6HFr573xVJJKHzUv9sGJufSbhhY5mVyf/kYxLTpC9
         8hyHGdZmMDFRxly2ZNJ8oCCxRpayaUrJ3H9+LdezSpGIK+mxuEv1bgelLzyyaOVspW5z
         hUl6/enhunBTGLj+zsCufXjIVTeBwkMUQn4so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C89gw6YvNATURTK9LTqx+RBcivfIy7/zRAMs6G4Hk8A=;
        b=jlwGaTNvc3fPtN4ILnehbLVym4LUe1WSVBcpMct3V5zkNtJgIJnZYf/Urs+9Ik+1FM
         toYYCdR5oo/gD8a1NofgRZb2r2wozDNkSFINaaklKmFqC0polR3ByuXQyp1MAqAvtvhu
         62M24IMaY7k4j+HhNhammFaOWTfAWuj372fDnmNTYMFbObbFFc/MF4zsZr/IQ7iwK0TE
         8ssXvBjkY5NyRSftYrGrPgXGGdRhZQ977xUXlNJRyMdXLZa4ydTQUXLvRpIibCd94yb2
         K4ixoSsDh1UaxPV9iWm7NpyxEWgP3q5TvThOd7tafT6T5rVJuqbA9N7ZW1BomhRKuhu9
         7iQg==
X-Gm-Message-State: AOAM530+b8rPSu85M0UJFXMnGT3wEI7UPd/wtTNIMz7QNVE6KeFm7l5o
        VM21Cvdl5Ngmk9sZ/0n6JgkpRQ==
X-Google-Smtp-Source: ABdhPJzr0zZEMTiv6i0Pk6M0VCXjUpl8GGjXkZL3oXFmtA2iioxrMcptT2U+p+0okuzjCesuPlu4ZA==
X-Received: by 2002:a05:6a00:2296:b029:1b6:6972:2f2a with SMTP id f22-20020a056a002296b02901b669722f2amr7012104pfe.69.1611356085048;
        Fri, 22 Jan 2021 14:54:45 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id i62sm6433509pfe.84.2021.01.22.14.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 14:54:44 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 0/3] iio: Add a ChromeOS EC MKBP proximity driver
Date:   Fri, 22 Jan 2021 14:54:40 -0800
Message-Id: <20210122225443.186184-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a different approach to [1] where I tried to add this proximity
sensor logic to the input subsystem. Instead, we'll take the approach of
making a small IIO proximity driver that parses the EC switch bitmap to
find out if the front proximity sensor is detecting something or not.
This allows us to treat proximity sensors as IIO devices all the time in
userspace instead of handling this switch on the EC via the input
subsystem and then other proximity sensors via IIO.

[1] https://lore.kernel.org/r/20201205004709.3126266-1-swboyd@chromium.org

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: <devicetree@vger.kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>

Stephen Boyd (3):
  platform/chrome: cros_ec: Add SW_FRONT_PROXIMITY MKBP define
  dt-bindings: iio: Add cros ec proximity yaml doc
  iio: proximity: Add a ChromeOS EC MKBP proximity driver

 .../proximity/google,cros-ec-proximity.yaml   |  37 +++
 drivers/iio/proximity/Kconfig                 |  11 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/cros_ec_proximity.c     | 252 ++++++++++++++++++
 .../linux/platform_data/cros_ec_commands.h    |   1 +
 5 files changed, 302 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/google,cros-ec-proximity.yaml
 create mode 100644 drivers/iio/proximity/cros_ec_proximity.c


base-commit: 19c329f6808995b142b3966301f217c831e7cf31
-- 
https://chromeos.dev

