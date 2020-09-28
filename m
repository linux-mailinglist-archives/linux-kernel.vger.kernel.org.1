Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693DA27AADC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgI1Jgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726477AbgI1Jgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:36:44 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601285803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vdgbob2/GE0armxfZu4qtsuYa9c1RgVn2ZfRSAximtk=;
        b=TkHX7NKaiTzp9pqnkvqAlikfareB0WUgtrgpNIbGJhPZSQRSoiVLtTCxoloMkvtpsv+aUy
        vKn1LGZ1s2ZTGLSHqEkxJ03GHg4fKgVPmRE8U6axfj1NHW1JA8n4uWg0c6+O1P5WE/3H4B
        ktzRHfnAjhHElgN71T9qc/8Vj/+2qjo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-xFdxArSZOtyU8NCVaaEv_g-1; Mon, 28 Sep 2020 05:36:39 -0400
X-MC-Unique: xFdxArSZOtyU8NCVaaEv_g-1
Received: by mail-wr1-f69.google.com with SMTP id a10so157737wrw.22
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vdgbob2/GE0armxfZu4qtsuYa9c1RgVn2ZfRSAximtk=;
        b=oFN+Dliry1sb0iQbTyTJsqCv+2Jvq2/i2XwUdwrfeZFw/dyGRC5ZkZYEJTBRwQKcaJ
         4lZfsjXlU2x7BgNwuB8/xL4+uQCThyy9hDyq1oygoAYTgU+GpjMwW/bWUp6cZyb62X9I
         b4ue7W5Dca77Av0r08O6K+Nh/ik/RJzcNENS9SIPB3oZQk81WorRDGprsdZjXYXjyg3K
         mDnjaRSwLq4X/3hg2qbaUXdFKLlDDy4ug6Ze9e0O0+N7egg0vbvZB85WGUcG0o/eNe0w
         lQztoR4jKtyjSsBmnTXn/tOY2yg/3+isYTzhQnZOKd7uQPSwtrKrDApAld/vx1b64vNB
         DlbA==
X-Gm-Message-State: AOAM532aQgK5bmlIxTatvmnul2MTb47Rz3c4EcFF3iynBEG2mPdLhLB2
        vfkLKJA5xJsxWwt+L7XkKE8qujBWuJANEqhMtTFnntbXKi5QETvz6wG/Cu7/WZJKECdWM5Kdi1V
        Kwi2eSvAdE+FCj2n46XtBBWnp
X-Received: by 2002:adf:edcc:: with SMTP id v12mr672675wro.240.1601285798381;
        Mon, 28 Sep 2020 02:36:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfY3SJelJZWBz2bbmEbzUUt/h66PBxvrq+C+TgyybqMy+jynj46kmyFfyrPfhPtJyvFYr9kg==
X-Received: by 2002:adf:edcc:: with SMTP id v12mr672651wro.240.1601285798174;
        Mon, 28 Sep 2020 02:36:38 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id y207sm495967wmc.17.2020.09.28.02.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 02:36:37 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 0/3] objtool: Extend CFA updating/checking
Date:   Mon, 28 Sep 2020 10:36:28 +0100
Message-Id: <20200928093631.210610-1-jthierry@redhat.com>
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

Changes since V1[1]:
- Minor cleanups/rewording from discussion with Josh

[1] https://www.spinics.net/lists/kernel/msg3662146.html

Thanks,

Julien

-->

Julien Thierry (3):
  objtool: check: Fully validate the stack frame
  objtool: check: Support addition to set CFA base
  objtool: check: Make SP memory operation match PUSH/POP semantics

 tools/objtool/arch/x86/include/cfi_regs.h |  3 ++
 tools/objtool/cfi.h                       |  2 +
 tools/objtool/check.c                     | 54 +++++++++++++++++++++--
 3 files changed, 55 insertions(+), 4 deletions(-)

--
2.25.4

