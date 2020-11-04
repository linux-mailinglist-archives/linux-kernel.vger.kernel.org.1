Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E711D2A6E1F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbgKDTgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731630AbgKDTgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:48 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C92C0401C1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:43 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id k18so3415766wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rOx6EKMe9cLEX5sCcL9yNRuSAjSnTgf4TrAZByBH0nE=;
        b=qVwnI2M8dZxrSdw2NYNyI1lLWDIuGyCXQiXDLe774cujI3X6oAAmgavLSwTiER1y5C
         U2kyPWcGevQNkpIq5JDP7Q5VHeG4gHzn2H0jjZ/QLcKUGjfGjPavXwgJP9NhgDyFkLyY
         o4WKRfQQBGlVWy25tgx6jah6MO097KE8g18EGnwcn3WmdDECR5x5/+uOwH0Ety3jDpIb
         J1BcLEfUZYeqlJ+fdICUz31xKs4Orxj06wqFw4TLr2MdxO/cYfCPhoLmDiFHr5jsUC7A
         npsMDFfi1FWDOgG0fj+1o/TPxF9XGYOEzKmvWhlATt1osyGqQeQju7vaeiLevVmEyfE+
         7ABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rOx6EKMe9cLEX5sCcL9yNRuSAjSnTgf4TrAZByBH0nE=;
        b=tJhnYBrl1Iu1NaI8EA3gXjWiVN13YX1r8zMpnC7xb/G5aBI8RJrZwFox6bIr4JND/w
         udGRrg9inx8Ui9e2K0c4vl0k3itMU6I5UWkazqNF+iLjVu9NP+7P/ykvV6xlWCnlRvgf
         gknDNV6TtbLknblU6uJJI5VACnsHWFIEpb2fMFBghioc+qEO5/C/8MhqSZwlDIcvbdr4
         JvoW+NyKhSwvNpa9joqBQWBCD4eL0k23bVZfMSVpoYGxW0ZNAnM72g6rKYOmfuN7xknJ
         lHi409v1V+f1s/AGE2a0siqk/oH1UnioAOcVfz1qBsa1DQ3ctSjVZfVtXiqE2NWRP6yf
         LXHw==
X-Gm-Message-State: AOAM5308XEiSGZFr2UM73Ch+k8jH/rW6Z8le7LwHkAq/4AR/gleRd8lA
        fse2yO8F16Fmw94kOp9Rj7zKow==
X-Google-Smtp-Source: ABdhPJzZgbv77ExAlMXXCPrJvnvMKI0TTcxO2Q9EkGZtYjF5woyXQgOnFRmNMb//r6HFp6TvcnFuQw==
X-Received: by 2002:a1c:a5d8:: with SMTP id o207mr6274133wme.0.1604518601877;
        Wed, 04 Nov 2020 11:36:41 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 29/36] tty: tty_ldisc: Supply missing description for 'tty_ldisc_get's 'tty' param
Date:   Wed,  4 Nov 2020 19:35:42 +0000
Message-Id: <20201104193549.4026187-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/tty_ldisc.c:160: warning: Function parameter or member 'tty' not described in 'tty_ldisc_get'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/tty_ldisc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index aced2bf6173be..1ba74d6f5e5cd 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -138,6 +138,7 @@ static void put_ldops(struct tty_ldisc_ops *ldops)
 static int tty_ldisc_autoload = IS_BUILTIN(CONFIG_LDISC_AUTOLOAD);
 /**
  *	tty_ldisc_get		-	take a reference to an ldisc
+ *	@tty: tty device
  *	@disc: ldisc number
  *
  *	Takes a reference to a line discipline. Deals with refcounts and
-- 
2.25.1

