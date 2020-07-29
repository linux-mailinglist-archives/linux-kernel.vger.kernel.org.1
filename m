Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1081B23168B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 02:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbgG2ABj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 20:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbgG2ABj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:01:39 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C808C0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 17:01:39 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id t15so13758691iob.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 17:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8XkyWGDBtbZKzOaOShYJKTEnyEVVaISF88UxbpxpW24=;
        b=hPhGUzs6xSlbNCUnN5ENUQ2bqcOMwofvm/bSyqjDn5UZrSkmnkTfoNc4UzdIZ/7m6X
         DIQM3w4QSO+rpZ7k6v57H0Jq2S/b7myCXPs2//qDk9W/el5a0vQGb4m3UxuZiCMJEe6G
         QbcXWnEH7feItnmCLtdl3qstnxvZphTXmxihMJh13J53vNdDn+YchYG6NWsxkUsAQtmT
         7VsoljeD6LrmxtMmSbJWgca7xja+Nvp+9KGmCALC5MbZttZh9Xvo6SuNQHBFCBlZFpSk
         7cZwKUnjT9KVr5SY7LWz4ILiytfrY4M5eev+6QZcXWlgArK5Zb8lbVFyUPRUsVwfiP56
         CuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XkyWGDBtbZKzOaOShYJKTEnyEVVaISF88UxbpxpW24=;
        b=nyYLpTUP67dVwJedsrmtz25RohWwUN18EvwCmUknXL7b+M5v3D7w4LtsZvv6HtVMST
         TXUP7fKIBt3V0WMNsQsfvgxWcYClog477BxaY7pCaxaa9MtpJTAe1EtCeCXo8CMs2FWX
         byQpxxF584BqWfxhebUt5F0smcWF1/YZOk7HGvswfxHl6qxbQebnNr4y1A58TEGafnIM
         DViR1qOgXs0ygulS6UPxX6LuNnelwSr0IwfXrZAuOBfkvpr7x9WUIwdD0ahyBUoqsnzo
         om7tlFjTxscBSuigl0BGe5TcwqKiSZe5DTQSxq/hg4f+t6DeoodqdA0nvJIYUNc/JYbX
         DpqA==
X-Gm-Message-State: AOAM533oGK9eoyFrAL/8xQ3tbcykO2YGxJmtDWGixH+lk3T3VPvxM8Lq
        DzlP0vTnTHW4SzaRW15MVAf0lA4rGE/7DOAjQcv+nw==
X-Google-Smtp-Source: ABdhPJzjWvD542dhVukYVQQMW5U9zxcyUVZ+VZBDt1u6koTpGVlpV1NuE6aVl5uBNUoGzpd3RzJqE1naVz43ToAHomY=
X-Received: by 2002:a5e:c311:: with SMTP id a17mr31245268iok.12.1595980898226;
 Tue, 28 Jul 2020 17:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <159597929496.12744.14654593948763926416.stgit@bmoger-ubuntu> <159597952011.12744.5966486013997025592.stgit@bmoger-ubuntu>
In-Reply-To: <159597952011.12744.5966486013997025592.stgit@bmoger-ubuntu>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Jul 2020 17:01:27 -0700
Message-ID: <CALMp9eRQyA+Mbu0iLqt88wv_sVxvJ=PX735tG99ji4WqSeWkPg@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] KVM: SVM: Remove set_cr_intercept,
 clr_cr_intercept and is_cr_intercept
To:     Babu Moger <babu.moger@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 4:38 PM Babu Moger <babu.moger@amd.com> wrote:
>
> Remove set_cr_intercept, clr_cr_intercept and is_cr_intercept. Instead
> call generic set_intercept, clr_intercept and is_intercept for all
> cr intercepts.
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
