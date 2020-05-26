Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802561B26D9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 14:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgDUM5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 08:57:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41813 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgDUM5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:57:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id u10so11009941lfo.8;
        Tue, 21 Apr 2020 05:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y4m+GVFgzQbjKNixL+VsTNrUBW5JSEQt9xcQPm3NyWs=;
        b=FOZ2YIeY99TBBj96qnUqLlqtwWlDUKcvhzx3j5iago2cxH+20rrTM9O19psbfvDCgc
         PznPhWaZsnCH8Ig3ifWOExPGmBlhWNJhPfsQgk4TPnIfofo+U0McLL9HZ2nstsA+kZdF
         eAMAUMoLQKdFZ3Pe2YbLFFqJhhGo7u/dVADXBguK6laeVo69lUT/dy+dYyMSuHCX2VZ/
         OvVmiEcL+kbKLOPJCxwAN+vHrOXYBBU8Kq8MULVliIcUPjszKq5M1RC2m1pjLqidMkeI
         QkSMSMA8DcXi2m7rFrf1FpgcL96Si/111D+uj7wPjZKTKQiO01fRTq/RONEVKidXontp
         6x8w==
X-Gm-Message-State: AGi0PuaikXGh4V5Y4ESz1+gaX+gmqdb7xe3bS/Yz4/Vl3UG9epF/GnjF
        MieNGMY7P/R8EwQBmiUoUF+l28EJXU0=
X-Google-Smtp-Source: APiQypK5Tvba1WL/kkyud8en5xTxZEL89yKBcPNvexIsXBfTleG9igvyU/7qcCxf03gh13W7yHYAfg==
X-Received: by 2002:a19:c8cf:: with SMTP id y198mr13103924lff.197.1587473861441;
        Tue, 21 Apr 2020 05:57:41 -0700 (PDT)
Received: from localhost.localdomain ([213.87.162.215])
        by smtp.googlemail.com with ESMTPSA id z7sm1902268ljc.17.2020.04.21.05.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 05:57:40 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-block@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] floppy: suppress UBSAN warning in setup_rw_floppy()
Date:   Tue, 21 Apr 2020 15:57:19 +0300
Message-Id: <20200421125722.58959-1-efremov@linux.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are based on Willy's cleanup patches
https://lkml.org/lkml/2020/3/31/609.

The first two patches indroduce defines to make it more clear why
cmd_count in struct floppy_raw_cmd allows cross-boundary access for
cmd, reply_count, reply fields. The last one handles the warning.

Denis Efremov (3):
  floppy: add FD_AUTODETECT_SIZE define for struct floppy_drive_params
  floppy: add defines for sizes of cmd & reply buffers of floppy_raw_cmd
  floppy: suppress UBSAN warning in setup_rw_floppy()

 drivers/block/floppy.c  | 29 +++++++++++++++++------------
 include/uapi/linux/fd.h | 13 ++++++++++---
 2 files changed, 27 insertions(+), 15 deletions(-)

-- 
2.25.3

