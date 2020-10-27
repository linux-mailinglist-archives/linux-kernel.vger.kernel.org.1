Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF0029C34E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1821535AbgJ0Rol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:44:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36781 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896213AbgJ0ObC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:31:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id x6so2018473ljd.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 07:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9yAnJkcJq8fJ842gCRIxyhnneLlwmBgpRa2BY7duk18=;
        b=JIM8871i1dAY6MSJz2tnV/FaZI+lJY9QwJ+/gDWCvRVezbv2K7KuEkac0kz9L4TnP+
         up9BbSX57/v+XFqrwe9Nk6H3tY8lSWitihitPvKIbv/oYdwnx9UbEhaTF7lwTVSiWIgD
         ilkRy+vADEKZklPaM92sf7U2ZDEvt4vyQe17Hxsa1D9yAAFqXvrXeAG2Sryk8l69zJde
         pqvLQX2h+a+SXWzUCKBuRQLJgq79yjMzdWMayJKWo9486eawdqlCCvRGx82m7o4ryXkg
         Z8XiUFO+bNowsVwe89aLNK8ALBpx8ImxxN9i0ZU5L8514D85RUZwUUjty5eqn4+jgs2n
         dH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9yAnJkcJq8fJ842gCRIxyhnneLlwmBgpRa2BY7duk18=;
        b=URGDJwy3zNNDC974+U7B3JEdMLKypMuCzQGGxvuFXKfu6K4cA037fdgZkMVIilKv9w
         IM56LrgKfAVSY8WlLaRMC4cHwMOEjhMfsHag2f1UsEcKrBLx7Lv5T8kLwv/6QlW07Gd7
         qNcxvDOW6WBVfjqFQM09OQRmdlfE7twarYhrCByUje6rDpFzIGpoNoxjLNqT8XLbG62b
         xUmHKf5RgjvTizzsIjOaNI/RnDM/X2+Fw4RbioTOg+hyV0G0lEV/2i4QTLoc63JbhI7+
         +GMB5WjKdgklRwpIz8+VZC+ZON1pb1lSvbx26a2wipgLamDdASYoc952JTKR2BD1RgjC
         CI3A==
X-Gm-Message-State: AOAM533LwKT1HXXgvw2ql0Aypm8Jl3S0J0Nqw0cCE0z1TBHIGj2p5vwQ
        qZsHi/9QZsm13DEpDVTS8EvKZx55aKxk6A==
X-Google-Smtp-Source: ABdhPJxE9wm01oT28amSRCIGKy3EHdyNrPGPuB+JBcPp7uz1dYSw974Isdqrkp2wPm37df4UQ++3rA==
X-Received: by 2002:a2e:6a19:: with SMTP id f25mr1306896ljc.386.1603809060636;
        Tue, 27 Oct 2020 07:31:00 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b10sm191716lfd.263.2020.10.27.07.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 07:31:00 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 54474103677; Tue, 27 Oct 2020 17:31:02 +0300 (+03)
Date:   Tue, 27 Oct 2020 17:31:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: RFC x86/boot/64: BOOT_PGT_SIZE definition for compressed kernel
Message-ID: <20201027143102.ugco5dmixu66fjsc@box>
References: <20201025004158.GA767345@rani.riverdale.lan>
 <20201027124007.xkkseswwgerlzlsl@box>
 <20201027131617.GA1743199@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027131617.GA1743199@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 09:16:17AM -0400, Arvind Sankar wrote:
> The #PF handler is already there now with the SEV-ES series, but I agree
> it would still complicate things. It's simpler to just increase
> BOOT_PGT_SIZE and make it unconditional (i.e. bump it to say 32 or 64
> even if !KASLR). It's @nobits anyway so it would not increase the size
> of the bzImage, just require a slightly larger memory allocation by the
> bootloader.

I guess it's fine. But I'm worried we leave the picture in the same
fragile state. We still rely on the magic number.

-- 
 Kirill A. Shutemov
