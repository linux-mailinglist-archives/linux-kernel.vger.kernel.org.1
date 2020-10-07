Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9CA2857C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 06:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgJGEcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 00:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgJGEcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 00:32:35 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8388BC0613D2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 21:32:34 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k8so625050pfk.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 21:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=M52oZrMi9dCtDbxAjDKC3w2Xn750c74KunzKHY+WZkY=;
        b=D6l/DmN3gqgifcj7qXftu2zdBTUAituYO2V5XfTpjzryg5w420y1a83h5y0uiTm91R
         I/zZGmrEGGulyFEVEaqwz9eY13sT50T0ZKEfAp2K3Bj2PMwLtzkbbnXIaI2Bsv4fGQYK
         3MyXZfGFnDqu2KPzxklsTZhER7enYE8ZvjMzDMXL4lUQ/YHQO/7Buc5AJ6cJ380bkTb9
         EXW2wIV8nOdOo1/saWYiNd+1da+WnSGOO9AB819PEAAiUax6sZe36Hiojo9O6jD9qNAa
         HpKW57GQi0pdwZRPl2ODezeeNfqXSlO4xQy4KDu+SVh7oLusj7aM8+e0qw9QDfWfpu49
         PCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=M52oZrMi9dCtDbxAjDKC3w2Xn750c74KunzKHY+WZkY=;
        b=Cx/2GZh0Zwm/0/fNQq9XnMawp3/nCyc8H/Qo5UkXdGE2OutoyODZo6kOPTUcAHaXv5
         kzG8qAjhPAtSSdskfmbB7ghBfmAHwGSyF32G+gg8MqeZiFchRRsMi1nXSqNMFGjStQw+
         KpbQOwy5T0K9uyGI2avIZP061T7O2GBrkFHUOi1rHlbN9tNicF/tC5GRltloA+UK5p10
         tMWkKDrwPjb5T1MBkCdV4s1/h4T+9/Szd2ADKE+g6h6wni2jOJf1dHUuJymAOZeM5Rry
         4wmm+wjprXwPYQDJ4v12jwGV2x/U1MXhYSRPRzxyO1rSJ6uc6S+hu9nwyaG25S5QtH17
         UAKg==
X-Gm-Message-State: AOAM532LB5QiJjUXx3uy28MGgDgKB4ZK1mpve7yKemZYoJWtG+u5S/g4
        YwIEkLPVkVK6YacwuynxmQIMDQ==
X-Google-Smtp-Source: ABdhPJzQT89WT7rRYWfnRKbt17fvHcbha1TTHMEjfz7leHTYTUS8ugTbfIbiz86KfnNlKO4T78vYtg==
X-Received: by 2002:a63:f342:: with SMTP id t2mr1366738pgj.313.1602045154069;
        Tue, 06 Oct 2020 21:32:34 -0700 (PDT)
Received: from centos78 (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id f18sm960710pfe.153.2020.10.06.21.32.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 21:32:33 -0700 (PDT)
Message-ID: <281cbfc346d55de4bd796916fa5779e06a833040.camel@areca.com.tw>
Subject: [PATCH v2 0/2] scsi: arcmsr: fix warning: right shift count >=
 width of type
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     kbuild test robot <lkp@intel.com>
Date:   Wed, 07 Oct 2020 12:32:32 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against to mkp's 5.10/scsi-staging.

1. fix warning: right shift count >= width of type.
2. use round_up() instead of logical operation.
---


