Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFB429DAD6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390332AbgJ1XdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390146AbgJ1Xcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:32:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791EBC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:32:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b8so877817wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s7oTJO2URUwicNq+0grzgb1zKL3aTp37KAP9mWzmEfQ=;
        b=RkhCJEMWAEf7CVCbwgNDcxiCFZe0Xv7wwi+BltG+iMI5kMEjVy/m2EmIKaONUI2RMA
         Ycp+UFF3l1p3R5IMVnT5JM5eMP5fy252Z6+MpJJtLTvb8iRfisWApn/vt0x0Zm9qGZCo
         POIeGL2eNfXmxCbQ6lS3mbW8m6TyVrRZCVacmFp/hm116lWmRmJJnyq5xm8amva3rMBC
         srRJHUd7P5DYX4A4MzBBuQi8Rlug/FgoWkmom595iq9u2DWNUxXiDfSuUwNDqBrY4mX8
         hs5FiI9k3AZ2jT076DQbTEVsctmgwby4QdHysruvDXXMDjhR+YaWES96Q9CYkjn3YHn8
         SkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7oTJO2URUwicNq+0grzgb1zKL3aTp37KAP9mWzmEfQ=;
        b=jRCN3OqE3H44QB/G0/H52fyUGjp6K2Mnt0/buSQcbX4peZ718Osgs6oy0OwH3vtT4w
         49kS1N3iPrk5KdAH0EJUISsC4VVsTKCKEvppZQoFCngLjKJMRbGAaecpb3OhGatyk0OV
         2HzLwToLGNK745eOnthnW0K6pIaM+o3+/mMkSaDQHyZmfo/nhHUcPTNqdP1iikW51Oqp
         lnphf414nG1Hd94staUYARhvArjrDLslKLOgmQ2FEhitSmTJimCQTaDOpxcOJNuix0p1
         EPGVKeQBRhLGjbCqAJJac9ducj0bZq0Xnk0PPF1g6ydC8eu3VxIv4UcVVie1/DuzUf9J
         ecMg==
X-Gm-Message-State: AOAM532/tE3CEmtgDWYiph9lRLF/dj8qhPwCbMpusyWxyCx+G2CkA5nx
        Is13HeUPMPvO8S70yA1Vz4az3LoIONAGGpeMeUaagCR7gbXthg==
X-Google-Smtp-Source: ABdhPJxYQ06WGTZk46k4E/0eoYf7OxVvvCI/IdrKL3cRLQySxmBc/1I92RL+kWyoNBkiKL38Kx023QuH+wpRCkVhJfI=
X-Received: by 2002:a19:241:: with SMTP id 62mr2067105lfc.165.1603854125720;
 Tue, 27 Oct 2020 20:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201027184853.20830-1-rdunlap@infradead.org>
In-Reply-To: <20201027184853.20830-1-rdunlap@infradead.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 28 Oct 2020 11:01:54 +0800
Message-ID: <CABVgOSkz60Dhrfg2ffXkejdE7Xbn4RkvEF=-6OmJTTQP9hrhwA@mail.gmail.com>
Subject: Re: [PATCH] KUnit: Docs: fix a wording typo
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 2:49 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix a wording typo (keyboard glitch).
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: David Gow <davidgow@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> ---

Whoops! Thanks for catching this!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
