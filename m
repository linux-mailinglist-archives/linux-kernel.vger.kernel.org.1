Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D742A87B0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 21:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbgKEUDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 15:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEUDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:03:03 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DA0C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 12:03:02 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id f9so4107552lfq.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 12:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dzlZsvxvnDbAB4V5qU3abNgbE7nVhIrLCKkbyuyi8ec=;
        b=bkU4Dkg48kCAPRFxnDmmJTKxQMN6YO7q5zZS1V8OAV2Ak27P6TVMjRXr2LRZ6c5dZR
         u5UkK3C3VGr/J/mVug2e1iFOqrxktkVQIX9iXVx4bKJ51YhPjy2wQmq5oX6Rmzf89Fqm
         n+eyy9zpL6oBOqWFwaujYmGaujnjXJZ/wNE+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzlZsvxvnDbAB4V5qU3abNgbE7nVhIrLCKkbyuyi8ec=;
        b=V7wfzy+xYoXUdyr6LIv/81prGNK+VrR+hXwTo4Nv9th8j4+Yv6C8Cbbpsr0O3xTnSU
         oFYRZndebJgVmaTXBbKmgCYl8wv2x1QniyMicfwr77qYlmIdB6e3YXV2s9lL+2UGrAqi
         Np0+0tlt0MKaBMqI22AsPiUC96hjICTbKuEY7Ldh0DUquKGH1QOSLP4mlcc/tJDc8ewj
         ZnP/V/LrG1bi/TO1vvvgkzL7vf7FliHHLuHUZ9si/d5zCKKhkxtg9lIwCx4Wmw17gK/p
         lKSBwJJKkOE+G3nCNRlVJ4rdmy8qzSYQ2VWLoc1zirCQIpA/f1xiVSEebTK35oSyPjpx
         SwZA==
X-Gm-Message-State: AOAM532Ccvav6cpM6HUwkBcUl2fHN8KibN/dVns+FrdILD/OMC0zNYC8
        +hMFks1dk3XUXjMUhPHrv6hKBOy6wm9lSw==
X-Google-Smtp-Source: ABdhPJyxduKoVepatcyGXUlcf6qRFeqndL0SC/vUMux1sW6LJFAq6bjJXdGae+OcJwjYuQGayohhMw==
X-Received: by 2002:a19:640a:: with SMTP id y10mr675970lfb.16.1604606580313;
        Thu, 05 Nov 2020 12:03:00 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id s13sm232378ljo.34.2020.11.05.12.02.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 12:02:58 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id i6so4123335lfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 12:02:58 -0800 (PST)
X-Received: by 2002:a19:c703:: with SMTP id x3mr1531696lff.105.1604606577657;
 Thu, 05 Nov 2020 12:02:57 -0800 (PST)
MIME-Version: 1.0
References: <6b9e77b0-7272-221e-d475-41b266b22496@linuxfoundation.org>
In-Reply-To: <6b9e77b0-7272-221e-d475-41b266b22496@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Nov 2020 12:02:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiscEwD+a4M2mns1kf2S+yE6gcPp0sn4znVt0ZUxaP3Wg@mail.gmail.com>
Message-ID: <CAHk-=wiscEwD+a4M2mns1kf2S+yE6gcPp0sn4znVt0ZUxaP3Wg@mail.gmail.com>
Subject: Re: Kunit fixes update for Linux 5.10-rc3
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 8:55 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
>   .../kunit/test_data/test_config_printk_time.log    | Bin 1584 -> 1605 bytes
>   .../test_data/test_interrupted_tap_output.log      | Bin 1982 -> 2003 bytes
>   .../test_data/test_kernel_panic_interrupt.log      | Bin 1321 -> 1342 bytes
>   .../kunit/test_data/test_multiple_prefixes.log     | Bin 1832 -> 1861

This diffstat is a bit annoying.

And the reason is that we have

    [torvalds@ryzen linux]$ cat tools/testing/kunit/.gitattributes
    test_data/* binary

iow, you're telling git that everything in that test_data directory is
binary blobs. Which isn't actually true.

This isn't new, but it was just more noticeable this time around.

That binary marker comes from commit afc63da64f1e ("kunit:
kunit_parser: make parser more robust") and I'm not really seeing the
reason for it.

                 Linus
