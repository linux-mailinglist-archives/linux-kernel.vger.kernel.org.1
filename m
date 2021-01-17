Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EC72F91A7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 11:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbhAQKMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 05:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbhAQKKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 05:10:25 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55C6C061573;
        Sun, 17 Jan 2021 02:09:44 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id g12so19544948ejf.8;
        Sun, 17 Jan 2021 02:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GAlzQhKZYq1VTOxNcXW0n5p+sG1hEvl0LZsZTzmenZw=;
        b=KcGIj3TOBx4vFM/uI02NNXxBBGDVYypGRfNq/+CHZCbmBR8rl5RM3upoB+pxGCBiFr
         IQpftZXipOHJp8dW+GsenxTbFFqGzDu43O1376z9UCyuqVrwN279YfIcCgu9I574YFBz
         ewqdqTP9/l47mTuV/8gOHCdeaVQTKJt1sO7h3se/93F4wcNKZCQJegfTyP6BgULJmrki
         VlqLgO+OR/5FEJBhdJWlRmTocopGE0fUmYUZ9NsYFG2xoAn6nT1T8S79XSgen+kVQ6Cd
         QiSQQjmDc2/eZpmhApJfzRqgw9lAg7Zrkh0IrSLtC3/Ms1WtGUUQoRMjs2Y3ni+nugAc
         f7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GAlzQhKZYq1VTOxNcXW0n5p+sG1hEvl0LZsZTzmenZw=;
        b=V+ZaeLDgem/93f2nG6ZqKFearNCYiMMX84BUP3k8RZnN9lI6G0/dZ/22s6DqX4Tt4C
         oDQPMSgWH2ECxBNnP9T24VVS2oY5GZGMGllqvMvYBLjGYhLe2rDZ2hk1ZFj6kkEOnm6m
         WbBl1a8ju5aN7eBn2L48bctx9tBJAo5dxQaCWDXc7NF0LolEWnVEnvvW6uan6zhrWa83
         NUQzk2sVk7s6C+0rTLnQqII0+rXnWzmCKMqYHwnjMxlpLjzQ3E9C/376U4NTI7iI6r1F
         7XigVvl/5TVyQRxDoeZFSydRMSyjMe/g0rMABUX7+7mENUYQw6z7SkYBoPBE3hPqSgc/
         TTCw==
X-Gm-Message-State: AOAM531Mbk6NLL6YilQ+WVDAFKy0qPTWO9Modd1x+SuQUubedNg6xkNO
        a0zN1ZwxHvjLVjnPuPyKDOQWtmAI+tbGAw==
X-Google-Smtp-Source: ABdhPJzWLYmx+QpH4rtDbsvUgp0x5cAY1wyUYn9lBeZriTUA5LB74QM3ot9KxO1/pemYRXrnZIZ5uw==
X-Received: by 2002:a17:907:7295:: with SMTP id dt21mr14718213ejc.518.1610878183481;
        Sun, 17 Jan 2021 02:09:43 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:c06a:642a:2af4:1e16])
        by smtp.gmail.com with ESMTPSA id s19sm9277855edx.7.2021.01.17.02.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 02:09:42 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net
Cc:     SeongJae Park <sjpark@amazon.de>, paulmck@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] docs: Update Korean translation
Date:   Sun, 17 Jan 2021 11:09:28 +0100
Message-Id: <20210117100931.9347-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This patchset updates Korean translation of 'howto.rst' and links
the 'memory-barriers.txt' translation in the index rst file.

SeongJae Park (3):
  Documentation/kokr/howto: Replace HTTP links with HTTPS ones:
    Documentation/process
  docs/kokr: make reporting-bugs.rst obsolete
  docs/kokr: Link memory-barriers.txt to rst

 Documentation/translations/ko_KR/howto.rst |  4 ++--
 Documentation/translations/ko_KR/index.rst | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.17.1

