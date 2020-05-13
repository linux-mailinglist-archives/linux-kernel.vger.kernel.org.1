Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0B01D2313
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 01:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732657AbgEMXdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 19:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732523AbgEMXdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:33:24 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4268DC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:33:24 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j3so1441061ilk.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pFfNmewz/mfCHMNh9XV194PnShatk6k9H447JJUGz6c=;
        b=CWlvd078GIR1ibZh6d8sahfhrI+/49floa8rvRRu809XIw7S/8SbgeF4DBpC7fIQSy
         0oZ/igGCFgfu7HSisKnk3pUfXmzQbB5wcfcyIpnwL7XjjUwwMfk8AI+JPTNPS2/kbtfY
         kUyA+XkxSys6iB83dmwD8RALiGFE1YjV+LxKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pFfNmewz/mfCHMNh9XV194PnShatk6k9H447JJUGz6c=;
        b=jvPVKlV1FotFcQoy2Xk0GToxiNKHx1ut6w2VZ4DHGUyXcVzk06iiLLaKZt/4A7avXW
         YxEjYJyeoDF5migCjeQ1kclyH4nYwbOj4UiWDk+cFxi+Fa79yTpmaJVVgaHOISGcraep
         Su2mtXzvK5VxaHXy1KN2AUxrHwMPeYN5B2f7npPF4b6IfmPEEbNOyHwY3yJgLy1K/DNO
         KxCYAvDscjnYMWP7HAHMnIserqjVVAICWgu3hOk8rxJohz3qp42biejc0i/cOXE7Rxgv
         GSczscVOahEmQ7qfNQUoIXR6aNLrTdf6gkGP8t4VFOG0LWBOIiBPujtqhMMCa6xE0ip1
         cQAA==
X-Gm-Message-State: AOAM533m8/KxU9K1MczKxrXDpD0kkeMeUfj2Ayhl3E6Jmi/dYEFCiDAG
        VyubTfiWLJtIoV/JiOIV0JCNOg==
X-Google-Smtp-Source: ABdhPJxUwwRpGwbnaEJPsLawzpT73ikpudZeKLQy0f/z7118JbmJJ4IwYR6fXfE67wE3QRnF1kkUSA==
X-Received: by 2002:a05:6e02:4cd:: with SMTP id f13mr2022503ils.300.1589412803580;
        Wed, 13 May 2020 16:33:23 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b1sm398072ilr.23.2020.05.13.16.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 16:33:23 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk, zohar@linux.vnet.ibm.com,
        mcgrof@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] fs: avoid fdput() after failed fdget()
Date:   Wed, 13 May 2020 17:33:19 -0600
Message-Id: <cover.1589411496.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While debugging an unrelated problem, I noticed these two cases fdput()
is called after failed fdget() while reviewing at all the fdget() and
fdput() paths in the kernel.

Changes since v2:
Patches 1&2 changed to get rid of goto.

Changes since v1:
Patch 1:
  Changed to address review comments to refine the code for improved
  readability in addition to the change to avoid fdput() on failed
  fdget()
Patch 2:
  No change to v1. Including it in the series to keep the patches
  together.

Shuah Khan (2):
  fs: avoid fdput() after failed fdget() in ksys_sync_file_range()
  fs: avoid fdput() after failed fdget() in kernel_read_file_from_fd()

 fs/exec.c |  6 +++---
 fs/sync.c | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.25.1

