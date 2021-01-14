Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F132F6AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbhANTUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbhANTUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:20:55 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF78C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:20:14 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id w1so9817517ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G+3wq4HbMGsLz02vnWPc8X5CuisGBMzZ/msi7tDk0Cc=;
        b=Ejbyg26r3zoTbu/HIHrzEVIxt0cl9UJH08qjWjRc4XBuXSllW0qFGwSgwywiQSHZ5h
         4FqOy/ydMWnI2HrlO3dPBZzKUWBcuXLLYfKhjfx4G/JSQu6KnrB9yvIRHtvqQhrnjO/c
         Q+cDqa+FFwSB4Eapu1DD9AULDfdGLuLIg0ATKqDmOexsgyURGhcv6NK2mRFf12vKuJph
         x8O4v2ppPTGX6SU9HQZzVUnBlyCfXtV8uwWxYZvxiU6zNNLdCeFHp7wozNPnagosvioG
         CQaoSdekTAcqmzV0K2+4VQlY9nPupEwMvmVQCaAn6rpwZh/DzWZerH0ozYd3GIZDEUkm
         ijsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G+3wq4HbMGsLz02vnWPc8X5CuisGBMzZ/msi7tDk0Cc=;
        b=h+EJbFg7IIaCK8/nk0JEmGhHYm5XK/bV/ZQ5l4Z34Ei4+1+qTPDKSRY78p9APXTABj
         32/QL6if7kvXTt4k6Qg68vk9RISdCUUnpxw2l/G2s3rbrh/w05UnKmF93VXAkpNkTrsq
         J8yATnpKLv920t4Vw4lXSnAxfyAn5xD25BzXiSSTevXJNMkiIHQmsBj4ZMfg2yv5N30j
         +CofaYupfxIVuR+oI4rYbaOih89nP8d+V/0/Ejh8P2dlsZM72XZjwSnY1vto7IOIj/KR
         aDIderpQMK3mTDwFHhO2qopieTNkafhVqEDDFMBiyB2zPFtldT7fYsOOqYgI1L6aVhKf
         Q5yg==
X-Gm-Message-State: AOAM530OuJa3mbiM/NJN0UtipI0aAbFpJ10SbCDJY9nOV5asHeMY9DAb
        x/uC+k18qF93TrfJR7GYwFg5lw==
X-Google-Smtp-Source: ABdhPJzXhBB1ut7DH9GReY20YbQG7Em14PrgFXHUGeE5Nso5Glp1BpkZPapbWQqyPTktnpONnoHkIQ==
X-Received: by 2002:a17:906:f0d7:: with SMTP id dk23mr2565969ejb.131.1610652013255;
        Thu, 14 Jan 2021 11:20:13 -0800 (PST)
Received: from google.com ([2a00:79e0:2:11:1ea0:b8ff:fe79:fe73])
        by smtp.gmail.com with ESMTPSA id j23sm2348324ejs.112.2021.01.14.11.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:20:12 -0800 (PST)
Date:   Thu, 14 Jan 2021 20:20:07 +0100
From:   Piotr Figiel <figiel@google.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, posk@google.com,
        kyurtsever@google.com, ckennelly@google.com, pjt@google.com
Subject: Re: [PATCH] fs/proc: Expose RSEQ configuration
Message-ID: <YACZZ+wqRJutiEiy@google.com>
References: <20210113174127.2500051-1-figiel@google.com>
 <20210113213230.GA488607@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113213230.GA488607@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 12:32:30AM +0300, Alexey Dobriyan wrote:
> On Wed, Jan 13, 2021 at 06:41:27PM +0100, Piotr Figiel wrote:
> > For userspace checkpoint and restore (C/R) some way of getting process
> > state containing RSEQ configuration is needed.
> > +	seq_printf(m, "0x%llx 0x%x\n", (uint64_t)task->rseq, task->rseq_sig);
> %llx is too much on 32-bit. "%tx %x" is better (or even %08x)

Hi, many thanks for the suggestion. I applied this on v2,
https://lore.kernel.org/linux-fsdevel/20210114185445.996-1-figiel@google.com
I had to cast it via uintptr_t to cast-away the user address space
without warnings. Could you please take a look?

Best regards, Piotr.
