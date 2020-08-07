Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C584B23EA03
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 11:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgHGJTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 05:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbgHGJTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:19:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C911AC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 02:19:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id o18so1350994eje.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 02:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jxCUiL1FgWun2oC51QoDOmsN9jreLX8epfpkWFsx2MA=;
        b=ms8t+iMzVGY/AiuJHjGuoQ4w1Y9S7Xjvy7NUnJjnQh9L8/eX/bWYkh3uxg4QSRzTrp
         FDpu/K8/qRT+WkWsIKL3rL+zaeG9yKsAnTH0MvnF7Pn8CcmteOSNezu796bmapFUIFB3
         eFSf44WIv5BbezA0X+Ygiv+k+yUvQykmHaQCWE142C9uM5JB9SMzRNcrZm92S4HaQIX3
         D41TZ//8acERYK+qAOKDwhb7P2nGOJW6Y+Zy5xR+I0AmahiVBSW6t6RX5/iCr2sbXkwY
         DhUGDcwqSxiRZnycOeC2FBUQWj/Fa5pSb+fokeUuCzmisddYzsDFFCIiZnt28gUOKzOf
         Y69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jxCUiL1FgWun2oC51QoDOmsN9jreLX8epfpkWFsx2MA=;
        b=sABYcEWGOWD0h19ll2UhYP00Vmj8N6FIZpwCPlPhEzcUxXmZay/8Qwbq5kZUlbytZR
         sAJpEP9oDHb5+b/OQm4AJEXcFnWNFnC30jPvSbsnvBBUxM9oHOz84er6ECRa96v1na6y
         CS+VC4vEQMQhIg85wqs3BnnI8VHdiyn+NSvvA70o+Gu7pz4XtO6H9WiGYpYeGItxuKw/
         8tmmTN+JuIkLcOllD8by5nUn7cnWqkzVg73fUwAyVnFxOw1P1NvPLFfzwRhVtew4SOsV
         QTmyvjpgTcmrvoE/E91HHaABAvE7H5ETh05WSkKIG9KpSRYQ8XB5qJBiwb2qMAtkf7Ij
         1fmg==
X-Gm-Message-State: AOAM530aMlhIZvDRh+30yZdQvxUDzff653E4mMJm+PLYXIJcRjd9PonF
        /2zHiebbXe9HsxVEzhsoxHyp1Q==
X-Google-Smtp-Source: ABdhPJxd7gZXcwVRKebPmvX3I6NP1L9SSgH8T2ts7fHpYdS8WQVMmrVruN+hzykqwl+nsx2Rj+T/Mw==
X-Received: by 2002:a17:906:7c4f:: with SMTP id g15mr8273162ejp.82.1596791978373;
        Fri, 07 Aug 2020 02:19:38 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xajgyum9863qf6si3v.18120a2.ip6.access.telenet.be. [2a02:1810:a421:dd00:2092:7f6b:4676:cab])
        by smtp.gmail.com with ESMTPSA id i5sm5156739edt.52.2020.08.07.02.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 02:19:37 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH 0/2] iio: temperature: mlx90632: Add extended calibration calculations
Date:   Fri,  7 Aug 2020 11:19:00 +0200
Message-Id: <20200807091900.967047-1-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the second patch is dependent on the first and was still not
merged, I have decided to send them together. First patch just makes
second one more readable as it splits out the repeated calculation and
that enables the second patch to tweak the variable to the new
condition.

Crt Mori (2):
  iio:temperature:mlx90632: Reduce number of equal calulcations
  iio:temperature:mlx90632: Adding extended calibration option

 drivers/iio/temperature/mlx90632.c | 235 +++++++++++++++++++++++++++--
 1 file changed, 225 insertions(+), 10 deletions(-)

-- 
2.25.1

