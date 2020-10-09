Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94D7289B43
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 23:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403794AbgJIVzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 17:55:10 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:48268 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403795AbgJIVzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 17:55:09 -0400
Received: by mail-io1-f71.google.com with SMTP id u3so7240798iow.15
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 14:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1VcEVtYsHrkseU7vptlx/kj9v0Fozh++G0GQ+AuTmvI=;
        b=Y4EKyWnWkTwynzArFGlsH9Hx5h338Mb8JdOgamch46UsCSIS4dhdQxyoB9VK0xKr9M
         6rpTiDyybLPRyzKgJVm3TMiR7t9jbRCwNgfAinrHetK8PMd2Bk2llFweu9isM8YZoIUe
         RsVbmcE/CAyHuD6DOw7uD+ASpGqMDguH7yn83V/tDzY6otkxw4EcFBjpC/tBH/3Sq7Tb
         XGilC2cFyKIRTxHEV95w/HRX9A6OKxl06+HfZrx/LXEyTAR3u5amoEC/Ml4gOxZAghsB
         2uC6ToVwn4MVZZHXAwXg7KzsggSO/otFMZYtWOG6rdCgfnya8KEkDNLHdelyNloGq+g3
         ZIeA==
X-Gm-Message-State: AOAM531Y+LZxnpDC1mS94uRaU4r0QRACeLEPttBYWeo9mG1cvCh5b/A8
        DlyfMqklDWkITVaaZv4aqlvL51XoYl575QK7ZryCqbszwSVQ
X-Google-Smtp-Source: ABdhPJyh/O/l/hmeASCTUXqkfyiy9y9I9hjw/xEinrgZIlXVFxou+3t5RefQj7UbiDLsd17zTFz7TRjpgDr4EEdyQQc/f1Il9Y++
MIME-Version: 1.0
X-Received: by 2002:a5d:8245:: with SMTP id n5mr10283207ioo.149.1602280508394;
 Fri, 09 Oct 2020 14:55:08 -0700 (PDT)
Date:   Fri, 09 Oct 2020 14:55:08 -0700
In-Reply-To: <20201009185548.GA546075@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088939405b1440053@google.com>
Subject: Re: WARNING in hif_usb_send/usb_submit_urb
From:   syzbot <syzbot+f5378bcf0f0cab45c1c6@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, ath9k-devel@qca.qualcomm.com,
        eli.billauer@gmail.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, oneukum@suse.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/net/wireless/ath/ath9k/hif_usb.c:1319:7: error: implicit declaration of function 'usb_find_bulk_in'; did you mean 'usb_fill_bulk_urb'? [-Werror=implicit-function-declaration]
drivers/net/wireless/ath/ath9k/hif_usb.c:1319:24: error: implicit declaration of function 'endpoint' [-Werror=implicit-function-declaration]
drivers/net/wireless/ath/ath9k/hif_usb.c:1321:7: error: implicit declaration of function 'usb_find_bulk_out'; did you mean 'usb_fill_bulk_urb'? [-Werror=implicit-function-declaration]
drivers/net/wireless/ath/ath9k/hif_usb.c:1322:46: error: expected ')' before 'return'
drivers/net/wireless/ath/ath9k/hif_usb.c:1357:13: error: expected ')' before '}' token
drivers/net/wireless/ath/ath9k/hif_usb.c:1358:1: error: expected expression before '}' token


Tested on:

commit:         6c8cf369 usb: typec: Add QCOM PMIC typec detection driver
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
dashboard link: https://syzkaller.appspot.com/bug?extid=f5378bcf0f0cab45c1c6
compiler:       gcc (GCC) 10.1.0-syz 20200507
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12e0fd84500000

