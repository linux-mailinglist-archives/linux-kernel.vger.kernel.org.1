Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD22427B073
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgI1PBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:01:25 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:56557 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgI1PBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:01:23 -0400
Received: by mail-il1-f197.google.com with SMTP id d16so982497ila.23
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 08:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=vgUtXMoVzIZuhx8MiM8mjs9qIwIIfUuwYTFaRd2LK1M=;
        b=I1bpl8W2Lbm3CqaJlTJQYxDPWco7RUa6Exg206GLKpYvsKu1pqo1Vqi2t3Wyr0RcGB
         3lDqHaEMS5B8Rbr2RhvTGTlAMED4F2XOUuAd7fFf7gFSOiVmDxtAh5exdCmpd6UcrARn
         1H7xygZTc2nhvmXQlTgeOptNy+V3K3i+PU7RsGGoZGYSyW2Z2HBRscW0V477F0zYw6wE
         RxvrwFyG/VQP8bjfWz9b9Yuj4wxuqByTaxKr/JJMPcyDCdCylOz3Rl1bvIxq5h1nh9l5
         kaQR84SCExhjj7ZR0grguIIFbtNEcis41IYJYySZ5Ldwxh2dv/YA9Z5ur4lq5IaGOBov
         m1CA==
X-Gm-Message-State: AOAM533w/dycdQhulFPsXfvNWddbsnWx7hSdk1dHcSFk08wh5zOVrro7
        P/VEM+n2h2WrdMnFS29Z9hiFAr2D5Dd6R7bjevjoh4EJ7OQt
X-Google-Smtp-Source: ABdhPJzvmXPhbd+OnJjeaLpf0fv/dOPSi+n2gUF1+r+JZy/3sFGdT1z/4lOKD5DI7cxhl3aBCCDj2qXGrL7rRLGXhmlGS74ESKhd
MIME-Version: 1.0
X-Received: by 2002:a92:4805:: with SMTP id v5mr1662666ila.170.1601305282258;
 Mon, 28 Sep 2020 08:01:22 -0700 (PDT)
Date:   Mon, 28 Sep 2020 08:01:22 -0700
In-Reply-To: <69d85830-b846-72ad-7315-545509f3a099@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086c59505b060f073@google.com>
Subject: Re: Re: possible deadlock in io_write
From:   syzbot <syzbot+2f8fa4e860edc3066aba@syzkaller.appspotmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Not the prettiest solution, but I don't think that's a real concern as
> this is just for human consumption.
>
> #syz test: git://git.kernel.dk/linux-block io_uring-5.9

This crash does not have a reproducer. I cannot test it.

>
> -- 
> Jens Axboe
>
