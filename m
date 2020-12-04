Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027EA2CE45D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 01:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgLDAQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 19:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgLDAQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:16:53 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B1FC061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 16:16:07 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id o71so3790820ybc.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 16:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=hW+tDMcroBnYjVio+hhjus4Lc01NoQdNAIz2e/PH8bE=;
        b=D/wIGfkoRntgV7Ro2xaCzABphrSrzeyCLVp+DJ7nI+LWZo5M+N0p48lSdg7K4DtZh6
         zbdVyi/qse2yZmY4hzUfjFHNYHWOwrp64/4pdfU9+rTXFwH/HgrxfBLgrbZfGllb/8SK
         HcRtwMI6rLh47ubxH8nzzsA6mQ6/2AIIloyORSnlu5CDRdgINVcca7AwjFtmUZBtL9/5
         Od5v5lSdZexg+NCA6fRiQEAE2b7xYH4Uyy5WD0evdk0hRolYKAkpiN4frfQ8y7uV13rk
         BOKpGyxDjKjmbg8SL8Yd5OQJDnXcrxASkg1VIPBAh/U+MV3qDKFjSC95IGPRNFJuTpqg
         rvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hW+tDMcroBnYjVio+hhjus4Lc01NoQdNAIz2e/PH8bE=;
        b=NDNhG1/2//GQM8fws8VRmanIC16F4A+aOFGzUc5rn0u96f3y6/M8HY///o15vdS+IL
         l+JA+QuP1IiSOOQ52TK/ZTaGwWsNjzmlqOepKCNxRu6fXVbGQeb+Grs9i+oNtO2/VZxj
         x9JVa/NxIi37jnaEm3PvadLIfo+nMqY+fDv6m7deiaeP3uZX2XWGfBc39XmGy92xkaR7
         RFGGMV//DgopQ7m64WxJx+8OTwOWxtSXRh165UkCo60VUDcqoTGA5rMK4vYBM5fzRyJ1
         fs1qqQ1DYgYRIJcgBlDrxac3M0A1oa+Na69HbnXOkHpXb2z5DpgTApb8/7GAN0tJ9+dj
         vdWg==
X-Gm-Message-State: AOAM5333AZOdTurXaqksHRu8jZEMBoFyGG09X+v4P7/g8D0la0xwxK3M
        VnIS1ph48EhrBHFoJcfrfjl9+OmTWnTmhbsqexBab935nwI=
X-Google-Smtp-Source: ABdhPJxJXtvnUtuHKYJm4cz9vEXSaXxF0nvOnN+rpykTovFSsS8I96H3xiPrK5vu8/9ROQAdqoniKmMHs2FgNRzyvzU=
X-Received: by 2002:a25:9345:: with SMTP id g5mr2473223ybo.208.1607040965867;
 Thu, 03 Dec 2020 16:16:05 -0800 (PST)
MIME-Version: 1.0
From:   James Courtier-Dutton <james.dutton@gmail.com>
Date:   Fri, 4 Dec 2020 00:15:29 +0000
Message-ID: <CAAMvbhFFkFstAH9xm2_KA8vYzW7cu9=V4YXTwioaDhb-mR_Dig@mail.gmail.com>
Subject: SO_REUSEADDR compatibility problems
To:     LKML Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The use case I am struggling with is the use of a Windows program
running in wine that is sending and receiving UDP packets.
This particular windows program uses SO_REUSEADDR socket option and
opens two sockets. Lets call the first one socket A, and the second
one Socket B.

The SO_REUSEADDR from the Windows application is translated by "wine" into a
SO_REUSEADDR in Linux.
Unfortunately the behaviour of these is different between Windows and
Linux so the Windows application fails to run on Linux under wine.
1 ) On windows:
All received unicast UDP packets will arrive on the first opened
socket. Thus on socket A.
2) On Linux:
All received unicast UDP packets will arrive on the last opened
socket. Thus on socket B.

The problem is that this windows program only expects to receive
unicast UDP packets on socket A, and thus it sees no packets.

There are no currently existing socket options in Linux that would
permit wine to simulate the Windows behaviour.
And thus, the reason I am asking the question here.
Please can we add an extra socket option to the Linux socket options
such that we can get wine to simulate Windows correctly. I.e. behave
like (1) above.
Now wine is pretty good at simulating most things Windows throws at
it, but socket options is not one of them yet.
Also note, that (1) is actually more secure than (2) because it
prevents other applications with the same UserID from hijacking the
socket.
Although (2) is more helpful in more gracefully handling some error edge cases.

Suggested new option name:  SO_REUSEADDR_WS

Kind Regards

James
