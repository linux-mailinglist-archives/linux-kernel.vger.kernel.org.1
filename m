Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025E11F6EED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 22:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgFKUpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 16:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgFKUpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 16:45:06 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED068C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 13:45:05 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i12so2684256pju.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 13:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgcyUinwCHycLb3PS81x+KxCtAyFp6vCMYT/i4Rn6Jc=;
        b=jRr9sC/FDkOl0dzyf+kzIJ8byovnOp/JzipaTBCEV3P8CDgg6SaKYLRuzGnuEPbtKG
         rZl2thSbfJhDAoIl+DgNof2SWzHDCwMtVBdqqFGuXbWwAcdNkNNCa/DYzBywCd1fJkjX
         RlZI+keBh73n7/Z4yl57rA9/YQJ/foH1KF+Q0iJfwL6YXiyOwo5rqd6sIJeWVn955kle
         qTK3j8QhDgWMs+TSJEUIhUBrLvzrDeEXww0FlDRzb6KTN99H3lAxcyROZpBnK8tpX28p
         vJXW3U3nPlVBu2wdCKm+6WGL6rJnNAiQm27GvCeFmEwdyYMRirtVSxG1SFyn4Jg54fZx
         GERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgcyUinwCHycLb3PS81x+KxCtAyFp6vCMYT/i4Rn6Jc=;
        b=EKX6gSWYcS1D36//n71ksWL6ustAINEenQcAla1eFYlCUdMsh14qFjimU/xPiKUh/4
         cSgRoZWVhb9qnAR0INp6FLKy9hIw1RcXC6l8cjIoWnqrFwm1WLTZgCbptybhQMepHuqv
         r73up6NaDSeuNwoeMSqjTWFCT4fzda1nIiPF4WqnNsIxk8iMhhY8dBBfBiX7qAOmVyON
         EPQaXBwkwqA7oKQyfn/j2Wnx21Jc5kIZC11jAg/HEKN+cc805Oo4DEOOwz2z7+wmzeVf
         5z32Vos0bKWl7SbcHr7EYl5ACCJlJt37p/QECEgEKJH+qzb4V4teDIyX5+WEkHx0aXYj
         EKmw==
X-Gm-Message-State: AOAM5315dOdTQx20anzpCWbP812oXbole3Uzu/55rXMiN1fcCrSfgQRX
        Ml/Kpv96sa+oo913GbrUxIx/460BWQenNQi0SfidrQ==
X-Google-Smtp-Source: ABdhPJz1cnfTCJS5sVdnVW8aR2nrwlnYlXlPlyxsFMnegG0svGilLMgAO3WWmEcfzclE73W87I35jMaNhXv7xSn76pc=
X-Received: by 2002:a17:902:fe8b:: with SMTP id x11mr8526903plm.179.1591908304657;
 Thu, 11 Jun 2020 13:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200610063715.v2qrqvwtegdxdwzl@google.com> <20200610191106.2662548-1-nivedita@alum.mit.edu>
 <CAKwvOdnF9xhrs+FP4QXo6uXxgHMfHO8NvPYs1=KDE2ZyhCw2QQ@mail.gmail.com>
 <20200610233046.GA2941409@rani.riverdale.lan> <20200610233954.GB2941409@rani.riverdale.lan>
In-Reply-To: <20200610233954.GB2941409@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 11 Jun 2020 13:44:53 -0700
Message-ID: <CAKwvOd=UyEPOx5M0w+uwiYwE5fY-A5vDmuvPnWs_pK4zW4RH-w@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Improve compressed debug info support detection
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 4:39 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Jun 10, 2020 at 07:30:46PM -0400, Arvind Sankar wrote:
> > On Wed, Jun 10, 2020 at 02:27:55PM -0700, Nick Desaulniers wrote:
> >
> > No, as-option does invoke the assembler. The problem here is that with
> > -Wa, the option is only seen by the assembler, not the gcc driver. So it
> > will succeed because the assembler supports it, but it will not test
> > whether the gcc driver also supports it.
> >
>
> I think in theory another way to fix it is to just use -Wa even for
> CFLAGS, assuming the compiler itself doesn't have to do anything with
> the option and it's purely an assembler thing. Then you'd just do the as
> and ld tests.

I don't think the CFLAGS are used for .S source files though.  We may
drive assembler via the compiler, but AFLAGS are used in place of
CFLAGS IIRC.  (eh, maybe not for ARCH=arc, ARCH=sh, ARCH=csky,
ARCH=mips)

-- 
Thanks,
~Nick Desaulniers
