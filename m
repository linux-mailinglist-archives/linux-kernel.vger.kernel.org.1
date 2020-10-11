Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A8C28A704
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 12:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgJKKbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 06:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbgJKKbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 06:31:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43421C0613CE;
        Sun, 11 Oct 2020 03:31:13 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o9so6858829plx.10;
        Sun, 11 Oct 2020 03:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qUbbonkvmJI/PJT7XYEgXBBQWmM8xuj/vukAq6acOQg=;
        b=atsoKcpA55UYV64jggSZrb3ULedRugy+lwNE37vqe1BPXujehi9wIVO6s5gtd1aAjQ
         1MQS2/rZxlgFbxPlefPOvfzfppp35hW7slcDPoQEpR2Vvvws9ZOS2aFckB5PlEBU5UJS
         JexYM7AyCjrDzwRy0m5HmpiUxJeeMBll8VJ58tlVf6/Lpv7Y82EeUeIRUmxXF4t/rZLe
         BI4tovth7mP+qWSdG1heminPKTiq81HpeGMbagfXaB9AA/7xkIVnvHis/UD033ArHl0N
         mywJmKyowxhfA7H9Ovl8dECZPBZeOEaypg57/D37Ho/lzdUokDRpAOaigniDMMHfHe3O
         rYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qUbbonkvmJI/PJT7XYEgXBBQWmM8xuj/vukAq6acOQg=;
        b=gpSmiibc4vg+8og8fT+NaEZZX4e5S0QZZzHMKZzEWI1y5qPbZea4D7x4BA0RfmNk25
         JfqOaWtL+A4AxFXymaNQNVR6r9S5Viu89Fw/+TXd3IPpqeqNowMHPBGwBDzYJ2wKKZWo
         Ci9qx6RksYUiaHwhsb0lhA4Hcq1jciF45TRa3CQs2s+hHbvAK7fv9oei29I/jn7kuh41
         u/y565o6S+DezOcJiXM2HUzS6m22K8fpKUJo1ZCK1ZGyWLG3qLM97NesWHTK6PccMw54
         1Ww/5/bglZwWxsyPPl4sjaKx4M0BKrj8j361gKPYh2UpU/TqjIGTknwPezzMKygWJh2h
         qz3g==
X-Gm-Message-State: AOAM531ZHgkpUHzZjC7lMM88KUdcGU4y2cXRXWigICB8+UzdxS1FQHTl
        qiODNYnVtAQo1YkSOwBPviQ=
X-Google-Smtp-Source: ABdhPJxzk0tcJh/JkNlmWArqX0vyYcSVvNqk7B169R1YAufNKFrOqTA7nPOqA4jjTG49STxQWhmFSw==
X-Received: by 2002:a17:902:8202:b029:d2:2f2a:6712 with SMTP id x2-20020a1709028202b02900d22f2a6712mr19441292pln.15.1602412272824;
        Sun, 11 Oct 2020 03:31:12 -0700 (PDT)
Received: from adolin ([49.207.215.73])
        by smtp.gmail.com with ESMTPSA id o4sm4394694pjj.38.2020.10.11.03.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 03:31:12 -0700 (PDT)
Date:   Sun, 11 Oct 2020 16:01:07 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     corbet@lwn.net, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v4 3/3] Documentation: Coccinelle: Modify Parallelisation
 information in docs
Message-ID: <15c5f36aea99a8947847a31cc0f982f9e829a12b.1602410019.git.sylphrenadin@gmail.com>
References: <cover.1602410019.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1602410019.git.sylphrenadin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset modifies coccicheck to use at most one thread per core by
default in machines with more than 4 hyperthreads for optimal performance.
Modify documentation in coccinelle.rst to reflect the same.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 Documentation/dev-tools/coccinelle.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 74c5e6aeeff5..530d8d313601 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -130,8 +130,10 @@ To enable verbose messages set the V= variable, for example::
 Coccinelle parallelization
 --------------------------
 
-By default, coccicheck tries to run as parallel as possible. To change
-the parallelism, set the J= variable. For example, to run across 4 CPUs::
+By default, coccicheck uses at most 1 thread per core in a machine
+with more than 4 hyperthreads. In a machine with upto 4 threads,
+all threads are used. To change the parallelism, set the J= variable.
+For example, to run across 4 CPUs::
 
    make coccicheck MODE=report J=4
 
-- 
2.25.1

