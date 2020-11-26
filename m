Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDE92C5DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 23:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391763AbgKZWV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 17:21:28 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57194 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387820AbgKZWV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 17:21:28 -0500
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1kiPdm-00057f-AY
        for linux-kernel@vger.kernel.org; Thu, 26 Nov 2020 22:21:26 +0000
Received: by mail-ed1-f69.google.com with SMTP id g25so1646073edu.21
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 14:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lRXUB1qEmss2IMoGdczKcPmeRHUynmNqZ/JpkKoX7s=;
        b=LOIpBCC87caZNDeM+LhjxPIS1lkfgAUQPXdMD+4ywmH3GjoD3cwucoV8qYB1YVpFQP
         LgLADYUOvGSVkj/NDygVu5pYsuaqmBUj6j8sl20o3TBJmw30pu0AqVOHz3fFOjBy8Bxa
         jPnAmyKnp2txCPZZhGrrbGO6jRSUj3J/LXg5LTHexiOghD+WJQoC4G96o/XSKH33MwJ1
         f7MhGhTPkmt3EeoIO2z42+/W1tdriaqX8l2vKxJTWvktNDFanH5jZvMROzpuFtMVjl1l
         6c/vckACwWsBVd4DIyMVYyaIgbGEcOmt8gwcwaTqPlotLB9oxyZYq6IPp53JImPSt5wZ
         ecUA==
X-Gm-Message-State: AOAM530xboJWOoPCwDjI7W+NbNwia+HKtKT2wAtjIaj25R19DilakvOF
        eSmEi0IeNaYJgsk0KLOSG1T+DjcgYtrWIh3LKC6FLCGtgQ+IipmOlODZLn0DYv591FM1z+DYdVN
        0/TfGmCh/xrZ8hA+3rqrVRoH3yHDlRYg1pbFpIkwvGPbDi0lmmeqncZBfcA==
X-Received: by 2002:a05:6402:114c:: with SMTP id g12mr4422721edw.167.1606429285934;
        Thu, 26 Nov 2020 14:21:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2qwvS5FzyrXmBe3Ijl7tfYALOW5KntKrAkuj56vAuqRprlCF1EeiFyxv0i9jA1ZUKV9FNBnZnsC9XbYh00ac=
X-Received: by 2002:a05:6402:114c:: with SMTP id g12mr4422713edw.167.1606429285753;
 Thu, 26 Nov 2020 14:21:25 -0800 (PST)
MIME-Version: 1.0
References: <72df55ca-20f3-c3ee-861b-c50c1a55495e@canonical.com>
In-Reply-To: <72df55ca-20f3-c3ee-861b-c50c1a55495e@canonical.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Thu, 26 Nov 2020 19:20:49 -0300
Message-ID: <CAHD1Q_yTqgcp83eMFtWFzTwAaUVvRAui+mXdwhh_TiukA+bz=A@mail.gmail.com>
Subject: Re: About ftrace+pstore+ramoops
To:     anton@enomsg.org, joel@joelfernandes.org
Cc:     Kees Cook <keescook@chromium.org>, ccross@android.com,
        tony.luck@intel.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        u.kleine-koenig@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a heads-up on top of my own email: as soon as I sent the email, I
had an idea. I was trying with ramoops.ftrace_size=X, so I removed
this parameter and it worked. As expected, it's a small buffer so
collected mostly the ramoops own functions, but worked in the end -
I'll debug the reason it failed with ftrace_size.

Apologies for the inconvenience!
Cheers,


Guilherme
