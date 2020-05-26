Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FA01C9F5B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 01:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgEGX5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 19:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726480AbgEGX5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 19:57:14 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB68C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 16:57:14 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id e8so3800814ilm.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 16:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9gJYJ3n1PrzT+nVQdUcEY+WLY9HYwAvNWuv9VcAD6k=;
        b=iiPl+40u0RQVypHXIV4K4Yl6qfR28bqEuxAHmloqQhk0MSlpzXevMLAmCM4B6z1N9b
         87knCEH46hb0HrDrwdHqbj7o73S0KioLHNwAo9sd/VBR58PAvOVCuIf0RayDDHIcnstm
         zh33AoFq2C5Rx1SvngiB8CHjBFL4XvVSsR4LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9gJYJ3n1PrzT+nVQdUcEY+WLY9HYwAvNWuv9VcAD6k=;
        b=P7oQSEvHFxB+/c8Mae5YYIF4IHmo3ZzIqOYabh0oIhLYlTJ8UXwe1wPAyVk4UlMdOb
         fcRW85CdcoCMjlm7Zx+kLwhIMkGjSCigxUGKdEK0zO92fxtjYEpoTGcQd+ZaasQCVlkN
         fbtbcPkkmKhTKEfUBRsbAzw9xSFZ4ZFNDCsFFIyoACJjxMXVD+UYMBYocTX2HTbZoNQm
         mvdTHNK364IKI50WuTOMjpqyALH9a5QpjAj5YpiJbHXE9VtOVSljn6qxbdXLizqPLjvy
         mNuo0l6vFK2qFec8BY7i4sHlLJdw79HJAFWB/tRsGO6X7aSVibzWWTi3kFwuseDNCR2A
         3RbQ==
X-Gm-Message-State: AGi0Pua3GPME04MOCs8MpUC7St8syJ61Qw96biu8ghL9g9zMRE8SD1w4
        lG35F/Zm+hBFL0+/v/Z4mSlreg==
X-Google-Smtp-Source: APiQypJCB+O0RXyXnDGd+gJg6HKweApSFsEIoGzatAvFK5k9aENS5j4AucalIRSxvrc/d106AIHzIg==
X-Received: by 2002:a92:84c1:: with SMTP id y62mr17356445ilk.116.1588895834251;
        Thu, 07 May 2020 16:57:14 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f19sm1369893ioc.9.2020.05.07.16.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 16:57:13 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk, zohar@linux.vnet.ibm.com,
        mcgrof@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fs: avoid fdput() after failed fdget()
Date:   Thu,  7 May 2020 17:57:08 -0600
Message-Id: <cover.1588894359.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While debugging an unrelated problem that got me down the path of
reviewing at all the fdget() and fdput() paths in the kernel.

While doing the review, I noticed these two places where fdput()
is called after failed fdget(). Fixing them in these two patches.
  
Shuah Khan (2):
  fs: avoid fdput() after failed fdget() in ksys_sync_file_range()
  fs: avoid fdput() after failed fdget() in kernel_read_file_from_fd()

 fs/exec.c | 2 +-
 fs/sync.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.20.1

