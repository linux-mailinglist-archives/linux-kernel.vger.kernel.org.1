Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9488E228A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 23:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbgGUVKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 17:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgGUVKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:10:31 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11045C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:10:31 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id q17so42692pfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZhFDYa4FfOvvUM9wrXOQAjhc4Tt6wbIOg27vSWas00o=;
        b=r4drilcsOVRuoawrOpfhw+dymjFUEvUJ8LUrnZdDYtwr4SUrvK1TOXNWu2AexT/Meh
         uDWLtU6Do3cnH41/8Uo9sOh+kN0BKt68ziFJ0/S5OUoIoMatggCbTlbf2Pi04mWnZ7p5
         4Jo1rs/LcGOzKFLAIFAg5As8aYZatAvppuO4sgZAjURrnsuT8BR3JdG3URMdy/rgyUkp
         8Opjs5SX/eadOJhi466+ANacMI7Q4BNFuT6apL8uVaSLfHOdGLvuuzOwmMYCUyxtfz67
         SKprIW4A9lLUkLHJtDMB8LKNZEcN6RC/dMDUvNs6CEH4/CIyCBtOH3jxyYUnTTRr1aJv
         9Bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZhFDYa4FfOvvUM9wrXOQAjhc4Tt6wbIOg27vSWas00o=;
        b=C+rbSF/3shWsYvsv5JWfgFyz0/fbgN32mU0WNzbWn5I7gFj5noZjfM/v85IjCslqiH
         aEPwsXOwa8Q1VBqPGg8xer/LMn19ZxKlLN/dX629hTpGQVdb9r6HnnTwGHw1fq0KF9qm
         0HXLfwJUtXubshEP8pG+Nbh7Olqf8HuopCyTlWnbgFLmX8uYsLw3kKulpoaDWniAaVQF
         5sbMgiYtvHXRf28RHMcrkLIi9l/Qv+H9fX/sleECawq5EMlPeJuQ39B/OVRKbSKiwiv9
         GpYWLNSIeiZ3wsTgW2i1/okoUWEa/Vb+w/to3kzzptLRmkOe4VoMIdpJMvQzSkDSscLF
         dUGA==
X-Gm-Message-State: AOAM5310RsGLIewzf7etSW8zWRMzJjm8knlqv4FQV1aocSdbt2PYvDBT
        eAcwSfnTitl18H60rmXb+YA43Johqk3r0ftB7EBErw==
X-Google-Smtp-Source: ABdhPJwoWRbs5GZLbVtYueLHOUh103u+TTXn30QPO7TztEYzA+lP7eK9C1X4VZur6jmAkEvULmrS9QZgaydLUbsPVTc=
X-Received: by 2002:a62:3645:: with SMTP id d66mr26786035pfa.275.1595365830665;
 Tue, 21 Jul 2020 14:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200721210044.15458-1-rdunlap@infradead.org>
In-Reply-To: <20200721210044.15458-1-rdunlap@infradead.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 21 Jul 2020 14:10:19 -0700
Message-ID: <CAMo8Bf+Pnkwu59vhwz21K_qoMHn+44AW3YUmO53dZ5nROaDdzA@mail.gmail.com>
Subject: Re: [PATCH] xtensa: initialize_mmu.h: fix a duplicated word
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 2:00 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Change "The the" to "For the".
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> ---
>  arch/xtensa/include/asm/initialize_mmu.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thank you! Applied to my xtensa tree.

-- Max
