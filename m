Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418BE1EBD8E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 16:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgFBOB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 10:01:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45320 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgFBOB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:01:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id z18so12674895lji.12;
        Tue, 02 Jun 2020 07:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2GWIfNtzCugpdmUqQsZRd/8mo4Bw27Ep9qZG/S6V/g8=;
        b=fdViPSblwRo3UhJL0C2d5x+BwIMt04XqTSU4EKCjbRcvCJXGEzyXgcjdJBi7s9rOcg
         f0iIiWkkaxIKL+M6yPFZ4lTVBKHBfprM4jNyE4I9hxMAYCnHFoFWj7UW3+LOat3T4ejM
         OQCw6CuzZkFKZVI156itfwJL6crrIDrZM03ekgBgEtjBqbOCS5RzR3QxzT7XtK1BaEJp
         HynU9/XAORVCFl5nqYVe7r/zUkwAWdnx5gOID1YKK22WCNsUAIyIsyORV486SDHk6hik
         YAzhCw5OvneeMlVGHVtVPKnqqtmasNGR2qx4e42Lvr4e+MB3Wq6dodgZo6lhGqKPrY0R
         oaAw==
X-Gm-Message-State: AOAM531xZbCkDVuI2RSit5ERxgmaGIUtAsLi3wCI2BrjG6xM2U9B7WFQ
        UAhBNOoCaKCrRR4Pq3Qird0=
X-Google-Smtp-Source: ABdhPJymTQM9Ny8rhRuuLH44YpMh03Mgg2hLv4ixzkGnxZxqRZqkzo7nc8Hdq3RuC9Y+E8yN45TrGg==
X-Received: by 2002:a2e:1453:: with SMTP id 19mr4084338lju.155.1591106486007;
        Tue, 02 Jun 2020 07:01:26 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id x23sm720423lfe.32.2020.06.02.07.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 07:01:25 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1jg7Ti-0000xq-LH; Tue, 02 Jun 2020 16:01:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/4] serial: core: fix up sysrq regressions
Date:   Tue,  2 Jun 2020 16:00:54 +0200
Message-Id: <20200602140058.3656-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a few regressions introduced by the recent sysrq
rework that went into 5.6.

The port unlock fix is tagged for stable, and the fix for the
unnecessary per-character overhead probably could be as well although
it is a bit more intrusive.

Johan


Johan Hovold (4):
  Revert "serial: core: Refactor uart_unlock_and_check_sysrq()"
  serial: core: fix broken sysrq port unlock
  serial: core: fix sysrq overhead regression
  serial: core: drop redundant sysrq checks

 drivers/tty/serial/serial_core.c |  96 +---------------------------
 include/linux/serial_core.h      | 105 +++++++++++++++++++++++++++++--
 2 files changed, 103 insertions(+), 98 deletions(-)

-- 
2.26.2

