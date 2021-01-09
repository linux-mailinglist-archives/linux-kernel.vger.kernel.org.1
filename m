Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBF12F0408
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 23:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbhAIWNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 17:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbhAIWNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 17:13:22 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9324DC06179F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 14:12:41 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o13so31847059lfr.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 14:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pWNdgAB7F54905PSxndcuizQFvWz899oT1UF8mQCigE=;
        b=VoWkuuaRzIcof6rg6fCj8gUuVQmk4mX+M7w5MsOegPHy0wlbZN0g5y31EVEOCG+JFc
         nZe3HayAOiuIRSWyGrg3Kw+lXX5mzU42uxaKbudkmwFyjtUHFjFsAk3586c4vTmyCImp
         AArWIZlmcpjQVnfPPRFpfGGDDoh5ITf8qYBeLNtsIamK0ewbrxav5lk/vDozVEbyrT2q
         iQ3QcUfMyEmh5m4HCZzaEhesRxcdlPDbuHZlNQwNxNIJ2dQmaPdt4YzwwF/YqMC9vP7+
         vXN8AE3jK+j2PoFDezpL6samXXmDbIJLhf4vK2s/Z3jvdmUoiZPiZEhpnxMqDUvtpBO3
         YpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWNdgAB7F54905PSxndcuizQFvWz899oT1UF8mQCigE=;
        b=ZxkweIuNaO5bRdFRqeoSk4DLeUOoWVTGfpd7tsrtZ12dA0d03BTOyiAheKpB1uQ9aC
         hUZD7bPKAomubfg0qb9eJsPsU2wJIPmofI1gWKi+JdjvFdBJuIdWYSCFRDE7GG9pZ19R
         e0i60uaHc6Q+izq2hZ/LDh8gjLB3MupIwG5DcXTRP+AfhDBmXUnRJizHY4Fe9k6uHHw/
         2SIeiky6TLqTDFE5vMEpAdofJ7D7sfOiir6u4jJN9YYUvFCyXgKeqqBlI4+5XJNOAJXv
         Ze1oatQEqMtv7owWyLi9NMsv/gYxpgPg92/qzxs4OW58x4reZvsLrFIo2dhreMnbztpc
         fp9g==
X-Gm-Message-State: AOAM532VEyBsAfJuM1I83v7/GtX//tAWYQqgcXprBIFGbgssheGX8df5
        HxVj+AjoUzaTuyLW0fuieK+KbTaSZcK60u+2QxCOOg==
X-Google-Smtp-Source: ABdhPJxACc9VPGH/iTwCxT+Lt9jPUgWD6ypR+Dmax5NfonZfuWTmjtMwb90HF88pUYCiu4Mx2CiDj4k+fDhIva0v5qw=
X-Received: by 2002:a2e:85d1:: with SMTP id h17mr4095505ljj.438.1610230360062;
 Sat, 09 Jan 2021 14:12:40 -0800 (PST)
MIME-Version: 1.0
References: <20210109140204.151340-2-angelogioacchino.delregno@somainline.org> <202101100151.3ojnIrPg-lkp@intel.com>
In-Reply-To: <202101100151.3ojnIrPg-lkp@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 9 Jan 2021 23:12:29 +0100
Message-ID: <CACRpkdbT6tv5ArKRLPh3hE-3fuYHotqG5tNwkF4vftSQ1T=wNA@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: Add driver for Awinic AW9523/B I2C GPIO Expander
To:     kernel test robot <lkp@intel.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        kbuild-all@lists.01.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        phone-devel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 9, 2021 at 6:24 PM kernel test robot <lkp@intel.com> wrote:

>  > 880          gpioirq->parent_domain = NULL;

The autobuilder is complaining because your irq chip is not
hierarchical and this is only used for hierarchical irqchips.
I think you can just delete this line.

Yours,
Linus Walleij
