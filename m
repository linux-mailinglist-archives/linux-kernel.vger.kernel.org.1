Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9517C2458BE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 19:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgHPRUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Aug 2020 13:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgHPRUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 13:20:32 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA584C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 10:20:31 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a15so12634933wrh.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=BZwN8MQg3nUFNF05W+2y2xyOzCj9uWLpsipBs2x7lzE=;
        b=OdF2viLC4Km2Gpz9+9RJVA7rt+XjVlOVW9vmiQsJqhFgP4DFsYFTFFQsxN139P66wh
         XbKsdyXac23JjtF85aKekKIDNarJVDAIRysGm87hJpr/O/pWNPl9v1A3juCZQD5MyqKe
         0/6on5ZOq6kFGIY2LewfyMpRrF+PmJGOUGALrnKYzL39EMfvgA7XZCUV85JQHhCpcHZ+
         JsE6oKmJaGaIxYriZneHzAuPnkjZtRBKU+Hg95BqeoLNtP2nS5fERzZ9kQmQc2yM6aqu
         cI1FRBBmNpJlwU2gsj55Ycw8iMd5h/4H5y142uKUOHCLQtMz9+0hifeOGMOeTmpWbieM
         gNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BZwN8MQg3nUFNF05W+2y2xyOzCj9uWLpsipBs2x7lzE=;
        b=OwxAd+uQDHp7O4mqTyj0aCpI47j9Axx01kztq6A+GGrWv0NloouX2AjRElEeO/ga8w
         neMXXGDiwsEURKq55fXuN181Twf46DqY3Z+LRnhNLq5KGQgtY8h4/nLHlMiFgZn3JGqW
         9RmtttSe0Op4WGm0CeE+iiZVYgegwOgeFcoXL25rcaevg1z4t07N/Kt1Pi5BV0bbG5h4
         7EqJnyegy7HPw+K+Nn6WWVLhp6SZI2tEH9CNSCJ4EU65NwZhcPt7GFOHjyPgkNBNnZnK
         gYVuj3fpMCfPXjJqISBpG3Za+vatbaCF+edT0yqMWibRR0c6o+U8tLVSRoveMuvSBMdL
         Ebrg==
X-Gm-Message-State: AOAM533yP3b1xKpgsF/39OrG8WyrR8qKv96HjNyGxI1c95u+nsLE84y9
        WWvBH7vtZe2sK6WiOHoIweg=
X-Google-Smtp-Source: ABdhPJwpG5arhaOEzF9s34BmgaRInsqakeB6bRu5uNHOS/NU0bCn50ErFYB617wDDSwr0m7xnSb2bA==
X-Received: by 2002:a05:6000:c:: with SMTP id h12mr11192685wrx.49.1597598430704;
        Sun, 16 Aug 2020 10:20:30 -0700 (PDT)
Received: from tsnow ([94.159.146.190])
        by smtp.gmail.com with ESMTPSA id h7sm27140377wmf.43.2020.08.16.10.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 10:20:30 -0700 (PDT)
Date:   Sun, 16 Aug 2020 20:20:26 +0300
From:   Tomer Samara <tomersamara98@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Riley Andrews <riandrews@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Replac BAG/BAG_ON with WARN/WARN_ON
Message-ID: <cover.1597597955.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series convert BUGs/BUG_ONs to WARNs/WARN_ONs

Tomer Samara (3):
  staging: androind: Replace BUG_ONs with WARN_ONs
  staging: androind: Add error handling to ion_page_pool_shrink
  staging: androind: Convert BUG() to WARN()

 drivers/staging/android/ion/ion_page_pool.c   | 14 ++++++++++----
 drivers/staging/android/ion/ion_system_heap.c |  3 ++-
 2 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.25.1

