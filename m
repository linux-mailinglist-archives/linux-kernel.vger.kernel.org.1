Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DE82824B9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgJCOXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgJCOXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:23:43 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D746CC0613D0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 07:23:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y2so5447491lfy.10
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ew9B0cLJWgsgc2LDPLGBJTjuRfVN64N0jnTff2K8RHc=;
        b=f8emFHf7AuH8mrV1smhSbhHFRiRc+m2ZUukKJcHxj37gi+dEfTemdjlTRYYObrosXP
         x7OEwX6tKdkZu/RSsAOGjap/5O7s+lyibY0YXo/lCTS2N+5WASZ9zLVvzBn9DCwzgqHC
         vmnOoOPwc+aCvqJ7xysJOTMZOkL0u71kxCQy+SmK7ix3jWrja/C6vD5r3JHZ203dXtvI
         wBIq8eVxgAVeFnOdWGvKIOMuWfGr9K8TquufXJbsdWaRc1eIXV32PtNZji1jvCLiPDVV
         vYnPockatr38HUmB7MaBZl0TqA5DZzj8YiRkoFETUbGwYI+eKcsCToZtfuIm7OtQAnSg
         pboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ew9B0cLJWgsgc2LDPLGBJTjuRfVN64N0jnTff2K8RHc=;
        b=nbf1Av9GVGW97FH3UB2cb1rz6rrUygjj+TIt8V2RfIwt8doP4Zn+Xmb+9eIj1/8Ro5
         gwBQS9AsxUSFJxp7cmzep4+wjWuurAxTUuE6RVFem3lQZi7i68XGpKyHx2C/akH6fHtY
         eILEUPP+p2EDK8Y33iT+fnQOTOyFq1BJ5jbcKDp7sdSP12U/adHKu8et6Q02eZY5fTML
         iroFy492rti032xTX4ya/llj55TD4Me2qld3psX7tb6DpmsyZAfpiYarKWCL/e/Ydwka
         0UW9QfDc1oId3+c/kMn+OGTlAa8+nCt4Gis4Glwcmc5lZ9BRZaSlDjlIQtuhg4AWTWrq
         vlMQ==
X-Gm-Message-State: AOAM530Nwk+YIUljROvk3s07+IakHeLodbk0vYS9dtyKsbogA2k1WKwb
        jqV3+XcM9CRcoxB0UcBK+yzzCDd1i90qvIKfvTcfdumNKw==
X-Google-Smtp-Source: ABdhPJzCaLcE8NXeOOlnwFFPbisHfAZIXrHpACWAdal5JfgWpff7OgGIIvWsGwTDBdP9wnWSGIlWAIaqDfHML2SPkwk=
X-Received: by 2002:a05:6512:3f3:: with SMTP id n19mr2389965lfq.531.1601735021288;
 Sat, 03 Oct 2020 07:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj1SJmva5pQxT-XZkMREOa+iJuy0K8-zua0K=vF-Jz7zw@mail.gmail.com>
In-Reply-To: <CAHk-=wj1SJmva5pQxT-XZkMREOa+iJuy0K8-zua0K=vF-Jz7zw@mail.gmail.com>
From:   Gabriel C <nix.or.die@googlemail.com>
Date:   Sat, 3 Oct 2020 16:23:15 +0200
Message-ID: <CAEJqkgiq5ss9S4edHGb5x+YjhODF1HqBW-5qjHA8=AFnhX2tSQ@mail.gmail.com>
Subject: Re: Linux 5.9-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo., 28. Sept. 2020 um 00:00 Uhr schrieb Linus Torvalds
<torvalds@linux-foundation.org>:
Hello,

> Shortlog appended, but what I really hope you all will do is to give
> it a nice good testing. One extra week or rc kernels will help, but
> only if people actually try this out.
>
> So.. Please?

I'm a bit late testing, but the first thing I noticed is this warning:

ld: arch/x86/boot/compressed/head_64.o: warning: relocation in
read-only section `.head.text'
ld: warning: creating DT_TEXTREL in a PIE

The compiler is gcc 9.2.1 20200215, with default PIE enabled, ld version 2.35.1.
The config used is the 64bit defconfig.

Best Regards,

Gabriel C.
