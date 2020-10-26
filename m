Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C53298982
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 10:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422564AbgJZJjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 05:39:33 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:40616 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422556AbgJZJjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:39:32 -0400
Received: by mail-yb1-f201.google.com with SMTP id p63so10456238ybc.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 02:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=sqeklWdICtGUlm4BzSZyDT81vCJHA9YvFrN0eJR+mck=;
        b=q0uzHGPNjB5m1DuTHX4iXRw0kDatf3gJdNLuyPAoc/OoZMHn82lSqBSuYL377RR528
         /bVZeqM166p83zgSj11HJKhhW9gUo7lXKl9RdfDAa+7AOY/3sKVIK5BTZtg8ByhHHkjm
         WH6zCR0CC2P4FYzZRF/RpMbfC2W1Te6ineAHUoWCh2su8MJua+sbQWk3svw7IUvmchYa
         yutOjAhUpFSu/S9jKvDNjHnRAvPgiZz4gUWp9UBEmswxChldZq/prb3tgQKfe3nIbDhz
         0+kUfEceCsFlW9fViKpWTGJGVSdlJcBVReSuJvgTCjZ91b/56ULdH0rTB4rz26NdxgZx
         so4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=sqeklWdICtGUlm4BzSZyDT81vCJHA9YvFrN0eJR+mck=;
        b=lst9t/Yp7X4+jGPWDnZKP4PisB6tQtr9jmp2hMBBo0CDGbLSkCXjEepA2+wEAqoR3L
         WJT1+GFhHo2vztmml/t9czAw8kvih6ofCllBqVVsiWvBDXBlpe9T48TzBIAzSz/zfnsi
         QCF4wacJOgRqwnG7hR640KBXWFxZ45QMqIo6jh5mT7v/dscZ/edk4kyEdTvze2i0HWY9
         nbT3Iyx9a+zTeI/GJW8wRLdjA8vDb3LG9DXqcYOzinFajPsOqDcB7nQnFzUUhr7KxALR
         57n7y6Ppd7n7cmEu5n7efAJ1p5zgmsOiA1rSh4jwxEsSJl0VMej7Js8YH97jKMShElth
         IbcA==
X-Gm-Message-State: AOAM531911+tZcwi/Fs+ybIMIMHKJ8o+Gwm2xyK2yafAn5KmQh9HYgv7
        HBIxifC/IuBD/cz9gP64kSYvcdSsoaH0Fw==
X-Google-Smtp-Source: ABdhPJz/h1idORhGUhGdrHKqXxETBi3Ayx3ZvwrPgqcdXpBVB/CzsBES44aCJ+epbOE6UDkQOQsramwRYyPHbw==
Sender: "robinhsu via sendgmr" <robinhsu@robinhsu-p520.ntc.corp.google.com>
X-Received: from robinhsu-p520.ntc.corp.google.com ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
 (user=robinhsu job=sendgmr) by 2002:a25:da4e:: with SMTP id
 n75mr21019061ybf.425.1603705169605; Mon, 26 Oct 2020 02:39:29 -0700 (PDT)
Date:   Mon, 26 Oct 2020 17:39:05 +0800
Message-Id: <20201026093905.1498859-1-robinhsu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH 0/1] f2fs-tools:fsck.f2fs Fix bad return value
From:   Robin Hsu <robinhsu@google.com>
To:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs-tools:fsck.f2fs: Fix always return 1 (error) after asking user to restore
           lost files into ./lost_found

Robin Hsu (1):
  f2fs-toos:fsck.f2fs Fix bad return value

 fsck/fsck.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.29.0.rc2.309.g374f81d7ae-goog

