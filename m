Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F15E1B952D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 04:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgD0Ctw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 22:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725911AbgD0Ctw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 22:49:52 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13738C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 19:49:51 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k12so13181500qtm.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 19:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qnap.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6areO0hRZKPHCG/vIEUys65Eg1IGVoIsPcw+jm2s1Eo=;
        b=C3QNF5GRtCMBC9Mlzcyc0ZPVn65I5g4rtLpBV+Fw5bTSS99nrnEakAyvu9IHv4v3SB
         agUXhz9plbouXJ1p25TCAhkKfrSc2Yf+WTXtE8juiZuYDzyUOfY/VrvFf6gouGusuGJq
         OkG4fNCI+X1sqND0HAfLNDTwZtOGYSOJvvchU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6areO0hRZKPHCG/vIEUys65Eg1IGVoIsPcw+jm2s1Eo=;
        b=DQLdr/dExQy8iV8N2s/nwL5ZU39b3fIv+KTHol6WWTmKOEgFAOhmS5vZlRq6Azpdom
         7Drn80WCUS9+SdQnGWMsa9W9vTHsoBHpv6X7LgBGBwryuRVY2beSHKCEgTLeaC7tPqkW
         cspS5I3HZ5IHGkWEGuuD+jiSh31WhYDW9h1BsMclrZ8GGm7Vbc9zUGm5+rWgS4mNjdCa
         uTYGwLrkzKayNeJAOGuzER3HD7GSRFfJtKnrtqc+KKR7yJcukthFk1d49JWqigWR2FkA
         1k8uJloVKg601anBk8JlolF6T0+OeenzfahtoaYX8L65hC8kIeISpAO3U+xw8Ojl81bR
         ZraA==
X-Gm-Message-State: AGi0PuZKAwUuTd/vzMhF+sqti4odgHa7ysZwxfhHcOUFJ6KWsfCELeti
        OiC02MxMYZgzgHeGt6FfYAaORB3x8caqzg8I3kkqng==
X-Google-Smtp-Source: APiQypL+Ou0nwruybxOTadtizGm5FwrO38szTf0UC8p0JC54KyEZSynuB0IuOFUBzsoAhdUxu31+0nxRlsmmPLBcgXo=
X-Received: by 2002:ac8:4650:: with SMTP id f16mr20992760qto.168.1587955789812;
 Sun, 26 Apr 2020 19:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUGjKiLPQP9wp0AgLUvHgKBOe9We2a-RQaZ7cd7CvhnarwWiw@mail.gmail.com>
 <CAKywueT0Q9WkANNsg8cEDwGZSMaaE5c4LHuEeMhVDzJAzycroQ@mail.gmail.com>
 <CAEUGjKhSBNQboKOMFMgos9OQfxcLQZsXp8aBrUSFcaSe1saH2Q@mail.gmail.com>
 <CAH2r5mt1k5t8rSH1KizeSrcLaN1Fn3GWeMvDPwT2Kfq43UAWaQ@mail.gmail.com> <CAEUGjKhpgmhj9RzcGQXPuFUyoqsUnk2d3oCpOYBdR=EwCO21YQ@mail.gmail.com>
In-Reply-To: <CAEUGjKhpgmhj9RzcGQXPuFUyoqsUnk2d3oCpOYBdR=EwCO21YQ@mail.gmail.com>
From:   Jones Syue <jonessyue@qnap.com>
Date:   Mon, 27 Apr 2020 10:49:37 +0800
Message-ID: <CAEUGjKh--8qs_pn1OjuQk3DmtVuqLo9m5ecL-Lwb08Hk2oZTUg@mail.gmail.com>
Subject: Re: [PATCH] cifs: improve read performance for page size 64KB &
 cache=strict & vers=2.1+
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Pavel Shilovsky <piastryyy@gmail.com>,
        Steve French <smfrench@gmail.com>,
        Samba Technical <samba-technical@lists.samba.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > And if anyone figures out how to configure an x86_64 Linux to use
> > PAGE_SIZE of 64K or larger let me know...
> I am using physical platform with arm cpu and aarch64 toolchain,
> perhaps try qemu-system-aarch64 later.

For reference using qemu-system-aarch64 + linux-5.6.4 + 64KB page to test
cifs read, this patch can improve cifs read performance:
with patch: read throughput 39 MB/s, SMB read IO size 4MB
/ # dd if=3D/mnt/cifs/1G.img of=3D/dev/null bs=3D4M count=3D256
256+0 records in
256+0 records out
1073741824 bytes (1.0GB) copied, 25.982352 seconds, 39.4MB/s
[~] # strace -p 23934
sendfile(38, 32, [297795584] =3D> [301989888], 4194304) =3D 4194304

without patch: read throughput 18 MB/s, SMB read IO size 16KB
/ # dd if=3D/mnt/cifs/1G.img of=3D/dev/null bs=3D4M count=3D256G
256+0 records in
256+0 records out
1073741824 bytes (1.0GB) copied, 54.367686 seconds, 18.8MB/s
[~] <0> strace -p 15786
sendfile(38, 32, [452984832] =3D> [453001216], 16384) =3D 16384

This link is a easy way to compile aarch64 linux kernel with page size 64KB
, a simple rootfs with busybox, and run it on qemu-system-aarch64:
https://docs.google.com/document/d/1NSVd-dib_asugCZHmZgohLZXHxV25ftzYtUDSpp=
Y3hA/edit?usp=3Dsharing

--
Regards,
Jones Syue | =E8=96=9B=E6=87=B7=E5=AE=97
QNAP Systems, Inc.
