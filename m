Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2338E26C823
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgIPSlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgIPS1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:27:54 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0629BC0F26C2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:03:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t10so7324225wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=knxO569bLvMm3zZAZopBUpZOyoYlMoX7PiYJWL4OG44=;
        b=R6ixiWVCXdMx0K9arWFsNKOjJk4iHav6D1zZX2aqLa92oQyBtOPlx+rUEsCsGeidP/
         puH9Qx4lCfoT6mwfTLggoINW9ZBLxfSEaYjjznEDL2Ih7puJtvx8ak72tmKgI0MkMjL2
         SuUfBkRW54rMdIjHOMXnXtlrkTU3H5o+48YsyAbSA4k8ruP1bbt4k4bkVM+IKxSlQ3mO
         ipazn5cZ0COX4Z98Z2lPSvFFaFdYNRnV5EGu++YnZ70n1Li9UgpmWlK5NEQtrpWOak1J
         n4LmPYPJiioO4MblqIg1NMTJD7wrQb9btlrpyhvVGfKSYscYmxbcp6fvey3KudtZ+Ffe
         CGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=knxO569bLvMm3zZAZopBUpZOyoYlMoX7PiYJWL4OG44=;
        b=hnWxuq+LQy8HnI6KZNGtmGRAnucAoptoTv0DgZq9d35eFavIGat+IyawsdUNdJE8wt
         sOnRkMApLO9j9I97X1cFliZbKrLSVWbGfKt76uGyJ1NQpNWodsZY4EA5Y9UOOqsi6C1E
         ifzWUvbLt71jo7YpjFpX5zhYg0u9Y+WPC106riJrBS6mvjRrFzqYEH01un35wrKl9YNu
         UDRno9baf28XfiOKnCgyeTHoJPMWlS39O4s2M8I0+PeMbZJ8EZU4IXQEz9BCnt3CCzNS
         YGGPjPw6+43kx5sNcjSFVBU7QysB89VCtL269iUjsnusJGjYgevboR5fvVwB2lamZy1N
         UcMg==
X-Gm-Message-State: AOAM53358bBYsbvtszGISVEF8e+dOPC6cHWuPdvzhhts+Zyth4y0/8CJ
        x+afZD5IkkmnWxA35/hZg5Vofw==
X-Google-Smtp-Source: ABdhPJzzHi1HcUgxHfO3xDe9SW7scPoglpjj/lJquDjB/VnPG/Uixw6pbcy0k8ojYEaalTkCcedV9A==
X-Received: by 2002:a5d:4c4c:: with SMTP id n12mr13901262wrt.162.1600268636700;
        Wed, 16 Sep 2020 08:03:56 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id y5sm5879951wmg.21.2020.09.16.08.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 08:03:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     davem@davemloft.net, gregkh@linuxfoundation.org
Cc:     vkoul@kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] bitfield.h: annotate type_replace_bits functions with __must_check
Date:   Wed, 16 Sep 2020 16:03:33 +0100
Message-Id: <20200916150333.11790-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usage of apis like u32_replace_bits() without actually catching the return
value could hide problems without any warning!

Found this with recent usage of this api in SoundWire!
Having __must_check annotation would really catch this issues in future!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/linux/bitfield.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 4e035aca6f7e..eb4f69253946 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -131,7 +131,7 @@ static __always_inline __##type type##_encode_bits(base v, base field)	\
 		__field_overflow();					\
 	return to((v & field_mask(field)) * field_multiplier(field));	\
 }									\
-static __always_inline __##type type##_replace_bits(__##type old,	\
+static __always_inline __must_check __##type type##_replace_bits(__##type old, \
 					base val, base field)		\
 {									\
 	return (old & ~to(field)) | type##_encode_bits(val, field);	\
-- 
2.21.0

