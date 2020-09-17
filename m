Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EBA26DEC3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgIQOwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbgIQOnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:43:01 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A10EC061351
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 07:35:19 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id m17so2438791ioo.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9Zju+tm0Sa6Z1fnnq43Sy6GY7DhLfZ3ESLmGY3QN/E=;
        b=ub336/6Pjba1dtAjwl9nDrPxr3O5UDSMScfz8w3nXsc+cbxPcXlbzNSpUZO6wLjw+V
         QmmGiFmxHQRMXe+u41B1rITW3Ttx2UjN2Ru5bKqCKGAU9QBNnp4cDyv+gQQwbJPtetlq
         YC+VjO5vpLotco7ZXaYJehNFxPM7E/xiqK8ORTtBdf/S8d+5Aaub8yLj8XVsURY9S/T6
         HIwbIfHesJ0gkDQuFV4F0b2tX4EbKmEImMn/XdB3e41/0ISd+rgkU0uIpfWMcha8GLo6
         BG30HcdoGOwhhodS4N0JYzsj731vuLWxgiwvjRMpOS4i2zH9SrfJwRYdX7b8Op0Of0gF
         QAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9Zju+tm0Sa6Z1fnnq43Sy6GY7DhLfZ3ESLmGY3QN/E=;
        b=fWPm8tbcqEzldwuDv9VKO0HudSBEZ8wmTrS1lgsfrn5NUQ68pCIfeGgU8+80VA+cZF
         IOEmiVb82Hyy6VbGvJEcLYZgshiMP1iajpQZg9TP5nWfnWZQ0yXOR+KDByz8OM5IJeyP
         qUX141DZwuXds+8L+lESEv7fMlRBoRuLyQxH8Vy3fVs6SU3urH8UsDqHO7uYP4W1+0xz
         PUgn8Fm/bixTqZ2wYF9WKbktKpSvNuLMzogvQZD8Qqr6HD2Yr7SYH6m50rg9pG4uvoUJ
         lt/w0bP1En1NedNogJiJFENFNSkUIiBhW+a1r8epqzhiH0j0Cd9BX8P0JBOpz6uEXzEt
         z4Pg==
X-Gm-Message-State: AOAM532HY68C2LD7IpdjA9de9QsG+FGXCVjeR/N7+TZ/cbOYZ1PVlRc6
        PDsZFx9l/2gbKAZS2bX1WlZ7xqdOD0ZOzchf+7myb8bo2mM=
X-Google-Smtp-Source: ABdhPJy+UB5fmZyJ9BpUT/adGb+iZ5z5l4/ZEp4ftuFedj37WtawOETrRx84yv/+yUikmB46SbLzaP3vuUkAuf7uJhs=
X-Received: by 2002:a5e:a705:: with SMTP id b5mr19309425iod.73.1600353318630;
 Thu, 17 Sep 2020 07:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200916191737.4001561-1-mathieu.poirier@linaro.org> <20200917090835.GB51699@kroah.com>
In-Reply-To: <20200917090835.GB51699@kroah.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 17 Sep 2020 08:35:07 -0600
Message-ID: <CANLsYkya-7-XXX8AL3yyRHEe-KgNhTZAba_O5YzzJ1KiTRe_Og@mail.gmail.com>
Subject: Re: [PATCH 00/16] coresight: next v5.9-rc5
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 at 03:08, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 16, 2020 at 01:17:21PM -0600, Mathieu Poirier wrote:
> > Good morning Greg,
> >
> > Here are the CS patches I'd like to see included in the v5.10 merge window.
> > There might be a part two but I'm not sure yet.
>
> Hopefully the "make things a module" gets fixed up to make it there :)
>

Right - that's the part I'm not sure about.

> I'll apply this later today, thanks!
>
> greg k-h
