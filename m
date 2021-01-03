Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE892E8BF9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 12:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbhACL10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 06:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbhACL1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 06:27:23 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4BDC061573
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 03:26:42 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id s26so57956135lfc.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 03:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kolivas-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HTquAlTkGvqJgpMX+IzHZIpbA1lxDwBFyCNUG/Z90jA=;
        b=EFRH/HIL7bGQe7yg3fyy672nyAkDnDLUZEYtJWLmsgtkXA4y85Vc8qMA1yG0QqeLMz
         XYW8FwHyRa2Egm6GM+q+HAOH4cEAKJkvw6ZogANBVjlBgv4Lyg/04j5loLcKN66lzA5s
         gpUG8gRNNfK2YHolfEQVfncoIxpaOz/R8YLv+T2zGqhbK0OFln+kG0VCSDpvix1YCXuz
         ifA2LLT3CETfz/SeOtQa/U/hAdAeZbrPlR0ged+FuQiwfYld08k8r6oO7AahkTyXshgT
         FXFODCcVr/vHRUiBYAGeNEhtZ1EaPP5iVudrlNiDZvELxahXkMGsI9G2fld9Am8272hV
         y80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HTquAlTkGvqJgpMX+IzHZIpbA1lxDwBFyCNUG/Z90jA=;
        b=FCN6lS8bsvSA3kSmgpTPKNPBXrGNJwBZ/v/V+c2oyw22qlYvIgvG89mFMi3DEuN6WG
         gMqFJo3hf8uSZDl1eJL1gITuWln1GAqZrj81tfL5MJGL8JlgpWQ4k9UcWRFa9ujmEerG
         b2uK6tbm4PCaUbo5l2yeQO7UyqORmhUoZ9+ylhEDUxMpyp/fBQLVW1b0LOxDZlp3/Ptn
         XLcfzohTRI8OQfOKIir9zPqMqzE2dCC3jc0+QFDBUX3FJOjf4Xr/EkwjANWbNA/KDJ45
         4Qg6xtvo6O6XpiEgp9E0sd9spFBSxWQULsCL/vMEzgIBGNIWdkrS6B6sUmtV7Ii2c4u6
         M1PQ==
X-Gm-Message-State: AOAM533wPxo3dPZA9Le7iAWW9nhp8wgifqanqAfchEVsi/6hQmyvNOC1
        +4C3gvZbqK87SNx4AN35MEFMiCrNHRZ8DInU6WoU7UL4Nx1jMzkX
X-Google-Smtp-Source: ABdhPJzs5Q60cCvUAEIoQcGU1QAP+zFYuf3hUmKM5KZ9COu75RX0v7I5+2lVJ2gAS0sCwNbHkFXFXRilYmj41YiQBNE=
X-Received: by 2002:a2e:87c4:: with SMTP id v4mr35406805ljj.413.1609673201333;
 Sun, 03 Jan 2021 03:26:41 -0800 (PST)
MIME-Version: 1.0
From:   Con Kolivas <kernel@kolivas.org>
Date:   Sun, 3 Jan 2021 22:26:30 +1100
Message-ID: <CABqErrE5Y1qEqxvewzTP-HvbB7o7CHHs+rStui8V1e9ukVm9aA@mail.gmail.com>
Subject: Linux-5.10-ck1, MuQSS CPU scheduler v0.205
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just reminding people I'm still around and maintaining this patchset.

Announcing a new -ck release, 5.10-ck1  with the latest version of the
Multiple Queue Skiplist Scheduler, version 0.205 These are patches
designed to improve system responsiveness and interactivity with
specific emphasis on the desktop, but configurable for any workload.

http://ck-hack.blogspot.com/2020/12/linux-510-ck1-muqss-version-0205-for.ht=
ml

http://ck.kolivas.org/patches/5.0/5.10/5.10-ck1/patch-5.10-ck1.xz
https://github.com/ckolivas/linux/tree/5.10-ck

http://ck.kolivas.org/patches/muqss/5.0/5.10/0001-MultiQueue-Skiplist-Sched=
uler-v0.205.patch
https://github.com/ckolivas/linux/tree/5.10-muqss

Enjoy!
=E3=81=8A=E6=A5=BD=E3=81=97=E3=81=BF=E4=B8=8B=E3=81=95=E3=81=84
-ck
