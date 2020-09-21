Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A699C27322F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 20:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgIUSrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 14:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgIUSrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 14:47:52 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99FCC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 11:47:51 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id j2so13815880eds.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 11:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pyDbIcQAdvsX0pQDLSC3IzwQOFdxADNEZk7v/eXeHTc=;
        b=IoHznwPzHOT1/HK/4KdjNbW3VhuKGXl+P/cFZ5oOS8j7l6omlNvRVY+IX6ljbCmS4u
         Nm7ZCAXl8KTfXvYsSNmXHgC0uian9TgtQxLW+oi0tNX7fNWt89tv2IDtS3IssEV+OiAg
         mDL8abQO6xKee3Gp++DudPOLquaQrWDV+eRi0yhkTY2YNC9KqOtUuvBwDkwQokWnobrA
         ydVOgaXnbtflxVXc5lTvukwzoCJv7t73HFLvd0FWJP7GCnXVDWL4a3zlYb3vAavqu2CW
         tIuGeZj73fNt3triaqANlSDGLTWXI+DgTY2SZXAWF4y1XUb6DBXx4kCdpGDxGZH/LwGh
         4fLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pyDbIcQAdvsX0pQDLSC3IzwQOFdxADNEZk7v/eXeHTc=;
        b=QuieqlCOGbRjcVGlviYM74O7doMGuJfUOrOdUk8Q9886/pdRVGpx8L9XI1MyyT6IHl
         JuhckQVOF389VRYr9EiHwcXs1XwFXdKjVV/FeN57Gem3M5FTrnRG1pq0wh9BZB5YzqW1
         FuS/OXwlu21oFU4zvVWNjrEyq82UbL9GIW91cQTylHVr1Zsq03cA/rIWFx05RjtxDR+J
         yRXrvsQukuE4Hwc/gwVKD6j7dTwGUjAlLWWAAR81tF19FqtpXmmlQewayw/cYfHycsNz
         p4kHPtemMw/LzR54bI/uVChjM7HQBwam+Sqs6jqX5LUxIWRX8n2SCpwH8ZcoZzt1pbuL
         GZMQ==
X-Gm-Message-State: AOAM533a80b27h9jCfoV81QP3GJ6pLWJka8sB1mocvhcW5lBkHpWxJSm
        Coc29ciE8jyelg3yfzNMDpD/QfI8DDIOSwVLbfoVVw==
X-Google-Smtp-Source: ABdhPJyr3HoCDSaaSE6/nQdSCDm40TS19EV3SXSzVioIoKdk8F7Y7f0V8JbN08ev9d+bgVmhdVvRbDDZMn9JIW+Dx+I=
X-Received: by 2002:aa7:d04d:: with SMTP id n13mr324028edo.354.1600714069342;
 Mon, 21 Sep 2020 11:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkGd6mPw_OKHwmpVs_xxFW2oqAoXyr7M8hu3PCCwkqCEQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkGd6mPw_OKHwmpVs_xxFW2oqAoXyr7M8hu3PCCwkqCEQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 21 Sep 2020 11:47:38 -0700
Message-ID: <CAPcyv4jZfbuS8zHZXBNqRTi_1HzHLUztkxDmsruMk5PGinGhPg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IGVycm9yOiByZWRlZmluaXRpb24gb2Yg4oCYZGF4X3N1cHBvcnRlZOKAmQ==?=
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "kernelci.org bot" <bot@kernelci.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 11:35 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Hello DAX maintainers,
> I noticed our PPC64LE builds failing last night:
> https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/388047043
> https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/388047056
> https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/388047099
> and looking on lore, I see a fresh report from KernelCI against arm:
> https://lore.kernel.org/linux-next/?q=dax_supported
>
> Can you all please take a look?  More concerning is that I see this
> failure on mainline.  It may be interesting to consider how this was
> not spotted on -next.

The failure is fixed with commit 88b67edd7247 ("dax: Fix compilation
for CONFIG_DAX && !CONFIG_FS_DAX"). I rushed the fixes that led to
this regression with insufficient exposure because it was crashing all
users. I thought the 2 kbuild-robot reports I squashed covered all the
config combinations, but there was a straggling report after I sent my
-rc6 pull request.

The baseline process escape for all of this was allowing a unit test
triggerable insta-crash upstream in the first instance necessitating
an urgent fix.
