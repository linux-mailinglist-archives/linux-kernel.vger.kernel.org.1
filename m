Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16722DBAE1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 06:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgLPF4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 00:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPF4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 00:56:19 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ECAC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 21:55:39 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jx16so30988140ejb.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 21:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LvriMkBWhOKEvUrE6d4wpD4XEOG5d8BY8yYJTTW83co=;
        b=YFqDOoeizE4ka0/inyPhydvoeIdm2kcvhdSMYWMLyLN/HL+W8ejh73eEs5DUnjRWa9
         mOJUT5PrYaEZNk02FNOlMPnVkJ9UKck+XlrY94V2uazXcBuq5dKIN1YHkzkwwITjYCZc
         7Ccu4xlljGwDctxc1oDxIpQhPw7fsVfzxzQennEUjHnvClTepFG7h4t+UtIx1NdN/i0j
         0AGEVDxc6tYvUAsuA5hzoVMLUzobtxSAhgyJy3qenl2zen+qwpOjyjtG5zPAWFXEnLHr
         nlDpEN6zRkvauLZwmmGaUcepLEvxmqcz6g1ja3Zr3S/L906XlUHc28EahviKwnDR6IoL
         Wy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvriMkBWhOKEvUrE6d4wpD4XEOG5d8BY8yYJTTW83co=;
        b=eigDvHpvcrUrrSm41NNeHHk3Z2afpx6oyiywAFAXPoHMlyzSqD7Cj2j9ag+ZkxdE6f
         PTPapdoN9zoZfiB9pumY3e8DKvgqvmq/mzTslUBfWdQ4JuYkjYqcx6S8LBdxUWEyMXBF
         +/n8fimcolcb3d2knNrvaHhtPss577GXfDGRggcG4NuhxEdbOq19P193FmxzeJPJT5In
         6A5GWvqEFGPO+dFLUKIk/fVAccAsKI9L1RrS5Xuqi0+owJd8rGyyUXpaoLS0PeOj8yE4
         3z3Mu2zYY1I6ibp3nd751BosXPpFbqzYIYAfLlvC3NHck7HBVXIYF3/kAfSAqdke7KOv
         chNw==
X-Gm-Message-State: AOAM532IxHB0PHzQYgvFJGd6wXK3xoMAGIMsDNCSg/3CY8NEHJ21YuRn
        JjwhyYEDHhE3pruaHHL/KgEaVzLjl8OLcaAgQDhq5hE73A+9Gg==
X-Google-Smtp-Source: ABdhPJwm9n3w0DmtvI66+d0sqqZ1RsMbiSg5GuES0KnQbGpL0v+5fndK8JIsyl9oSjh9RSWlDnB6EGbsFxL5H5D770Q=
X-Received: by 2002:a17:906:4146:: with SMTP id l6mr9969831ejk.341.1608098138158;
 Tue, 15 Dec 2020 21:55:38 -0800 (PST)
MIME-Version: 1.0
References: <20201215163531.21446-1-info@metux.net>
In-Reply-To: <20201215163531.21446-1-info@metux.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Dec 2020 21:55:26 -0800
Message-ID: <CAPcyv4jzpDBOvm8s7XJZgfOHC2OR8OAjehvaKTC9-LQambKywA@mail.gmail.com>
Subject: Re: [PATCH] drivers: nvdimm: cleanup include of badblocks.h
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 8:36 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> * drivers/nvdimm/core.c doesn't use anything from badblocks.h on its own,
>   thus including it isn't needed. There's indeed indirect use, via funcs
>   in nd.h, but this one already includes badblocks.h.
>
> * drivers/nvdimm/claim.c calls stuff from badblocks.h and therefore should
>   include it on its own (instead of relying any other header doing that)
>
> * drivers/nvdimm/btt.h doesn't really need anything from badblocks.h and
>   can easily live with a forward declaration of struct badblocks (just having
>   pointers to it, but not dereferencing it anywhere)

Thanks, looks ok to me.

It was commit aa9ad44a42b4 ("libnvdimm: move poison list functions to
a new 'badrange' file") that left the straggling include in core.c.
