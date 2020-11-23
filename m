Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5312F2C1921
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbgKWXDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 18:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733244AbgKWXDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:03:19 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FE2C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:03:18 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id x13so834761wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 15:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iQ5bInMQHEd3mry/pnJUmeAGZvhgJKRP74BEVfnU10U=;
        b=OiNTiGSS5/LF9CfoR+WnFhenvR/4NniWfWQwswHpPxLxZUsQ0a+wRzk+uXc7J5dhHv
         miy02vvzYop//5DKzFtHgqUXk1zfIDc0LZLyv6V8ftwzeFeWn+Fj12381zIe8g+Uku/X
         V28evtG18FULftcR7O6FsssAaIf1OCBAd34IqsH3CnDcKV2smLRYfJThbE6esY/m0xvz
         94ODSao14NPUcPJlq4sz39B3Td6i0OeeGqiVZ678J2FbXooJ0w46zMWXadEVCdxc9Kut
         nfih8ajhVVBc9ebXJLNxTa5kr4xvjO/b+DGEsTVWklds95K4Z/XjD6lZlrMx8HSqR45j
         8caQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iQ5bInMQHEd3mry/pnJUmeAGZvhgJKRP74BEVfnU10U=;
        b=s6SrgSjtcDYnXestoYIdvJz/ZmUKKJ1NZjPfiL+NKC6EwqB9RIWTZzbaw/tUt26/Fr
         sCdGDfJtYNqkpTbyzcxJhnUvklrFzLTjXCF7OWGzEPFs21iituiu0U7ezTX2RMvQszdK
         iAlhlXFme0H4B1UXekVjKtedzEg43BTUjotBKXEW/d7s5Lrkn2LhxIuMfBHwNwrp/0K3
         YyJ80OwbFb3ZdspcNuqWVGegL+/RTy3RWoUdsVRkl/Ggdox7MAm7hEomGENReUhk0wib
         4vhtwL5iTaa2oA3xoRiq8zjDlo2C5dAQsrxMJwawHjgWYdwfRitkSVJLrAAJKgCyV7Ly
         pI2A==
X-Gm-Message-State: AOAM532ii6Bxo7X6cE+qGt3VLwXitXd+RMFzP9Ma8Lyz5JKAhQrcvhk0
        3tTXM1QFJmXeK/NUDDScNw69ww==
X-Google-Smtp-Source: ABdhPJyA0nf7pxUIMJ28zOQAgOgSLORmK9/qdRewiPJ94F284kqUl1gm7GQIPWuJXSwKKzwLh9f0Ng==
X-Received: by 2002:a1c:a986:: with SMTP id s128mr1158308wme.94.1606172597529;
        Mon, 23 Nov 2020 15:03:17 -0800 (PST)
Received: from localhost.localdomain (hst-221-74.medicom.bg. [84.238.221.74])
        by smtp.gmail.com with ESMTPSA id q66sm1501463wme.6.2020.11.23.15.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 15:03:16 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 0/3] HDR10 static metadata
Date:   Tue, 24 Nov 2020 01:02:54 +0200
Message-Id: <20201123230257.31690-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Changes since v1:
 * moved the controls in hdr10-ctrls.h header.
 * the structure fields documentation clearer.
 * fixed some typos.

Some thoughts, because these two CLL and Mastering Display controls
are borrowed from SEI messages we can introduce sei-ctrls.h instead
of hdr10-ctrls.h. What you think?

Comments are welcome!

regards,
Stan

Stanimir Varbanov (3):
  v4l: Add HDR10 static metadata controls
  docs: media: Document CLL and Mastering display
  venus: venc: Add support for CLL and Mastering display controls

 .../media/v4l/ext-ctrls-codec.rst             | 71 +++++++++++++++++++
 drivers/media/platform/qcom/venus/core.h      |  3 +
 drivers/media/platform/qcom/venus/hfi_cmds.c  |  8 +++
 .../media/platform/qcom/venus/hfi_helper.h    | 20 ++++++
 drivers/media/platform/qcom/venus/venc.c      | 29 ++++++++
 .../media/platform/qcom/venus/venc_ctrls.c    | 16 ++++-
 drivers/media/v4l2-core/v4l2-ctrls.c          | 62 ++++++++++++++++
 include/media/hdr10-ctrls.h                   | 55 ++++++++++++++
 include/media/v4l2-ctrls.h                    |  3 +
 9 files changed, 266 insertions(+), 1 deletion(-)
 create mode 100644 include/media/hdr10-ctrls.h

-- 
2.17.1

