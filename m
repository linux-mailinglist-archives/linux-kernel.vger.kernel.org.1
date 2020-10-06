Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6C9285205
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 21:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgJFTFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 15:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgJFTFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 15:05:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B84C061755;
        Tue,  6 Oct 2020 12:05:03 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e10so9020148pfj.1;
        Tue, 06 Oct 2020 12:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=0Yw4y12mYXqqzBAefSKmQPErnuJA8Bd/3bClQhft1f4=;
        b=J9sFhc+1KcqbpLQ7ekiat8iAZKtmnnrkH4W2rtwSKcoBnqWye7OXmkWmVFTIzIrF64
         95oHtrlypE1jdVQrzKddZSnaTMd8mmVZcR5aWKDer3JR/AHJ6RVz6fVaHYJL25G6owJV
         grag7y4YkMTjqNAQoXtGNQ40dXREPsToFLFJfdRiTAocUgEgrGcsdFvWKuY7IKEkEM3F
         I9XeTXM7rA+5I5HcJe8NoCL/nndWYFgIOVLb8Uyvifp7MUieznep8mIHzJ8fwuS5Y1+j
         ugUF0UOnN2yMZ4l1bp5WfbWv3UsBj56FoQFOs5X3yN+ozLTLzYcRX1Yv09UgKQIebypF
         Rqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0Yw4y12mYXqqzBAefSKmQPErnuJA8Bd/3bClQhft1f4=;
        b=fceUkiEK/6b3uTZyFJbs6R1V4Yy3/zFethNcypW3mV+oGUVF626yshfIAPDRqZviZj
         PBXFJ3mfQ3gERGrn2esacLT0mUcCKjBuhHiQxsa1Z+jVRtN+7LHDaOCAg1hr5a6Ps/JA
         ei9QNaV8lVo7A+ETyRJEf8ZyyoDtmIsAEfsT+rwZtZJ7CZvg3SZ+9bZmGx3A8Ic6/NH+
         bj18JHkTCmOFsiNRd/PAFXHN8BlmmK6gp9EcXl0WPuTWJZNCAlp0ZnRfcli2Bl4bhxAd
         Fe+geHr5pl+OBLQUB5m0WPpLL9v3tB0pKf+j9B0bhTiLQMZoFw/+f4k0fP3WK0Vey/y7
         CvSw==
X-Gm-Message-State: AOAM530lIIWoNX2KOS/bfOv/UQ7AxYxyOZqqIupoDmUBIIG7eIMrSoYQ
        wPkq6onRngJJ3Nj1UDm7q2GGJ0bQAomO9Ll0XSQ=
X-Google-Smtp-Source: ABdhPJwcQ61R1577YVbspYVyB7F5RVUxCM47PqwOQFHeyVaG+sJacA66GKFM4l9CoXNElUhnhfb8Hg==
X-Received: by 2002:a63:ef4f:: with SMTP id c15mr5349356pgk.140.1602011102920;
        Tue, 06 Oct 2020 12:05:02 -0700 (PDT)
Received: from adolin ([49.207.211.213])
        by smtp.gmail.com with ESMTPSA id q6sm4640246pfn.10.2020.10.06.12.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 12:05:02 -0700 (PDT)
Date:   Wed, 7 Oct 2020 00:34:57 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     corbet@lwn.net, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 0/2 v2] Improve Coccinelle Parallelisation
Message-ID: <cover.1602010816.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinelle utilises all available threads to implement parallelisation.
However, this results in a decrease in performance.

This patchset aims to improve performance by modifying cocciccheck to
use at most one thread per core by default.

Sumera Priyadarsini (2):
  scripts: coccicheck: Change default value for parallelism
  Documentation: Coccinelle: Modify parallelisation information in docs

 Documentation/dev-tools/coccinelle.rst | 4 ++--
 scripts/coccicheck                     | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.25.1

