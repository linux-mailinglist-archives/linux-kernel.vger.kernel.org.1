Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E3520761F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 16:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391203AbgFXOx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 10:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389818AbgFXOx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:53:26 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FEBC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:53:26 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id jz3so1270497pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OPWu0TeNvD4ujFH7IT6Yq/7QVWt6mn1sVW+hYIGa3/c=;
        b=hpP80aWoVCRlVHrXGBwyfL+RPDRXCMe7ZswUMGPPdIckNU+/eQLVr51wJYXeK84tS8
         2WCDJZSZTwtxrmhRVEOIBcnY26CQPqWU3uVdGunp0mR0o+2LoNpU5OTOKcg3KoQqUP/D
         FsCCqiNuvarAC7Prd/cfAOwQBwApsIR4mQjPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OPWu0TeNvD4ujFH7IT6Yq/7QVWt6mn1sVW+hYIGa3/c=;
        b=Bf3cDtmHl72ngoOMOyL45SXM1s3egfJbxnTkGpAvDGRi5gk/teEaoc5HT2DUyoJdWu
         rAirRONeWEY9AIPF+1jrJ/v6n48sH+jwhrd4VruhOdjWKCiHzQlmM5K+2UAkNZg1MoxX
         8DaGNyCng9wNc//pchby/ubln8CS26HfhuRUjeQpgBksxYgqoYDN5mg6QlmtDan5kl1N
         /PcdHTXEGYQncCoLJWZW63ofp9pOpTFPBh0hi2GL/7ww9Jf95rDxHF1mQTfvx3LYSy61
         Gs/WQpp0QDYX+NTxTCDCOMvigEHTVpMRjTtCdw4129FP3wxVel9Ro291UA8xx+jZoDyI
         FY1Q==
X-Gm-Message-State: AOAM530f+K5+RI1X6flzAtRLw2vSc9X6URPn0mPd5+cMyXqDctPc0+vF
        cJeZHu6tWTeq1djoAAcyLVJ5Ng==
X-Google-Smtp-Source: ABdhPJwkPoYDkU43oyjXTZ3o3ijQjsdZRoWueUiZxBpfidz8te1WzS0FHYIMG6I55iroLY/YVnEmig==
X-Received: by 2002:a17:90a:f508:: with SMTP id cs8mr26450593pjb.16.1593010406141;
        Wed, 24 Jun 2020 07:53:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d4sm5876447pjm.55.2020.06.24.07.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:53:25 -0700 (PDT)
Date:   Wed, 24 Jun 2020 07:53:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Jann Horn <jannh@google.com>, Emese Revfy <re.emese@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Alexander Monakov <amonakov@ispras.ru>,
        Mathias Krause <minipli@googlemail.com>,
        PaX Team <pageexec@freemail.hu>,
        Brad Spengler <spender@grsecurity.net>,
        Laura Abbott <labbott@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        kernel-hardening@lists.openwall.com, linux-kbuild@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org, notify@kernel.org
Subject: Re: [PATCH v2 5/5] gcc-plugins/stackleak: Add 'verbose' plugin
 parameter
Message-ID: <202006240753.8C62F5A@keescook>
References: <20200624123330.83226-1-alex.popov@linux.com>
 <20200624123330.83226-6-alex.popov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624123330.83226-6-alex.popov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 03:33:30PM +0300, Alexander Popov wrote:
> Add 'verbose' plugin parameter for stackleak gcc plugin.
> It can be used for printing additional info about the kernel code
> instrumentation.
> 
> For using it add the following to scripts/Makefile.gcc-plugins:
>   gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK) \
>     += -fplugin-arg-stackleak_plugin-verbose
> 
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

Applied to for-next/gcc-plugins.

-- 
Kees Cook
