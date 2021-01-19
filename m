Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A690D2FB47D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 09:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbhASIrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 03:47:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:53340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbhASIqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:46:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 099F923133;
        Tue, 19 Jan 2021 08:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611045963;
        bh=EhDrlhUBT4+ZynPIWmAgXKhTbpG5px2Eof82Q50odMw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iZocDxn1lYzWh/0uDot4IGeZPMMt5iyOXB/3nGiBUy3E1d4eZEsDWmT4SgyOB4xZg
         9xhZdDekWkeiz//xwyCtmQCaSY3H6TYLpI05zqsRTvl3foUpmbPekJix5Zxd8fBV2v
         2kbn5GZcE9IcgvgfirVO67s6q9/MuB5GpbVGzavpcOtW1ydAvzWEIje7WqIcL5jUvE
         zp3K0mPoEtGExSRAazJLFjhWUUYP++X0tD1suCdE/zanawgNRNxpHv7TXACV34nej4
         z3B11s2QXI2EOEjOQqDpe35F4MFwII3Lzc/qPu+ESTHbOOP1BCeO9fsZtCZTA/6yYA
         LV8XiNkKM5y6w==
Received: by mail-ot1-f44.google.com with SMTP id n42so19024627ota.12;
        Tue, 19 Jan 2021 00:46:03 -0800 (PST)
X-Gm-Message-State: AOAM530TDcLkbAacqkX5A5Qd0Y3a+F+kVnAkU8HLrgHBa1/mUAV3DHka
        OZmvvIKyL5ZlDB9qpnstIRJn75ABqDYaZ2P+LP8=
X-Google-Smtp-Source: ABdhPJzZooVlEyU406kd+ZBbJ9AvvTuWM6eo8Q9gPtS0DgegKi1tEb0sbxI4iPb77GMeoAXvqKN0BuWXFPYczYneakU=
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr2690183otq.305.1611045962217;
 Tue, 19 Jan 2021 00:46:02 -0800 (PST)
MIME-Version: 1.0
References: <20210119053444.23108-1-rayagonda.kokatanur@broadcom.com>
In-Reply-To: <20210119053444.23108-1-rayagonda.kokatanur@broadcom.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 19 Jan 2021 09:45:46 +0100
X-Gmail-Original-Message-ID: <CAK8P3a16oeVpMeqt_47DAmc=VUNXLq9vqGEVai5JkAQ-CWfkBA@mail.gmail.com>
Message-ID: <CAK8P3a16oeVpMeqt_47DAmc=VUNXLq9vqGEVai5JkAQ-CWfkBA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] arm64: dts: stingray: fix usb dma address translation
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bharat Gooty <bharat.gooty@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 6:34 AM Rayagonda Kokatanur
<rayagonda.kokatanur@broadcom.com> wrote:
>
> From: Bharat Gooty <bharat.gooty@broadcom.com>
>
> Add a non-empty dma-ranges so that dma address translation
> happens.
>
> Fixes: 2013a4b684b6 ("arm64: dts: broadcom: clear the warnings caused by empty dma-ranges")
>
> Signed-off-by: Bharat Gooty <bharat.gooty@broadcom.com>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
