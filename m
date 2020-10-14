Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7200F28DA8D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 09:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgJNHiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 03:38:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728208AbgJNHiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 03:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602661089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SAEY/Zpbkl/XgbPMQLeAmZDA/PzkXRRi5ZfbA8Z/nCY=;
        b=I7ITeHCtPqkgx8wSFguSEYFLsNV90zS0k3wAGSZ2dXHpY7R9SYqd/rV/6A8wodbw2hUwhR
        4ZfKWDgMQ3DfdoncRoDeJMtaeGXEMB2m+tla3daPwF1zlMefZfMlDHs3VVeFChPG42ZhT6
        ofAOp9etekiYokz8QXM+/VJh238H5CU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-nXMqgdlYNDCmXCbmx5HrhA-1; Wed, 14 Oct 2020 03:38:07 -0400
X-MC-Unique: nXMqgdlYNDCmXCbmx5HrhA-1
Received: by mail-wm1-f70.google.com with SMTP id w23so240476wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 00:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SAEY/Zpbkl/XgbPMQLeAmZDA/PzkXRRi5ZfbA8Z/nCY=;
        b=f6DGtajMmATQDtIdMaV5Nh1fEQTAY4LHKTP+kly7swFg4D+s3OQnhfGu26hwQsMeLk
         eWDTOZ0qhy5j0AehuBXmPDKUipkPaU5XbuKoggukJu0Ul0n+PuqY9ui3Ohy8vnSVFoH3
         VSUxwA6EzGnBKrFyjXDXbUSCr7RKiCEYfFKs6qFsJG6JxxhVedwLwsy0p3r5Zduu04pW
         5BCpC5shw3WVeKZV2ib1vwW1O7xnCdTTn2BKZYGfIAOBLSfVcMkAy2Oxvc8rTElGjFwX
         7zIMODOvssw8kzxoa4bmjjBDDQ7LSlWxOrGyll17BQm4m/YwntahG35T+4XcfecapLzY
         mYVg==
X-Gm-Message-State: AOAM532TXFHx7xZyn4bttYhzHWA4oveQivwlzwwJPNXXugPnKzwlWSzs
        we+FZhP4oy75ezWDz5bXHeSBgBZA2+hBO8wk+LKTooyqkV/qgb50Jn6x+Vi+k77wafiVNKPrRke
        lEPDyDzuZqJrrMKhkErhoFaZ4
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr3730631wrj.287.1602661085563;
        Wed, 14 Oct 2020 00:38:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyysyYOcx2r3Z2x4aRWN4/ATbE+CI9DTvphe6931ZSMbCL+aIwE8v3S6AKNv4ppKsMdUXSjtw==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr3730620wrj.287.1602661085415;
        Wed, 14 Oct 2020 00:38:05 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id y66sm2618360wmd.14.2020.10.14.00.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 00:38:04 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 0/3] objtool: Extend CFA updating/checking
Date:   Wed, 14 Oct 2020 08:37:59 +0100
Message-Id: <20201014073802.436630-1-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches are the result of limitation found on the CFA
management code when trying to validate arm64 frames. I tried to keep
things simple and not contradict current CFA management logic nor
introduce too many corner cases.

Changes since V2[1]:
- Simplify cfa offset checking for BP and return address

[1] https://lkml.org/lkml/2020/9/28/354

Thanks,

Julien

Julien Thierry (3):
  objtool: check: Fully validate the stack frame
  objtool: check: Support addition to set CFA base
  objtool: check: Make SP memory operation match PUSH/POP semantics

 tools/objtool/check.c | 46 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

--
2.25.4

