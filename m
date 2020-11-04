Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B312A6E1C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbgKDTgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731687AbgKDTgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:50 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C9AC061A4A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:49 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id s13so264827wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ErfYpYEPgr7SyR0IGrTLDHOPTVsMeF+NG57/GEyOHB0=;
        b=pX29kLlmBcSPTSQCXTO8Lo9d4QG+nqnnImw6YFxmstscNqOOswbExguUzzT4L2axlU
         D3GWk5jA11ZzA+AZVtegLCVhl2Ob2ZmAEEHVzMHCsciCYwyQTL8h89K8WzLvAsv7TRcu
         7yI+7qd87nij+dGvWnf+2yyWANiI/xOXRymlotH13o1iY4W7M550ffyUTs+i/hqzxRcZ
         TKhz+VRg0g9MO6Q9omYUAHnyYyG0b/tNB7yPcru/BSqEkR7LGsnBTwhTnSMhBAoFeI05
         ZFKQqxZhOGvRVRNlQ6UmnNU504R2+m9kxBQlMwaHA65WTwkPAt9WKivfMsX/iLNdWsoh
         CY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ErfYpYEPgr7SyR0IGrTLDHOPTVsMeF+NG57/GEyOHB0=;
        b=m8i/AnVXVsbYKjpujvE+kIDTxmYT+Yz7fb+GFbZ5PBGyIH0LR1jKjDuf4U3SMrTDYK
         xHPlwKMooxN0sBl7WUOfGFR/Zdv+sYv26UFi+h5X7SZpHoYLN5WSW042OlKX/24d19zZ
         zAkCvJUuE9HU7kdktSjQn02FzEA6tpPE7s1FD4VXYOJOeicmqOGwIUr6/ILK7WpxpM3H
         Hv26ZdkncZs8kfxUXo/dv077kQPNb9q3UL7d+g4CCbtoltXAIEx+pVe2Vi1dfsU9M8dc
         XYn1sKqta/hgwdajT3JCtMUiS1Ul9CgdCMZastoefn6vFzlq5FmVN+fO4tnybtyRLRn+
         BlfQ==
X-Gm-Message-State: AOAM533R08NAMZz9YN9Eda4oClvCj/+PFUp4hVFkNTeIrf2gelvuWNyG
        MPt/1aDEm9m7dNMn9yos129FtA==
X-Google-Smtp-Source: ABdhPJztfIELyaPKKHSKpD48Wccw9fHxSvlItbhEYnm/xRNIcnSe+Wnjs2/1thwCJMJZLY6LsZDnhw==
X-Received: by 2002:a1c:a90e:: with SMTP id s14mr6477604wme.46.1604518608351;
        Wed, 04 Nov 2020 11:36:48 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 34/36] tty: serial: pmac_zilog: Make disposable variable __always_unused
Date:   Wed,  4 Nov 2020 19:35:47 +0000
Message-Id: <20201104193549.4026187-35-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serial/pmac_zilog.h:365:58: warning: variable ‘garbage’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linux-serial@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/pmac_zilog.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pmac_zilog.h b/drivers/tty/serial/pmac_zilog.h
index bb874e76810e0..968aec7c1cf82 100644
--- a/drivers/tty/serial/pmac_zilog.h
+++ b/drivers/tty/serial/pmac_zilog.h
@@ -362,7 +362,7 @@ static inline void zssync(struct uart_pmac_port *port)
 
 /* Misc macros */
 #define ZS_CLEARERR(port)    (write_zsreg(port, 0, ERR_RES))
-#define ZS_CLEARFIFO(port)   do { volatile unsigned char garbage; \
+#define ZS_CLEARFIFO(port)   do { volatile unsigned char __always_unused garbage; \
 				     garbage = read_zsdata(port); \
 				     garbage = read_zsdata(port); \
 				     garbage = read_zsdata(port); \
-- 
2.25.1

