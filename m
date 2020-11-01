Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C1F2A2037
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 18:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgKARR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 12:17:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727024AbgKARR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 12:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604251076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=uuly4wAr/fzdpk263kpsg6J+QT6BwsiMCrn9kjrT59M=;
        b=KsiHa0hc4JMInEqbHBZyXFZwiyPzGFJ0WmObZr0EcmnCsDLbpZnGf0noZTTBKwUlexyMjZ
        tVR3ragnMxowor8Z6YEu/lnemYAmEfbelgr5z7nNhVQM4h4Em3cgRK8n9L9FO+TQUDbo9L
        01nGNpmpVQ8xK3Vtmv+h60p9uao0m3Y=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-KCjHjxOLNX-SXa3KAmJ-0Q-1; Sun, 01 Nov 2020 12:17:54 -0500
X-MC-Unique: KCjHjxOLNX-SXa3KAmJ-0Q-1
Received: by mail-ot1-f71.google.com with SMTP id n13so406659otk.22
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 09:17:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uuly4wAr/fzdpk263kpsg6J+QT6BwsiMCrn9kjrT59M=;
        b=biVtKIWUNeal20xydP3dDHCAL0r6vu73qHr2rd97XkHSzha8NY22JoOf9SrrGbyD55
         TYONd0+muhh49w+vbCQnfnptL4q4ZC0f2r45maTbCvsWwFv++QRN/4+Nw1+otO6ihRww
         +fzgAdNMZxbZ0k05mYQ4SHBxMtJqTrPgr+SpESIVpm11jrnF5usSqeuDwdJXc5N3/YDi
         tip/GuGiBwbdGMS6cyySDwd/zr9Qvyrqil0PBp49YrxcutCz5u6J4UW18pAKWUEC8swx
         p1p0DtPn/AXc7p9OC1Y8EE9zF7noN2PH+w7r/45cHqOC0ixx146x36mgRLJwVempF843
         2r1A==
X-Gm-Message-State: AOAM531dudQD/U1/uz5AFN+ZiO7cKz/3/yWGVxt+7QQ3pjK5mGn5kUK+
        CJn25ThP/sQtfbU+R9GLbhA7mZvf5HtmWmwuz4Df6cUFt5m/0PRzYRD7/k+cMKK7otzov7vNibR
        cTHGGD4rGlcpC2NByV374dIjT
X-Received: by 2002:a9d:3b84:: with SMTP id k4mr9883705otc.4.1604251073398;
        Sun, 01 Nov 2020 09:17:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQAVwtMBSipzPXHNXt3pGMhJq+m1IeDnexyQWxCJE3lz4owlX6fp7o5zeMAYeycBXI6n1i4A==
X-Received: by 2002:a9d:3b84:: with SMTP id k4mr9883697otc.4.1604251073213;
        Sun, 01 Nov 2020 09:17:53 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t83sm2883674oie.58.2020.11.01.09.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 09:17:52 -0800 (PST)
From:   trix@redhat.com
To:     steven.eckhoff.opensource@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ASoC: TSCS454: remove unneeded semicolon
Date:   Sun,  1 Nov 2020 09:17:42 -0800
Message-Id: <20201101171742.2304458-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/soc/codecs/tscs454.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tscs454.c b/sound/soc/codecs/tscs454.c
index d0af16b4db2f..cd1f1a592386 100644
--- a/sound/soc/codecs/tscs454.c
+++ b/sound/soc/codecs/tscs454.c
@@ -177,7 +177,7 @@ static bool tscs454_volatile(struct device *dev, unsigned int reg)
 		return true;
 	default:
 		return false;
-	};
+	}
 }
 
 static bool tscs454_writable(struct device *dev, unsigned int reg)
@@ -197,7 +197,7 @@ static bool tscs454_writable(struct device *dev, unsigned int reg)
 		return false;
 	default:
 		return true;
-	};
+	}
 }
 
 static bool tscs454_readable(struct device *dev, unsigned int reg)
@@ -217,7 +217,7 @@ static bool tscs454_readable(struct device *dev, unsigned int reg)
 		return false;
 	default:
 		return true;
-	};
+	}
 }
 
 static bool tscs454_precious(struct device *dev, unsigned int reg)
@@ -246,7 +246,7 @@ static bool tscs454_precious(struct device *dev, unsigned int reg)
 		return true;
 	default:
 		return false;
-	};
+	}
 }
 
 static const struct regmap_range_cfg tscs454_regmap_range_cfg = {
-- 
2.18.1

