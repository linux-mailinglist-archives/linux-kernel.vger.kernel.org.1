Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504472B0383
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgKLLHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgKLK7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:59:07 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692C7C061A04
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:59:06 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p19so5916988wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wgyLyFchGL7Sp7PDuveL5Dq/jWJMAfMom/lcxhPZFGk=;
        b=OIcAU4L2NY90scoNe97J7Lo3gdQ4brKCLe5fP7yOH2yD67Ofz0aO0Wo5MUjF2m7/2C
         iqhZfqgE7sx7uOpFPy6Ej8kW1KzNWFmtq5SPp7JzD7HcWn46JIHoJagCqfDo1sLnBMmW
         8Ag48q1gpX4QthRyaDE+UI3Mt18iHtxM0E6J81ecjFGOXmqgtNRJkbanRvJMVY+ewKaZ
         yKEIWMnBWpwiUDnYYiK+r6VCsU2UdmV9yTj07zJZJMrzl00HxHjL52MRjrnzsiZLqanr
         olAQRFJvinPjCXmYaWsofa2c+EJTF0jTIVk2+chj6Zx6LKZcVdSbdxxJR5dgoozgc9p4
         XSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wgyLyFchGL7Sp7PDuveL5Dq/jWJMAfMom/lcxhPZFGk=;
        b=MlHhPmWS3Oiw+JGP9cWcKjkEWN4EscTAwg7aV1NcsXGUSVMS3O8F//tZiIqx3n8SZZ
         DnQ00LdGxxwAXZBHFKhv8BKolxF4idGKp5ODzXR7x0KifpXUPVgPjIS95r3uUCrQiiR7
         7VpSFhV6Q7nz8aII4mKqOlcwp6TGhD0tQ4XZsoydT9sJr5Dx8di5gB2YGhZDBQO0bQLL
         RCiCzaURvQmOD21bLRNeuU5aiwMiCbCeNxs5LIKN8Pw6fLGdHix9s9KojnbYGUFcWtPo
         kOwHskoPaDkhak7YiGi50VfGVEKD8F6pZ/WK+yvHxQ6mLjUtBqyRHXANSfu4PfzNykJ+
         ARhw==
X-Gm-Message-State: AOAM530Mh7zl73AWrvo8/Ax63RT+wvNiHGDtilrd+pU0npFeJdJ72LkU
        3yhvg4MkVuqCrzKOjjk0h+noTg==
X-Google-Smtp-Source: ABdhPJypm3E5Z4Dtn6FAq2BnkUT91LvIbDHRoSB1aVRFTBICzorGYZNNLlfeGh36eCzBVJ5tkNl0tQ==
X-Received: by 2002:a1c:4c09:: with SMTP id z9mr9042901wmf.55.1605178745182;
        Thu, 12 Nov 2020 02:59:05 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id u5sm1167239wro.56.2020.11.12.02.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 02:59:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/4] tty: serial: pmac_zilog: Remove unused disposable variable 'garbage'
Date:   Thu, 12 Nov 2020 10:58:57 +0000
Message-Id: <20201112105857.2078977-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112105857.2078977-1-lee.jones@linaro.org>
References: <20201112105857.2078977-1-lee.jones@linaro.org>
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
 drivers/tty/serial/pmac_zilog.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/pmac_zilog.h b/drivers/tty/serial/pmac_zilog.h
index bb874e76810e0..fa85b0de5c2fd 100644
--- a/drivers/tty/serial/pmac_zilog.h
+++ b/drivers/tty/serial/pmac_zilog.h
@@ -362,10 +362,10 @@ static inline void zssync(struct uart_pmac_port *port)
 
 /* Misc macros */
 #define ZS_CLEARERR(port)    (write_zsreg(port, 0, ERR_RES))
-#define ZS_CLEARFIFO(port)   do { volatile unsigned char garbage; \
-				     garbage = read_zsdata(port); \
-				     garbage = read_zsdata(port); \
-				     garbage = read_zsdata(port); \
+#define ZS_CLEARFIFO(port)   do {                       \
+				     read_zsdata(port); \
+				     read_zsdata(port); \
+				     read_zsdata(port); \
 				} while(0)
 
 #define ZS_IS_CONS(UP)			((UP)->flags & PMACZILOG_FLAG_IS_CONS)
-- 
2.25.1

