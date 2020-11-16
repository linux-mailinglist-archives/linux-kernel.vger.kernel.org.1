Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083E62B53FB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 22:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgKPVts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 16:49:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53655 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgKPVtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 16:49:47 -0500
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1kemNd-0006NZ-8L
        for linux-kernel@vger.kernel.org; Mon, 16 Nov 2020 21:49:45 +0000
Received: by mail-ed1-f71.google.com with SMTP id d3so3708665eds.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 13:49:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=umNIoM2617jBm/kSow8UcR9m5NpkXB/CDpm1QO+O5AE=;
        b=L2bh04S8KWxR6cubsLIA2cThXCuL5mGubyctMnNCKwA8SozE1LIv3lzmv7GFPgEZwI
         4V1pKIWrdRef2+YAicFwHrmaLkrPWh3+AP+uMNjPwJ/5QK2GMKuW8TReiS4IM3UNOFyT
         rd5ZYdP/4PU+zqZ5OwMctKLQMkK2UD9X5Hr2CEX+1dTlakk6Vwb3G1W9e3UYrPmrV+bm
         oxmh2znKkuyv2eiXo8rRdRmjrsM60j8KR+kt2fEYY5KxhuvtnIhkIYOqPXsAgoz9s7Y+
         UuWZVn9f+KNfM+dcoW1NXcnNX+mI6kS1h/aNG0g9eXKghgsSqf7IVCFWCskwVuR29qTX
         sPxA==
X-Gm-Message-State: AOAM530QfCbidFJm41W2+h0510vC4vL4o2n3u2P8PQlxPJiv+H+h7GYf
        +ENSf7FakE1TjFZ4m1PKNwcXDpvdW2BpU1R27moVnTRtUOVqtz4+GX5vfLuhrbN1ggKDkkk2V6t
        JS9E/WviGtCN5vI6SJWHO76jjibVxG3hWa1wPE3tQgNjnyuo+E59FCYb5Og==
X-Received: by 2002:a17:906:fcdb:: with SMTP id qx27mr16916797ejb.470.1605563384818;
        Mon, 16 Nov 2020 13:49:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAp96hr5JgdqVnl6r62CtZZ/vc6C3LNUKt1YzaSo0TRa1TeoieSyEzCGC0UHu4wHv/eCeV/8tRzuALD2OY1A4=
X-Received: by 2002:a17:906:fcdb:: with SMTP id qx27mr16916769ejb.470.1605563384635;
 Mon, 16 Nov 2020 13:49:44 -0800 (PST)
MIME-Version: 1.0
References: <20201114212215.GA1194074@bjorn-Precision-5520>
 <87v9e6n2b2.fsf@x220.int.ebiederm.org> <87sg9almmg.fsf@x220.int.ebiederm.org>
 <874klqac40.fsf@nanos.tec.linutronix.de> <87lff2ic0h.fsf@x220.int.ebiederm.org>
 <c8238524-4197-c22d-7bae-df61133fcbfe@canonical.com> <87a6vhht71.fsf@x220.int.ebiederm.org>
In-Reply-To: <87a6vhht71.fsf@x220.int.ebiederm.org>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Mon, 16 Nov 2020 18:49:08 -0300
Message-ID: <CAHD1Q_zk6Z841E1yAH-GKpDXQ=32YPb-R4Exo7UcNHnTY3bdqQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>, lukas@wunner.de,
        linux-pci@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>,
        andi@firstfloor.org, "H. Peter Anvin" <hpa@zytor.com>,
        Baoquan He <bhe@redhat.com>, x86@kernel.org,
        Sinan Kaya <okaya@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Dave Young <dyoung@redhat.com>,
        Gavin Guo <gavin.guo@canonical.com>,
        Borislav Petkov <bp@alien8.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guowen Shan <gshan@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Streetman <ddstreet@canonical.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 6:45 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> The way to do that would be to collect the set of pci devices when the
> kexec on panic kernel is loaded, not during crash_kexec.  If someone
> performs a device hotplug they would need to reload the kexec on panic
> kernel.
>
> I am not necessarily endorsing that just pointing out how it can be
> done.
>
> Eric

Thanks Eric, I agree! I think if we use something like PKRAM (a more
dynamic approach) we could have the PCI hotplug path updating the data
to-be-passed to the crash kernel, so the crash kernel doesn't even
need to be loaded again.
