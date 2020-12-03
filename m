Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1992CE2D5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 00:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgLCXmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 18:42:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43392 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgLCXmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:42:01 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607038879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i7gBRxgAGm7K2fN1qLOKlAz7CCD6Khwmjl5AhiwCfBg=;
        b=EA4Ov1tkXeFiBkbAzZYsVtoGURrpTRhOAKtUc4ytHtk/UahjHggaiux8ynuADgVGNDFLL2
        JTiX2k6Bf8fKbc70FL+zIfhDkiKyktSGQEGsG6tV7OzxDlBm4TFDjfNqc3K3H3CrCZnR8l
        L1H6RVuzKK8tAsfzvciA0VW5wrbJZxMzzvrYYHugsh/mli43kOyt4CJgKTxgM7OPSyvAuq
        JqnaFA8q/7e839dd1kL+4s2gi23LuBHAVtBACC5xod+q94MR1iTGUxDSmxt4ZGg2nQzu74
        kNVjIjSk35tpZKiY0fVdCqjOJ40NiG/PKHLBfCFk7OVuVOitDZDk01/1iMQHCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607038879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i7gBRxgAGm7K2fN1qLOKlAz7CCD6Khwmjl5AhiwCfBg=;
        b=EmfWkxcRfdMSX6qmQJ/ytBwJib9EkxTZXiNSBOnpK9vbKe6Ewywo7AescTN0s427TIIHR6
        /WjztkNhVyB1LKCQ==
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] timer drivers for v5.11
In-Reply-To: <028084fa-d29b-a1d5-7eab-17f77ef69863@linaro.org>
References: <028084fa-d29b-a1d5-7eab-17f77ef69863@linaro.org>
Date:   Fri, 04 Dec 2020 00:41:18 +0100
Message-ID: <87o8jabgpt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03 2020 at 20:23, Daniel Lezcano wrote:
> The following changes since commit b996544916429946bf4934c1c01a306d1690972c:
>
>   tick: Get rid of tick_period (2020-11-19 10:48:29 +0100)
>
> are available in the Git repository at:
>
>   ssh://git@git.linaro.org/people/daniel.lezcano/linux.git tags/timers-v5.11

 .... git@git.linaro.org: Permission denied (publickey).

The http variant works way better .....

