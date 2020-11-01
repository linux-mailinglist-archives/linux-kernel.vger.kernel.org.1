Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88392A1F63
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 17:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgKAQDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 11:03:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726730AbgKAQDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 11:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604246600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=IO0WphOpYfe5qfktjcb4gZWmqgtIIkYaSyI84BD9VQc=;
        b=aAMAr51Z7sLV6efZTKAhqzTpohpBlVLu3rRByq3DblMeuJWOIqO3I6wtb5tXmgm/QnPF6E
        eDdkGlCgG9d8k+mDSz4JYJoFCKvVb8P7Qmgme1vU0ecnZFbVJaY+YvmyAO5tCy8h/secJK
        YaDitMaBztIA87YQCckFtWXZkxaUeFc=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-H8bXcTOANzSZNNcAQPiWjw-1; Sun, 01 Nov 2020 11:03:18 -0500
X-MC-Unique: H8bXcTOANzSZNNcAQPiWjw-1
Received: by mail-ot1-f69.google.com with SMTP id e5so5212965otp.8
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 08:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IO0WphOpYfe5qfktjcb4gZWmqgtIIkYaSyI84BD9VQc=;
        b=I0DfkWhvicWlJRBeHaqyHVm2KrJ+Qn8wXBYFGXSt4XgytfzENeNk1MUme7oQA7YKZH
         RYcMJ3JwUGHyNu/mYSnqmPhoIileGi4LOFI8TInxtsv33OPMBoc/0Zft2ui5hWRyrD7k
         DN9esiAkqyBRK7Ny9d50GpbDGru5EpzhT+8tYxnBA67fpNFbVqfSnV3DKUtnX2Apqrni
         Jr77cg28q1ZWaEHs20DzwD9G8gQ9JG8XXfLGY5mT11hNe7ukMaYFTeOppbmThPpbGBPy
         2tGqqNJYOiiEW6PYVL0j13Q9Wq3ibAm2UtwRC4DOUQq1sPIkpaz57e8QohKKXSCtpAQT
         ILHQ==
X-Gm-Message-State: AOAM532AsCvLXB12HQmZJxFcNCSxn6AH6A3BhPg24b1nG9vZ5WDWdApQ
        DJlhWzZAX5zcM9zZKXfDnFG9rip+ZBRALxHzqiX7GaaToOkwltK7wVs1rcbIeC1w8Qqz3VmKY+o
        idPiPJc2SR3l+x8w8eMEzLhSx
X-Received: by 2002:a9d:6c16:: with SMTP id f22mr8504199otq.173.1604246598195;
        Sun, 01 Nov 2020 08:03:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0NVhAd3RAFy1ChJ73q5Yk5OCmScu2Gyt/6ini7be7gafypppYbsM9VIcGjknqQa0IpZA2LQ==
X-Received: by 2002:a9d:6c16:: with SMTP id f22mr8504194otq.173.1604246598034;
        Sun, 01 Nov 2020 08:03:18 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m13sm2983573otn.20.2020.11.01.08.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 08:03:17 -0800 (PST)
From:   trix@redhat.com
To:     steven.eckhoff.opensource@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ASoC: TSCS42xx: remove unneeded semicolon
Date:   Sun,  1 Nov 2020 08:03:12 -0800
Message-Id: <20201101160312.2296146-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/soc/codecs/tscs42xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index 3265d3e8cb28..6200fab7896f 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -66,7 +66,7 @@ static bool tscs42xx_volatile(struct device *dev, unsigned int reg)
 		return true;
 	default:
 		return false;
-	};
+	}
 }
 
 static bool tscs42xx_precious(struct device *dev, unsigned int reg)
@@ -81,7 +81,7 @@ static bool tscs42xx_precious(struct device *dev, unsigned int reg)
 		return true;
 	default:
 		return false;
-	};
+	}
 }
 
 static const struct regmap_config tscs42xx_regmap = {
@@ -1294,7 +1294,7 @@ static int part_is_valid(struct tscs42xx *tscs42xx)
 		return true;
 	default:
 		return false;
-	};
+	}
 }
 
 static int set_sysclk(struct snd_soc_component *component)
-- 
2.18.1

