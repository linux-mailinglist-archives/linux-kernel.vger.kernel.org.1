Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680E62727D1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgIUOhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbgIUOhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:37:46 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF9FC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:37:46 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id e23so18097950eja.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YBeSXvLus4k89SuWvx5C+h9enofCPRsPbiAnHJnW60A=;
        b=tS8DgT5159bYCvJY40SO6VuwxrqT1cXXFOCm8aXmbbh2ry1aGWGb6uDClNfEGnai+B
         JGdMghZwvStBGl2hJBdKKtOJU8sr1wbo2sYxUewvTcW+gNi8IvoGxN8oM7rDOAYJ6SfN
         0cKY7AE18gM+TPAi1eihr5MX0mk1rVn17OyxvxhOt+aa2dbgIAVTFMvZ/LQD2F6GFd0s
         yzux9geU3RldxcPXVTFvORr7/Nxc0SyP13QMPqO3DW2/b6ALOomSesQcEe/wv3hL57VV
         woNHgefDKYI5bgHLIglA4y4OrrwTK/qlX4sfbumrzaPWQrIoYdKhuVbE2ngSqqFzHw6M
         wvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YBeSXvLus4k89SuWvx5C+h9enofCPRsPbiAnHJnW60A=;
        b=f9f5V6y5YAAKowondBSyks+xkWzbfkiQi+7s37VnDfoQBnP58gAHJEJgvv4WSDFz0t
         Ari5eNjoyAGluL08VvV8DVLep2jT90U1vrP8cDPd8R5lLwa1QQmF33+2twXIRfhzjyto
         /Xg4K1n3HqqyxpSRbY6AGCjuFPb1PJW7MGzI3nz59C+0zUKYdNOJdLlzi6eeEXa9gXHz
         jMrQNODTvmI8YQPuRV/ZU8687uFVe0u1BtooynIn64kZGjMiUdPsDlrZD5xiHqgMQOaU
         9ZpgXrteFETUsgstoFj2G1YDZwDL0snhCw3mUl8mvjywnCO9joM4CYrPn8c+9UdZ22mT
         2Uxw==
X-Gm-Message-State: AOAM531LAws1azc4XZY3FZjYbP5F5hKMOD2/18oUU4IlOd/OHAwVWwLu
        u9qBspcbbUvyZfWkbHU/COJvVJ1ZXttN5dCJOv5nS6WzLGBOSw==
X-Google-Smtp-Source: ABdhPJwhXtSU3n2JqzHAvWL+ObX1hB9FbR/lmhh7oSMUv6M9LaBZioM3dK7aIllUn7WLtwD8GT0j9auDc6T8AYlGAhM=
X-Received: by 2002:a17:906:d7ab:: with SMTP id pk11mr49816186ejb.472.1600699064876;
 Mon, 21 Sep 2020 07:37:44 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 21 Sep 2020 07:37:33 -0700
Message-ID: <CAPcyv4jCqzs7vjFCvLxHSL13OE0CX0Ptc75ApT-dyyGo_UZ1jw@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fix for v5.9-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.9-rc7

...to receive a straggling compilation fixup. Apologies for the thrash
this caused.

---

The following changes since commit ba4f184e126b751d1bffad5897f263108befc780:

  Linux 5.9-rc6 (2020-09-20 16:33:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.9-rc7

for you to fetch changes up to 88b67edd7247466bc47f01e1dc539b0d0d4b931e:

  dax: Fix compilation for CONFIG_DAX && !CONFIG_FS_DAX (2020-09-21
06:53:09 -0700)

----------------------------------------------------------------
libnvdimm fix 5.9-rc7

- Fix compilation for the new dax_supported() exported helper

----------------------------------------------------------------
Jan Kara (1):
      dax: Fix compilation for CONFIG_DAX && !CONFIG_FS_DAX

 include/linux/dax.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)
