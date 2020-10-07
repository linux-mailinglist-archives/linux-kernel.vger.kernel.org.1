Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D605285A5F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgJGIXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgJGIW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:22:59 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0CEC061755;
        Wed,  7 Oct 2020 01:22:59 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j33so917113pgj.5;
        Wed, 07 Oct 2020 01:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DTMIeAb4199BQec+LNtvo77g56g0FGiP7OwneWm/qvY=;
        b=r5BnuTJLumHmMsoWOjoCTn0gMd3jUUw8iI1MJypztqgE5nG9CU48UfVtN/rMXQM1VV
         9T9wzdYfyxDvwqIKaC0Uogef32LbP8aY80dXceZCT9SmtMe947Ezwe8v/TGV3kT5cBG8
         AvzvzQRrY5FfVf9RXlA/0HWbScgyo+BejsLtuefOVV0oD9IgY9DZWmZlM8jBHwXq8Rcq
         z2awCSt0XRi26cQC4dhwsEtoJLVapdo2WzkklbaRzMiosk9p6zCRYbWZJ9DzXdUafiyr
         4IjmhXbwG1+APq65/HQKdO33dC8UgGaA52aZV89jTuvhqCVNzSoWFyRAjEl832NMqUnv
         sZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DTMIeAb4199BQec+LNtvo77g56g0FGiP7OwneWm/qvY=;
        b=ALJbApXnff3Fugx0QPQVZWQQAWESsVdP4PEFNdKIVjcPvkXFjaSs4bojo+4LeCiwuF
         hxlApqvP0A4GoyzqwlosKTOhx7TBoL+gtcuv9NTlCDYWTSUVlHDatPpqcjEY6fVQTZnZ
         yTpZ4p0HCqkathhsuQcckUlEtUgReYgq8++qb1s6p54ZYrGonQFz070YuSBIUDT5Htfk
         u5YFOQQlFCP/P9mRGLo1y8UkT4c1qsH0TbLfO9XvPgJjicz77/E2RhJLd46gMSsp38dH
         l05VZKIWbua4giam4HVn6CcgQH02mJpaiQ06/IX8lp/PZVfWgdAdg7geP7lu2SNDwUc0
         CQbQ==
X-Gm-Message-State: AOAM530MD56Gp4OSC4PXksquAdHTCEWxrxUmQf9bPMi8y5ookbUh/tRl
        ou4VjLTCiSAE2syO7q6T8/Q=
X-Google-Smtp-Source: ABdhPJw7aCjvWh+9f5ZHF7Si16K7xRCRQhAenNZXmtVZEZmwMh2/En9ERkjHqxmnFwxsTNeJFHnCUQ==
X-Received: by 2002:a63:4e4a:: with SMTP id o10mr391023pgl.384.1602058979301;
        Wed, 07 Oct 2020 01:22:59 -0700 (PDT)
Received: from adolin ([49.207.194.78])
        by smtp.gmail.com with ESMTPSA id g4sm2042335pgh.65.2020.10.07.01.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 01:22:58 -0700 (PDT)
Date:   Wed, 7 Oct 2020 13:52:53 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     corbet@lwn.net, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 2/2 V3] Documentation: Coccinelle: Modify parallelisation
 information in docs
Message-ID: <25adae324909605cdbe5ae88a9d60c34aeb515d7.1602054065.git.sylphrenadin@gmail.com>
References: <cover.1602054065.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1602054065.git.sylphrenadin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset modifies coccicheck to use at most one thread per core by
default in machines with more than 4 hyperthreads for optimal performance.
Modify documentation in coccinelle.rst to reflect the same.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
Changes in V2:
	Update scripts/coccicheck to use all available threads
	in machines with upto 4 hyperthreads.
---
 Documentation/dev-tools/coccinelle.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 74c5e6aeeff5..6fdc462689d5 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -130,8 +130,9 @@ To enable verbose messages set the V= variable, for example::
 Coccinelle parallelization
 --------------------------
 
-By default, coccicheck tries to run as parallel as possible. To change
-the parallelism, set the J= variable. For example, to run across 4 CPUs::
+By default, coccicheck uses at most 1 thread per core in a machine with more
+than 4 hyperthreads. In a machine with upto 4 threads, all threads are used.
+To change the parallelism, set the J= variable. For example, to run across 4 CPUs::
 
    make coccicheck MODE=report J=4
 
-- 
2.25.1

