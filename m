Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF012A083A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgJ3OrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgJ3OrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:47:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE4FC0613D2;
        Fri, 30 Oct 2020 07:47:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l8so3192649wmg.3;
        Fri, 30 Oct 2020 07:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ScZ+VzP1QYcZfstHOxjjBbZNAzcQQLSuH0DC5A967ic=;
        b=HDeKD/cMtLiNV5ZI3CH312ywH4G7LVfd+AlUSoSURojP+LK8mOCwVR+uATUr+vVUcV
         xPuxgxsEtD4DKydBTdBliDNbh3ffeb9mgXSY4Q4TMeswQg9hEgT0Uh8hy5qkTxlOP+uo
         K7kWGlcA3q0TA+3UReaTq3Vi5MBMRkohTDiCEdVbgCe61iwZmB7gV1dPvJNElhGQpJrr
         4HULxXM/ZpyyFIw6mkz/CPLJnRCtBfoigpvgMHFlwrLsUPIWjSM20bLAp6aZLpDhu4B/
         Vwhi1hpGddWys00jpzkggjYHa8CkLrGs+kdKSV3U3FUn3FTovVh9UiidvgS7mvKHZASN
         efow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ScZ+VzP1QYcZfstHOxjjBbZNAzcQQLSuH0DC5A967ic=;
        b=ifLMpde1ahXyV2uA86o7TNMI1656E5ZBPUm1+sL6yRlqU4nzG9HaSWCpEOIPC2jGEM
         K9rNyNI+WVrbhapv5wNhPfLGVJiwV3YF5F4q06doQRK8jL4UtNkMPUHCxfyJIRZ/AJUK
         6CICghUS4vXYRop35cYpeakPJSU2VcG7MTrf/K3GSg+OagrP3l8zPukXUPXb3zTA/j9s
         f7SMbEtoGmsW29IJuzZ2HCm8Maldz/Pox9QaMreyiRMPGKYx5IaoYBqGApwjV0XSsSJy
         cwrgAqGgjvJVufl1039erE7fKGS9e6JhvPuYpSxLHkZj6xeB9C22U2Hp+E0YWEyqGmD/
         ihpQ==
X-Gm-Message-State: AOAM533joeW5XMH31zRvAKERfs2USA2spAOTgXV9D8WTkaM7+wwiFCib
        YcXY1hm4s0ETReg/kqTjo5iN0lA7vI4=
X-Google-Smtp-Source: ABdhPJxASGYs7QMUz4F5m/JlOUcIg5llz68iga1rHeYUKCzCIjk8CZAUY04aXGOtXP4RVskZhmNVzw==
X-Received: by 2002:a7b:c858:: with SMTP id c24mr3108010wml.176.1604069234977;
        Fri, 30 Oct 2020 07:47:14 -0700 (PDT)
Received: from avogadro.redhat.com ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p21sm5058785wmc.28.2020.10.30.07.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:47:14 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net
Cc:     Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 0/2] kernel-doc: Handle function typedefs
Date:   Fri, 30 Oct 2020 15:47:11 +0100
Message-Id: <20201030144713.201372-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

QEMU has been using kernel-doc for a while and we're very happy with it. :)
These two patches are relatively simple regex changes that were done to
support QEMU header files; they handle function typedefs (i.e. not
function _pointer_ typedefs).

These are basically the only difference between Linux and QEMU kernel-doc,
so I thought I'd just send them out and see what you people think.

Paolo

Eduardo Habkost (2):
  kernel-doc: Handle function typedefs that return pointers
  kernel-doc: Handle function typedefs without asterisks

 scripts/kernel-doc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.28.0

