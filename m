Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8074027235B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgIUMIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgIUMIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:08:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06476C061755;
        Mon, 21 Sep 2020 05:08:48 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kk9so7032910pjb.2;
        Mon, 21 Sep 2020 05:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+jFV0xM8cKU1CDUupOoLQo0KGan04YFIOb5P0R+Pk4=;
        b=QCDxqhH2xoJZyObLN3Z3c4a6gOel1Qs+v3ZvzHVCXmbXY465eqb3BR2BM6KiWqoYYn
         F03mjr3iY/tZf3vUW88Nj6UntMinx5Xo1e+v9EFRQGwVJzz7A4JhpHpmzl8j/fTDcRJQ
         aWNkGwzueh2ocNnz3kStWhu9aDCVHwGXArF+tH621eUKSaa1eT6bSLBiVNlas5he0BKw
         69rIUl0/hyWKJKpwaGFo+5+rr24Sg9r53kxIYKc666B9DUtLZdTIeeFSGBOncYK0Wu6o
         21orv4HeDmL55pLjDjE/PExQ33/Zw7EzaHBDmAf4TowxWTzx2Ek3ocwDdOmZj1R5HTAa
         f9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+jFV0xM8cKU1CDUupOoLQo0KGan04YFIOb5P0R+Pk4=;
        b=lyRrSY+iZv+pZADb0xXIxeUTGsDauscGF1TD3tS3xDmfdmiaQcaMVr+OUS+qlYwEyu
         gpuqV2PCrXJJEVhZ3/6IozICyWU+vbFRkTy/eTnsHk7BnU2O1uovl2aRBjvxAsuVXkwd
         ThqQlWsS4pscpx3WEsz1fDT1mVGjSlhu8N66stSq5bpmGck/sPdLi+apRdEZaj2SRdhH
         7c10hqvMhKYnxK7iz+pNz7X6ij5AAOFvjhc2w2DSoLtCgsXygkiGiktZxYCyvwbSr+05
         HtUqmwd17srAD6VF7Hbw2nKJ/NB5VqFx3AU/t5H3m4N0rMVKjT/fO54U3mEXrq+//01U
         vRgg==
X-Gm-Message-State: AOAM532qiG8GLMIhnGAwUBEzr9fvv217roqpPKSGPM8REW6JXHZaL0kJ
        4OkYZsdfqOQiV4s86k6RgMkcklHYPhjRIkOT5jq7BQ9SqmqVqA==
X-Google-Smtp-Source: ABdhPJyJQYiRrsrOID7vINf6ruUI/FciiVP0aqfOL9AkOPGwkJ9cqXNkDjbSOWNI+J1950ZEFjN5bophdUtjIxnaK3k=
X-Received: by 2002:a17:90b:fc4:: with SMTP id gd4mr25047068pjb.129.1600690128041;
 Mon, 21 Sep 2020 05:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200917065550.127400-1-divya_bharathi@dell.com> <001ba7fe-fb88-cbe3-c413-1c6973b9e786@redhat.com>
In-Reply-To: <001ba7fe-fb88-cbe3-c413-1c6973b9e786@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Sep 2020 15:08:30 +0300
Message-ID: <CAHp75VcgVgSH6CLr78wfoK8fQVGk2g1x7CK+pAqmMcUDXHoa8w@mail.gmail.com>
Subject: Re: [PATCH v3] Introduce support for Systems Management Driver over
 WMI for Dell Systems
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Divya Bharathi <divya27392@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Divya Bharathi <divya_bharathi@dell.com>,
        mark gross <mgross@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Prasanth KSR <prasanth.ksr@dell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 2:38 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 9/17/20 8:55 AM, Divya Bharathi wrote:

...

> Now I see that you try to correctly deal with strncpy-s nastiness
> everywhere, but please just don't use it all.
> Not using strncpy at all is much better.
>
> A lot of the strncpy usage is hidden in:
>
> strncpy_attr(char *dest, char *src)
> {
>          size_t len = strlen(src) + 1;
>
>          if (len > 1 && len < MAX_BUFF)
>                  strncpy(dest, src, len);
> }
>
> Why is there no warning printed when the source string
> is too long ? Now we just quietly throw away the
> data, which seems undesirable.
>
> Also wouldn't truncating the data to fit in MAX_BUFF be better?
> (honest question, I do not know which option is better)

And don't forget new compiler warning if it can prove that string will
be NUL-terminated.

-- 
With Best Regards,
Andy Shevchenko
