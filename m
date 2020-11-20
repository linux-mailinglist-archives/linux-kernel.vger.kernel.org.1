Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAECF2BA390
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgKTHip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgKTHip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:38:45 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5024EC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 23:38:45 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id v21so3178293plo.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 23:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BPHueWPsAzZX4KIbpi2s6NnCrn6gqE31TO7Qw8ZTpxA=;
        b=FOCqRMWV/Bcq2gUH3zBrLdf1fWn70LdOMd/c3/Ql46jWp6iKXzzUrCkXVmoDsrHO0y
         WilWcVIUP4BIQrKbjta2j2kpPZufPo8rfrEXlTJ2Uu8rBRUsMvY6t3BLYb5pfI75lAck
         t8/jCeBgTFSWmMS7S+27UeM9MLxYv12Z1g984=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BPHueWPsAzZX4KIbpi2s6NnCrn6gqE31TO7Qw8ZTpxA=;
        b=eQfbaC1A01MZsdAnb2cinTAutpgqPjvn7s7cmO1f0mvbr2HYO6NLgwnObuuYURjYIO
         comW38WRc1ivkp8tfawVge5rHrNlLjFrEbb/ARUs/AmbkJRx/II8quWoyId65Pqo/6iO
         rW6MLIzOUcMc/9vh7V/vsyJD3wX0QSSpV7T/VZbIkcZNLqKWP9axQF2N8Qqg5wYtmGvt
         xehurLXQU1mEcsHYkHsgeZsiPdrZJ2sc5jZwg8M2CT5A0rQ0TLib302dsm3rh8n7d9W4
         9SX0DrMLXaSuzGDuyaXCA1hZ00fQRoqL+nF6NTmVSipwTxNcWrIisxCYYrDltO7qQWtL
         z6bw==
X-Gm-Message-State: AOAM533kskeFEn05qovD05Ct6z3A7M7UfvOxEEQDeiwpFwK2+8wK8aCI
        dWA0rhzzU+KdPAQ88cyEDSMZ9w==
X-Google-Smtp-Source: ABdhPJwKINDMQKOdcjkPXg2iJjG8fKHb/zDVo/Wq0wmZWYnnZeuyXVNZYS1HqeVul8qCUnbH2q1Org==
X-Received: by 2002:a17:902:74c2:b029:d7:cce5:1813 with SMTP id f2-20020a17090274c2b02900d7cce51813mr12506702plt.50.1605857924548;
        Thu, 19 Nov 2020 23:38:44 -0800 (PST)
Received: from smtp.gmail.com ([100.99.132.239])
        by smtp.gmail.com with ESMTPSA id o9sm1742633pjr.2.2020.11.19.23.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 23:38:43 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH] iio: sx9310: Fix semtech,avg-pos-strength setting when > 16
Date:   Thu, 19 Nov 2020 23:38:42 -0800
Message-Id: <20201120073842.3232458-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This DT property can be 0, 16, and then 64, but not 32. The math here
doesn't recognize this slight bump in the power of 2 numbers and
translates a DT property of 64 into the register value '3' when it
really should be '2'. Fix it by subtracting one more if the number being
translated is larger than 16.

Cc: Daniel Campello <campello@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

This fixes commit 5b19ca2c78a0 ("iio: sx9310: Set various settings from
DT") in the togreg branch.

 drivers/iio/proximity/sx9310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index a2f820997afc..5d8387ed9301 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -1305,7 +1305,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int i,
 		if (ret)
 			break;
 
-		pos = min(max(ilog2(pos), 3), 10) - 3;
+		pos = min(max(ilog2(pos), 3), 11) - (pos > 16 ? 4 : 3);
 		reg_def->def &= ~SX9310_REG_PROX_CTRL7_AVGPOSFILT_MASK;
 		reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL7_AVGPOSFILT_MASK,
 					   pos);

base-commit: 5b19ca2c78a0838976064c0347e46a2c859b541d
-- 
https://chromeos.dev

