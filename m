Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA3F281DBC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 23:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgJBViS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 17:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJBViS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 17:38:18 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E934DC0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 14:38:17 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d6so2230148pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 14:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=BkeyaNc379+rmFlMxKoqdtmCXLr04UwoNjZDGrW9WDQ=;
        b=lsQYj1LmYSATIcKw7t6GatdByUeYFi5qTGn4f786FZZeCAMKp7N1ihGZCBSlR1VWSM
         btHAOWptJmuBoCYFE4OqvK1a39O6Uk5TGn/Q4An6wKsPNWkijA4bNTPTURIeRgrbt7NY
         jLfNbrD4VUdNSslW+ZY6lP0urGwBuZU6dxbJo/PMRnnLDxL5+Nu8tQMje/CgGylP4odT
         DDX24g8Ij/oip1bsh+sqZJDWYOTugXsBPqLdRmVOCjnb2vV475HK48ybKMjncwNWKzIg
         zhgV3zLaW1yIh5TVzp+G65itIv3YB2oFDuGY+hfDre1caw1GjT9LCEx3nFtTCrQvlTqv
         7Wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=BkeyaNc379+rmFlMxKoqdtmCXLr04UwoNjZDGrW9WDQ=;
        b=lj3nO125O7Ly4ncpxst6cINNVjfr6Vk/vARIEpLkwm2ucOGjsSIZMzYy2C0zgQ2NG1
         H1+JdJl7Piv6p8L1zRfp7W8d4l47x/pwUeFoPIkhLBaQ7fUsxmofmefly0wBHfUcMvgC
         fBHve3ok30niXHHo+nmHADu6NoetRDSNErLwNQyisGdG9PuAhXNz5MqWSu31v7ufrsch
         LqZMnL78egVb9PizJ6tsvR2gLplGYJiJAh0B1zlThYVCSs60+12QNNcSRBkI28ZAaLL7
         VeYt0VuCo3Ww2S4k+uHY8vTZg1CiuMJeXBsvjbasgbg/++NGof1Y1DdqLVhKYwawPH6W
         hG+g==
X-Gm-Message-State: AOAM530DEAb4R7TZRq02qjzh0iQ9cVwlKydybN0QAV3N4xXlCURCyOFC
        FhzSTG4EFLhdhtV5rNqpZ6P9Hc8fU2cZNoRa
X-Google-Smtp-Source: ABdhPJw62mh5fmOWbiRdQymV1NGzb23R7SDPtopMC0852HpRC8jYwfUpY38HlP84dOHcD233rrlf3g==
X-Received: by 2002:a62:52ce:0:b029:13e:50c8:499b with SMTP id g197-20020a6252ce0000b029013e50c8499bmr4829715pfb.14.1601674697178;
        Fri, 02 Oct 2020 14:38:17 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n125sm3064404pfn.185.2020.10.02.14.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 14:38:16 -0700 (PDT)
Date:   Fri, 02 Oct 2020 14:38:16 -0700 (PDT)
X-Google-Original-Date: Fri, 02 Oct 2020 14:38:14 PDT (-0700)
Subject:     Re: [PATCH v8 0/7] Add UEFI support for RISC-V
In-Reply-To: <20200917223716.2300238-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, Alistair Francis <Alistair.Francis@wdc.com>,
        akpm@linux-foundation.org, Anup Patel <Anup.Patel@wdc.com>,
        ardb@kernel.org, nivedita@alum.mit.edu, bp@suse.de,
        greentime.hu@sifive.com, hca@linux.ibm.com, mingo@kernel.org,
        keescook@chromium.org, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, masahiroy@kernel.org,
        maxim.uvarov@linaro.org, michal.simek@xilinx.com, rppt@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-12da283b-ad4d-4a55-9196-ccd91ca08c8b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 15:37:09 PDT (-0700), Atish Patra wrote:
> This series adds UEFI support for RISC-V.

Thanks, this is on for-next.
