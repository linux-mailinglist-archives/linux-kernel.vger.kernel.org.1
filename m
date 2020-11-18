Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0B82B7893
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 09:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgKRI1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgKRI1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:27:10 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15F1C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 00:27:10 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id g7so960501pfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 00:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=+UEvuhVABCSTSx6IeJB9bBbg5aHLUMZsVfdLPOgJT9c=;
        b=Z0h+b26aTfemEvlP1tw3xk2gWsl7hCdYzhvD7+wvTb1UIzLrEJK1RczvM5HQvDp6eS
         8iXUpLOKA6Wcj5NbbQcUJ6/qpm75k9nRYO2vQaalPzXuNZt8NE7iQ9Jj2Zoqgb+02LMb
         77tSB3ZKi96DI1Tgdaal+T8UfJGdtIHkIhNvdtWPXwcqWxawtrGRYIzkREsLCf2NV6gA
         edSWz03mPPwHVNi3qsPy9HfTOXudQ1Q0kWEux0aQ+eWNnhyBEIBaJYZ68mfTqw1TpwxU
         djM45Pox/oYYwdIoR3/guhzAZatxgoGB5RuYMZZ6gro6mqOmMCdVyyiFW19dkfJ8daKA
         6+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+UEvuhVABCSTSx6IeJB9bBbg5aHLUMZsVfdLPOgJT9c=;
        b=lE3GLSTh1n+bqp0YrQ/ZKVZdsRcNftsmiCXfZMiEaLKagyGLCsnmm/CdGB9GVJ/QWM
         22OKAp7/XnEJJM2q1Q0IzcO1QkAUmLX5iqgxyHPCj2xiB85W33QDufzDtNScnkFLnAWy
         Ixm2KRW6agF1N0fkz9j7t6ARuhdbKgM6cuuFcDEL+Qi7IBsUqmYW7iled5mJokqmAbGn
         otGaG859K+izOAQ1ULSTixgdL44oKEYd3Wyxq/yQkyd7VA3ok44B6aerAAeqJhZfdBvO
         kQDORPnwc+fVqecyKrAJCTOwaFI0DM2zQ2K5Q43ksol0GJExiloo6mHmg8VW8MDn9EuM
         9r1w==
X-Gm-Message-State: AOAM531W/we9j6xThj7IeaBz1L80ZnRigYSeLfQb82XkrYsCIexTia9J
        c7iGgpPJ3/VFbcdQ59MfV8U=
X-Google-Smtp-Source: ABdhPJx+a/CMDhnCQNlBfShZbIiVRdoaBNbKrE37QgtY6fSL3YzMcN3qZCvdVawcsSNjjT14COCZqw==
X-Received: by 2002:a63:6245:: with SMTP id w66mr7574986pgb.251.1605688030165;
        Wed, 18 Nov 2020 00:27:10 -0800 (PST)
Received: from adolin ([49.207.220.203])
        by smtp.gmail.com with ESMTPSA id s4sm1586907pjn.0.2020.11.18.00.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 00:27:09 -0800 (PST)
Date:   Wed, 18 Nov 2020 13:57:05 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] scripts: coccicheck: Correct usage of make coccicheck
Message-ID: <20201118082705.ympf6ulol6wua4cl@adolin>
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
---
 scripts/coccicheck | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 209bb0427b43..f3b8bf505c5f 100755
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
+	    echo 'Example:	make C=2 CHECK=scripts/coccicheck drivers/staging/wfx/hi_t.o'
+	    echo ''
+	    exit 1
+    fi
+
     # Take only the last argument, which is the C file to test
     shift $(( $# - 1 ))
     OPTIONS="$COCCIINCLUDE $1"
-- 
2.25.1

