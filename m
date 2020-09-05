Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA9425E755
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 13:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgIELrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 07:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgIELrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 07:47:01 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4685C061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 04:47:00 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id z22so11913027ejl.7
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 04:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XjHO22gOUNTCEf8s5/cXCs8QJ9leFwSLuG3Wd2iaO5M=;
        b=YZUnCTt9vIig9rL+EyekTx/ph/4ZpXonVy5Tf39gUziMYEDjylZ4IodVJzJxRC95xB
         at89Uh6PLeZ1ycd+lJAQLdMi1X5bwqLICNWBUF4U8GegAqZsYTqw8rDxdZ4ZilzR3Trv
         UmZkbb1OU+rcjCyX6x9tOTQR0z9ppTsHslL5blsMRRL7MLSgCwq/J6f2dGPiI1tCthbr
         xWM+OLH1E8uzIY4uDATZFYfpmrkt5Sb4mwtq8JNumQAsW4dGZC2+f4B8GjRvvoqPjGWu
         5rN1JHj01QFyG0wMW/4zf1+LGZn6Mf1PHnjV/SQOtHnZWuhKYvqUx9lYuME+DI6t0asV
         IS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XjHO22gOUNTCEf8s5/cXCs8QJ9leFwSLuG3Wd2iaO5M=;
        b=d8g91gSENaHgWpQwxxJ4oANZnSQwAH96KImIf5Q110g64F2oB1HgtSvPJDIULGGH+c
         d8qhA+gECDSa2X4l+hFdj5ff+EMV/IjBi8YCAj+vTa99SJUDVMMFmUisErOL7K375dzE
         I2eJNka3H4Xzh5EItceO44SIs7W14ygu28uBBpW/bfdEGBbCR8M2VeGjXkSgZbzwOM1L
         SaU6LzxUs4pjrB0h00XMtFPhAtjKt8jaik5fmPnGRQByaz11Lb7bL0WFgkrJZ5QfPLjq
         KW+XY1YsZEl197q2HNbr3SWUcLN7iIlleA6PYLNC37kQ9Oep0UQRWFW6k8u7mbp+Gf0o
         8MrA==
X-Gm-Message-State: AOAM530+yzr3QMvOisHU957LhB1B9lLNb5hHj5cDumYSG45D93AkwgLT
        8hr675Uie2k4kYOli5qd9VG/JlfU6K1cFmwV
X-Google-Smtp-Source: ABdhPJwgQ9oJVT9kanLpfTgZCBLRSegCzu9BjnfVcm6wkHUKXySglXw2g5fslgc1COBo4Rdlq0DnKA==
X-Received: by 2002:a17:906:644e:: with SMTP id l14mr11905602ejn.60.1599306419216;
        Sat, 05 Sep 2020 04:46:59 -0700 (PDT)
Received: from gmail.com ([46.101.156.237])
        by smtp.gmail.com with ESMTPSA id a8sm9088097ejx.73.2020.09.05.04.46.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Sep 2020 04:46:58 -0700 (PDT)
Date:   Sat, 5 Sep 2020 13:46:48 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] clang-format for v5.9-rc4
Message-ID: <20200905114648.GA6048@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

We are in the middle of the cycle, so here is the usual update
for clang-format.

Cheers,
Miguel

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.9-rc4

for you to fetch changes up to 4e4bb894467cd2a08fc3116407b13e6bc23a7119:

  clang-format: Update with the latest for_each macro list (2020-09-01 12:53:42 +0200)

----------------------------------------------------------------
The usual trivial update:

 - Update with the latest for_each macro list (Miguel Ojeda)

----------------------------------------------------------------
Miguel Ojeda (1):
      clang-format: Update with the latest for_each macro list

 .clang-format | 12 ++++++++++++
 1 file changed, 12 insertions(+)
