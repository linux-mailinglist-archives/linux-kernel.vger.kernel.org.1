Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0F6285A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgJGIOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgJGIOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:14:38 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F47C061755;
        Wed,  7 Oct 2020 01:14:38 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d23so612898pll.7;
        Wed, 07 Oct 2020 01:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=aR/crGqpjngWx4uY4BPhbCIGGN5/NfXCrwfurQ6wFX8=;
        b=M+Js+118hi8DOmX4FZf6mM4Ib2Y7HqIbHABHKm5ceOi/4YB8ADUtyzTcFCLWJIiiNL
         d/PiaG1qaUaFVeft9/wdrewQBHyiiSYMZPUn1gsuMeeuMUEvfcU9m7VwDCW1JiGlMo1j
         3TSGkt/XxZ7y+JrANSekJFzReHjOnpQQqhTXKzE9aabYvy+YHbY0lJAgkJJ91bv9cp3Z
         S4ospVUiU0DcNofTKhlJgPIuKGU675U84EOke+sMGFdZaomba+4el2KKYDbas7PlHgsf
         /IetCjGw4truos/ZkrxPMbYjhtdU3IXsucgFh8GZv2gGIaqT7nonV0RRj6pngaHd4SV5
         SY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=aR/crGqpjngWx4uY4BPhbCIGGN5/NfXCrwfurQ6wFX8=;
        b=WC2t/KGKAJ5Ut2hH6uC3kL5NpIv/cao7xG2A4qmgyIcqpKn+oSJkSyMv3yqM7EumSf
         WZhboTk3FLU17XGuNQOzsPzNjNm/6SJiu4mVT6oIvitXIg0py2KMP5r3QEm+JHJPFvlt
         ic0gZIxwDTqUWVO1QRDrJD3ybXAQEZVa1v8fC8WSuoIBv/3kaYKfOMIzraSeuA/72t4r
         NguvtSsphhC7kSBuz5BPxbMmHUplfrUmb81mD8MiHxw8WX2bXcheuWuXe9T9/+R/tE2u
         uxeWfXhxz8F3hw+n1tlYVjqX1rX0t881drIqNpGJRyxKeOEAj8ZoV/Ot3ZYTtSbN0bUV
         i9+A==
X-Gm-Message-State: AOAM532sudpdlFLVTgUoXcP4qUUsT1tS4IEbIsVLGlmwYtL37DjcOnJd
        TORIUDdFvZ4nJEdz0pT0XXs=
X-Google-Smtp-Source: ABdhPJz/IG9016CRVziTx6VnTnMzdjx9OkOQzHYZaUJYwr+krDqW/GsysWerNUdwLfDFLLG/GMQ9mQ==
X-Received: by 2002:a17:902:b70a:b029:d2:6391:a80f with SMTP id d10-20020a170902b70ab02900d26391a80fmr1843556pls.0.1602058477662;
        Wed, 07 Oct 2020 01:14:37 -0700 (PDT)
Received: from adolin ([49.207.194.78])
        by smtp.gmail.com with ESMTPSA id w10sm1443590pjy.13.2020.10.07.01.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 01:14:36 -0700 (PDT)
Date:   Wed, 7 Oct 2020 13:44:32 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     corbet@lwn.net, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 0/2 V3] Improve Coccinelle Parallelisation
Message-ID: <cover.1602054065.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinelle utilises all available threads to implement parallelisation.
However, this results in a decrease in performance.

This patchset aims to improve performance by modifying cocciccheck to
use at most one thread per core by default in machines with more than 4
hyperthreads.

Sumera Priyadarsini (2):
  scripts: coccicheck: Change default value for parallelism
  Documentation: Coccinelle: Modify parallelisation information in docs

 Documentation/dev-tools/coccinelle.rst | 5 +++--
 scripts/coccicheck                     | 5 +++++
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.25.1

