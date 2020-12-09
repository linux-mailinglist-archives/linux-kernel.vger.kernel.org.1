Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA522D396A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 05:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgLIEGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 23:06:53 -0500
Received: from relay5.mymailcheap.com ([159.100.248.207]:60348 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgLIEGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 23:06:53 -0500
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [149.56.97.132])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id AA9D9260EB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 04:06:00 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay1.mymailcheap.com (Postfix) with ESMTPS id B66B83F201;
        Wed,  9 Dec 2020 04:04:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 9A0592A379;
        Tue,  8 Dec 2020 23:04:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1607486668;
        bh=R5zphAM3Icws23KniVf1A5AfdXoGkjeOwQsoMeQy5Fk=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=cP+E9HpfnhHfShCjfVrDuDksUs6qI+XzsQlFUxU2ZMaFOXz/1eW1+JQXPGIgv+nzv
         hkqj1pMoJdNbhRmKfS5rdzr7simwDTVSi3T/HedXhDwyONZPWj3DUKQn74dSDS4gy1
         915js2Njv9xdqLqPqd6p7akLHxEqr86iCh8RnYSw=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3Ob-LPZRFAIb; Tue,  8 Dec 2020 23:04:27 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Tue,  8 Dec 2020 23:04:27 -0500 (EST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id EBC2541FA8;
        Wed,  9 Dec 2020 04:04:23 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="eyIrrjLF";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [127.0.0.1] (unknown [103.135.251.64])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 1A10041F0C;
        Wed,  9 Dec 2020 04:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
        s=default; t=1607486653;
        bh=R5zphAM3Icws23KniVf1A5AfdXoGkjeOwQsoMeQy5Fk=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=eyIrrjLFpIVrPEObFdVCvvonmpyk+N0ryicqrGpAOk9f2IAIkRqAx3GgqXL19XCEN
         D3h4KhNZB3qD3XCtjcmHlrhxh4FCiFBzUdB6bYV3616r+hqI6SiNlFVI9a201W9XVb
         aq6bEvElRTrvTlVLDMuJofma/or1wG8rPMoXl47E=
Date:   Wed, 09 Dec 2020 12:03:53 +0800
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Roman Kiryanov <rkir@google.com>,
        =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        Huacai Chen <chenhuacai@gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lingfeng Yang <lfy@google.com>, Rob Herring <robh@kernel.org>,
        anup.patel@wdc.com, Alistair.Francis@wdc.com, qemu-riscv@nongnu.org
Subject: Re: Re: [PATCH] drivers: rtc: retire RTC_DRV_GOLDFISH
User-Agent: K-9 Mail for Android
In-Reply-To: <CAOGAQepV2_uNhWmQUG7pypukDsA5E9Uobv-JrqcQrAtxsHttLg@mail.gmail.com>
References: <20201113205233.827493-1-rkir@google.com> <20201113210730.GA1992396@bogus> <CAOGAQeq29S06+6M58qF0e4ivjzkZDg4+M7ffSK+FapbgmCBrLQ@mail.gmail.com> <CAL_Jsq+QjQxDh3_KDhgE_2A6DjA+gSyvknjrVfRFLMLz-p_M9A@mail.gmail.com> <CAOGAQepCsj63yZzJJHKCdHTenkWNLc_v=Ab6PgvS3hzqZMwH8A@mail.gmail.com> <CAOGAQepW3pbbjK9KpPZR1BwGY-CGF7V_pTY_9dw98XPgUKYFHg@mail.gmail.com> <X68aZ/Dgm7CObQmH@kroah.com> <tencent_3801BEAE39670E174105E007@qq.com> <X6+SKQS6QJr25kF0@kroah.com> <d1d47715-482c-f598-a958-499d9fde21e0@flygoat.com> <CAOGAQepV2_uNhWmQUG7pypukDsA5E9Uobv-JrqcQrAtxsHttLg@mail.gmail.com>
Message-ID: <F272A750-0160-47F6-A9F3-26141361609D@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EBC2541FA8
X-Spamd-Result: default: False [-0.10 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[flygoat.com:+];
         DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
         RCPT_COUNT_SEVEN(0.00)[11];
         DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
         FREEMAIL_TO(0.00)[google.com,lemote.com,gmail.com];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B412=E6=9C=889=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=886=
:28:11, Roman Kiryanov <rkir@google=2Ecom> =E5=86=99=E5=88=B0:
>On Sat, Nov 14, 2020 at 1:48 AM Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>=
 wrote:
>> Thus I do think it shouldn't be retired as for now=2E If nobody comes i=
n
>> I'd also willing to maintain
>
>Hi Jiaxun and Hancai,
>
>I sent a patch to add you to MAINTAINERS for goldfish-rtc=2E Could you
>please ack there?

Hi Roman,

My patch modifying Maintainers had been accepted by rtc tree=2E

Thanks=2E

- Jiaxun

>
>Regards,
>Roman=2E
