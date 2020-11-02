Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B932A2571
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgKBHlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgKBHlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:41:52 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE330C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 23:41:50 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 32so11791634otm.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 23:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kj3U6hFnTQIkwWsatUBxJ+UhrIPY0z25L1oLVmranbg=;
        b=LetsDsvfKHNkVfZ3AhwrmT7FFjpwbIEiRHTnmKhRuw2Sgm4P41xg7xB42Kc4ArV+5v
         QY9TxC1j79dAlliUOulxuwyteQJsugki+38KmqpCFjXPViXwp+hUTjJXNLnX3nirUd7d
         3IKLk6OLqlHTEkiss7qkgA0y9EJfitThloVQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kj3U6hFnTQIkwWsatUBxJ+UhrIPY0z25L1oLVmranbg=;
        b=hbZDDOj3CxrDupG5TzqMHeuB9mQECyKjLv3M8pTWhaAHObekIKzLgyeiFH3TgnL5TA
         2/6TkCOkJ4+vPX7hk/0J8PJwkuM6BZvS0BFA1U8DZN0V3oFk2bWGD4XeTipNBtvDYL+4
         MDwPq8LBGUQG6gAmqABez8joqkCmKNvUxTSOibnAlxQkryTw6vgHdL3vhl+5HWgj0/UG
         sL2OQZO7n8TVSHHt4QKuBWmnpYQSgqGEbOJyOFDO1ItttstYeYgIokmlRiNqVLMht1dS
         F9pk7PIrhf9ZzxrTbh4STUk1AU40hLx/me1voPQOQGV3qFkDlBSNvleOtdhAtoxOEOmm
         0q5w==
X-Gm-Message-State: AOAM533Doe20na38mB8RIM39J5MGSmb+r+XjnIvFbFMUE8O8J3RnZmjV
        JQWWi53NGHWJDO69W0vpfSERfUOd8Iy7rA==
X-Google-Smtp-Source: ABdhPJwecUd8pmbR5EcWm+a5EIQ9nZW5hFo/HU3Yv2JMLYLxO7E4j1ucmXzSaphYldqWgTxHa7Lsdg==
X-Received: by 2002:a9d:2389:: with SMTP id t9mr10366695otb.329.1604302909996;
        Sun, 01 Nov 2020 23:41:49 -0800 (PST)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id v11sm3498070otj.73.2020.11.01.23.41.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2020 23:41:49 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id p73so3139415oop.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 23:41:49 -0800 (PST)
X-Received: by 2002:a4a:c4c7:: with SMTP id g7mr10844459ooq.50.1604302908566;
 Sun, 01 Nov 2020 23:41:48 -0800 (PST)
MIME-Version: 1.0
References: <202011020817.nhpgLbGq-lkp@intel.com>
In-Reply-To: <202011020817.nhpgLbGq-lkp@intel.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 2 Nov 2020 16:41:36 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXTUJ31jpif5ucZs6rPDhuCZrqUOjVpzZAHqy-Hg71ByA@mail.gmail.com>
Message-ID: <CAPBb6MXTUJ31jpif5ucZs6rPDhuCZrqUOjVpzZAHqy-Hg71ByA@mail.gmail.com>
Subject: Re: drivers/remoteproc/mtk_scp.c:645:34: warning: unused variable 'mtk_scp_of_match'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 9:09 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Alexandre,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3cea11cd5e3b00d91caf0b4730194039b45c5891
> commit: cbd2dca74926c0e4610c40923cc786b732c9e8ef remoteproc: scp: add COMPILE_TEST dependency
> date:   5 weeks ago
> config: x86_64-randconfig-a005-20201102 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 235dfcf70abca65dba5d80f1a42d1485bab8980c)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cbd2dca74926c0e4610c40923cc786b732c9e8ef
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout cbd2dca74926c0e4610c40923cc786b732c9e8ef
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/remoteproc/mtk_scp.c:645:34: warning: unused variable 'mtk_scp_of_match' [-Wunused-const-variable]
>    static const struct of_device_id mtk_scp_of_match[] = {
>                                     ^
>    1 warning generated.
>
> vim +/mtk_scp_of_match +645 drivers/remoteproc/mtk_scp.c

This happens when COMPILE_TEST is set but not OF_CONFIG. Sent a fix
for this: https://lkml.org/lkml/2020/11/2/102
