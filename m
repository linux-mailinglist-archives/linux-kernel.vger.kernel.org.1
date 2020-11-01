Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70592A2049
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 18:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgKARVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 12:21:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39204 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727087AbgKARVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 12:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604251296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=j4Fd3vNf6QkiJ2K1fA3WX6EFw4MpOCKOi1CDGbw0lNw=;
        b=YMrKEBCTvrZ+C5BV+u4IxfyMPRJvommXKM1edpSyZNtoDM3u2MxsBTFSe2Xf3m0uZMaWzF
        T9TUGk99xv6Mh19mJKwn+wPpFB7Bp+u9FSTNXZGbKuKSm0jx7lJpY9nwsNRVMKRn0nKYHa
        qatXSXu4Ta0fmoQdxaz5EDdDaC1udLc=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-39HG4Y0OPla0QgvihZCvQg-1; Sun, 01 Nov 2020 12:21:34 -0500
X-MC-Unique: 39HG4Y0OPla0QgvihZCvQg-1
Received: by mail-ot1-f72.google.com with SMTP id b22so5274725otp.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 09:21:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j4Fd3vNf6QkiJ2K1fA3WX6EFw4MpOCKOi1CDGbw0lNw=;
        b=mhc/DzuhQUt2ttwGNOsgG6FbmDkJk1FxDICybbL87QayDaymLQuW8plzwLpoXxLb0G
         H7xmJVZ95hQy466XxIxBARD+tZ8Hsp5Zb/efnmrajEbNDd4UwFaSrviEHVQV1iPcuXOy
         40zejYLZIORY4l4Q3HWP52h9Rk9vbVLhMq/hrKkARr4yGvfFQQS8KM0/Dwn5EdAIkO5Q
         boJIPxrpYbf9SEbAYaI2heo8wKfv5Pz8BAjAQrRX/x+nBJmBXrL0IcmG1RmzNYJS4sDR
         GqmBjAMQfPOYj39e9HEg9jHmA+eM514DRuMlJTYTgytPrKX4kRPgHFBu5ugxd35Eau32
         FKrw==
X-Gm-Message-State: AOAM533fVW2AumAY50zkQKJ3xVI6n2N+IAeYC2uCGKKouKk3H6uV0Te9
        RxUiOlqEVfg6zHR4d6G4uOsngHmQNPDDbQtt2bIFEaTgBoWhpC1zaD2ioI7UuwbpGi3hjn5hflH
        qmc12xSM7i72o40aB1moL8v8t
X-Received: by 2002:a05:6808:696:: with SMTP id k22mr8123465oig.107.1604251293922;
        Sun, 01 Nov 2020 09:21:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhggkrimbcrzhi+3d89K9YE9zyRIbl7xcXdDmd6ao4Lvit7XtdyjCGL1x9+BZ19J1MOGOvMA==
X-Received: by 2002:a05:6808:696:: with SMTP id k22mr8123461oig.107.1604251293781;
        Sun, 01 Nov 2020 09:21:33 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x13sm2965686otg.66.2020.11.01.09.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 09:21:33 -0800 (PST)
From:   trix@redhat.com
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, kuninori.morimoto.gx@renesas.com,
        srinivas.kandagatla@linaro.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ASoC: wcd9335: remove unneeded semicolon
Date:   Sun,  1 Nov 2020 09:21:28 -0800
Message-Id: <20201101172128.2305539-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/soc/codecs/wcd-clsh-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd-clsh-v2.c b/sound/soc/codecs/wcd-clsh-v2.c
index 817d8259758c..73258e292e7e 100644
--- a/sound/soc/codecs/wcd-clsh-v2.c
+++ b/sound/soc/codecs/wcd-clsh-v2.c
@@ -507,7 +507,7 @@ static bool wcd_clsh_is_state_valid(int state)
 		return true;
 	default:
 		return false;
-	};
+	}
 }
 
 /*
-- 
2.18.1

