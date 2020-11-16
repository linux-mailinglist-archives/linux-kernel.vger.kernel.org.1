Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1BC2B4AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731862AbgKPQSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:18:45 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45658 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731770AbgKPQSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:18:44 -0500
Received: by mail-lf1-f65.google.com with SMTP id z21so25905320lfe.12;
        Mon, 16 Nov 2020 08:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WJTr0HyJXBGJ5SRj1ATu0Culm5WGmevS0n1BvtFN6CE=;
        b=qgZ0HjdEe+Wom0DdLgWD8cGT7Mrf/Je2Wy9bTr1lI/nKG0YP9PbvCfArEzt9oeTEA5
         ylT7v9MLOXRznkp9+9p0MIxHp+l+29bYxkgtZBKbVpskI4lfDngyHOX7j5oVfGS+dpPb
         R3EMmPv5xyca7HPi7MXHUChOD00S/7MHbc3LwSG5pvOhgt1H4K9HU6/RYDxuvhAIJvRz
         zmhIp6iDfpe5m2pK3yJKpR+wshnLbw3GBE4SwNnjr758TQRmsdwzMsnx9zjNdckaJ9mX
         67tQHm6hbr1ty6R5ROVL6awBoM1Mu4HTAb8pk/UzySKQtWT0SoIBbCQqSejZfV6NuWHj
         KCew==
X-Gm-Message-State: AOAM531sJqlISs6vQhhSRem0CGPmNqKNTn0+kpSsjrFACdHApsw28Kd5
        vL9GAsKYM3JywxaZyCW1558UjozJPQ9Rgw==
X-Google-Smtp-Source: ABdhPJwFHTcSxtp41DU5s7h8hRGQ+ZuTC5zHvWlSeXgliUnFf2KXdsJHTqv2QbIvnyv+O0a5DG9O2Q==
X-Received: by 2002:a19:8093:: with SMTP id b141mr53971lfd.526.1605543522063;
        Mon, 16 Nov 2020 08:18:42 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id x22sm2769263ljg.127.2020.11.16.08.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:18:40 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kehDH-0007fc-Ir; Mon, 16 Nov 2020 17:18:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Sheng Long Wang <shenglong.wang.ext@siemens.com>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/6] USB: serial: cp210x: clean up termios handling
Date:   Mon, 16 Nov 2020 17:18:20 +0100
Message-Id: <20201116161826.29417-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike other drivers cp210x have been retrieving the current terminal
settings from the device on open and reflecting those in termios.
    
Due to how set_termios() was implemented this saved a few control
requests on open but has instead caused problems like broken flow
control and has required adding workarounds for swapped line-control in
cp2108 and line-speed initialisation on cp2104.

This unusual implementation also complicates adding new features for no
good reason.

Rip out the corresponding code and the above mentioned workarounds and
instead initialise the terminal settings unconditionally on open.

Johan


Johan Hovold (6):
  USB: serial: cp210x: return early on unchanged termios
  USB: serial: cp210x: clean up line-control handling
  USB: serial: cp210x: set terminal settings on open
  USB: serial: cp210x: drop flow-control debugging
  USB: serial: cp210x: refactor flow-control handling
  USB: serial: cp210x: clean up dts_rts

 drivers/usb/serial/cp210x.c | 499 ++++++++----------------------------
 1 file changed, 104 insertions(+), 395 deletions(-)

-- 
2.26.2

