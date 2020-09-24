Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A40276FEB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgIXL1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgIXL1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:27:50 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC4BC0613CE;
        Thu, 24 Sep 2020 04:27:50 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z18so1737023pfg.0;
        Thu, 24 Sep 2020 04:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YDFIQq/o1hm+LPrfCgI+XDiyZGlyHTyQEBbo9XIzVSg=;
        b=WuRgE8Jjopy30o3FSLNz3iDk57XIlZh37vnPbLS1kM2vsI5akChLVS3hNvv/ZBe/jK
         KY8+uhar453Fa7ME8SSX3VbMX8bsPw9cQl++OLNKH9aDEGXHtCQ9Fh5IPuXk1IlBR5/K
         qNQ+anXXi7d9KPta2u3CPqMrNqWD9bG8unkPjETicAV3sqUDXEoJljMAXMrowuwKky2z
         5eZ9rnc/54B5dZy1jcAH7BLeiSbRk46KOBCODjninAflSOxojrtubRDkDICSdsDr8SZy
         kenaEFDVuD4uH6/KONa+GdT3oDCKesM5T+SPvCUBh2KxjgJ90PArh1b461RkMBkZ86Ir
         Y7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YDFIQq/o1hm+LPrfCgI+XDiyZGlyHTyQEBbo9XIzVSg=;
        b=PH0g/7WWumRvY2hAgG4jxhgi0X7bHuNZbCTv9C+YWlzcinOVDOh+ZZabCIMP9EQlRk
         sV7O/SCekJuOYe6ksjnTRHIADhQNRfEY8HDkjZrqArxG4ddfL9XpcG9ZWD/NjokDM4Ca
         uR28z7X0dDV4XFtV+Pdx4z5DJbHFgnhekL9YqB561qRJN99s/BDR45f9Fs15FosVf8JX
         aF7HWU+FlPVMO+IWLQWXi4CZU2GBskWmPlKvakhysbMhSaMKF2rHVlINMprqdoXGB3Yb
         v0z1g6MbujdtjBJ3HVRg9IKQs82ymxeTU5ffdkm+k0QXZR1o+1rT4a7Syu29WrO9tcFw
         Qj9A==
X-Gm-Message-State: AOAM5338K8dxYKDFwJqXUIFyhMXZTxVswBNvyoG6eNX3Nr0MP5RCgVMX
        30oD59xVBuh/Li5fwhGPI4E=
X-Google-Smtp-Source: ABdhPJwLhKbyQz7qDtizIH2JGxD8Qq8fkhyk4avxo67t4ta6TF8+O3ly5vMX7Xu0cVlAynT9iJaHRQ==
X-Received: by 2002:a63:4e52:: with SMTP id o18mr3530830pgl.171.1600946870002;
        Thu, 24 Sep 2020 04:27:50 -0700 (PDT)
Received: from adolin ([49.207.208.43])
        by smtp.gmail.com with ESMTPSA id c3sm2739187pfn.23.2020.09.24.04.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 04:27:49 -0700 (PDT)
Date:   Thu, 24 Sep 2020 16:57:44 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     corbet@lwn.net, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Documentation: Coccinelle: Modify parallelisation
 information in docs
Message-ID: <3ecfe0e7f95021525b7bbf783a45eb3a176791a9.1600945451.git.sylphrenadin@gmail.com>
References: <cover.1600945451.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1600945451.git.sylphrenadin@gmail.com>
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

