Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A405E2FDBF9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbhATVg1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Jan 2021 16:36:27 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:43948 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387716AbhATVLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:11:55 -0500
Received: by mail-ej1-f53.google.com with SMTP id a10so18881903ejg.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:11:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6wG7hqV6sPVHeeUPWbaTayxJ/qcqM2JFqZV0LzCv3KQ=;
        b=LVrtZCyKCW2uJ9+YO6QEO66E+beFOkIN+NeyX+TAJiHnTrbfQxCWyQfNfIqBsj3yTB
         aVkf7D7EaYuova4R1le0XD0Y0KJsYAULIe6NXOJoAEBedfxaBMSq00KPEh9liFDS3/ld
         V5ucXyAdk5JHcfS38rFUteYLsd2LZzDW5mq/bmuNFFqU29W/6L41fk6utDhxJOjnfrdA
         vb8KQl/rxkaNs1lEsUFvQ1JhamdfLEDGpEgJzpo2S/vc6L0VIUn9O8Gp2RKjFPnhjZFp
         MzuinSFumyVkVcR+uA5vX+K0tgHiQfapsHpj2oF1C5r0o9XMKNcWg1OwiAcOoE9ULBXi
         E87Q==
X-Gm-Message-State: AOAM530qrlYa75HvfE1DGPNOdwCsdGhdE4YIzB5fbetgxkvNHzLyk6ev
        tx/8k7q/NheDzWcVtV/TfS9NJJRk22mfT7jLMQU=
X-Google-Smtp-Source: ABdhPJxlsYNAg+bJnsFRhvJQAQ6oW6mwRq7g/Lf33Vqw205XfVD/jA+YftdcPOtTGP9SWichyamIAUP3SicfZvb+k7s=
X-Received: by 2002:a17:906:3a0d:: with SMTP id z13mr7062659eje.2.1611177073961;
 Wed, 20 Jan 2021 13:11:13 -0800 (PST)
MIME-Version: 1.0
References: <20210120131559.1971359-1-arnd@kernel.org> <20210120131559.1971359-5-arnd@kernel.org>
In-Reply-To: <20210120131559.1971359-5-arnd@kernel.org>
From:   Barry Song <baohua@kernel.org>
Date:   Thu, 21 Jan 2021 10:11:02 +1300
Message-ID: <CAGsJ_4wHw2np0AcxX0eRLzYjv=LsmhW=BwpBVW03JmSRXHyJaQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] timer: remove sirf prima driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> 于2021年1月21日周四 上午2:16写道：
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The CSR SiRF prima2/atlas platforms are getting removed, so this driver
> is no longer needed.
>
> Cc: Barry Song <baohua@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Barry Song <baohua@kernel.org>

> ---
>  drivers/clocksource/Kconfig        |   6 -
>  drivers/clocksource/Makefile       |   1 -
>  drivers/clocksource/timer-prima2.c | 242 -----------------------------
>  3 files changed, 249 deletions(-)
>  delete mode 100644 drivers/clocksource/timer-prima2.c
>
Thanks
Barry
