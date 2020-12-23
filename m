Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CC82E10E8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 01:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgLWAyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 19:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgLWAya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 19:54:30 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3F1C0613D3;
        Tue, 22 Dec 2020 16:53:50 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id g20so20683017ejb.1;
        Tue, 22 Dec 2020 16:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jhwq8dFCnYRB1GRDZAa/1oWzJtmgPF7TILAcsF6Iqv0=;
        b=QpxCpqkRXdK+CKFv29ntOoplOxMiYGDU6xEVbswo2Fjw2p5tWIgtFrJkSUo0EZjSUF
         50ldsbvfJvwlqllT19d5ZjFj1FJzykrE86RcSmTd1hmaWurzBQWXYBFVpaezqXHeuS9y
         z3N34e9eriU00qmRlaZVEr6Uud6ML3gHiRJn/IrvJGcIDsiEwcx1xz+dHyG3YMNZHdqN
         5Ic8XdSRwoyhY869ZDrxFqnlL+gwzkBUGw8GBGNpBJuPUjC+KOuY/SP8M+h/OrYq7YKs
         X+Ki5zsUSeIfIrLzFZ39/z543soIBaHlYXc9hfXoCmuPXW9ePI0z3OYz5tJiC8lE1J/T
         Gr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jhwq8dFCnYRB1GRDZAa/1oWzJtmgPF7TILAcsF6Iqv0=;
        b=hViat7m2RV6Ga8p8iPkUStVjjtlpREQvEe1tQHD56PCAXN0pPo66KRUGnQJNR3JdqW
         MtOgpEgsosJVsYgV/2i1+0NOCzmEsJyvbpiMGF8fYVuoalamm+wSO0uM5R8VUNmY/YAU
         A9cZnQjYcM/LcUbbfzLyRn89PWpQ+c+xJW3+99zkl3JBDk5DIfqvPbhs6ZkIFWkSRFin
         rldGJWX1ZPD/Vs8Ijod04HCvBVav9pyzXz2Nj11fnF3t0zTdLQvhwVTAAJ3ECy72kWSt
         IKVaIRcB1bUQ8R+7ejwEpXw2gsJuPJWbmREOanQyl39SPG4SIy13ss+T/UvfA23KZsNw
         KUYw==
X-Gm-Message-State: AOAM53206JnqNxJ0l0t+UP70bOi/sBkW7fYz2b5/MFpNaM1Rk6Q5PYFp
        4t3jV+aFOXgK+Wvj01bzXg==
X-Google-Smtp-Source: ABdhPJxXgrXvFDYDXXlnCyFl+1D630wBoTUdP8V0HxqwsqR/txVDpIsK7cOzOgC7GCm6FH/bN5ohvw==
X-Received: by 2002:a17:906:a2d0:: with SMTP id by16mr21599305ejb.207.1608684829109;
        Tue, 22 Dec 2020 16:53:49 -0800 (PST)
Received: from crazy-nitroan51543.fritz.box (business-24-134-37-65.pool2.vodafone-ip.de. [24.134.37.65])
        by smtp.gmail.com with ESMTPSA id k21sm31625058edq.26.2020.12.22.16.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 16:53:47 -0800 (PST)
From:   Gabriel Craciunescu <nix.or.die@googlemail.com>
X-Google-Original-From: Gabriel Craciunescu <nix.or.die@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Gabriel Craciunescu <nix.or.die@gmail.com>
Subject: [PATCH] hwmon: k10temp: Zen3 Ryzen Desktop CPUs support
Date:   Wed, 23 Dec 2020 01:53:15 +0100
Message-Id: <20201223005315.20077-1-nix.or.die@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module has only support for Zen3 server CPUs right now.
Add support for Family 0x19, model 0x21 which are Zen3 Ryzen Desktop CPUs.
Tested on 5800x, 5900x and 5950x CPUs.

Signed-off-by: Gabriel Craciunescu <nix.or.die@gmail.com>
---
 drivers/hwmon/k10temp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 3bc2551577a3..5b1677d85b3f 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -448,7 +448,8 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		data->is_zen = true;
 
 		switch (boot_cpu_data.x86_model) {
-		case 0x0 ... 0x1:	/* Zen3 */
+		case 0x0 ... 0x1:	/* Zen3 SP3/TR */
+		case 0x21:		/* ZEN3 Ryzen Desktop */
 			k10temp_get_ccd_support(pdev, data, 8);
 			break;
 		}
-- 
2.29.2

