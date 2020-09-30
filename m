Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FDA27EA60
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgI3Nzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgI3Nzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:55:46 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E44EC061755;
        Wed, 30 Sep 2020 06:55:46 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d23so1073268pll.7;
        Wed, 30 Sep 2020 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lkmWkLx+50LSvUth/jRPI7AGPelcJcdIBHooAnh4UZ8=;
        b=XYVU4+CLhfLRo8EjLEtD42r80dI9L6KQa2htg/QTFXcQh+W2Rij3VlUpT7HFoCroz2
         AUZgEbVhrHpl84EKJpQ4bK/opkla+EdRUaw/Qd2gDzOeSsnxvZ66gbXvwuz5pRqwfsbU
         f1pso8uznGXGBZiL4OQa+UOpwUI6dAV3cZLDHk9EF0np1/myYV2BJKuVjbNLdFEK97EP
         jAAUiFAcdpA3JVepu7w13Qv35lt62etUiymR6VCIgGvEORvQJT2vbWVJwu1eqcDWrmMW
         QSxDVbdcWPf30epnB9nAaMfHySTv/1KHH6isXWB6dYT2dsJ2eaLVhpQdgulC6e3EeiN3
         AF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lkmWkLx+50LSvUth/jRPI7AGPelcJcdIBHooAnh4UZ8=;
        b=mfkXLDd5Ptip49svb7EdBzfopdWCBj44JZIDSPui31zhHXrqi63WvFxPPm0TPRaSdi
         JXHFYkSnkD5W1R2o7AR63/1advZUF/L8aJO9af0V+L7xNDSBb/Kztbgo2OmVKZox8EyV
         zSzwhhWGpbAJrdUhYu/QitYPTY8E53ILb4AJRDpFBwLGeIJ6ehWcf4VhBoBcm9KXHzPN
         Q80bSzFdEf8+TBeiWr5M2DYUubGqBb1/udWnYhJNsCs5Xxl4gSymTxg+ORkfu/tTZetA
         e1R0AEkibEjeVnHJ9vLiybMZ5ncK8ezHSNB3gDFcgQnmT6fb+AROwtfLwD1xdN/4ZOxX
         1Z8Q==
X-Gm-Message-State: AOAM530k2RFS4AmNPfRioubtgtYOnNMPKGqANi7eTZSrc4tBetl9HEnc
        uEWAC1bA+tXAt/4jBdo5YInsWKllM3WMnO8goR8=
X-Google-Smtp-Source: ABdhPJxlkomiM9Fv0b2uYyfqXoAycR7ivW5AUzx/IzG/UXy64NwjVjsxIB3HJCY2IgFU9+TrWLFEdhbsctZWJnXvbC0=
X-Received: by 2002:a17:90a:fd98:: with SMTP id cx24mr2577392pjb.181.1601474145833;
 Wed, 30 Sep 2020 06:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200929082025.51446-1-aaron.ma@canonical.com>
In-Reply-To: <20200929082025.51446-1-aaron.ma@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 30 Sep 2020 16:55:27 +0300
Message-ID: <CAHp75Vf2eCDHuqdtrCXqg7FNiDoSg5BDmtXLJ7AMuF8He9qy=w@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: re-initialize acpi buffer
 size when reuse
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     mapengyu@gmail.com,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 11:20 AM Aaron Ma <aaron.ma@canonical.com> wrote:
>
> Evaluating acpi _BCL could be failed, then acpi buffer size will be set

'could be failed' -> 'could fail'

> to 0. When reuse this acpi buffer, AE_BUFFER_OVERFLOW will be triggered.
>
> Re-initialize buffer size will make acpi evaluate successfully.

acpi -> ACPI in all cases above.

Fixes tag, please?

> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>

Code is okay.

-- 
With Best Regards,
Andy Shevchenko
