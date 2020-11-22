Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEFB2BC681
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 16:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgKVPcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 10:32:46 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44461 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgKVPcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 10:32:46 -0500
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1kgrM4-0007TO-01
        for linux-kernel@vger.kernel.org; Sun, 22 Nov 2020 15:32:44 +0000
Received: by mail-lf1-f69.google.com with SMTP id m12so5488838lfa.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 07:32:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9evwnH39CJFfcj3FvZu2zi+TDnPYv0kuormvhxYBAA=;
        b=If7Fl5aKt8L3ZIsP0kpVh/oyikH8Qg57xkiCaYFXzIoaXlXHgAfb+L+SiEfL4NZ/1n
         VRoX41o2rKLHxwoUG2lPV5YP8eRvjQUTiTHIq0rBGP7CAU0fo7XxhKN3bh90ldJnSyHz
         OdsRPpzlpi6fCHcaGFNHhSMzAns3oYwv8z0rxT9aZ6osMrBAuy5TovufLr0n1nD2Zjn+
         aWl1NoAEyMmRLuZPaGQcSDZtX16o7vzE+vahMaeukthwnmGBTiUYMIwM7uG19VmczMtF
         HqbnUVKnV4QvfplNnWgT+pAAmaqmhJ7KY8b39R1LnifGny/o5jyxqMAyxVmIjszP8HrN
         xZzQ==
X-Gm-Message-State: AOAM5302VadExYQ0UPh8WBL9rRsjFH1Uj4krFixEkOFYCvZxfO0bgQEc
        XLXle2ZHoYqIFBKyyv8pYgG0TzTid3naAJmQXvEVI1J2JMIS/SPDBjsjeXO2PBs2fwHa2ymk3se
        i2yWh0v1EzEsK4bumIe3BzZEaENHf2Ii2C74VYLYiy0U7cSQj/ApYNKGZ5g==
X-Received: by 2002:a17:906:c244:: with SMTP id bl4mr19269100ejb.430.1606059162568;
        Sun, 22 Nov 2020 07:32:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnEWK3w+i2158MoX6RM4KiZ/7sCV4gPqKTsqAdtmrUEEmnYH/vrzA+/LOucs/sVWiFMzq0TUHBOTV4uu1By1Y=
X-Received: by 2002:a17:906:c244:: with SMTP id bl4mr19269067ejb.430.1606059162349;
 Sun, 22 Nov 2020 07:32:42 -0800 (PST)
MIME-Version: 1.0
References: <20201118232431.21832-1-saeed.mirzamohammadi@oracle.com>
 <CACPcB9e8p5Ayw15aOe5ZNPOa7MF3+pzPdcaZgTc_E_TZYkgD6Q@mail.gmail.com>
 <AC36B9BC-654C-4FC1-8EA3-94B986639F1E@oracle.com> <CACPcB9d7kU1TYaF-g2GH16Wg=hrQu71sGDoC8uMFFMc6oW_duQ@mail.gmail.com>
In-Reply-To: <CACPcB9d7kU1TYaF-g2GH16Wg=hrQu71sGDoC8uMFFMc6oW_duQ@mail.gmail.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Sun, 22 Nov 2020 12:32:06 -0300
Message-ID: <CAHD1Q_yB1B4gu7EDqbZJ5dxAAkr-dVKa9yRDK-tE3oLeTTmLJQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] kernel/crash_core.c - Add crashkernel=auto for x86
 and ARM
To:     Kairui Song <kasong@redhat.com>, Dave Young <dyoung@redhat.com>
Cc:     Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        John Donnelly <john.p.donnelly@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "# v4 . 16+" <stable@vger.kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?Q?Diego_Elio_Petten=C3=B2?= <flameeyes@flameeyes.com>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave and Kairui, thanks for your responses! OK, if that makes sense
to you I'm fine with it. I'd just recommend to test recent kernels in
multiple distros with the minimum "range" to see if 64M is enough for
crashkernel, maybe we'd need to bump that.
Cheers,


Guilherme
