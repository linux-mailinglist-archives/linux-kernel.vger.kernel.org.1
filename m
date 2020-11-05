Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EE32A8162
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbgKEOt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730775AbgKEOtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:49:55 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEABAC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:49:53 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id n18so2085925wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=atTzCWPPlahrYZ6oaD6a/eMQRrb+6N0sjW08hjWOzVc=;
        b=HkMQhjKMqiOTmH6iKAEQHVMKYFBnek8NxAqQLJKOzxXjz3o2zr5ws0iM5xBW3dIMml
         89wAaPYzb1201n7JJEJ8a4Sm6uk4eyjIwxccNFKHl/Og2BSCwTOdXFi6tqOub/otsBIf
         7qat7sSS2+y/WhcFf3+5o52obwcr6yl5piYYT0SJDvIrX2KnKwCNBU92NT8O7+pKks0z
         0rshZl2oeCJ40VZj4nSd6e3ui8dj7a2qBc2i8ztWMzTthg2/DDpAVlVQmdqoA8tLYZbR
         reTe7ENA1j1O9/3WFKbNdjlB1IAJi22XqQvokkUAxoNR/EoYWgK1KrBKO+6ZVQga1SRp
         PJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=atTzCWPPlahrYZ6oaD6a/eMQRrb+6N0sjW08hjWOzVc=;
        b=o/aZXigQsmMexQDHFL0pa0yRvxsS+1NSf7HAL+56CFZh2AfpqS5f7TvuvpCjzD9tEU
         1LgRi0Z5agFAn+gcV+kGIAycI4FWc+mp5Vvn4STzq0qUVFpbXl/Kqi9bEQ3/Y8wb+iWl
         o6N/uqeJXyUiXOst1G+bv7To3aPsmA/bmKpYKn2YpO2oLGnbKUx43doANQHdwT39ah6+
         CHfUYJyFfcnsmfg1PrvcqtBrODCtYJUDLhOI8KD7044Af9Z+QmHNdTg5aNfGOkgMygY/
         2+ItsyZGz6sexThq+kQhsYF3xZSUgSqwX3HGO87oaHykLX5e/nl15hJBqryz/M6EOuJO
         LchQ==
X-Gm-Message-State: AOAM532lWdsUxIcGiJJvlt9jNQuiVErAqsIIinHUrXf7MaTXFwLzAwHI
        OdxzRkIcwqQr6tfGhLw6qbY=
X-Google-Smtp-Source: ABdhPJycFxukL6YmcsvmqtnfVEqh2FZUWevL8kW5bsAdKvWtwzl3BMo+RE9hI2sl3+9aZarQ7El73A==
X-Received: by 2002:a5d:4148:: with SMTP id c8mr3330544wrq.261.1604587792651;
        Thu, 05 Nov 2020 06:49:52 -0800 (PST)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id z11sm3055512wrr.66.2020.11.05.06.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:49:51 -0800 (PST)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH v3 0/3] Elimo Impetus and Initium support
Date:   Thu,  5 Nov 2020 14:49:42 +0000
Message-Id: <20201105144945.484592-1-matteo.scordino@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029022000.601913-1-matteo.scordino@gmail.com>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I removed the patches that were accepted from V2 and applied the lastest 
suggestions from V2, i.e.:

- moved UART1 definition from dtsi to dts of the carrier board
- correct sorting of the dtb in the Makefile
- fixed indentation of compatible property


Matteo Scordino (3):
  ARM: dts: sun8i: s3: Add dtsi for the Elimo Impetus SoM
  dt-bindings: arm: sunxi: add Elimo bindings
  ARM: dts: sun8i: s3: Add dts for the Elimo Initium SBC

 .../devicetree/bindings/arm/sunxi.yaml        | 13 ++++++
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi | 44 +++++++++++++++++++
 arch/arm/boot/dts/sun8i-s3-elimo-initium.dts  | 34 ++++++++++++++
 4 files changed, 92 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi
 create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-initium.dts

-- 
2.20.1

