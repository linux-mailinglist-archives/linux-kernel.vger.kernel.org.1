Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC9D1CB958
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 22:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgEHU4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 16:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgEHU4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 16:56:54 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C017C061A0C;
        Fri,  8 May 2020 13:56:54 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w65so1552079pfc.12;
        Fri, 08 May 2020 13:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zlm78NTnUQgNYB/Y967ROyt+Vq6Ourlp2uSc1BOpBws=;
        b=M0Q9kTtNIZEe1jIjMA66/OIdnRkPBbQmv8ljANvcY0f8o5u0x2faUnJ6RuiDVnOogJ
         AZMu4rNisN6N20x7HUsPvfqyLbVKklvH0F1W4pzLm1MKs8v8RQKA6pgoeIfwLoqeg718
         UtUJ48rWMMZqrgWXdWcSZe3nY6vlDd94hg8uTaYXZc7beM9AdCXXmAOJ2GW30ETN65FD
         TOZ4tAx8+5NoTgNeKEmbR7Wy47gjeN6qxrA6gbJYfGatNkusS/Itn799v4Y2hjZ93CNH
         hlZ9LBEFqrN0W85cWQAGFgvfg7/W5nAXtacoeWpBEdbBrZBVQLvQmICPy2RbzX4/Sir5
         lY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zlm78NTnUQgNYB/Y967ROyt+Vq6Ourlp2uSc1BOpBws=;
        b=ltFIAZ1II/i2Dx32YZ83Wt/rv6XCQGZq0gQBwt6YQeLcVjoJxk82QLvCc8nefBm1rR
         o9yBmXwWn4l3Kcevz3bTNM/8Pc28N7Z1Cgrd8ZP6vJuNyOSXfpTJ92OUg8dZvbNL6Y8X
         TK1CiiYS1kcy6BhTxkOmpDmWIc09D/HY1AR2LVwqiDRBY/IUX0L9AcnAruPjIdisF6TK
         gGV6D31G5EHifRr+nTtAsMfv9M4VlrMtEoxTxvf/ccHCNIarkxuczOZIQoyNIUWmL/Jn
         SK/LVAeIEAYIv8Vh2mmlRGVZwCbLURVcfjg1bkuH+m0lQMGgp92hm9jscIlkftlN0Xm1
         3QaQ==
X-Gm-Message-State: AGi0PuYL8zgMkD6R5zRhLHdNdOlM+XiguFBDyvAFV8g7OT9kR4LWo4H5
        NisZtUi3u6CxxO6o2bMZdA542+BzBKoY9wJrqdc=
X-Google-Smtp-Source: APiQypJh5cAMBBfNusXJPVcVDn9Dbj0bYJKdrDRWrc0mlA/7CUTo/0H3snaYhe30TjSHF9rjzmoNpoLfAM2489rl8dk=
X-Received: by 2002:a62:7f11:: with SMTP id a17mr3486614pfd.36.1588971413629;
 Fri, 08 May 2020 13:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200422220559.99726-1-hdegoede@redhat.com> <bcb4d40a-8971-22d6-959b-14b2d329cfd4@redhat.com>
In-Reply-To: <bcb4d40a-8971-22d6-959b-14b2d329cfd4@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 May 2020 23:56:42 +0300
Message-ID: <CAHp75Vceqb4tpM_G7hcg2RWF6Cp+P61NiiYfQsf9tr8vtFJGHg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: asus-nb-wmi: Do not load on Asus T100TA and T200TA
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 10:54 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 4/23/20 12:05 AM, Hans de Goede wrote:

> Andy, Darren, I see that you have already added this to the for-next
> branch of linux-platform-drivers-x86. I'm not sure what your vision
> on forced pushed there is. If forced pushes are ok, please drop this
> patch. If not let me know and I will send out a revert.

Forced pushes are not okay, but we have exceptions in some cases.
It would be done here, but there are complications, i.e. we have
already immutable branch merged from MFD. Of course, I would remerge
it again, but I think we better not to do this right now, so, revert
seems a less painful in this case. Or, if you have already done
something better, than keep it as follow up improvement rather than
pure revert.

-- 
With Best Regards,
Andy Shevchenko
