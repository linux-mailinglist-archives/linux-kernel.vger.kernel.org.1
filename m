Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A012D867C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 13:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438884AbgLLM4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 07:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgLLM4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 07:56:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C906CC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 04:55:29 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kaF+v+fhwt1veB6ieNU6FFpGGrgEPEEqeSc+iQSLfQg=;
        b=TlfreJBs4v5s1kkqxpHDRTAWFcKEPmkVDaBtAikAAQQRBUXJPpaIv+m63CP03mceoXxpYC
        thPRa8m2vBgHXeYL1zAjMapYhYck74jUXfHd3mHRE/9UPODoSWxorV+JZM5IV5yLcJQys+
        jMmgD7BmHPkm5aCTjIXsrHMz1kHppolocZH77o+HUpYuGuVPmloyKDxZ4QOspAwA7l0Hzv
        aLYEkoEKb8JvJMGYBXKkhzq+nF+w997ZcHv5fd59Wfoe2z8moRFoJvcQQLT/7noPHvlp6R
        Ot2Tr6RR4dFk9MRhW2uYnq/JDnpNYEsSp5n+QiUiqD/lluLhu2c3dBcdn97K4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kaF+v+fhwt1veB6ieNU6FFpGGrgEPEEqeSc+iQSLfQg=;
        b=BzN/JMjDEUef2A4OFFc/1bFKpnVlFdYAdGx5DqpTsoZViU9P8phlCEHw2R4pSWg0NPTHNb
        5SqMfWPqwN37RNCw==
To:     Daniel Lezcano <daniel.lezcano@free.fr>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Keqian Zhu <zhukeqian1@huawei.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] timers changes for v5.11 #2
In-Reply-To: <65d593c1-93a8-bd43-bfb5-891e7c2f4f2b@free.fr>
References: <65d593c1-93a8-bd43-bfb5-891e7c2f4f2b@free.fr>
Date:   Sat, 12 Dec 2020 13:55:26 +0100
Message-ID: <87o8izfakh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10 2020 at 12:23, Daniel Lezcano wrote:
> please consider pulling those 3 last changes which fixes some issues on
> the drivers.
>
> The following changes since commit fef92cd2bc04c64bb3743d40c0b4be47aedf9e23:
>
>   Merge tag 'timers-v5.11' of
> https://git.linaro.org/people/daniel.lezcano/linux into timers/core
> (2020-12-04 00:39:45 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/daniel.lezcano/linux.git tags/timers-v5.11-2

Pulled.

Thanks,

        tglx
