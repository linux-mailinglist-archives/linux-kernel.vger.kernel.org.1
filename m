Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B0428A810
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 17:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgJKPwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 11:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20604 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730174AbgJKPwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 11:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602431526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=KQnb4CH7LT3cdQtsJpo37voSU/mfPI7rXeisXRwZ6eQ=;
        b=eaYuFmRVAij+gSFDlPLIO64T0ohs+kkqau5f1k1hO3SmMNuNbFOWIFDCjckcR4oc9VFOGK
        uTGxFmvI0OpSW3WXeaUk3EWqLIiGzB2czah1a4ZWi0BxB9zysOZC35GNoWZYgeferCbjBp
        +WZht4InWpIzubvbVC4b4WRZ4Sy6V1Q=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-plahEFQlN1uOt6VFmCmm-g-1; Sun, 11 Oct 2020 11:52:02 -0400
X-MC-Unique: plahEFQlN1uOt6VFmCmm-g-1
Received: by mail-ot1-f70.google.com with SMTP id v7so5212779ots.19
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 08:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KQnb4CH7LT3cdQtsJpo37voSU/mfPI7rXeisXRwZ6eQ=;
        b=djDv6vGRjtoAOf6A768dWwE/yTmhvJHt6jkwZdkSknu+r+MM1NIP3ksmsG0nkmJQQa
         b4ZAjzm8GQ3UMFzxFOL/Ht5uWKyz3u9zY2h1z5HJUETEanUm55Wm31a59j8V3Cb04X0c
         P/ek/9CpFCWK9Dkrmm0WoTNIc5JXhofUp6ks0rr3a4uj81Z1opJA/HV+ogcRMsTQxDuF
         ycxKd2mabCEHypI70gwr2fks4mQQ/TpH1vl1Yyr9/alw2Kcbk5s+/zSThLDijltFwNbq
         H+sXnNKOTL/g3g/fwALkfsJ6PYjovoZkycoeX7u+M7BGh16vKjvH2hGBCjYx3cIvccuj
         uVIQ==
X-Gm-Message-State: AOAM531UwGYG+rymqiYZQPRjocfAsKC9CHZ+WgN9DYOep9XOKXTXPC6f
        cZITQUeAsKzhY5511zCMv56pKWr7V2R1cu502mBy0vN2ILVngMeQ56gYLFSn3ea+1Lzkrc00JDd
        FmOol3W/ke3F//mk/drD/fIqg
X-Received: by 2002:a9d:2264:: with SMTP id o91mr14637419ota.24.1602431521850;
        Sun, 11 Oct 2020 08:52:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1SEkn1HK15DwepPB+QXg6E52BH98J6MiRVEFvjsYtV5EAeQiPN+9fCaC/ZFRcsjNrOBDfAQ==
X-Received: by 2002:a9d:2264:: with SMTP id o91mr14637411ota.24.1602431521631;
        Sun, 11 Oct 2020 08:52:01 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q8sm7920611otf.7.2020.10.11.08.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 08:52:01 -0700 (PDT)
From:   trix@redhat.com
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] nfsd: remove unneeded break
Date:   Sun, 11 Oct 2020 08:51:55 -0700
Message-Id: <20201011155155.15538-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Because every path through nfs4_find_file()'s
switch does an explicit return, the break is not needed.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/nfsd/nfs4state.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c09a2a4281ec..741f64672d96 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5722,7 +5722,6 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
 			return find_readable_file(s->sc_file);
 		else
 			return find_writeable_file(s->sc_file);
-		break;
 	}
 
 	return NULL;
-- 
2.18.1

