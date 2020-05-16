Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EC41D60E0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 14:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgEPMoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 May 2020 08:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726206AbgEPMoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:44:04 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11281C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:44:04 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l17so6523041wrr.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IgUxf8/whiEMr3BbVOGT5V0QZ7sOsie1bVJvZSf8S14=;
        b=DoUT3iuc7yg2quN1SGyXucg5mnzzb1MR1XFsA7sQ0pb0fTun0+FOaII2lZSTs1zwfl
         +gbXfQWaTAuDFB++d4+/tRJjtsqnRKOQY4V6OSd0w1O3ZMlDJElaNGqe/zlj9+f6/rCb
         w1ETF1Wpb1ssO9D36EgPncTiE/Nn+ZCTMWMfLw6huqm7i3zuxdMb06CdbGG/OyeCgN/m
         PgGLnis9V9R4w9xnKo9xj1dSbtT2yPy8FJkSleF6QP0iUTedqs5kcXeL6ESOr5F6WdKK
         mfRj1SfWC6Yft1PdcLsefI2HSmUsapbadZri2d4gyKb1BCLih4tSsqmKB8eqpRz106mo
         rwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IgUxf8/whiEMr3BbVOGT5V0QZ7sOsie1bVJvZSf8S14=;
        b=TSy/pUGlb6Addv2Sh5lTsUPXczoCxFQiA8nJBbWuBqw8hDruQXU2jR8vcsbTbcwcdc
         ny/TKEhTrbCF8TMK6I0WgJmQxKUZCvVPqGTgjugjjueNhVJSamJ4+TqLC4Tac28TMPjr
         dELEtqXs+1VZtGEtsHia+l5jCWEcUwtf4itjGxEKM5RahPZS7IafzRLw0OczlsbATp10
         KYx5keFf0e3A1wE2tSxauj1MXWl9xbi1WrOKUIIgFShnI6MSLQA7W/iPnbrw9drItSOU
         H0MDfypgPiMEQUjw6jRN441o48DxEMaFCKAiJ9Sz+p8ENslzOLIjlKbqLaXUDSf1GBNl
         gdVw==
X-Gm-Message-State: AOAM532+6r2bqCOyrpDdt+cT0cxDSrpcZG1MraXLtKTcNdHWXUTw04i8
        +dMBWFwRYqTUYg6snF70LQO5U1XrGPNBDg==
X-Google-Smtp-Source: ABdhPJxN9ZJRjIQ8GVgRLvAGsdVZGRyUnJ3GOfMPJS9ZiO3Ug1mweQPZBq2IE4PVHb2BiCud4krMwQ==
X-Received: by 2002:a5d:4702:: with SMTP id y2mr9157384wrq.136.1589633042179;
        Sat, 16 May 2020 05:44:02 -0700 (PDT)
Received: from dinux ([102.188.168.74])
        by smtp.gmail.com with ESMTPSA id w82sm7561495wmg.28.2020.05.16.05.44.00
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 16 May 2020 05:44:01 -0700 (PDT)
Date:   Sat, 16 May 2020 14:43:59 +0200
From:   Mohamed Dawod <mhm.dawod@gmail.com>
To:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wfx: typo fix
Message-ID: <20200516124359.GA11592@dinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing some typo errors in traces.h file

Signed-off-by: Mohamed Dawod <mhm.dawod@gmail.com>
---
 drivers/staging/wfx/traces.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/wfx/traces.h b/drivers/staging/wfx/traces.h
index bb9f7e9..80e131c 100644
--- a/drivers/staging/wfx/traces.h
+++ b/drivers/staging/wfx/traces.h
@@ -32,16 +32,16 @@
  *             xxx_name(XXX)       \
  *             ...
  *
- *   3. Instanciate that list_names:
+ *   3. Instantiate that list_names:
  *
  *          list_names
  *
- *   4. Redefine xxx_name() as a entry of array for __print_symbolic()
+ *   4. Redefine xxx_name() as an entry of array for __print_symbolic()
  *
  *          #undef xxx_name
  *          #define xxx_name(msg) { msg, #msg },
  *
- *   5. list_name can now nearlu be used with __print_symbolic() but,
+ *   5. list_name can now nearly be used with __print_symbolic() but,
  *      __print_symbolic() dislike last comma of list. So we define a new list
  *      with a dummy element:
  *
-- 
2.7.4

