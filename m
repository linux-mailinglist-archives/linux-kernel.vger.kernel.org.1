Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C712F1254
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 13:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbhAKMcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 07:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbhAKMcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 07:32:01 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5894C061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 04:31:20 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e7so18157169ile.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 04:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=t1RBS+pz3TCSz9yaBXTL9npXBs6/Rl7TaNaQnPf6x90=;
        b=a4aIM97BLiHH+eIdzKM287vOP5/KmTDYnPqKo9zViAmh8KaTs2MLUN6ldvqhH6PnWl
         vL5iPZghsfWDJMo3uHOiFtm8qr4ZdsUAth9+G0ko+cEHdeDNQCXP1MqFsJaYv9o2lm/D
         OYtBiJnn7Wy9QJp2PVisksSz5vo0DQ8reLRNxK3SBypIaQZZr4G/6QxFWE0RcCfeli5V
         WTi5sgZgHTwbv6LZFBLGcBRakO1bHFDKyBHbg+C9KauFvMVSLXTx4BLKTKbe3ffpgo4Z
         vU4CZbhmUEwfBPaSdpNfBANmMKMTrnxkfGeQDInW5nlbuXyOWpuXYiNJuZwnzILvCQe2
         +OSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=t1RBS+pz3TCSz9yaBXTL9npXBs6/Rl7TaNaQnPf6x90=;
        b=Kiwm4sQ//exm93q0L9vh8DI2LHqE7yUbouV9KY0jQnXaUJ1yJggkHmKkvrpwH9MxLd
         r2YbFBOe9B/XPXGOQCKcnErWkVhgPnZvf/EG0MVlcLNbDqwrvBCQkEqVN8Viq4fJbTe8
         biD4f2wemsG7ds1AVzlk/QD0x7gx0N27bh09vz4Eunvbs6nBlxh8CA5H7ZKkI84CQuBe
         qizIwhJjCKyknnJBuYKZEDSzffdmaTwTcuNvVta2sey/LWZFokHjOZirio/0FAb/UHbz
         Bf5na4K4jp7hU5Ibo1tkijuViJKJwd4+6xA5Dh7ZJzvveFVbgZkUapWgk26PpEUGNNg8
         0P8Q==
X-Gm-Message-State: AOAM532/eO0SL2tPV2GNFBoHHlt9UjBvaXlnR6b9eFIzd35NLIA3gI88
        hxPKhdeqU2ZFqV2cEUDKob3DXw==
X-Google-Smtp-Source: ABdhPJxDH/MgjbUb9HPEP06bCJP/IFbuiDjqIGnJj17fLtJbvSVodrC6DP1EAUA/P0pYWPVKA5RAgA==
X-Received: by 2002:a05:6e02:216f:: with SMTP id s15mr12281002ilv.81.1610368280182;
        Mon, 11 Jan 2021 04:31:20 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id a4sm13496774ild.5.2021.01.11.04.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 04:31:18 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] gcc-plugins: fix gcc 11 indigestion with plugins...
In-Reply-To: <CAMuHMdXR09QdSiziQQ_XuPcJPOca_+mK1jYYHj3VsP_eCu_KbA@mail.gmail.com>
References: <82487.1609006918@turing-police> <160997457204.3687425.15622431721220616573.b4-ty@chromium.org> <CAMuHMdU1YSODgh_T5RxqUqorveAQiy_-gQbF_SwMEj7gvG25qw@mail.gmail.com> <122278.1610362619@turing-police>
 <CAMuHMdXR09QdSiziQQ_XuPcJPOca_+mK1jYYHj3VsP_eCu_KbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1610368277_16026P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Jan 2021 07:31:17 -0500
Message-ID: <128149.1610368277@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1610368277_16026P
Content-Type: text/plain; charset=us-ascii

On Mon, 11 Jan 2021 05:56:59 -0500, I said:

> > It's probably related. I'm just having a hard time understanding why 4.9 and 5.4
> > whine about the lack of a space, while 8.3 and 11 didn't complain...

So after more digging, at least some clarity has surfaced.

It looks like it's not a kernel source tree issue, it's a g++ issue fixed in g++ 6 and later.

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69959

And it looks like there was an intent to backport it to 4.9 and 5.4:
https://gcc.gnu.org/legacy-ml/gcc-patches/2016-02/msg01409.html

The bugtracker doesn't show an equivalent for 69959 being closed against 4.9.x or 5.[56],

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63254 has a patch for one of the
gcc-supplied files that tosses the warning, but that way lies madness...

Not sure what we want to do here - the main alternatives I see are:

Tell people still using 4.9/5.4 to either live with the warning or upgrade to 6 or later

Make the flag a variable and pass either -std=gnu++98 or -std=gnu++11
depending on the output of 'g++ --version'

What say the peanut gallery?

--==_Exmh_1610368277_16026P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBX/xFFAdmEQWDXROgAQLWmxAAm+/eycJLapNJYBLQxszzcM/PdssJs8bl
9RoBqSLrTzdLeT6NNK+qTGACeFfc1eSJpMxw0tL4fg24nRBIEdr8IJuCi6ncukzR
8w3HdgXMJ6w09+yTAoc2S1TzqVEyd91MaoAGWl7OIkuXdk/iVigAR5DDXKZalr8j
15bCM951bSN7KGMKTSsWd1HtEAwi7YAuxJr1zhk0ijvXKCsnhMeAZALD2QdcDgBR
8mY9UA+374z7rEtqRs42vEn7leS5m3GX1rEMPkkeFaGNIYEL6+zZGn2e/WHQWjfm
RifQgKcE89BNMq1V9jlScTGhR/p8mk02bOMR9CoM7FXS3vUKn4CFjWlB8SdAUhaJ
WMZ7W6d0MYfFnkkUrZ/SfOQy+4T8lXWvKjaQ6/9vpZzm3VhbkO+K7n7Xjvr7qZlC
8VDjyQ60ojoNvJky46VFxSFgjnHHou38iPuuVfNhe4fcb2Ci8QX4fY4h6yEEi8n9
lLrehATWLjDBahAVQLojei+xh498Z5m53WvxOfFZDlld45hAz7F7iTX3/OwUlD5f
kZACnjH/ZC12ewCKetyQY6h9GTahgR0qkCgSyhoC4+0xYdIfIRK43lOKkkTx3QUN
hsavEhfeD/en4kHAbqcNWZ+64oL3jkvsyhBOVNY7IqnW5qSwEcuOs9NOe2hso0TS
ujJfklKBnY0=
=mGP8
-----END PGP SIGNATURE-----

--==_Exmh_1610368277_16026P--
