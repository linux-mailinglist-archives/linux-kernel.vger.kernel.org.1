Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFFA2F6F75
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 01:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbhAOA1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 19:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731034AbhAOA1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 19:27:24 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1F4C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 16:26:43 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id z21so4908495pgj.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 16:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VrR4pCt2QpQ9EObd7CgJ7W4oxOaFcsdsZorMfy/tWv0=;
        b=tWHF9b7E+s658hVcVQWZ7xA7N39BrCFFPLzoS0ymT8X3+KazjEqdCiYhzgz9fN9qj+
         5dWtOWUIgnrqGVT6/86ihJfKIkeqRsfBWheF6ZeIgyqkaBFkA2KzRM2PK8887qeFpz5h
         hbajFFpi8WKfnzNsAv2zg3gIW3RTfGPf5Pvo47H7g+3eErORkbVzZI46rnsN5uxigBZ5
         isJ8CIrkjq0spXsL0L8vpa3Nz6MwJDiKtgSKys9I8xD6q/PgAAvbWmWNmDYU7neWVaVm
         iJ0WQbCPnbVPXPUR9CoOMJkSH1gk8xO58aKcdt1OWq9T5qYgLbhc3fQd+wFiQ5SkZivR
         q2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VrR4pCt2QpQ9EObd7CgJ7W4oxOaFcsdsZorMfy/tWv0=;
        b=MaP6n6QlLvo67BrFcjKe4faG/0a5bEl51iwtTu98bBjSJwCwOtPJsD/z6b8uH4eh9Z
         FzDKp8UkX8CtBuqLKlCShKIOIPimHDJwDpwtgj6Frm5dYDrJvnbUSSIcuvPyQpi1rN5Y
         3Cv0ksajgb3ycmE+pLrZV317+CYredSlXWR5v3CjsLNe8rw4K5k3t32YcAtwCvdI6Svg
         QXQt9JsJfMYKjSAkD+pmT6K3E+FGpQPU66yrS1jjg0K90ttc9vBiUOlLkUrq+GV2Vuma
         qCpXIZjhe2Zzi+mu6yKxXXUHv0oifa9NbopdXP6IR1nR0CcNgxy6bNIBnIA+05kM40/R
         5V0A==
X-Gm-Message-State: AOAM5322Z+n4zQz2VGej8pzU1lGHEgxO1hA7kDmFAhR857yBiZwzxi/8
        ozIU6o4Hn+Ame2z5XW6ihi8ZNzAqemP4McRBypdx8g==
X-Google-Smtp-Source: ABdhPJxu3zfPxFZyoIathC3722ixEjnt64UfpFHbWXcvYgdgtrv91Naw97mNoXKEslKAcpYV6r3ZPMILsPZntqZb7R0=
X-Received: by 2002:a63:5d7:: with SMTP id 206mr10239836pgf.384.1610670403049;
 Thu, 14 Jan 2021 16:26:43 -0800 (PST)
MIME-Version: 1.0
References: <20201211223232.697679-1-davidgow@google.com>
In-Reply-To: <20201211223232.697679-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Jan 2021 16:26:32 -0800
Message-ID: <CAFd5g45xaOE0KOeOoHzY9NsJRbtDUimto1rDs0+aD6hw4zbogw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Fix spelling of "diagnostic" in kunit_parser
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 2:32 PM David Gow <davidgow@google.com> wrote:
>
> Various helper functions were misspelling "diagnostic" in their names.
> It finally got annoying, so fix it.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
