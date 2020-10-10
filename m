Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF4528A2BA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391000AbgJJW7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732003AbgJJW0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 18:26:43 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF7EC0613D0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 15:26:36 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id n14so10051393pff.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 15:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=d33hZfar/K98+yMiku6CtFMQQTBXDdROIGBCH7bwLzQ=;
        b=WTb7XDqiFuLnj1UF7bqKWWklVxe/J/BU4claofQJMBkSgaHv6W8dAD3s+KluHk56oX
         NUabJcqrvomJGn34/fH7CbV7t2ZYvIkJSyV2xAsDh/6AwfSIHi9W+zYjpmJNXn2TAC7b
         EHWF0GjnrPpPD528B9ItVYy2kRHcIadqXaAI36ls/Ru9RJaRRzm1fkKZb6y7UUjACyhP
         ssKAS9p4/9GZb7pwElW8uxNt5DdsHJm9uFUvT42pBbDkIFLp+EoCxwUt/RhJw9rK9r6W
         lU7TN9Rfn9xP1jyNJoNFpsWyz+zJF3oGX5EPB3IcdYRVRuOhzh+AS3bG3/sUKPTW1TtQ
         +TUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=d33hZfar/K98+yMiku6CtFMQQTBXDdROIGBCH7bwLzQ=;
        b=p2kiY9bpl0S7Q+N19wBtCgnO1xTvJFawymae8xEk6HbFDH88TKJrAqXq5g7D9++xrM
         Ca1h7ccNz8mq05SjNUSE700zqxzrDSLyfNvLjZZYyW8vmC5UTZqinBebKKaLF19pKFSp
         fShzA1L0sQKB4UYcr0NucqP5sbHnopMBEucS1g5e3fmImYE2EQorw1E7FfKf4MAnvC+A
         tAedprrP/dLearrvlBfXG3MGAS9q6gvYET1PRsD5ArdrGzI190XedTZhomQehXRHH91Z
         dxm5jQVIl6XlUZgqxrErxE0E1YEc71lOVRdoDRWcAGl/IQBuDeyvLWrLXWxgJavVNwOS
         3HzQ==
X-Gm-Message-State: AOAM533qjG5/N5s7ceyR2PzH7XFt2ItiHtgPeZOmv9GUxLt3S2pe8S4c
        irhjWTVQABSHXilmyN53x8S31w==
X-Google-Smtp-Source: ABdhPJxTc9oJhhm0uITnqgN+Za2bvX71araGYar+clIyakjpcMn9Fn6EOUSwc7nwBV+G3yrmSRB+bQ==
X-Received: by 2002:a17:90b:8c:: with SMTP id bb12mr11972197pjb.48.1602368795490;
        Sat, 10 Oct 2020 15:26:35 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:2981:6602:c037:1f66? ([2601:646:c200:1ef2:2981:6602:c037:1f66])
        by smtp.gmail.com with ESMTPSA id z6sm15596247pfg.12.2020.10.10.15.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2020 15:26:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: i386: CONFIG_HIGHMEM4G only detects 3 GB out of 4 GB of memory
Date:   Sat, 10 Oct 2020 15:26:32 -0700
Message-Id: <BC8FECF1-7703-435A-BA60-F0B45D3CC940@amacapital.net>
References: <321879b2-d7f4-b1f7-8f5b-f757500e43a8@molgen.mpg.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <321879b2-d7f4-b1f7-8f5b-f757500e43a8@molgen.mpg.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: iPhone Mail (18A393)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 10, 2020, at 2:50 PM, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>=20
> =EF=BB=BFDear Linux folks,
>=20
>=20
> On an Asus F2A85-M PRO with two 2 GB RAM modules installed, and an APU dev=
ice, building Linux with `ARCH=3Di386` and `CONFIG_HIGHMEM4G=3Dy` only 3 GB s=
eem to be detected: 2.2 GB according to `free -h` plus the 768 MB for APU gr=
aphics memory).
>=20
>> [    0.065059] Memory: 2285148K/2324512K available (11785K kernel code, 8=
92K rwdata, 2748K rodata, 668K init, 544K bss, 39364K reserved, 0K cma-reser=
ved, 1423796K highmem)
>=20
>> [    0.402082] calling  populate_rootfs+0x0/0xa1 @ 1
>=20
>=20
>> $ free -h
>>              total        used        free      shared  buff/cache   avai=
lable
>> Mem:          2,2Gi        72Mi       2,0Gi        13Mi       130Mi      =
 2,0Gi
>> Swap:            0B          0B          0B
>=20
> With `CONFIG_HIGHMEM64G=3Dy` the whole 4 GB are used (3.1 GB + 768 MB for A=
PU graphics memory).
>=20
>> [    0.121036] Memory: 3229952K/3356700K available (10301K kernel code, 8=
21K rwdata, 2700K rodata, 708K init, 540K bss, 126748K reserved, 0K cma-rese=
rved, 2449840K highmem)
>=20
>> [    0.450668] calling  populate_rootfs+0x0/0xa1 @ 1
>=20
> The Kconfig help text for `HIGHMEM4G` says:
>=20
>> Select this if you have a 32-bit processor and between 1 and 4           =
                                                                     =E2=94=82=
   gigabytes of physical RAM.
>=20
> As I only have 4 GB, I chose that to save 50 ms (maybe only due to less me=
mory detected), and thought non-PAE kernels can use 4 GB of memory.
>=20

Your memory map contains:

BIOS-e820: [mem 0x0000000100001000-0x000000013effffff] usable

That=E2=80=99s 0x3effffff bytes mapped at a physical address above 4G.

The 4G limit without PAE isn=E2=80=99t, strictly speaking, about how much RA=
M can be used; it=E2=80=99s about the maximum usable physical address.  One m=
ight wonder why your firmware set up your memory map like this.

But there=E2=80=99s a much bigger issue: why on Earth are you running a 32-b=
it kernel on a relatively new machine like this?=
