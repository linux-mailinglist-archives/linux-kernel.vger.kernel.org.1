Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51802A5E3C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgKDGrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgKDGra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:47:30 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A05C061A4D;
        Tue,  3 Nov 2020 22:47:30 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id u4so3930158pgr.9;
        Tue, 03 Nov 2020 22:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1l065BLgxWbxhplgeNpVsx8uBEVKvB/dIxgH9PkcSoY=;
        b=VQl2kssQL/MA4gCfSeHZLVdP/r3A7uu837GRvD5zvddRgqDdxBnMQTQFoq6e9CO0vW
         cHMbvrgrcW7axHSoSjMfQmKny+YF6wAJeyCpojWhlzWv0GFagFUVQ8c09D56NQhV0+8E
         3r80DFulSqTmM+hBOUImyWXu5PPXL3Ho6nTY0OG8cL+KGGNICd7dK2XuEou4a0w8SJvE
         Ax8Bn//3jgjJZ6+WBumalr/7pabCsetmwVfDzC+0ga0qvMnZ2QBeOLbuJlNtmrz69POX
         ktycWACXUUMLkczZIXeGneDCy0zVqoPcEsWBW1uuepMwULE9p5lIU0N2k7Fw/LzyADo8
         4qnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1l065BLgxWbxhplgeNpVsx8uBEVKvB/dIxgH9PkcSoY=;
        b=WAdWgPLq86BsaWxkLM1EwgHoJiC3OG+SQun1p0bkbpPE2ad7+hPX6maQnqiumjC3CE
         hO+4+jgQeBW2tvLum7FfsIQwX+Bh4IwLXKbiwCJ/XdELNVJIEuF9d5QZ2rZIsVHmuy7Z
         rI8yNWB+k2OB6/Pp/g9Raj5ibvxz7fhRIb7DmolEQqlJMuaQ2PjN7nWOCjUYP44E2jH4
         iW78N/UMjMWLOpcoTMRNpLrFqXCCrf5vRG2VkUbDorGhS0yVJbFFYdyBFJjnVE0QMmtG
         X6wPXhbMYxTDQ2xmDi/lzT0xXeGrNZT0u0r5RkjGOXwlLbDWkTa0RSpXlTzX85PYUDsS
         9xiQ==
X-Gm-Message-State: AOAM531LF/q3gGwj1zKbWoA7XrD0BLh5FYWD+b2K9xSS2OZLD4w9FTu/
        hSc8qKdFZUkd2rS/GdnpbnQ=
X-Google-Smtp-Source: ABdhPJwRTaBboM6XKpBofRBwuq6f3rthm1CtkTdW9rvytiGCkEjVhU8h6//nXU/hjUWY/T2LcdqQdw==
X-Received: by 2002:a65:4bc8:: with SMTP id p8mr16241224pgr.335.1604472449308;
        Tue, 03 Nov 2020 22:47:29 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:16e6:8166:e462:9fba:da9c:beed])
        by smtp.gmail.com with ESMTPSA id s18sm1036873pgh.60.2020.11.03.22.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 22:47:28 -0800 (PST)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH 00/15] usb: serial: avoid using usb_control_msg() directly
Date:   Wed,  4 Nov 2020 12:16:48 +0530
Message-Id: <20201104064703.15123-1-himadrispandya@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many usages of usb_control_msg() that can use the new wrapper
functions usb_contro_msg_send() & usb_control_msg_recv() for better
error checks on short reads and writes. Hence use them whenever possible
and avoid using usb_control_msg() directly.

Himadri Pandya (15):
  usb: serial: ark3116: use usb_control_msg_recv() and
    usb_control_msg_send()
  usb: serial: belkin_sa: use usb_control_msg_send()
  usb: serial: ch314: use usb_control_msg_recv() and
    usb_control_msg_send()
  usb: serial: cp210x: use usb_control_msg_recv() and
    usb_control_msg_send()
  usb: serial: cypress_m8: use usb_control_msg_recv() and
    usb_control_msg_send()
  usb: serial: f81232: use usb_control_msg_recv() and
    usb_control_msg_send()
  usb: serial: f81534: use usb_control_msg_recv() and
    usb_control_msg_send()
  usb: serial: ftdi_sio: use usb_control_msg_recv() and
    usb_control_msg_send()
  usb: serial: io_edgeport: use usb_control_msg_recv() and
    usb_control_msg_send()
  usb: serial: io_ti: use usb_control_msg_recv() and
    usb_control_msg_send()
  usb: serial: ipaq: use usb_control_msg_send()
  usb: serial: ipw: use usb_control_msg_send()
  usb: serial: iuu_phoenix: use usb_control_msg_send()
  usb: serial: keyspan_pda: use usb_control_msg_recv() and
    usb_control_msg_send()
  usb: serial: kl5kusb105: use usb_control_msg_recv() and
    usb_control_msg_send()

 drivers/usb/serial/ark3116.c     |  29 +----
 drivers/usb/serial/belkin_sa.c   |  35 +++---
 drivers/usb/serial/ch341.c       |  45 +++-----
 drivers/usb/serial/cp210x.c      | 148 +++++++------------------
 drivers/usb/serial/cypress_m8.c  |  38 ++++---
 drivers/usb/serial/f81232.c      |  88 +++------------
 drivers/usb/serial/f81534.c      |  63 +++--------
 drivers/usb/serial/ftdi_sio.c    | 182 +++++++++++++------------------
 drivers/usb/serial/io_edgeport.c |  73 +++++--------
 drivers/usb/serial/io_ti.c       |  28 ++---
 drivers/usb/serial/ipaq.c        |   9 +-
 drivers/usb/serial/ipw.c         | 107 ++++++------------
 drivers/usb/serial/iuu_phoenix.c |   5 +-
 drivers/usb/serial/keyspan_pda.c | 172 ++++++++++++-----------------
 drivers/usb/serial/kl5kusb105.c  |  94 ++++++++--------
 15 files changed, 406 insertions(+), 710 deletions(-)

-- 
2.17.1

