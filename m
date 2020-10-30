Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CD02A11BA
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 00:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgJ3XoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 19:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgJ3Xn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 19:43:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A88C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 16:43:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k10so6832536wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 16:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wy0WZ8Zzeq6t5Ra4/86MQfsMVcEh1cYQvRErHx8pLC0=;
        b=CscVTr2x0G2Yf0P9jpOFER8XDeb9vCVovhcaPbIRHblL6Pg3gJUW1RBDgqYJ2YrOwe
         6mDCbbElYMTbc5ESqsw46SMuGMwqYOjEeGjWVPUhEasRhqjbATbK0KTJKWa/P1N7BkM6
         9BuGYl9KqEvBfTcbMoRCXzPZSu4PhUU4pJVXlJ3WaXtqVOjHBMH4yJwcjiFX8YIRNgEN
         CXiYjgi2iJLrzipNLt9ce+zc0UDcdjLXeww6sWkRPcZlKfjQi1xm/Dp1XssI6koFGAGS
         ThTUtqql6lx3QjESZROvNTCUkoxpwUOBu+IMxsQFjQWbUVWvzNQHoUJVhtVlUd37Ff4K
         BYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wy0WZ8Zzeq6t5Ra4/86MQfsMVcEh1cYQvRErHx8pLC0=;
        b=K7/nHPxuVHQZ+4tc2ZyF06RvDaEuzU7g6ZuxHrfocC+keAekPnKgUElfsBbj81WZ+M
         QTDIW8b+tpiPigA+07IB+k7qHDD7YAYspbhHrJeT91+Hgc2MoxmAqipd5uX27JMuk6wE
         QyGpwNqGDbnl94Ew9oQKvFQanuwKxVr6XbuScjOwbOb0iD7hMUPHfOK/9ru0vtccRbEL
         j0yVH5S5k/9ILlB59pCnXHqFw9SLIj1yAyqP8glyOg2/xMQUNRxdA/6E9fLpiigMVi1Q
         HvPqQ5z2ozZ0mPHwp3A9eTTbVzcCLMfqxiI+1BlDii97RaUlxMRGNcIPzhOE3uGR48lk
         ecfw==
X-Gm-Message-State: AOAM531wXbxzs4rOt+HZO+bxAziTeZ2DpqHMcGICkeB2OgvpCGs3gwQU
        PK0SyDKriudIpGmPaYgwXQvgBL0wD8pu/mKM6dQ=
X-Google-Smtp-Source: ABdhPJzh4u+Y3nNJdpLrpbabrLSGPlr0eoOBB9vE0uwUUI4raBzhexCAQgL4WdFAm8FzzLTGd2Pq4w==
X-Received: by 2002:adf:f101:: with SMTP id r1mr6593660wro.392.1604101433179;
        Fri, 30 Oct 2020 16:43:53 -0700 (PDT)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id z10sm4702381wrp.2.2020.10.30.16.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 16:43:52 -0700 (PDT)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH v2 6/6] ARM: dts: sunxi: align pinecube compatible property to other S3 boards
Date:   Fri, 30 Oct 2020 23:43:25 +0000
Message-Id: <20201030234325.5865-7-matteo.scordino@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029022000.601913-1-matteo.scordino@gmail.com>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatible string in the Pine64 Pincube dts diverges from the ones
used in other S3 based boards, like the LicheePi and the Elimo Impetus
and Initium. Discussion on LKML decided the PineCube should align to the
others.

Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
---
 arch/arm/boot/dts/sun8i-s3-pinecube.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-s3-pinecube.dts b/arch/arm/boot/dts/sun8i-s3-pinecube.dts
index 9bab6b7f4014..4aa0ee897a0a 100644
--- a/arch/arm/boot/dts/sun8i-s3-pinecube.dts
+++ b/arch/arm/boot/dts/sun8i-s3-pinecube.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "PineCube IP Camera";
-	compatible = "pine64,pinecube", "allwinner,sun8i-s3";
+	compatible = "pine64,pinecube", "sochip,s3", "allwinner,sun8i-v3";
 
 	aliases {
 		serial0 = &uart2;
-- 
2.20.1

