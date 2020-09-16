Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D679026C96C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgIPTJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:09:04 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:50747 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbgIPRoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:44:34 -0400
Received: from mail-qv1-f48.google.com ([209.85.219.48]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MIdS1-1kEsiK2Mj7-00Eg3I; Wed, 16 Sep 2020 13:02:41 +0200
Received: by mail-qv1-f48.google.com with SMTP id cy2so3295687qvb.0;
        Wed, 16 Sep 2020 04:02:41 -0700 (PDT)
X-Gm-Message-State: AOAM531Nw7irZ9H4kuVPXD2jf5EI5/Q14R2lvKDnmZ/xxfZ+XWL8Ec6L
        cQDXehcl2Hy0zlUxhDe4Ze0rimrugrrPPGi0am0=
X-Google-Smtp-Source: ABdhPJzuJrJvQsGtUiuL+16EpeBsTP/ldoobNcDcIEbx2eyk3x9px1nSg/L5LCAG0u9JFS+7UkZs1YcP/VO4yVMMwcA=
X-Received: by 2002:ad4:4594:: with SMTP id x20mr23091171qvu.4.1600254160175;
 Wed, 16 Sep 2020 04:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <3874de094d193a08624a00a35067a3237e0b42b1.1600249102.git.viresh.kumar@linaro.org>
 <7f4a98d4dac9257d9577e48992cbfb62a968f127.1600249102.git.viresh.kumar@linaro.org>
In-Reply-To: <7f4a98d4dac9257d9577e48992cbfb62a968f127.1600249102.git.viresh.kumar@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Sep 2020 13:02:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1o5Ey9KVPW0Tk+bOCH_TC8PgbO=Oh3Lgm=kHEioUtgpw@mail.gmail.com>
Message-ID: <CAK8P3a1o5Ey9KVPW0Tk+bOCH_TC8PgbO=Oh3Lgm=kHEioUtgpw@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] dt-bindings: mailbox: add doorbell support to ARM MHU
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:IBDXzLfe8wcS6Fxyzqi/6+81janeqXRabL6eFrjtAeBjocYUk0J
 rsDPVXSk9tFgtV2m/zMBvZNpfhhIfHjAk/69yVNhVrccZvg25kF38DWxP/+h0V6nawBWN2r
 kQb7To1K4HL85zLGSY6CsySlts6WW9vw74shU7/NArkFUVodhdujCTJedh7dNBjq4dNqNs0
 AXHytEFWqkHM9u1/626NA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JQ3jHQkw4Fo=:8Bkhm7HxadNbhAniMIaUvO
 nMau930v1WACDKbBAZwQnuS07IhONEpPdDtd4y26vh7/y1yCztUuHSCbBgqrmBZN/QJoUaSmu
 VlX6HfvzGh3LI3+zEkV+P7m1UUidH4HfrFymf/yoCVX9AOVinLcdfjQz4uvWKq5bWVbdNzk2n
 kMksALgYZLcOKDwYv7NLb8ahLoG5RNuAX85cbmZ6C8jYq3KRXuZmSl+Ov4YZw5ETZi4y5ZzQ9
 Y/3RHpjIvVJjR/v/48RL8JG3KFeaZ3mQuVfiAIxPKgl2rNuJIqMLKyLuEPW4W4JXz/2M85KEB
 ygRue99SbNw2M/nZSHef+Ulzpz+ovAdwI/ODFC2QwNnC8nRYtKnV2D09KnRqfZ3lztelUe9sh
 M5+lfygftf7UUx90lFIKZSPl6ffIQjvufxPOPV6nVGnKKlFlgXh4ST7TBeZ84pYHBE0bWOEOL
 vvUSfiUUZvlPvwGpiqcskOExveWrY59pA432o4ACAR0p+Bk/EMM30K2vWC46FEQMz3Yi8/MPD
 XVFXZm3rglaQohYixadoqNS6ODzwfgckvdHSVN+8lsa758p+zxerk0BulldQ5ahobPB0Lb1pn
 Ghtj+ubQA/Xu1842P1mDlfNPYVemZ9oja5QrQk8bIVDXmA/xvzgdtG1PZYTlpnevtYJwn/jIa
 E7I1C9RqZnVjAGD4oAoYtm3/GMvi0+S9G1HF0eESVfTJuYIwDFjOEyEENp0xB4wRCqx1Zb8vJ
 Trd00vhcnvsC94neMFgoYKfMnF5IhcH7Ehk/JWVEvbVtkxDadRtTtp8TuWq5yrCfAAqLI7q2k
 FbIMw37yMyk0DVfaGXCrSf/6ZRay+8TE6FWH1H61rcrlx4EGWvmDKg6lk0mSB545bmuQf+S
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 11:39 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> From: Sudeep Holla <sudeep.holla@arm.com>
>
> The ARM MHU's reference manual states following:
>
> "The MHU drives the signal using a 32-bit register, with all 32 bits
> logically ORed together. The MHU provides a set of registers to enable
> software to set, clear, and check the status of each of the bits of this
> register independently.  The use of 32 bits for each interrupt line
> enables software to provide more information about the source of the
> interrupt. For example, each bit of the register can be associated with
> a type of event that can contribute to raising the interrupt."
>
> This patch thus extends the MHU controller's DT binding to add support
> for doorbell mode.
>
> Though the same MHU hardware controller is used in the two modes, A new
> compatible string is added here to represent the combination of the MHU
> hardware and the firmware sitting on the other side (which expects each
> bit to represent a different signal now).
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Co-developed-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
