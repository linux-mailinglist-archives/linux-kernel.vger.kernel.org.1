Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876482F6E15
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 23:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbhANWUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 17:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbhANWUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 17:20:49 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4DAC061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 14:20:09 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id r4so3631809pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 14:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Do79F0qCKpJd7LSoRqgLMEzb1pOqhgiMpv8fnU8/fbo=;
        b=k+NjQDLbgIimZJchpQ+b1b+Cg8mX1+7364ivdWf0Wzz2+9hTqem3XdAIqy5WJ4bf0G
         M2Xgzzknf604bcHhgbqDlYzaDcpd57s1s5KUb3TScPNNxv8pNynTRziXV12ptOYsZwiq
         NfX3/teSMazs7Hie41XrQ13PhbSUIazcxwXXZLHl5FyNtaNKnIbiXtDj1qOWLeCnjbWd
         7/3KSAI0cOw60iax4CIjcO/1FdKTJJkM6afhCOlz4PDe13+loSVdu8mmbfDtYrbdWvsc
         fvZwG+PUMvMUMCXnJ6+yfnuS7nmdY6TEfCS5siBo51+m4GcfQNdrVU3X2D4VQdhS59Eb
         JZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Do79F0qCKpJd7LSoRqgLMEzb1pOqhgiMpv8fnU8/fbo=;
        b=sHs8tjhx9zbQA9BahQfewUIJp0xA0102/HaBcchUxUPIAV2pejS+EE5y8SvRVskYDx
         SO4dc88aTvZ7Wu9f/qeEhqFzfzb60dScAXdy7akzs1B+vcvhLQdB2R7KcEEo5O57OqAb
         q9X7v0ewMXzXmlxWKMhyHwDh3xc8HWLgtYD6uoL7+KCXSShxYg/vc6gK17A/939r9+lI
         3QgeMrpbIZRO2koCyX7dj9s31E9Y3POuW46sHLR9PIo4FuVpTdFUHIBssi5X+oyIWUDl
         J/qLNZAB88Kc3XJbwmGHDEzw0X0EW4n9Dg9hImUR99H2nDN/szHX3TSA4I9xR2sbA5of
         gnaA==
X-Gm-Message-State: AOAM53163eaEugaiNC3cpnwvBN7fR7OZeErFxtZBlR8OedEJ5q5AAc1E
        v4meFQ0mvK/pLejqMl0XQobIUxnI0hj1teoH5TKY4ZTt4rjxfw==
X-Google-Smtp-Source: ABdhPJw9uBU9jQLLAQC6qlEuCIK+zjIemNgSj2UYEKyxihwOwbYeyc/8LFnpNCBLmQ/4u3+Vmsm3tgL1esZiv4hkRh4=
X-Received: by 2002:a17:902:fe87:b029:da:5d3b:4a84 with SMTP id
 x7-20020a170902fe87b02900da5d3b4a84mr9569152plm.51.1610662808494; Thu, 14 Jan
 2021 14:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20201202190824.1309398-1-dlatypov@google.com> <20201202190824.1309398-3-dlatypov@google.com>
In-Reply-To: <20201202190824.1309398-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Jan 2021 14:19:57 -0800
Message-ID: <CAFd5g47+1o4W4Dq_pH4eN5-qGgO5gBGj-6kpMkHQ4ESSXHCGSA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] kunit: tool: use `with open()` in unit test
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 11:09 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> The use of manual open() and .close() calls seems to be an attempt to
> keep the contents in scope.
> But Python doesn't restrict variables like that, so we can introduce new
> variables inside of a `with` and use them outside.
>
> Do so to make the code more Pythonic.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Tested-by: Brendan Higgins <brendanhiggins@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
