Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7877428393F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgJEPML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:12:11 -0400
Received: from mail-qv1-f44.google.com ([209.85.219.44]:45160 "EHLO
        mail-qv1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgJEPMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:12:10 -0400
Received: by mail-qv1-f44.google.com with SMTP id w5so2053779qvn.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 08:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BSJ3P3KkGw45fciVj/f+mboJnQ+bOrmHm/xdLDFvhTY=;
        b=n9PkvFWpMaehImr/TEIKu1+VAYTvLWIb7iEvGQa1mhqgbpYX+I7kca13IPu47buTfB
         4rW/e/wJQdiflpoXZ9xPyaMoDBLiY7w6zvvBXbikNEy/ms1iNylSFPQ3tjrL2Wy9M2Gm
         DFlGT5r7u+oRPoZWb9471WXkmJATp9RHRrk9PoU6hwBkp4kZ2b23jK5Im/IH8usj8MMI
         c7vCa33EkK+a5kN01580Khc7kHc2i+LYj8ry4CE7FdpLJdIK/UbVKHjFkxu9NX2PvafS
         5Zz7BrCG8Q2yRjSLArB0twrObNt7l7usw6g0gP6m8XVXC7oh8mq5qY6KmQiQOiysTFWF
         uqVQ==
X-Gm-Message-State: AOAM530h6clOC3EPUY6DPrAHLHuPx8SwiCrM43o9aTuJTbq9mF/6rl7r
        91gcN0duwekyo1LIjBrFgYk=
X-Google-Smtp-Source: ABdhPJyE+qvwmV6xlLsbC3zl+aH6vXJ+dgCG3Ev4zyHVN84Wp/w6ATvup0bdTXzWqHKdxQWMYTA+Uw==
X-Received: by 2002:a0c:edc4:: with SMTP id i4mr17696qvr.29.1601910729908;
        Mon, 05 Oct 2020 08:12:09 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g7sm36975qtc.19.2020.10.05.08.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 08:12:09 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] x86/sev-es: Remove dead code
Date:   Mon,  5 Oct 2020 11:12:06 -0400
Message-Id: <20201005151208.2212886-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete some unused macros and an unused function.

One question:
  4b47cdbda6f1 ("x86/head/64: Move early exception dispatch to C code")
uses native_read_cr2(), while the asm code it replaces may use paravirt
to read cr2. Is this intentional or should it be using read_cr2()?

Arvind Sankar (2):
  x86/boot: Remove unused finalize_identity_maps()
  x86/head/64: Remove unused GET_CR2_INTO() macro

 arch/x86/boot/compressed/ident_map_64.c | 10 ----------
 arch/x86/include/asm/paravirt.h         | 11 -----------
 arch/x86/kernel/asm-offsets.c           |  1 -
 arch/x86/kernel/head_64.S               |  9 ---------
 4 files changed, 31 deletions(-)

-- 
2.26.2

