Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC05E2FA594
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406390AbhARQF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406080AbhARQE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:04:56 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1C2C061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 08:04:06 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id x23so18709490lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 08:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CRVjXKKrBcqwznGwkqTzMqru1Q83Wf5kKWHY7eqB8zM=;
        b=lbWZcFrp2/xw+8YB57Zf263+bZpNgoZ7EoISNDLdIhXY1lIpJ3pER18lYziEAhGzZt
         k3Vy+kuDQ52eFj2/nSBqgI1Dzl/17VaiB072NC5dPTgG5h+DniV+PC/ASDYnAGnZdixj
         m9l3MdV3f/QuJS67asRhuBCF82FyEAw2vfbo5w94pdSc4pwxaMSfXD9C3dd5IY7WXNR5
         Vt41zbAu78xzxub//34cHf+ASxBcrXUjYu11iy/unGV0P/R3W15JKXODhM6o0iOGh3GY
         Fm9Ier+d+Gx93110sQLSgc1L5RT0LGqEB7uEP4gXzBmdWf7Eds+qBBubBvXZ7kJS3I8q
         5yhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CRVjXKKrBcqwznGwkqTzMqru1Q83Wf5kKWHY7eqB8zM=;
        b=FYz+zBt3e9MT6+nU0/6DQkevv0uQDWGvO5V5RLiEXrA5Mv3Xd3Uk8AkwZygh8mlakz
         e7pf62UwKwRX9eBYQx2G1i2tJz6C/p3+2wRClOOTcExqbAjCAg0vXJ/jwYFg4N/jQbWu
         b9+Y0O8euDUQrat5Ya5CGc8VnK6buYh1a6CbQ+eXEIgo4sA4mD8Na4+Uawtmb7s/yeEk
         hq0Cp5RPThJYC1NBWWum0QAFnRsj4XpFNbJJ6l3HIHBZae/4TCOeCvVDeNp+qrDwrNWD
         qeqa+T0vAu0xX2gcij0PGDw8ton7p5UzPIxuF+n68kyEce9Sg7TT9U+VBv2e5/46jcbT
         lzSQ==
X-Gm-Message-State: AOAM5319+X0TljwtN4es7PPB7mdHYz1GdLQGpFOq/3DUqYj2GcZu7wPI
        yfnuzz+JiHRK38m5dO8RXha1
X-Google-Smtp-Source: ABdhPJyhoURVwyFMMZQYjFq/YzVLjesKUyS4L8Y3IIHImbFP5hN46ZurI3143j9QemFLDSa+xuFSiw==
X-Received: by 2002:a2e:898c:: with SMTP id c12mr147949lji.193.1610985844464;
        Mon, 18 Jan 2021 08:04:04 -0800 (PST)
Received: from ?IPv6:2a00:1370:8117:3ba7:1569:a6db:ab8:291f? ([2a00:1370:8117:3ba7:1569:a6db:ab8:291f])
        by smtp.gmail.com with ESMTPSA id j17sm1946104lfb.145.2021.01.18.08.04.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 08:04:03 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Compilation issue with Linaro ARM toolchain
From:   Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
In-Reply-To: <20210118155921.GA462671@xps15>
Date:   Mon, 18 Jan 2021 19:04:02 +0300
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linaro Toolchain Working Group 
        <linaro-toolchain@lists.linaro.org>, keescook@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <061303A4-51F3-42E0-BCE3-BFAF416D7609@linaro.org>
References: <70249918-0081-aef4-0605-85db700aadc5@orpaltech.com>
 <20210118155921.GA462671@xps15>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sergey Suloev <ssuloev@orpaltech.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 18 Jan 2021, at 18:59, Mathieu Poirier <mathieu.poirier@linaro.org> =
wrote:
>=20
> Adding the Linaro toolchain group mailing list.
>=20
> On Mon, Jan 18, 2021 at 05:49:39PM +0300, Sergey Suloev wrote:
>> Hi, guys,
>>=20
>> I am having an issue builduing kernel 5.11 (rc4) with Linaro ARM =
toolchain.
>> The issue seems to be related to CC plugins sources.
>> Here is my build log: https://pastebin.com/DTn7Szax. I have never =
seen this
>> before with versions 5.10 and below.

Thanks, Mathieu.

Hi Sergey,

MPC (along with GMP and MPFR) are libraries that GCC and its plugins =
depend on.  I think, installing libmpc-dev or equivalent should fix the =
problem; installing an equivalent of =E2=80=9Capt build-dep gcc=E2=80=9D =
might be more robust.

Linux kernel has recently relaxed the way it detects support for =
compiler plugins, so it=E2=80=99s now enabling them more often than =
before.

Hope this helps,

--
Maxim Kuvyrkov
https://www.linaro.org

