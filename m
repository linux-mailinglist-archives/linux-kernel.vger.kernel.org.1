Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8405721634A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 03:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgGGBSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 21:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgGGBSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 21:18:13 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2306C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 18:18:13 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id v22so10371pfu.22
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 18:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=POAVhW08+ZU8xNdsup56SoBpII/10dTLj/pBlPAsXoM=;
        b=pTTesSpA/Wt0QVgk5baicGZGjj69MSJbJ4Mi5YjG8KasrEtX20Bo/ZX9b+Co9GqKvN
         A04FUEoHRLV0jRqBS9Ir54zmpfvCgjJ7Itba7qb24b0ovI7HVPC+TtlDsf+URVEYCjFL
         nluMHi6RT0yFfy+IhtV3BDURvgaTBBxpcJHOXHHMyFAE9jlisvuxxAQtu1pB+DeZrKfo
         z6pNRzV8xWmClk67t6ZiKRRuQd6Kkqab0tOHQUA2GPvU2c1U3Cwy9dMNyi/HcT0SnrDY
         HntDo9ctgMs1atfFq7v/kC50zwyKbVUsLapSpLtWFD7w0AAANAce0R1QuapQvaU0B1JR
         joRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=POAVhW08+ZU8xNdsup56SoBpII/10dTLj/pBlPAsXoM=;
        b=I89T5pG/iHT2GoqmYukCS3ACVZQOJEE+MSYeqYZ+LenAkiKmT0QEYwC2zZSAoZpOWZ
         mwMsM+dav549xraOf4YEk6KviZ3WaimMMhhoXDTX14WFxtveemej7Cey25DMKH2IAnaK
         djjXMkOYf2Bj1Z8c/IqHCpzjL9LQdXSVeY5ydaemAON5FZlnC+6AczM/Toigl492E7dF
         eM/OJfCvW8kE50hloD4otwKzAhbyKIBG3DezTzXS4uKjxVbYzEV4L6m0j+F4SGU9u2Bs
         jXbMHDIkuCyrSlObyY0YRTzES72iyG5zfmHAIcLbOW+si609MSQ7gBIOUQiGvfmyFFRo
         q0VQ==
X-Gm-Message-State: AOAM5315gxh5Vpa+VUF/sgJ4/TxsNseKJvFbOcMnqx+SkgPaFPwOsRfR
        +RBXqddvA5Fp47ZkhAnT4eIkbTpmdDI6df1z
X-Google-Smtp-Source: ABdhPJywWILE5dEPoNQpf/klFKbEE+y0dTcS6+2HIRsETRXH1Nk3SPz6eqO+XBlkQZVC+O2e+08/NWEMTi4vljkq
X-Received: by 2002:a17:90b:4c12:: with SMTP id na18mr337569pjb.0.1594084692806;
 Mon, 06 Jul 2020 18:18:12 -0700 (PDT)
Date:   Tue,  7 Jul 2020 01:18:09 +0000
Message-Id: <20200707011810.2508233-1-linchuyuan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v3 0/1] hwmon:max6697: Allow max6581 to create tempX_offset
From:   Chu Lin <linchuyuan@google.com>
To:     linux@roeck-us.net
Cc:     belgaied@google.com, jasonling@google.com, jdelvare@suse.com,
        linchuyuan@google.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongqil@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per max6581, reg 4d and reg 4e is used for temperature read offset.
This patch will let the user specify the temperature read offset for
max6581. This patch is tested on max6581 and only applies to max6581.

Testing:
echo 16250 > temp2_offset
cat temp2_offset
16250

echo 17500 > temp3_offset
cat temp3_offset
17500
cat temp4_offset
0
cat temp2_offset
17500

echo 0 > temp2_offset
cat temp2_offset
0
cat temp3_offset
17500

echo -0 > temp2_offset
cat temp2_offset
0

echo -100000 > temp2_offset
cat temp2_input
4875

echo 10000 > temp2_offset
cat temp2_input
47125

echo -2000 > temp2_offset
cat temp2_input
34875

echo -0 > temp2_offset
cat temp2_input
37000

Signed-off-by: Chu Lin <linchuyuan@google.com>
---
ChangeLog v2 -> v3:
  - Use reverse christmas tree order convension
  - Fix the type issue where comparision is always true
  - Change the line limit to 100 char instead of 80 char

ChangeLog v1 -> v2:
  - Simplify the offset reg raw value to milli ceisus conversion
  - Substitute the temp1_offset with dummy attr
  - Avoid using double negative in the macro definition
  - Return the actual error when i2c read/write is failed
  - clamp the value to MAX or MIN respectively if an out of range input is given
  - Provide mux protection when multiple i2c accesses is required

Chu Lin (1):
  hwmon:max6697: Allow max6581 to create tempX_offset attributes

 drivers/hwmon/max6697.c | 92 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 4 deletions(-)

-- 
2.27.0.383.g050319c2ae-goog

