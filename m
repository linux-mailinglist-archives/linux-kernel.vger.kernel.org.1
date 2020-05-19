Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5A81D90B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 09:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgESHKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 03:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgESHKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 03:10:06 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CB3C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 00:10:05 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id i14so13562964qka.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 00:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KOdUPiJQ4WMqd6TPu6I+f5NnqoqhJlnMM8IsOlYOcQM=;
        b=wuRONm/bmI6Xof3evItK3OQkI85RpeckZCfeMrVvpIWPGdlygwUVgDf/H++0PqYKzb
         DwEmBVzYh0S3suh0WysnWyan/jKgqFLUTyIG/pZ6SofXgyXvQdblJbqWtR/Gizaz8BjJ
         l9iRzqJCoI67rHe8+nobhO/SHuMRnuWqoS04k69mc/UClmtY7GIUdCgTg9MCWmoQ8ZFI
         lDrJV+qu4yicaWnZvVNSom5E7i66XAJuPStMZhQWqGEAsOVtr0kE0I9IWpfVGm/7D3VH
         kfRoMjEmOWUkhnC56/TtBBPVbZ967i5BFEOi5dFq7PDvTzMPmi/EKUU4ra6OgNWMUx2g
         ObDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KOdUPiJQ4WMqd6TPu6I+f5NnqoqhJlnMM8IsOlYOcQM=;
        b=kQ3OnHaFWKmiKNpzCpqT9UHkul4JG4IhD8GsD7udJdcPU8fQ1z3/aiX4m73T6dNSEf
         vVe5HY70HvODay34tCvvUlO870j83UIyBxiWgA8kk863bkXkSCTC76wTomgxN8NFmFc+
         Zf3WmP5cxj0vMDb7ADVs1kcatMQ2aUoLVvHzmJWrmUsF8d2eBlzgA39qFzkB0pWS6Mk5
         lvSDToNHi6bwy3wuH6B5xMD4xkQpEknGcRLDrNKGsbULxI66hRpDnBrWt9safEdeJDJI
         9Nwp158eRhY6Imz5RfPDridUpsUvmK/hXInh0r1VFPpOOz8DVAWagaCUhinH2EIOKPKw
         Aezw==
X-Gm-Message-State: AOAM5331Vp6IC031/EmjFYxfwXnNpoFm0cS4QuJ982O06aSUCGYWWUt5
        dkNUH7X5C7k0Hk4PkNAO2x4etQN3G1iHrp5/LGgiK67a
X-Google-Smtp-Source: ABdhPJxNzWQXkolQlTKJQWuG+a8ny2E36b0nRIXkHwT3uWPnIdVF2upQrgI4ZZ3t9j/23d/3d5MC9QWo/vFaTrDI8is=
X-Received: by 2002:a25:bd10:: with SMTP id f16mr28718795ybk.125.1589872205139;
 Tue, 19 May 2020 00:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200518133459.28019-1-maxim.uvarov@linaro.org>
 <20200518133459.28019-3-maxim.uvarov@linaro.org> <e886d85baa24c09a6b571dd993e7450d5b16d48c.camel@linux.intel.com>
In-Reply-To: <e886d85baa24c09a6b571dd993e7450d5b16d48c.camel@linux.intel.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Tue, 19 May 2020 10:09:54 +0300
Message-ID: <CAD8XO3YBUT0tOz+zZMT+wsXG_HgsEm+kOe9tqjdgxCUKdMv9qQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm_ftpm_tee: register driver on tee bus
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 at 22:38, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, 2020-05-18 at 16:34 +0300, Maxim Uvarov wrote:
> > Register driver on tee bus. module tee registers bus,
> > and module optee calls optee_enumerate_devices() to scan
> > all devices on the bus. This TA can be Early TA's ( can be
> > compiled into optee-os). In that case it will be on optee
> > bus before linux booting. Also optee-suplicant application
> > is needed to be loaded between optee module and ftpm module to
> > to maintain functionality for ftpm driver.
>
> Please use proper casing in the commit message e.g. tee to TEE
> and so forth.

Ok. Will do in v2.

> What is TA?

TA there is Trusted Application. I.e. application which runs in a
secure world (arm trust zone.).
This also fixes the Microsoft ftpm driver which has a corresponding
application for secure world.

Maxim.

>
> /Jarkko
>
