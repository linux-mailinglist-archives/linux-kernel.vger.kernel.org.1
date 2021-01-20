Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C0C2FD7C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404168AbhATSFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389415AbhATSCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:02:20 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654BFC061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:01:40 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o10so3725512wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JAOkhmmw4YQR+9PHOdtL+6u+JGaYw59w2erSNxO3s34=;
        b=zS+WYqe2z+ivR2E7NhWrRijMEKh3TXKg3og1Ym5rPg0gZ0gyFOQoEcCAvjtJqwaXRU
         3jlgt0XPHSPqjpAE7cG8TB0bjxoT3hodDywTSuYhpdFknpggZYEGHB52yqPuFTteVYeW
         kk2UXtwVP6CVrLOsk1nj8+Am6MAfCSAUEe4jo/jHqKVbs/+lNwiWXDcRDkS3wf29/Xsw
         aEtqcua0WJsDpatK47IZDrgVDJZhYeczSLMYPXJAzMWOmMd+aUiS9bU3KgphGE74D/GW
         ZWk2cVL5v9RPY5eMTZTZb+ENnFQ+4ggcgTAPoDHVEWsvVmDDK+gIk/EjO7UaxGIkB6Qg
         fACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JAOkhmmw4YQR+9PHOdtL+6u+JGaYw59w2erSNxO3s34=;
        b=IU0CVvKCdwoQBT6LtldRRY2OVYogREASy96LsEWsUb2zJ4CTWA3w5oTOajnD4jXNlX
         9nbyg6gVtCPiiMFTlRpypmTho0RS1cAkD1dQsvAJ/aVJ6zrt4+9H0LTvbIJ2vijxRq9k
         pIIVtwBdsxFX6KtteTuItMNM+Kbg7ff2cAOY5aeDJsLnvy46G8GLopJ9mYB2qKSO5Bp2
         zrb1LPpXYyyCO/ij4cOLtlPCAl5zmjL9AqmdjAxdHD1ztgA7ZgMRV4I0i57UwnN15Eek
         YPNXNjKos6FweCJJ3CH5czyyII9Z8N2cDlgPqWylIM5KJ1xQxNhNi6C4UTSbI4DQHhg1
         3TJg==
X-Gm-Message-State: AOAM531+J48sNlI/fcoZxMA5qn5O75E60xc138fY1OW8DUUojw/Ki6xs
        JUhnGAhNZZIz0n7ahFuuYDA2k4puVwlKtQ==
X-Google-Smtp-Source: ABdhPJyfoVE50bx/HXCgAJ0HczPq65R4zDz9RIgAi2BDIBSdZSIADIH7dz07Q9YIlnzDbFnyyw9efQ==
X-Received: by 2002:a1c:18e:: with SMTP id 136mr5528719wmb.69.1611165699157;
        Wed, 20 Jan 2021 10:01:39 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id g194sm5267422wme.39.2021.01.20.10.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:01:38 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 0/2] soundwire: add static port mapping support
Date:   Wed, 20 Jan 2021 18:01:08 +0000
Message-Id: <20210120180110.8357-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the soundwire controllers can have static functions assigned
to each port.

One Example : Master Port Num 1 and 2 are for PCM streams
Master Port 3, 4 can do PDM streams

Now Codecs that are on PDM should only assign Port 3 and 4.
simillarly PCM Codecs should be assigned port 1 and 2.

Other examples can include some usecase based mappings.

In such cases its not correct to assign/map any free port on master.
Currently there is no way to pass this static mapping from Slave to Master ports.

This patch provides a way to pass mapped port number along with the existing
port config structure during stream config, so that master can assign correct
ports based on the provided static mapping.

Srinivas Kandagatla (2):
  soundwire: add support for static port mapping
  soundwire: qcom: add support for static port mapping

 drivers/soundwire/bus.h       |  4 ++++
 drivers/soundwire/qcom.c      | 11 +++++++++--
 drivers/soundwire/stream.c    |  4 ++++
 include/linux/soundwire/sdw.h |  4 ++++
 4 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.21.0

