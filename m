Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB4228470B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 09:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgJFHUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 03:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgJFHUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 03:20:23 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90072C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 00:20:22 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o25so7506094pgm.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 00:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=rxAgGOnSp5xOsvFWw6q8lz/Ct2uhAJkdx7TguqBlof8=;
        b=F4WNRrKBKMcxU+n0nc4dkanncDiXPL/ee8GnugHv1N24B0UhktyHf/9Iu413xLq5OI
         6VELsmsoRfB9B1ijm+X/74ew8aD/Tdm9ahgm4sHvORS8XjaPn3Q+3RFpfGINGQWaDT+8
         anAbUBW5CWTSrodFiXxo9FT867C7JW1jd6d5628LVpUje4qyaEE+g9DlOcX4M7fEId+v
         W8Z53x3vdgJelEeyn1S++eSHd6zh/Gt+x8cu9Il+7txxQ30oECUzMB2c+YusC3P0hQYv
         z+jLWgSkio71KxMZ4/uXvRuStv+fY3Jc/ZdR7KWvJwHoGknAlFcnmVZa+MCU7h3czH1/
         kYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=rxAgGOnSp5xOsvFWw6q8lz/Ct2uhAJkdx7TguqBlof8=;
        b=YMaWjyunneZUigQltKj2s8af8Frb6YrkXMDxLFi1HW5/mRN0VYsXKPfdA1KkXocNLO
         CdlVXHqtS94OCSHTU3M34DKSxfStiPNU0sThPYy/Q8E2H3N6dJEV2C71DTrymmUzlOLm
         U9ouT9vNKuK79ll3E43XL3Mk66c7XmCzi+BVUSXWJ2BUwrLEyiFAapMKbJA3ftSjpP4K
         ZHU20r/IsX+kVcuT4G2VHeM5OZtYuzB0x97XbaQPS/Z8QGre0sUevpo9ct1qI0drtDAs
         YbN4SkOsSOnn9vgxkki2ZJImY83nwT+6v80JlPeVkJRGIjMlvuNxQm6EES1rHBT+Vy57
         IRPA==
X-Gm-Message-State: AOAM5303Nl2TV6+JUu9x+w6mUVgCBDaTNdmQqaXJYQiJ5Sjoh5q2+1A7
        Q64qIyM/XOtFgk4Fp8RHYTiy1Q==
X-Google-Smtp-Source: ABdhPJwFixwHBWx7FZbq4mDm9X1o+f9+TAKkQxezHJdX1AtJAI7MPnznxBsp8EZFQ4Y8Rt+/Fs+n5A==
X-Received: by 2002:aa7:9201:0:b029:13e:d13d:a10c with SMTP id 1-20020aa792010000b029013ed13da10cmr3081378pfo.40.1601968822143;
        Tue, 06 Oct 2020 00:20:22 -0700 (PDT)
Received: from centos78 (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id j6sm2238910pfi.129.2020.10.06.00.20.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 00:20:21 -0700 (PDT)
Message-ID: <c065aef85fd477f3d3e17b8d095d563226e568dd.camel@areca.com.tw>
Subject: [PATCH 0/1] scsi: arcmsr: fix warning: right shift count >= width
 of type
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     kbuild test robot <lkp@intel.com>
Date:   Tue, 06 Oct 2020 15:20:20 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against to mkp's 5.10/scsi-staging.

1. fix warning: right shift count >= width of type.
---

