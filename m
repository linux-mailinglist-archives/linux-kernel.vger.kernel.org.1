Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F20B27861B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgIYLkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgIYLkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:40:22 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E5EC0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 04:40:22 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id nw23so3206774ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 04:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bibwz6xtXc59LlPlbNqZb06QG0WOc82EPNG/m8AOWgM=;
        b=dSc/KCtznv2Nneu9E0L4E6GZC4phzWtLtucZD26WfnjbrQqAVDDyDuLH3ReTVHBRrb
         j9UOuSPctci4XvnfIEs3V4w0RfmwW+h9FfXeORqfzJEEPLqMSC9/BQXVOvrl2SmZknhE
         yrvruWYm18xxeI13FqyzFRWrPmHrWCDerMMLvrehr3rBZgtnhtPEmuc1iwvnUHpXMwK1
         7zbGq7zUD7+0aMDo1TJVn1OsQf7wOz2xb1ftrwHos58uzo6ZMvFZiTYVaB9BXnP355FS
         ySdfqnrSSQXsBoSUnyr1hKbRqD9HG805rkMwEVMcPRiU33N7c2sD+9pphRyaHk/wxClx
         JAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bibwz6xtXc59LlPlbNqZb06QG0WOc82EPNG/m8AOWgM=;
        b=kMFrah3gYQNnCxkDXeE04ZXSN95qwu93AO56A9MpwvHiJ1JDh64GUJWmAopzpX+ci9
         7KBs22SpHivcegLFG1X2E79FaE+sa0WMUkI135tLkNKQ44I6KXI/5qPgmZ+Z1Z6Y9Kom
         neu6XJ/TsVxrvVL2g1WkOxwl6P+D26V0Gmgp6eOR5YjXUF+6knhx4hSpfhiCkwYEEHNo
         UHEj6T7GgkbWlto7rnDGAcWntfOmzk0THVFr3E9huJUkSNUDfVxBi0P5emA3cjyRCabR
         0QpCshkBCOdM1GbzRpWhcNjzXDrhpHfrVUb5OupfHDgW/8EedwQ7k9ckPjx/HgCgAVzN
         ossA==
X-Gm-Message-State: AOAM533q21hzfbqAzTW8xW0TCRNMk/YDO7FJbfj8SOLpAqYE/ScwrmsR
        Ax3xUanPrSnVnPnICpgwfB5fXgaDunbmbrDrvDq71A==
X-Google-Smtp-Source: ABdhPJwn2e7xjK7G36KT8ZSmKFE3rfPC7d3IYHiCVDf7fxLGWKu8DM1qXuYm/+oEWtbYS/rR/2Q+AfvcPV71RZviaPM=
X-Received: by 2002:a17:906:49c6:: with SMTP id w6mr2170357ejv.445.1601034020713;
 Fri, 25 Sep 2020 04:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200924113842.11670-1-brgl@bgdev.pl> <20200924113842.11670-9-brgl@bgdev.pl>
 <20200925090329.GZ3956970@smile.fi.intel.com>
In-Reply-To: <20200925090329.GZ3956970@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 25 Sep 2020 13:40:10 +0200
Message-ID: <CAMpxmJWBSwofFy94mHZWB2mdvHGStYp5oLDZp2M+wO57t40HSQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] gpio: mockup: use the generic 'gpio-line-names' property
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kent Gibson <warthog618@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 11:03 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Sep 24, 2020 at 01:38:41PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > GPIO line names are currently created by the driver from the chip label.
> > We'll want to support custom formats for line names (for instance: to
> > name all lines the same) for user-space tests so create them in the
> > module init function and pass them to the driver using the standard
> > 'gpio-line-names' property.
>
> ...
>
> > +             if (gpio_mockup_named_lines) {
> > +                     line_names = gpio_mockup_make_line_names(chip_label,
> > +                                                              ngpio);
> > +                     if (!line_names) {
> > +                             platform_driver_unregister(&gpio_mockup_driver);
> > +                             gpio_mockup_unregister_pdevs();
> > +                             return -ENOMEM;
> > +                     }
>
> > +                     properties[prop++] = PROPERTY_ENTRY_STRING_ARRAY_LEN(
> > +                                             "gpio-line-names",
> > +                                             line_names, ngpio);
>
> Forgot to update GPIO_MOCKUP_MAX_PROP?
>

No, there are still three properties: chip-label, nr-gpios and
gpio-line-names. Same answer to patch 8/9.

> > +             }
>
> ...
>
> > +             kfree_strarray(line_names, line_names ? ngpio : 0);
>
> Perhaps you may check for NULL pointer in the kfree_strarray() and drop ternary
> here?
>

I did in the previous series and you told me to not to. :)

Bartosz
