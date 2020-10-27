Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20C129C92A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372218AbgJ0Tob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:44:31 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:34894 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503729AbgJ0Toa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:44:30 -0400
Received: by mail-oo1-f68.google.com with SMTP id n16so625932ooj.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/b5O6FPaHNp9MQasn/J3mPbI+olxJ1Djuu2IqydSnVU=;
        b=EMb0D/Ny5cL/MFLCU7G50YrlFojujNMKsnbTEnpmxixf4rsp0EbJbHrjHy56RQuZoM
         wHsKPwNbhOCUq+2ndA+xma40qTBz2VkpcfFucDsuo15QHHnMMOF64/eRExlicLs9FKNy
         RrWFVDk4e5MC51Oizck+tUce2A2n4acHt+MrXmpbHyLIq1Xk69o/nLHKcQRi8Q6uyx/X
         GOinnK57UTYzxER4pmViMZJE/6e1PI/Xl+xEEeEuyjEqm/9ZVSOR2pvNbWpVScdUwk65
         GyQ4e9xZVj7w8jhJdafqCcYZmWXDeBCkCgk7xVqFhS2CXcJYmxwuGZjfVIsLuhinzx/o
         AsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/b5O6FPaHNp9MQasn/J3mPbI+olxJ1Djuu2IqydSnVU=;
        b=KNmnh+wYYOpzLpVKoKLikQZM4QnzM+xwMXkhh/19hJL0ceV28QEp0EzVX4nDe/af63
         LtQp7+ajZSobx+dfKI2v+t7pl/RUiT0Fi5KzgWCx627CMYd5MQEmfxezZrNDNqCd5IEr
         3k4nPtjTmaeiMyUP5wfBRBIdtY+4/qThnI/v2ecH99h2DEgGVPGJb6s0gWuyqTlBQ69+
         hAjO6RCP5gNKLfb6+LokHNT+VFdynaiBJhpryQc4htIcHfXNgm3YYY96M0vyghkuaGFB
         jjbNNe0TwGuT2K5WkfUb6zGKDn7/oB+aaW6keWgFJYBC3QCSs71o0nxFkOfy4LQRZ7Dj
         QtRw==
X-Gm-Message-State: AOAM531yWPF5sEiCNBf21BHuS3F9HFwiCUJwQZl1n1ffhoTzF3dm1jUO
        6swXNPLRdCXqqedjDLVKBQI1LH4PlZoLXoXONno=
X-Google-Smtp-Source: ABdhPJy+3jgkpd3OG4prEhXki/9d9tUVRu13ucOY50PK75BmTVXh3cLofjvOES5m/c1qe173nxTEOj6oDoNqjk3YFME=
X-Received: by 2002:a4a:be14:: with SMTP id l20mr3023952oop.27.1603827867842;
 Tue, 27 Oct 2020 12:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201026160825.3706944-1-arnd@kernel.org> <20201027075655.GC22487@lst.de>
In-Reply-To: <20201027075655.GC22487@lst.de>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 27 Oct 2020 21:43:58 +0200
Message-ID: <CAFCwf12M5Hk-_7g6bofLBDm4EunJmd7C_wPFU6U8fHOyqL_Bxg@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: fix kernel pointer type
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Zhang Li <li.zhang@bitmain.com>,
        Ding Z Nan <oshack@hotmail.com>,
        Tomer Tayar <ttayar@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Dotan Barak <dbarak@habana.ai>,
        Moti Haimovski <mhaimovski@habana.ai>,
        Lee Jones <lee.jones@linaro.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 9:56 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Looks sensible.  Btw, I've wondered for a while if we need a gen_pool
> variant that works on kernel pointers.
>
> Acked-by: Christoph Hellwig <hch@lst.de>

Looks good. I'll give it a spin in our C/I just to make sure.
Assuming nothing bad happens, I'll add it to my -fixes tree.
Thanks,
Oded
