Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09691285210
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 21:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgJFTHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 15:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgJFTHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 15:07:04 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0255DC061755;
        Tue,  6 Oct 2020 12:07:04 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t18so1678022plo.1;
        Tue, 06 Oct 2020 12:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YDFIQq/o1hm+LPrfCgI+XDiyZGlyHTyQEBbo9XIzVSg=;
        b=TVAY2c6tnOiTVeF6ZU7OajfKrQ4dLXku1bZ7uAV5WTVSFaxnsCS0Ln/JxQN6ibwzLt
         7sjbSogVb0kupW/N+cFDpW2gbMFAoD0qd/30ogozwCYqe44MvXn9QdSC325CnP3AdyyE
         bwxNkXUNcCl2onkwdaxMhgNREDTK4Uh8RfrIbZ4eZRlYobhub58obMEO6c0zjOXtxugc
         fvcoiwDPxuqQtIyQuU/VFcdZ/0Q4wNeiB5TAU8LfjMH4/VZ5eusZkh1Uxy/7qtZ+5hGL
         exmlCO+VZ/xKZOB7SJvpOgH7DCe7cgLRW2VOpcrYP3C8J7ASOYe6rLKht2KHwQG/UUQ4
         em5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YDFIQq/o1hm+LPrfCgI+XDiyZGlyHTyQEBbo9XIzVSg=;
        b=LXQWmSCVkVf5CyFMaEIPIP28FOjqdfTKt1b9lOuyT/SRZhPR26OimBqrGU2JqAcHT5
         sFnbAf+3pMCYThgTV0J8OExWD1SfUBSFguTNvrssi97HrAy175Dq8VTdG6dZcyaJ37mD
         e9znC8F3ULi0VhKihubLM9IcgpiQ9ILv9C17aoYhFpap+8N6nUL+ZduGhSs9cdeylbZR
         /7I19857bumTUhO3aGQ77mIKyZc9r6RoFDkkzSv0wULNBSA4KTghQSS45G07zpwsIK2y
         PIq0dBUj30iLNxP2THPP49lu8gFyQ0nDc2v+k+Vmp7GPd5tHeyfEaABtox+J8C1Zjlrk
         OFtA==
X-Gm-Message-State: AOAM533KKHRNi6nKvjLyoLCuXDxwSXZzR5c7xLRiVTsxaIlv2eTXSwqR
        AG56IH5Mh31pd2RlonULNxA=
X-Google-Smtp-Source: ABdhPJwmpDG6+mANDCPgRVfuvABQFO58x9fHsyIB74xKqjhgmQM0wDFJ+uO7uImTEahCXmsC9O8Z6A==
X-Received: by 2002:a17:902:760f:b029:d1:f8be:b0be with SMTP id k15-20020a170902760fb02900d1f8beb0bemr4612506pll.9.1602011223606;
        Tue, 06 Oct 2020 12:07:03 -0700 (PDT)
Received: from adolin ([49.207.211.213])
        by smtp.gmail.com with ESMTPSA id x10sm4588100pfc.88.2020.10.06.12.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 12:07:03 -0700 (PDT)
Date:   Wed, 7 Oct 2020 00:36:58 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     corbet@lwn.net, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 2/2 V2] Documentation: Coccinelle: Modify parallelisation
 information in docs
Message-ID: <69bd5a72b18138df7a979532062ffc306fbc3b45.1602010816.git.sylphrenadin@gmail.com>
References: <cover.1602010816.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1602010816.git.sylphrenadin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset modifies coccicheck to use at most one thread per core by
default for optimal performance. Modify documentation in coccinelle.rst
to reflect the same.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 Documentation/dev-tools/coccinelle.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 74c5e6aeeff5..a27a4867018c 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -130,8 +130,8 @@ To enable verbose messages set the V= variable, for example::
 Coccinelle parallelization
 --------------------------
 
-By default, coccicheck tries to run as parallel as possible. To change
-the parallelism, set the J= variable. For example, to run across 4 CPUs::
+By default, coccicheck uses at most only one thread per core of the system.
+To change the parallelism, set the J= variable. For example, to run across 4 CPUs::
 
    make coccicheck MODE=report J=4
 
-- 
2.25.1

