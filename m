Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDED2A275C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgKBJtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgKBJtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:49:00 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7834C0617A6;
        Mon,  2 Nov 2020 01:49:00 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id t14so10341539pgg.1;
        Mon, 02 Nov 2020 01:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3m1fHdBEtF1GXzLrh850WEeEvbCCehA35f+ouhTNIb4=;
        b=XvUXUJuL6qRbbHHE37BR1yj5zge+FGcohhhSr9DibJyoVAgPD3yh4854zlthhh55pY
         dJ53dLzVbUZX/VauXVrtDSpy/xDKMWzxwXsOsM1gxDJ8KJk3ApdX3dv3n8vytmWUBmEY
         6q4/GmTBBkuSmLgTTKsBTrrydZOerP6YMbBq1OvlAjS5ByHpOvn2Db3ErrwCKfDSGAN8
         1I1d9Kld79mgupONsYK35BPmEzuAQtbxDwUrqdR8q9RHATaO8VWqE8IGDECWYp3l7C/f
         TdEuasQNcbwXSmQyT7k3km7N1Pn4u1qpY50d+hjxczezkxT8+4164serbeX2nzQEeIx/
         p8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3m1fHdBEtF1GXzLrh850WEeEvbCCehA35f+ouhTNIb4=;
        b=cw7ZjnF1DmJpRUe0ksMtCsRWMvTVZzgUe8sgeIk2F6WXh1jpE83QOMZaslIo+NV0eQ
         GSdoye8SxQbCLV1Dsl91Fput4w/OJ4ZBT6bb1Y8hldHNFIn3P5JKG4hvNLOVQGsD3AcV
         xLt3JACgn8HMJXNTPvMll+5mpUh66h1HQMVg9+zH9MCW/wX/4SULysOBW2qVtUD+K7t7
         ft5YRPfcE5K/Xn0mdtSCzpqCOY1VZWcqc2rxFmeLq27T80mF7JmTVUfwnZoZPjBJdTCe
         eHswy21TRmsDKacGEKV+dLI7iJQtsxhxa2EpicxC6+4j6F4xsJoU6yK9niuqHQg92X0x
         zZcg==
X-Gm-Message-State: AOAM531leOVWNGRNRRUHJ0PJVFGrECWcdpjf8uPpwuFvkMXmjh9LNHUY
        jGKCPqSWjou8+HHnfZvF43U=
X-Google-Smtp-Source: ABdhPJwreE9z7RRc0vFoAeA0Lz2EEKr1GBHEHKjUlqhr4NgX9Nm4D38t33oM4QFE6BE2NTID3iv9mg==
X-Received: by 2002:a17:90a:d104:: with SMTP id l4mr12013746pju.194.1604310540059;
        Mon, 02 Nov 2020 01:49:00 -0800 (PST)
Received: from ruantu-3.localdomain ([103.230.142.242])
        by smtp.gmail.com with ESMTPSA id y5sm6935453pfc.165.2020.11.02.01.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 01:48:59 -0800 (PST)
From:   Yu-Tung Chang <mtwget@gmail.com>
To:     robh+dt@kernel.org
Cc:     mripard@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yu-Tung Chang <mtwget@gmail.com>
Subject: [PATCH v1 0/1] ARM: dts: sun8i: h3: Add initial NanoPi R1 support
Date:   Mon,  2 Nov 2020 17:48:50 +0800
Message-Id: <20201102094851.85301-1-mtwget@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1:
- use SPDX header
- rename led node to led-[0-9]
- use "function" and "color" properties for led node
- add aliases for uart1, emac, wifi
- modify usb_otg->dr_mode property to otg

Yu-Tung Chang (1):
  ARM: dts: sun8i: add FriendlyArm ZeroPi support

 .../devicetree/bindings/arm/sunxi.yaml        |  5 ++
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/sun8i-h3-zeropi.dts         | 85 +++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-zeropi.dts

-- 
2.29.0

