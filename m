Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9474E2240F9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 18:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgGQQ4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 12:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgGQQ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:56:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706DCC0619D5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z15so11864076wrl.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3yCjZzdqVBjfabIra8KmWX21RZUH0S4lOrIP/Y6t4jI=;
        b=rmUQhPd0dNStDC+2Z/NUOcKEElQLXqhPkITlP2X7v1qD5nVOC1XVqDMgcIkmF9jena
         NiddjeEjlHYmNjv3YAI+tgN1axWWTlnmwk7XEJvJA4yUHBqWjPob7ivHsrjynV/o7h89
         t7b0uBQ9Tp7B7XRVWinbi5yWBFhvI5fNmVzh5Ecm1N9PYZYltSHjRBoW0ptN8G0IuWlt
         R/wWGxwJnEzGy7H7bMCFgP3Q5WLgVKqC1NAd7nlw9co70FapzFoWhU4bThNXIzNJ7/oN
         N42VGywbYYbw1uUlT67iWdwO13+R4covjdL190KEWPvaGGVFamNHMDzELRa9vMKAmxWU
         mqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3yCjZzdqVBjfabIra8KmWX21RZUH0S4lOrIP/Y6t4jI=;
        b=HXySzNadrGJXzw5kP/XOAnQecdnD9bCkEHL7A1/CEj/LSOkkNwEHafCs+Ei49M3aQh
         aJL2PekvYYR8RR9DkXI2RLiyHpHs9qOMdlMUKsnDxjz7nZtC7MlEqBelTIQyDn7GDCkf
         pxTghXQTGIMrTlruNjXHIvUnEE/+Yq93C9b/jvTeDh6mcCESW2dIWJ5XN4EZI4UDL+Ju
         8lSBAlBUcO5x4N+BHDIJcRGYkssMCuYoZdE0kd9vMryV+BB0GTaAmyDNYqDiwpF33ofN
         HRKMGpceHXMT93siVsQsT9pBZSQ3fweej/HmtVa9qhqHd39+E2n5N5rwS+NmoEgzYNVs
         bz6w==
X-Gm-Message-State: AOAM531e5isolyT6GrgmGeOMi8xE/yEftne9W2i0F6xx6vYcuxFPfYKU
        dxelRNJt5EYeH51AziF4Pa6UIGStEHMnBg==
X-Google-Smtp-Source: ABdhPJws+AORrTjb6PwxGFZBmbZXNWopNyC6Ln4tgH2AO7EQW5uDtQ4Lj/rjWAAuzac+5ArTk0DDcw==
X-Received: by 2002:a5d:4c91:: with SMTP id z17mr10935922wrs.267.1595004982145;
        Fri, 17 Jul 2020 09:56:22 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 21/30] iio: adc: max9611: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Fri, 17 Jul 2020 17:55:29 +0100
Message-Id: <20200717165538.3275050-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document any of the demoted structs here.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/max9611.c:117: warning: cannot understand function prototype: 'const unsigned int max9611_mux_conf[][2] = '
 drivers/iio/adc/max9611.c:145: warning: cannot understand function prototype: 'const unsigned int max9611_gain_conf[][2] = '

Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/max9611.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index 04d5ff7d2c8ec..3a361299a70f4 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -110,7 +110,7 @@ enum max9611_conf_ids {
 	CONF_TEMP,
 };
 
-/**
+/*
  * max9611_mux_conf - associate ADC mux configuration with register address
  *		      where data shall be read from
  */
@@ -133,7 +133,7 @@ enum max9611_csa_gain_params {
 	CSA_GAIN_OFFS_RAW,
 };
 
-/**
+/*
  * max9611_csa_gain_conf - associate gain multiplier with LSB and
  *			   offset values.
  *
-- 
2.25.1

