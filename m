Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4752F77E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 12:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbhAOLqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 06:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbhAOLqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 06:46:30 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30161C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 03:45:50 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id t16so7376923qvk.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 03:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=A1L5LiBXauTNSiThdiKpn8PiuSiEsdxg7IXuLjvuJiE=;
        b=quv2i1zkZlwy1Dp26TdFDlOdkrMzdCjPwdHofP6/kJ8sMM2YlaOx2CUK+C+xMaeCcC
         wiYqUlER9Y68k4CGt/pkNbnTPZXwJgl2hgUIw186/H7EkDLChdsSYp7hntFw2G2bBwj6
         HsbKZHCLS94PSlGncDsBfIm5UMR66O9MSlyJGCzIWh3g/MUjuL7aQlG2HuOYLMEdRaVY
         jnsXXd1Lu3RKEwzbNeQAz4JpIRigk4R00jCj7TS3SheFiAe3c7E3IuXkBf5lZ+xsuj8+
         USW7iakliYd2dlHltzTIbqAJj5pNmWuRZ/FZnUQG5VdnzWI18o/BJS/RrAxFTXTAWJuH
         dnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=A1L5LiBXauTNSiThdiKpn8PiuSiEsdxg7IXuLjvuJiE=;
        b=gCN9udQ2eZ0UHNAM09eub5xIKJ4VK0+knVS3fQndw5Qg7hlTwcVzonFIVvhcmW+XTd
         ergY6GnlLfTBmw5zyQg2vgzXRoWNPZmjPC0dvzvUBS08yzKgkdOCK9yi+q0EqLyCnReU
         c1VOqFUaLj6nPmbUMQeGhPARfsJkTiYcbEqVNCsNC8V/92bj9wvMgl2EXEhZt7GclsyO
         1MSVNStJkGDZeq7/dnimBqKhqsIUfWEFFoIWgnEk+oDDWeWR23/ebHQ+kTYDIst9rQzE
         oF2St6rrdRlrJsZHPGJjSXXBVj5VsZ2KDFDwAc+vS3/CB8iHFG5NeoLUblwffZiQSMaG
         sDCw==
X-Gm-Message-State: AOAM530yDiylupjO5Fvz5EYJbcZsbSvxcSBTys6lpcTwnuO36or1mhR4
        A4lxkxEECAuwBN4stL5hwUYbfCv+r5S7
X-Google-Smtp-Source: ABdhPJzmRzMTYsK6JufS+gg1o2UjoLxakUX7PNu5dhXrEwOvB0uPXPmlthwFWXtHETHU1JpMEW26vrHLVvFe
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:99c8:: with SMTP id
 y8mr11358708qve.35.1610711148511; Fri, 15 Jan 2021 03:45:48 -0800 (PST)
Date:   Fri, 15 Jan 2021 11:45:42 +0000
Message-Id: <20210115114544.1830068-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 0/2] fdt: A couple of no-map fixes
From:   Quentin Perret <qperret@google.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        drinkcat@chromium.org, swboyd@chromium.org, f.fainelli@gmail.com,
        karahmed@amazon.de, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the context of a KVM/arm64 thread [1], it became apparent that the
difference in behaviour of EFI and DT with respect to no-map regions was
something worth fixing.

Rob pointed out in that thread that a couple of patches in this area had
been sent but still needed to be integrated together, which is basically
what this series attempts to do.

 - Patch 01 is a generic fix that should make sense on its own;

 - Patch 02 allows the kernel to have a saner behaviour with a broken DT.
   This one had a small rebase conflict (caused by patch 01). I tested
   it in qemu and everything is looking good, the error message shows up
   in dmesg when it should.

Thanks,
Quentin

[1] https://lore.kernel.org/kvmarm/20210108121524.656872-1-qperret@google.com/

KarimAllah Ahmed (1):
  fdt: Properly handle "no-map" field in the memory region

Nicolas Boichat (1):
  of/fdt: Make sure no-map does not remove already reserved regions

 drivers/of/fdt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

