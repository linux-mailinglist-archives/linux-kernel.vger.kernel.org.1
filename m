Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA852F6E28
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 23:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbhANWZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 17:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbhANWZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 17:25:12 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EBDC061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 14:24:32 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id a188so4210063pfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 14:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gRC5Pleb9dUxv3nJaqlApsE2Yyj1i5/5CS0p59ghBkc=;
        b=NuA3EJ3p4xB56QjPMOsEQQMUhXG3PQ0y8iWnVaCIXTapcQ7PX3/QSUg5osssQ6nGaj
         nXJUe4amtRfx6WBlML3wsytOVgXf5u3kqra+2KdixvTHv9z4lABT8g0mk1lW/SojZ+EK
         PkMKhJ1T1u6iB1YcKAH8AE+8Gu9QaZ+l2SS3rakd67ORcNMQNvVx9KN2dJBgTVTgrAK8
         JV11HngiDjErzuUzkePUoq+HBWMAR52Q6rYRdwVXEq/tpnvwFg8N9r0Ne1j8nKhdHvax
         m9qmj+a0tvXZHGHElR23N6c2euo8y2gB7BYZCAGbPbnESrxtBxA/D52GWNDgkwbgA+Jp
         u/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gRC5Pleb9dUxv3nJaqlApsE2Yyj1i5/5CS0p59ghBkc=;
        b=muXJO8OWWKbvLIL1xoxoEFqca0IEVf8O8kOgwxwSoYSbCXhzor4QUuf2zbm8XlTmAM
         RjMT5I2dSqGUj+G8coto8ihf3UswqE0k6lPQ6zYMk5DDX3NbrzG6u3qwas1nYe8K+imD
         urV+7CeBekH47SIyPLJEy27J2y1qY92bU9+DAwsVGm/somLYTo8LBOwzDOPv2MypHYd+
         DXAv5ImrTcR1kbvV4f8+08PqDSd+ZtrTF76LyeK1jOH2JEaiwiznD5X+4g3n48Ngp9AH
         hZd0Cr/Ce1orCKrJgEC8SXj0UaR5le3+9AzfZtoro/N9bQp8NbOu+Vnz5wgV83kIsi8H
         NBqg==
X-Gm-Message-State: AOAM533+VKBqrPyp8/p1zmowZZtloH1zUv9y3xXLXzCOSuSryqDQaEbM
        ttLCuia0tGScIL8ay1d2kzlqA9ErJeNWC3baWtgmSQ==
X-Google-Smtp-Source: ABdhPJxY9okKFIOu7O3uhTD28hz1VT6/8eJsX891SLMhHJQ2T++lZwV0wgQ+6dCV2/GwDFou+QUuaN6E2MdsZSWNbcY=
X-Received: by 2002:a63:c84a:: with SMTP id l10mr9703913pgi.159.1610663071797;
 Thu, 14 Jan 2021 14:24:31 -0800 (PST)
MIME-Version: 1.0
References: <20201202190824.1309398-1-dlatypov@google.com>
In-Reply-To: <20201202190824.1309398-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Jan 2021 14:24:20 -0800
Message-ID: <CAFd5g44+y-n3v_As8J2piVu+fyLCXCgHx1zmuo0mfb+VKkSUBQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] kunit: tool: fix unit test cleanup handling
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
> * Stop leaking file objects.
> * Use self.addCleanup() to ensure we call cleanup functions even if
> setUp() fails.
> * use mock.patch.stopall instead of more error-prone manual approach
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Tested-by: Brendan Higgins <brendanhiggins@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
