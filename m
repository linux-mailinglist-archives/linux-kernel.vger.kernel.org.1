Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044AA1B1571
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 21:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgDTTJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 15:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727914AbgDTTJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:09:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6930C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:09:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y24so803616wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YqYAor/ApIIt19cJKNwvcsnIqUVFNbWnoDijOlyYHgE=;
        b=RkHoxipA4EHNod4vicJf9LOy+sn0bQNs3ayzNA/jOY17MxAXRE7yU5VPBddPX8EjeW
         GxPad84V6zusnUj3iAko9TOGoFmHKphICMcklCO3Nof5dAltqODzkw5BK0z7KaSWOvFT
         QzlZ1iJ3gJrrhr/h9aXAwqnftbTNeburqANKUi+aDOm7+RCBh3//082lgWECbkZGSU0B
         adZFyAriXfbbMRazzInxtJ3jftZbDEJaQyp0jHjutJTdZjTbBGW/j0KRP1/WSkG18Vzg
         C+gM7vsdsEOozUGlIAMyghOrUsu0CzeelrnEhoHpmQyMs6Vkwi3Xj5O3FIwyxkJ9pmF8
         ua3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YqYAor/ApIIt19cJKNwvcsnIqUVFNbWnoDijOlyYHgE=;
        b=HSjzhVo8sZccLcMOGBRH2o275Ncolv4pkEb4VedSndD2ZOcghPg8mTrR3b/3T0E39+
         6nlUxjr6ijXi3QUBc2JsafegEPkzyx6jhz732540qb+gmTABFpoMyw+akTbm7+f3rSsD
         K/mkRRIaNJQhwbKpd6gOCOi/9F2uWKkDUlJ5fvLBYl141YdPYR+oRrsarWgKv7a5ugl8
         2Qgmm6Gkvy8rPoztn9rQHWMRD+fYMU1samQ7ZXJDDBRV0PF7/Bg0cskBZkVOzp7RYGqg
         6Smv3YR2danZvox+XmEEDsM8rlkDYl3I8xVNohMPjtkpoGz+GguGQE/sNh/gz4PNgaXV
         c/eQ==
X-Gm-Message-State: AGi0PuYznh6D0Mgp5JXbjUzZbKKcqPrXIQ+IXFLpHh0Xt0Ry/EI++9e5
        zlwZN6oj+pHo8lY2S7Si+7yNEjtm6+i1lA==
X-Google-Smtp-Source: APiQypIaJHSST6LTUwkLJR90NqbKD7bSzv6kj4q+6e2lfqOr49jh2OLHaLhYepFQf9wXy2EEYGaStQ==
X-Received: by 2002:a1c:41d7:: with SMTP id o206mr852216wma.89.1587409774567;
        Mon, 20 Apr 2020 12:09:34 -0700 (PDT)
Received: from gmail.com ([64.225.109.20])
        by smtp.gmail.com with ESMTPSA id l4sm568959wrw.25.2020.04.20.12.09.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Apr 2020 12:09:33 -0700 (PDT)
Date:   Mon, 20 Apr 2020 21:09:16 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ian Rogers <irogers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] clang-format for v5.7-rc3
Message-ID: <20200420190916.GA11695@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The usual update for clang-format plus a requested C++ formatting change
(to align it with one of the C++ files we have).

Cheers,
Miguel

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.7-rc3

for you to fetch changes up to 5d65a0218fee471e2cd512a8139ec857183b4721:

  clang-format: Update with the latest for_each macro list (2020-04-18 13:49:33 +0200)

----------------------------------------------------------------
Two trivial clang-format changes:

 - Don't indent C++ namespaces (Ian Rogers)

 - The usual clang-format macro list update (Miguel Ojeda)

----------------------------------------------------------------
Ian Rogers (1):
      clang-format: don't indent namespaces

Miguel Ojeda (1):
      clang-format: Update with the latest for_each macro list

 .clang-format | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)
