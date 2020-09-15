Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A66426A0CB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 10:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgIOIZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 04:25:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51976 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726161AbgIOIMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600157532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pEjuQVEDncAilcZkvQzCurrU4ec16+YfsdoF8HmqmaY=;
        b=MO94vVD/+1ttlYpihkn1mHI+ClqU2heicbBHInQECSMB3r1Z2Mazv83XmTaka/KbvuvPUD
        bOurX8hpIX4ZseCeXCZ9YWrs+j8bW3s5moa1RydtVFtynGeyWyFl7VGm3aMyVxKCpqVxbk
        cf4/4N7QO73cwhgN/FGK/qEHU91pOl4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-3CDNik5kO26_4fwas83FkQ-1; Tue, 15 Sep 2020 04:12:08 -0400
X-MC-Unique: 3CDNik5kO26_4fwas83FkQ-1
Received: by mail-wm1-f70.google.com with SMTP id b14so887799wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 01:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pEjuQVEDncAilcZkvQzCurrU4ec16+YfsdoF8HmqmaY=;
        b=OccU1l3arvIVPXPCh6anutjfiUkwMElssELWF6tw0fUqetamPzGd5Q2B198t3cMITb
         Z7E9apseGRSxvLy0v4hcXtrH40fxWq3bWKKPNf4ujUtnwLlPM2vzyLL2JWfoFfjgMqBk
         gkdH2Tw0gJewWOOUGSMnb7DUeD3YhlcUFzjH5rUfPzap0PdQq3aMRbiDV/Jt4jdi+q9U
         QEQEnXYlUowmFc6D0kNr05t1YjfSiUuCnUKf2BKtzSP77qUgjnDwP26ZameqGrfo9XZH
         02bXuFI/yqStGGwfBk0i2qtW93sJPG8KW11VzV3L1E3Re61kyvxNlIFFrZhTZoB1Zdl6
         tRkg==
X-Gm-Message-State: AOAM533bSsJeksyUmrWOxZ+Ctc9So3g63NvjSHiVYTrtXBbUIMoOVDi/
        3lVs7xE0aYOqR6t34fbmfGwzUGTAoec6fWbutrdSY8z2ifuOyjqWztnhVloDSXa5QSdB+tbOwNU
        +xAB/LDybUsd++AMjr77c3OyA
X-Received: by 2002:adf:fc92:: with SMTP id g18mr21353786wrr.201.1600157527306;
        Tue, 15 Sep 2020 01:12:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVBs6+ANvkbH4sIZOFylLCk93ltz94X3juDXbbDJL7dleYI62JAcfgJmQ0A0o1nHtTPKo8iw==
X-Received: by 2002:adf:fc92:: with SMTP id g18mr21353755wrr.201.1600157527045;
        Tue, 15 Sep 2020 01:12:07 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x16sm24661372wrq.62.2020.09.15.01.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 01:12:06 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 0/3] objtool: Extend CFA updating/checking
Date:   Tue, 15 Sep 2020 09:12:01 +0100
Message-Id: <20200915081204.9204-1-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches are the result of limitation found on the CFA
management code when trying to validate arm64 frames. I tried to keep
things simple and not contradict current CFA management logic nor
introduce too many corner cases.

The patches apply on top of the cleanup series[1] I sent previously.

[1] https://lkml.org/lkml/2020/9/15/199

Thanks,

Julien

-->

Julien Thierry (3):
  objtool: check: Fully validate the stack frame
  objtool: check: Support addition to set CFA base
  objtool: check: Make SP memory operation match PUSH/POP semantics

 tools/objtool/arch/x86/include/cfi_regs.h |  4 ++
 tools/objtool/check.c                     | 47 +++++++++++++++++++++--
 2 files changed, 47 insertions(+), 4 deletions(-)

--
2.21.3

