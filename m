Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A970E29A34F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504985AbgJ0D2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:28:03 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51969 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504976AbgJ0D2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:28:03 -0400
Received: by mail-pj1-f68.google.com with SMTP id a17so58347pju.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=UgL1OqbLLKBOpo+035gGI2ga82oCmxIxfGnnI3yWATc=;
        b=kBHF5TaMzia6Q1KvnOxxpV13u4ohfEngYW+WyvyWcjbM0gUeKOYJsbPoquhOSC+l/F
         2XAdb+GpFLH5TWOGDnQOaX6A8NMo9V08ieqI0hd3cGPSxpGnAcu9y92X4y1XLXw2Yp91
         Gut3S1dFJu0tNAbC1B5g/8selVIxjiJSH30Hk14JHYzp4PVKoWpfLnBuEwLV3r3AmEwJ
         TvEqFXMUEAMFQgaUfCQy/1nuVhVsR+cDK1+rL3Eg20jMjNUzDavLDnbQ9fgJ8vEiOhZ4
         Byd900RpRO81nkgrwuI+WLBM3Vay4SQNPQN70q9v1LoizUbM+Y5tiurVVopYBQXGY8a0
         +SuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=UgL1OqbLLKBOpo+035gGI2ga82oCmxIxfGnnI3yWATc=;
        b=bBuqe70wiwObZ6srDb4aF13YIfGBq2Gss54Lq5/ggw/5s1XDh7/p0Z1eHP8FqABokF
         Wi37NwqzoLBHJtKaPVxusvrKImACDn8ocOTxKf29q4XyDD/CP4LIkrrypbnLmqrW2rkD
         fGdvKERpVs/hXG2dm42sZ6pmIPfbRVFyvyf1ZcuqESPhFbMzAwumelYNZQKhyYshN5dA
         hD794mzx6IvdZO8BorqAEwX1dO5kKS138qykTfOr9SYkzJt5O8wKsENPy+SxlARQ+P6G
         1eDqV675TSgc5qHdwzlLdIo28JA3f1akMWPEoRgggJsfklB4KhSZvEp0qH4S/i9KS8Oa
         5w9A==
X-Gm-Message-State: AOAM533Ulux8dWZqWi+BfFuVEvysgk25HxN3DjeTEHtm9iE3OA3JFpsU
        QuI0rfxO2A+RUYQwE4sDbb2RPg==
X-Google-Smtp-Source: ABdhPJz50Vq6kPm31HR2dL70/9FiLagBDMcNydandHW/TTeNonwMePgnt5thZNu6PfUrOSzwKMAYEw==
X-Received: by 2002:a17:902:7c8c:b029:d4:e5b2:fba4 with SMTP id y12-20020a1709027c8cb02900d4e5b2fba4mr432402pll.82.1603769281168;
        Mon, 26 Oct 2020 20:28:01 -0700 (PDT)
Received: from centos78 (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id n7sm41005pgk.70.2020.10.26.20.27.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 20:28:00 -0700 (PDT)
Message-ID: <53bbf27e75420ae1de09899c40b42e4c2d5edda6.camel@areca.com.tw>
Subject: [PATCH v2 0/2] scsi: arcmsr: configure the default SCSI device
 command timeout value
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 27 Oct 2020 11:27:59 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against to mkp's 5.10/scsi-fixes.

1. Configure the default SCSI device command timeout value.
2. Confirm get free ccb in spin_lock circle.
---


