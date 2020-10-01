Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA88280715
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 20:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733116AbgJASkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 14:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbgJASkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:40:20 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6505AC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 11:40:20 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t14so4696268pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 11:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bT1J6Z9CLIzHImMMrPae25NAqAg4qvT7z5q5kWJnZFg=;
        b=RQLTms+f/csSVRNAGdl1BpdQVCaCa/kppkRSMYQT9AUbjLsK3VBNvDVhE7GqrFfspm
         jB2y+GF/oueCRqPF8wv7qo0c1zt0aCl1fsIgFNkzm3YdLjNUi2SBGBgiowSGb5K6L175
         tQ/M0je70wLZtwmOnmE6jhGHtI+sUX23sG9qyWgqqyV0GRYy7u9d+lUrQNrEbGhXxsDZ
         Shqt3mdj9xZ+D2GXuFh2LZj3HH0qEQa/PUtvN5Hmf6/1X9s9a45mgP47eNygCM6qIL8l
         J9FSwoJjOXtuPBqZfqGdKTbtAjT9V3TXlhJ6yA7qcL+stSs/KZwYnEAL+j2hbXwmXdzF
         T3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bT1J6Z9CLIzHImMMrPae25NAqAg4qvT7z5q5kWJnZFg=;
        b=B9wxIXoqYnRIDGi06BEny38EHEEkBajT7yNSpRXQwHQSx5PW29yOezLLbgHR3vhfqQ
         6MtAMSQuzL1NrfI/vA6PpzpVhBKpKXDd2Q7ej3pwm9NeV2ApBhw8tD79okTH5lT93vGw
         /y0vRo603Zx9ROvxzDdr+kJMI4dlarqpsRtojQCx123WWgIluamYqNgSAvslWwaJiX4O
         CUrO2HXxEE2BX+CLu1bLlGJwm2khXw14ofR9xEuk99Def17imcqwW7HvJmCPBQeRjAKD
         SbsTMqnwAlvpY3zSH4WQpjBI0TxBrURG4k+M4Q9QyrkZdv3SdWhreMP2DIAqcquw2MgT
         K3JQ==
X-Gm-Message-State: AOAM532i4ARfJml4KUz4S8LRF56RbgvrgpA6F2gv+AzIrbfCtjZKLrC2
        gmb2hi1y9Wexzf45Kd/QSEU=
X-Google-Smtp-Source: ABdhPJzddNNmu1r8MnkavWgAH5ix6tOHgYoHpJizB/QDiZbbhIqRnAkgaAbIyzscnoyKf1eQNPQrVw==
X-Received: by 2002:a17:902:7798:b029:d2:80bc:7429 with SMTP id o24-20020a1709027798b02900d280bc7429mr8809310pll.80.1601577619815;
        Thu, 01 Oct 2020 11:40:19 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45e1:2200::1])
        by smtp.gmail.com with ESMTPSA id r14sm6216966pgm.7.2020.10.01.11.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 11:40:19 -0700 (PDT)
Date:   Thu, 1 Oct 2020 11:40:17 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [tip:master] BUILD SUCCESS WITH WARNING
 99b8adf3cd30dbcb441cdd7282f0c6f7ef1615f3
Message-ID: <20201001184017.GA539221@ubuntu-m3-large-x86>
References: <5f761f6c.3JikdZmQTQD4YT0X%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f761f6c.3JikdZmQTQD4YT0X%lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ clang-built-linux, full original message here:
https://lore.kernel.org/lkml/5f761f6c.3JikdZmQTQD4YT0X%25lkp@intel.com/

On Fri, Oct 02, 2020 at 02:26:52AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
> branch HEAD: 99b8adf3cd30dbcb441cdd7282f0c6f7ef1615f3  Merge branch 'linus'
> 
> Warning in current branch:

We have outstanding patches for all of these I believe, just waiting on
review and acceptance.

> ld.lld: warning: arch/arm/built-in.a(crypto/aes-cipher-glue.o):(.ARM.extab) is being placed in '.ARM.extab'

https://lore.kernel.org/lkml/20200928224854.3224862-1-natechancellor@gmail.com/

> ld.lld: warning: arch/arm/built-in.a(mm/init.o):(".discard.ksym") is being placed in '".discard.ksym"'

https://lore.kernel.org/lkml/20200929190701.398762-1-ndesaulniers@google.com/

Cheers,
Nathan
