Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C6628C4D9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 00:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390333AbgJLWi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 18:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389220AbgJLWi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 18:38:57 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696CEC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:38:55 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d6so9500555plo.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=MHjY2BtfKrd4/1qBHnd1VY01yh7hsfG7Nbpa6Facd+8=;
        b=UbxwGpbCpJR31PRA8U0b3q9Gsauw1M4jnXZT1WZtQmMITiNkYXbJ4nF55/VfZSwgnE
         Cof86BCkQCrUE4aun3Bxc5sIxchNPopS8/DoymK/XvcObDUiOy1ks59rp/MOEv2/r+aK
         3aK70LJUlFEkzNHYAY4dP2r/hjeTUW6SfJytg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=MHjY2BtfKrd4/1qBHnd1VY01yh7hsfG7Nbpa6Facd+8=;
        b=a65BRt1dPfolhM8pYxjl/UkHG+mzjIlk8u4CIMOwLAMTh9oiG3R6H8zoRa6kX6OfiY
         9sj9bGOn+tiB/20C75qArOq5LSlX5IfYv/UF+IMjUvxLcg6PWPEE/PE7Ri/gEs+7v+uy
         DR3Fn4pgc3dFq/B52Cc82Vm2IdkgukfNj/swam0k/n1/XzxbLGGqasnhMwTZi6o0yf0I
         u8Kk4/OYwf5VhCngNPc3y7ihNJDkm590VOg9dDiJxsnT3dWI4E9MDDNahWdpqvl0FHA6
         lKG7GidkNN6Hun+ytf6fpJI9n96AMr+VgazASXUPpGQ7GR0htrtKJnpagDBtKuAygbeB
         H8wg==
X-Gm-Message-State: AOAM531KfiJPk6OQoYPeVw9yVEFxu0q/T+YOJO6eDsTUwZm/5O4Vg7ey
        BiI+xRgEUDt8fTJepY82ZQIBEW3LpH+QUA==
X-Google-Smtp-Source: ABdhPJz6bcNd/AxuM1IWQf82RoKB/XXjkAkfb3UFrvbM0uot3+WB2l8W1A3qzQFXQYr81TCDO777OA==
X-Received: by 2002:a17:902:b611:b029:d3:89e2:7957 with SMTP id b17-20020a170902b611b02900d389e27957mr25299479pls.19.1602542334866;
        Mon, 12 Oct 2020 15:38:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bx22sm26965614pjb.40.2020.10.12.15.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 15:38:54 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:38:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [GIT PULL] overflow update for v5.10-rc1
Message-ID: <202010121537.E5CB11BA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this overflow update for v5.10-rc1. This tree is pretty
quiet this last dev cycle, so it's just a single change to help enforce
all callers are actually checking the results of the helpers.

Thanks!

-Kees

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/overflow-v5.10-rc1

for you to fetch changes up to 9b80e4c4ddaca3501177ed41e49d0928ba2122a8:

  overflow: Add __must_check attribute to check_*() helpers (2020-10-12 15:19:07 -0700)

----------------------------------------------------------------
overflow update for v5.10-rc1

- Add __must_check to check_*_overflow() helpers

----------------------------------------------------------------
Kees Cook (1):
      overflow: Add __must_check attribute to check_*() helpers

 include/linux/overflow.h | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

-- 
Kees Cook
