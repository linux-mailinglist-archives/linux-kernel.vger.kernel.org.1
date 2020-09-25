Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E132783F8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgIYJ2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbgIYJ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:28:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C72C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:28:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so2764370wrn.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tO4g88PTeL3YugtnYW8r3i0Fso59FI9gNwUwFSYLPPk=;
        b=ZLSNVdwl9YYdc5LJKcAO7mMSdj4lA8XJUhGTNy18Hiiw0GFeAwVLrt7Ki2kV3M7txN
         FB4OM5DJLspbbfL4dgO15DjaXedxQ/p03/TQ7ej0/iQIXb7CD/As8exF5DufY0yLISji
         Sp7dxFyTz8q0NnDb43/toJ+5jMl9bJ2vd5eK55cmBxDj6IsKkYUC8zP+QFWKOlT2mUgW
         lF0hTDaXhJKQ8HTszaIVUrzVznP2rfuKf37h14Z9l+U0gOsXrNpU2nGdiG3Sy5misyJD
         p459qR0VpIgp/GSl4PTAm/RsrYn8W79l5PmmT9LXStVOabsxia0+9OBdDbwlS8ZRwMKe
         QIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tO4g88PTeL3YugtnYW8r3i0Fso59FI9gNwUwFSYLPPk=;
        b=p7F/bZ1rbKtCyVQyrhKTSQIh6jCJwagq35judJIjy48FVBV1EfkPIoWG/+bYPwhxFY
         92WqMZGgJ5BxG/D20qVjBTlZmWSMjEtfBy8WCyuHtIHAe+VX/WwJ9S+3RsmcOjSsXb5O
         GfEafUBS9RmnJNXmnCmmhA5DQTZv0cGNJfLTe/Ly1lKgGm0OJmOMsShn5Mk57OhpuDXE
         BqRBMPnnsRdTffJtXO2rEAIm7GLCbBMnrS3qoMIbKhp2eW9Yo1/+1On7sIMGNn5gXg5b
         JHpeJOy+uuB4NzbyGz+13WzHe5+OlQljtcOoSytqCmYHmXzriQhYlIWRyCzqoWyuo2nf
         jiVA==
X-Gm-Message-State: AOAM533cWUrQXWBmZyOnNqNL6TsDkmZP8nxJNqu8e+Xxy7nuEyN3WN9i
        C440styqVKjEed59VhCoBpvTIw==
X-Google-Smtp-Source: ABdhPJwJO2o7AdUOdSBVxDR9hgvc+Mqpq7gzWgIGyfrUqnmerA7YzUskVs4Tfq5sr41LAZ+6yOt/lA==
X-Received: by 2002:adf:db48:: with SMTP id f8mr3597511wrj.144.1601026113058;
        Fri, 25 Sep 2020 02:28:33 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n2sm2366859wma.29.2020.09.25.02.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 02:28:32 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, srivasam@codeaurora.org,
        rohitkr@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] regmap: add support to regmap_field_bulk_alloc/free
Date:   Fri, 25 Sep 2020 10:28:02 +0100
Message-Id: <20200925092804.23536-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usage of regmap_field_alloc becomes much overhead when number of fields
exceed more than 3. Most of driver seems to totally covered up with these
allocs/free making to very hard to read the code! On such driver is QCOM LPASS
driver has extensively converted to use regmap_fileds.

This patchset add this new api and a user of it.

Using new bluk api to allocate fields makes it much more cleaner code to read!

Srinivas Kandagatla (2):
  regmap: add support to regmap_field_bulk_alloc/free apis
  ASoC: lpass-platform: use devm_regmap_field_bulk_alloc

 drivers/base/regmap/regmap.c    | 100 ++++++++++++++++++++++++++++++++
 include/linux/regmap.h          |  11 ++++
 sound/soc/qcom/lpass-platform.c |  31 +++-------
 3 files changed, 118 insertions(+), 24 deletions(-)

-- 
2.21.0

