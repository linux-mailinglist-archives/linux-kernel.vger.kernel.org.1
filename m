Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B085D24357C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 09:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgHMHxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 03:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgHMHxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:53:16 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E381FC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 00:53:15 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a26so5175216ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 00:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/CQP6Mp+jMuAdeJV/E9lJgqu50DuZ6HxUkaNbDh+BH8=;
        b=CxvhhQpnl8Zz78ssZKplng7mcCGn29a0e98wO5QTm5UK5IHfxeGDRdmMBYo180yOLi
         djviL7cjNEjZXa/r7cEeLIgKks/vKd3yh+3p1OK3ZHzBlkRINLp7ryDBsV8HKHhjDnHu
         eYC24ttssWTiQS1pjsDwKLf6pCU0gMbR3FoHb17dPRIBPH1Cx8ifQGCduomNd/h9QVHI
         UhUnLvax9JG4yZjrpPHcktdWyhT65wq/93FCC32QeTW1hMuajWBzkxi+eUn8cwJ60QyI
         mbvXXNYURCAO6rk+GJHyIjdTkQnIZTG6wqZWKRx/88g2sdvMU9J5rGruHsx574ihP+df
         9Lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/CQP6Mp+jMuAdeJV/E9lJgqu50DuZ6HxUkaNbDh+BH8=;
        b=e3OhGNuEjJnICKcxdlE8rSBw29OC34wLDjMRzn1YtrmsVRrQIgHkbN4FbZALWF4kcO
         S8tAQAoMBt0KnzuE65JcP9NAqzI2qNxoD6dPPHUHg9bOXMNs/bH11TT8bo3/ntdQ53nP
         kcPh7azrH6MRPOCyYPTO3ZYLwDCMzz+zIZeUMYEYxWVweKN5UBdBCPKS3mUfd4hOzxP/
         xefOh9odhhdhHTnmRnHLdZtvmSLUZgg+CoNFNBQr/g5yPun3QQkoIySO1FsO0GrEJutM
         pFFCZU40CIP0f5j8eHmzWUvZ2+q16U8fK5MU/fVt0gy1mJCyBCWDAjwlwq0aIrhPoScF
         7Lyw==
X-Gm-Message-State: AOAM532HnZAcLthbhDILgVQ12atd26/MhO6bCLoyDQ2wLVz65I8aI4qp
        1dnu0RaX7iTVP/mtrpkETf2KGA==
X-Google-Smtp-Source: ABdhPJzGeyLzQ1C+boYWENTUuWFerXsIp9+BXxBuZxvnJDfIdRX2XeZ0VmMgR65jaK61G2ew0ZPPFQ==
X-Received: by 2002:a17:906:4007:: with SMTP id v7mr2787076ejj.197.1597305194613;
        Thu, 13 Aug 2020 00:53:14 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xajgyw9mz6ybkfgzn4.18120a2.ip6.access.telenet.be. [2a02:1810:a421:dd00:8d0a:592c:7d6d:8770])
        by smtp.gmail.com with ESMTPSA id br25sm3363449ejb.25.2020.08.13.00.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 00:53:13 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 1/5] iio:temperature:mlx90632: Reduce number of equal calulcations
Date:   Thu, 13 Aug 2020 09:51:21 +0200
Message-Id: <20200813075125.4949-2-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813075125.4949-1-cmo@melexis.com>
References: <20200813075125.4949-1-cmo@melexis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TAdut4 was calculated each iteration although it did not change. In light
of near future additions of the Extended range DSP calculations, this
function refactoring will help reduce unrelated changes in that series as
well as reduce the number of new functions needed.

Signed-off-by: Crt Mori <cmo@melexis.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/temperature/mlx90632.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 51b812bcff2e..c3de10ba5b1e 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -374,11 +374,11 @@ static s32 mlx90632_calc_temp_ambient(s16 ambient_new_raw, s16 ambient_old_raw,
 }
 
 static s32 mlx90632_calc_temp_object_iteration(s32 prev_object_temp, s64 object,
-					       s64 TAdut, s32 Fa, s32 Fb,
+					       s64 TAdut, s64 TAdut4, s32 Fa, s32 Fb,
 					       s32 Ga, s16 Ha, s16 Hb,
 					       u16 emissivity)
 {
-	s64 calcedKsTO, calcedKsTA, ir_Alpha, TAdut4, Alpha_corr;
+	s64 calcedKsTO, calcedKsTA, ir_Alpha, Alpha_corr;
 	s64 Ha_customer, Hb_customer;
 
 	Ha_customer = ((s64)Ha * 1000000LL) >> 14ULL;
@@ -393,30 +393,35 @@ static s32 mlx90632_calc_temp_object_iteration(s32 prev_object_temp, s64 object,
 	Alpha_corr = emissivity * div64_s64(Alpha_corr, 100000LL);
 	Alpha_corr = div64_s64(Alpha_corr, 1000LL);
 	ir_Alpha = div64_s64((s64)object * 10000000LL, Alpha_corr);
-	TAdut4 = (div64_s64(TAdut, 10000LL) + 27315) *
-		(div64_s64(TAdut, 10000LL) + 27315) *
-		(div64_s64(TAdut, 10000LL)  + 27315) *
-		(div64_s64(TAdut, 10000LL) + 27315);
 
 	return (int_sqrt64(int_sqrt64(ir_Alpha * 1000000000000LL + TAdut4))
 		- 27315 - Hb_customer) * 10;
 }
 
+static s64 mlx90632_calc_ta4(s64 TAdut, s64 scale)
+{
+	return (div64_s64(TAdut, scale) + 27315) *
+		(div64_s64(TAdut, scale) + 27315) *
+		(div64_s64(TAdut, scale) + 27315) *
+		(div64_s64(TAdut, scale) + 27315);
+}
+
 static s32 mlx90632_calc_temp_object(s64 object, s64 ambient, s32 Ea, s32 Eb,
 				     s32 Fa, s32 Fb, s32 Ga, s16 Ha, s16 Hb,
 				     u16 tmp_emi)
 {
-	s64 kTA, kTA0, TAdut;
+	s64 kTA, kTA0, TAdut, TAdut4;
 	s64 temp = 25000;
 	s8 i;
 
 	kTA = (Ea * 1000LL) >> 16LL;
 	kTA0 = (Eb * 1000LL) >> 8LL;
 	TAdut = div64_s64(((ambient - kTA0) * 1000000LL), kTA) + 25 * 1000000LL;
+	TAdut4 = mlx90632_calc_ta4(TAdut, 10000LL);
 
 	/* Iterations of calculation as described in datasheet */
 	for (i = 0; i < 5; ++i) {
-		temp = mlx90632_calc_temp_object_iteration(temp, object, TAdut,
+		temp = mlx90632_calc_temp_object_iteration(temp, object, TAdut, TAdut4,
 							   Fa, Fb, Ga, Ha, Hb,
 							   tmp_emi);
 	}
-- 
2.25.1

