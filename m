Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA832EC68F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 00:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbhAFXK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 18:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbhAFXK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 18:10:57 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54CCC061799
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 15:10:17 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x126so2595363pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 15:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=axakR3V8Px/scAgH93voC/mtIO5dG1PShrCOBx0oSuQ=;
        b=csHjke2t8Ll0E6OubejG57TgVe6VHXNFpLMhiBdQRRCutar+xa87WJc5VHGZMcT1j2
         fJ7I6HDt6nYZRqBjwBfNp7OhvBj6P65MhLHnhFYk/Bdzi+OttQAl1K+Krw4eE6EHXKhf
         JP9rvM3eh3NcxiiWj6GrEqbrziuWNlVcED89c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=axakR3V8Px/scAgH93voC/mtIO5dG1PShrCOBx0oSuQ=;
        b=lrTO4nWB6ogoXoU2v20s9R9sx7sxL8gSQnMaZNtCHYkt10CabvPKXo9HmqpRADBJqJ
         uZn/sgiosf6IdaLWHQKwM5HMqAwi+9Q1vRYni0rEec6BFil0JvLhHuKKD8d8FiLXmoaZ
         YbY1YjSBhzAY28zbkGLTXDzEXsrn0dq2Z++y8eBgWhAyPTEGJ4xKItIBg7cuIlgTW0HM
         yrAlXTGEXI2Y5xuWB+bxA/0+c7Sjs5s69nYtOvGZ7pjKft5BNZIcSSI7C1haocfh/pWX
         Vk8CsMNp4ckA0MzHx16Sb0vH1r86DySfXtR/aXw3EVRhHnRxCkDUUd0cWC30VKqTbHnm
         qcqw==
X-Gm-Message-State: AOAM532e4nMiND+S1jFVLu3PZFTded6XhUckWoq6M7vn+vMVYnsn0lmr
        KCBtuHGtqMw26pqmyelI48sZCg==
X-Google-Smtp-Source: ABdhPJxKgVI2vxQQnj6Y2VwwC48vKM49s7TZmuVnIrPHI7UEvLlX/5hkXht2F4PdIa4y51aCwp5ttA==
X-Received: by 2002:a63:2265:: with SMTP id t37mr6720232pgm.336.1609974617144;
        Wed, 06 Jan 2021 15:10:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x1sm3469752pfc.112.2021.01.06.15.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 15:10:16 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] gcc-plugins: fix gcc 11 indigestion with plugins...
Date:   Wed,  6 Jan 2021 15:09:42 -0800
Message-Id: <160997457204.3687425.15622431721220616573.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <82487.1609006918@turing-police>
References: <82487.1609006918@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Dec 2020 13:21:58 -0500, Valdis Klētnieks wrote:
> Fedora Rawhide has started including gcc 11,and the g++ compiler
> throws a wobbly when it hits scripts/gcc-plugins:
> 
>   HOSTCXX scripts/gcc-plugins/latent_entropy_plugin.so
> In file included from /usr/include/c++/11/type_traits:35,
>                  from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/system.h:244,
>                  from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/gcc-plugin.h:28,
>                  from scripts/gcc-plugins/gcc-common.h:7,
>                  from scripts/gcc-plugins/latent_entropy_plugin.c:78:
> /usr/include/c++/11/bits/c++0x_warning.h:32:2: error: #error This file requires compiler and library support for the ISO
>  C++ 2011 standard. This support must be enabled with the -std=c++11 or -std=gnu++11 compiler options.
>    32 | #error This file requires compiler and library support \
> 
> [...]

Applied to for-linus/gcc-plugins, thanks!

[1/1] gcc-plugins: fix gcc 11 indigestion with plugins...
      https://git.kernel.org/kees/c/67a5a6801305

-- 
Kees Cook

