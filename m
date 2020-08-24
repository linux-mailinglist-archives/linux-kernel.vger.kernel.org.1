Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE39250885
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 20:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgHXSy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 14:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHXSy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:54:28 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C458DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:54:28 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k2so1641843ots.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tLCBtT+QFa7w4jD6QdulIiBj+RkSmBuMJhEuHYSYoXo=;
        b=GF/j83PJDd1yGIUw42yBZ0PXGbWAtwTGiRA9C/KcAVqBAD+D4DfxIsPXr+T4U8Fb/O
         /XRMrO7pAw+wWkOvPo+XmfmCKSC1XczvnDns8aMT4dU+DJ8GTT8TjsacZvjuI4EYZ9Po
         hWVS4+T//lcA5d/WRMSK5v2pHFEBc9JDWgu0aLcYwPHB9D91g5PClESBqcVVDcHgBfZk
         qUfrctsy1tDcp8Q1u27TPKgqklv538O73X8GrtcAxcfJ1cTieExs4jHY3/4asP7A1fnz
         gnRvWwRddtYBj4Kf0ZrLPMYztNHc39JekvnKvKxTzf0GGBaxV9Vejk30osP+PumiPRos
         rM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tLCBtT+QFa7w4jD6QdulIiBj+RkSmBuMJhEuHYSYoXo=;
        b=VkHyiIksuEANbn09dQ4+rtkq/VEU/wSqBB18ikqvs0Fc0yUKktX4J3ih0OEJxt38pa
         uw6BaQ6IZCQeaQgVbbF54jpBIgWOsSbJpERKK+5WIcMSUIACSL2KZaIzJ/9aPHWikMnC
         nzeI58DVUWNH0Jpw9rnp8nG4Xw3B2HveQxA7h77ai8v5DljACICBacj2Wj0/9wqmD6ga
         CeZVhEuFDxzPTiZr5eB7JP48qyTWWZf7PgESelu3vz7yf+SYlUEsP0T7Hd6NqMmo9lZ0
         w7/sTjoU3Fpas0OGDJKGKCLyaUxfqr17ncljnO+mxbaMQhKsP3TVNKWX54EVU6Qj39DZ
         ZiZA==
X-Gm-Message-State: AOAM530lZg4TliSNVvY1tNAt/yeZAD5knF1HcOG6ss7A9sCaawmRS5uT
        zKnBn5wQerku8sBLb7y1FMg=
X-Google-Smtp-Source: ABdhPJxrwoCZoT60BW8EJ18KPb6V266hDQdfBPoRQl/C0fgRDIrFZnKJM/wSRn5quS9UxpBX5/X0Gw==
X-Received: by 2002:a05:6830:4b7:: with SMTP id l23mr4782325otd.35.1598295268188;
        Mon, 24 Aug 2020 11:54:28 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8203:5970::b30e])
        by smtp.googlemail.com with ESMTPSA id b188sm2112414oif.19.2020.08.24.11.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 11:54:27 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/3] dynamic-debug fixups for 5.9
Date:   Mon, 24 Aug 2020 12:54:09 -0600
Message-Id: <20200824185412.1617174-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - fix new export name, with a wrapper for more utility.
 - parse format="foo bar" like "format" "foo bar"
 - pretty-print
 
Jim Cromie (3):
  dyndbg: give %3u width in pr-format, cosmetic only
  dyndbg: refine export, rename to dynamic_debug_exec_queries()
  dyndbg: fix problem parsing format="foo bar"

 include/linux/dynamic_debug.h | 20 +++++++++---
 lib/dynamic_debug.c           | 59 ++++++++++++++++++++++-------------
 2 files changed, 53 insertions(+), 26 deletions(-)

-- 
2.26.2

