Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6D12C31FE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 21:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbgKXUcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 15:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgKXUcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 15:32:18 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EC2C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 12:32:18 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f17so224068pge.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 12:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=27455kkYZ9lPDJYvnYh5LLVgC7lrUgf8EO+9xKtt6bA=;
        b=Cd4dV4OKIQBWdm7uTqh4V2SjRc1TMtpkyqDU5FqH1Ft24qwESpO32ds5mh+x0jjYVT
         in1ThNq11w3txAOHjQnB2yMBha4Sq0pEtR8nM8CiVNigWUBC4BvHUST0FLgf7rbmnRPZ
         dbBRLe+YLNDvMkq9birGws6moRAYDLMGD9hr9YCxbHdLla/P009lr8yDrGk4T2uRQPXE
         wOqnGj892rdKNSGM9yxHZkettz/NuBc1PM9YJ7OPQoNy4lNO6/wZdUklEucDAtjLQwET
         WR3tgv22j5A/dgbJP6LZGnNErDTeIJVQigsuoLiqmw5U2Jah/eD7yFQLfwD+UnMXEOU5
         kkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=27455kkYZ9lPDJYvnYh5LLVgC7lrUgf8EO+9xKtt6bA=;
        b=VYL0cpoBlc7vSEZ75QKZ8/G5gWuQ2DORttMrnia2cNl0Vzs0ydYkPQHCwzi5YqD0kz
         3eQRX/uEdeRSW16NtvNY3KvfaT8hCdO6hKNPti8ue2tIUeLtxazCtibgoN7kzih8aaTd
         PYUF32WVX3iJryrZ2KLkAcrVNJJYeuRQIqMCs5tP/2HufFgxDwHZRm7iW5dIb8MzJmbB
         AJ3oHawvGIIXxRqnjdcV0+4ElWUgwZwR4V0O6roOo1OaaK53LEcwLUpOojPijLLKMXAl
         qQtD30tQy6hv74vbRSdHDW/ttNDSA56IduKUlhjpLEpJf0Efum6OJPcBZPPeUpOUntyd
         f35Q==
X-Gm-Message-State: AOAM532/nYoAXb7pS8WwlzcwrOIa5Zvo4YEmwrEcrUHEeSLwm7ahUijU
        Pdt1l+zCUsnhhSOKJxj/geA=
X-Google-Smtp-Source: ABdhPJw5ai/TK2pCNJPuRtFJQNIWH6Rfeudvu4xJNAxJgnpXe6CIbx37Aa546osc3FVJHpHGcFDxzw==
X-Received: by 2002:a62:5b05:0:b029:197:fafb:50f3 with SMTP id p5-20020a625b050000b0290197fafb50f3mr131117pfb.76.1606249937975;
        Tue, 24 Nov 2020 12:32:17 -0800 (PST)
Received: from adolin ([49.207.219.221])
        by smtp.gmail.com with ESMTPSA id z22sm6005999pfn.153.2020.11.24.12.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 12:32:17 -0800 (PST)
Date:   Wed, 25 Nov 2020 02:02:12 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     linux-kernel@vger.kernel.org, michal.lkml@markovi.net,
        nicolas.palix@imag.fr, cocci@systeme.lip6.fr, Gilles.Muller@lip6.fr
Subject: [PATCH v3] scripts: coccicheck: Correct usage of make coccicheck
Message-ID: <20201124203212.tlvj7dvpmeql6spc@adolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command "make coccicheck C=1 CHECK=scripts/coccicheck" results in the
error:
        ./scripts/coccicheck: line 65: -1: shift count out of range

This happens because every time the C variable is specified,
the shell arguments need to be "shifted" in order to take only
the last argument, which is the C file to test. These shell arguments
mostly comprise flags that have been set in the Makefile. However,
when coccicheck is specified in the make command as a rule, the
number of shell arguments is zero, thus passing the invalid value -1
to the shift command, resulting in an error.

Modify coccicheck to print correct usage of make coccicheck so as to
avoid the error.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
Changes in v2:
- Move test to only display error message

Changes in v3:
- Update example with latest file
---
 scripts/coccicheck | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 209bb0427b43..d1aaa1dc0a69 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -61,6 +61,18 @@ COCCIINCLUDE=${COCCIINCLUDE// -include/ --include}
 if [ "$C" = "1" -o "$C" = "2" ]; then
     ONLINE=1
 
+    if [[ $# -le 0 ]]; then
+	    echo ''
+	    echo 'Specifying both the variable "C" and rule "coccicheck" in the make
+command results in a shift count error.'
+	    echo ''
+	    echo 'Try specifying "scripts/coccicheck" as a value for the CHECK variable instead.'
+	    echo ''
+	    echo 'Example:	make C=2 CHECK=scripts/coccicheck drivers/net/ethernet/ethoc.o'
+	    echo ''
+	    exit 1
+    fi
+
     # Take only the last argument, which is the C file to test
     shift $(( $# - 1 ))
     OPTIONS="$COCCIINCLUDE $1"
-- 
2.25.1

