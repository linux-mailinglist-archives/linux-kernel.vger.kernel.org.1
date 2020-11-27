Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DD32C6E28
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 02:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbgK1BZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 20:25:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22062 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731216AbgK0UA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 15:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606507216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=FE1VeygfaaIjZiXkpb2+4qiM4KZKUB7XA3OmjLaRGCo=;
        b=LhuQcYZtTdIeGfAXj5c/nPymt173dW+h8u6aYVKGp4pnKW14fuCRK9fJGiRuHTdA39J4XR
        tuAAxXloYVqNBRgk3SCzsE+dmg2Wso6vuzgNfdssC9fVGpozNVb7LjSchiOAC+OeCyUNbH
        +79L5TJ6kVFnvlqlyJ6xX8H9VuqpkLo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-QgSwwIfwNW-p1ajINUx3AQ-1; Fri, 27 Nov 2020 14:23:18 -0500
X-MC-Unique: QgSwwIfwNW-p1ajINUx3AQ-1
Received: by mail-qt1-f197.google.com with SMTP id i14so3747098qtq.18
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 11:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FE1VeygfaaIjZiXkpb2+4qiM4KZKUB7XA3OmjLaRGCo=;
        b=GFUVQF8MxWsAqioNT/PEOcMlTx7Fz8Vr07iM3VCdX51w2DKRyPjFyuPk+SHGOB8j3M
         LfexnC98kfErrjpZ7MnG8NqVPG/ZJudtixiXk1HXR8HNhWAhWE5NJEf29k47wYFabZal
         WP48cfc1OyVdrJXM4iRcMIcCDR0QlzXwyU2icrq9xEQw8UhroaMXJKQzuRlc62od9Y+1
         dquoSD2lW4Ep9fnHkP+QpT+O9eLJW8Z8tx4a2JMg5CFHUGPsgjk6ryPPUN1LE5dPZReb
         riKrMDJ/Y7p9svt59SSHaiueqWKFhk2cfKxQBFSuoPz61mz3YgXkdXt2tUlHsacujDZc
         YkzA==
X-Gm-Message-State: AOAM532Ui8xeQH2qef7C0zdNsa4FTsFiSys7RyydG8khjn5hqlDkJPKO
        vlvERMf7Zb4Ja/SxaCwHrNYxzpqoO7kFucgDvQHqDAyila2sCpDUYc9Yh709nXGy8Kl3EQbCmhg
        5dTbUNzovk1Hbb/gTM2j5Ugle
X-Received: by 2002:ac8:48c1:: with SMTP id l1mr9740966qtr.341.1606504997600;
        Fri, 27 Nov 2020 11:23:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzR0qnX4kmZyDLuCqAE19U8+hDWgxoJ8eomxF1lEcQxzP9PivHfRg0Vd3CT64Ey8C9K/NDDZA==
X-Received: by 2002:ac8:48c1:: with SMTP id l1mr9740954qtr.341.1606504997430;
        Fri, 27 Nov 2020 11:23:17 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 9sm7231178qkm.81.2020.11.27.11.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:23:16 -0800 (PST)
From:   trix@redhat.com
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ALSA: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 11:23:12 -0800
Message-Id: <20201127192312.2861127-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/sound/hda_codec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index 73827b7d17e0..2e8d51937acd 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -344,7 +344,7 @@ snd_hda_get_num_conns(struct hda_codec *codec, hda_nid_t nid)
 #define snd_hda_get_raw_connections(codec, nid, list, max_conns) \
 	snd_hdac_get_connections(&(codec)->core, nid, list, max_conns)
 #define snd_hda_get_num_raw_conns(codec, nid) \
-	snd_hdac_get_connections(&(codec)->core, nid, NULL, 0);
+	snd_hdac_get_connections(&(codec)->core, nid, NULL, 0)
 
 int snd_hda_get_conn_list(struct hda_codec *codec, hda_nid_t nid,
 			  const hda_nid_t **listp);
-- 
2.18.4

