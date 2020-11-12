Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAB82AFEE7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgKLFhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgKLECN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 23:02:13 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DDDC0613D1;
        Wed, 11 Nov 2020 20:02:12 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id q1so4024831ilt.6;
        Wed, 11 Nov 2020 20:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U+8jpjvx6PAYwsv1dXTnTLiw8GFCxCK+HvTqDAev6w4=;
        b=a8wC6MGMvbtOwRwEqZ+bZ1sl1CkbTUaiQmrEtWsxDvDAjzqe3VbbnpcJaJrcKecJuK
         Fk6cFG58xCPrj6NE8tF0zuGDWOowgbXLNeiA77pz6trKRETvUEGhVWaDWKPhFvkqe078
         RxxIgCtxs29YzaoW2sRkK5+4Rc7HnYX29VZVLRmiOHYg7yTPjc/Dm+LssRvplsVmw4mP
         7njwoiEeY1K84OppoLt280JYE3KL7SCjHX2xAgfgvGk3z9XmDsKTLUSSgjmS8eFWfuJy
         azUziBo46TD/0pVBn0hDSE6NLNQsR4nBg6NYKQCJ2joWKigsgOjGpkZ4/q3+HEtX9Kb3
         ikiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U+8jpjvx6PAYwsv1dXTnTLiw8GFCxCK+HvTqDAev6w4=;
        b=APDuR8icKO1agoIdFU9qlJyDiQjCKk6YDEtBMP5qHkoVo1Vupjt3/8N08QprQDQIUW
         TdM/8OhXCzujlE9GKdr7SAlS444JyaRvYW5txDIXX1ifScnuhlfkpOC+cb7oX9cFKwj3
         XJotbs8Ugqgwe7m9hu04tdiTEjXmk0NktqMQfaWIe45fQVIq0M8Ueea/W6TZ6uZ8LmI1
         ZblT3emXjBeVY7r9bl0UkId9eW2AuEp/Bare8OkhY7eZ7hHFVAdihMH55QPV5bXeYxU+
         rC49RyYeXOJcAMwgMWrZbR0QASOBgn+eLSOOu7FvPHJEooiiUcMKwuxScxBi4gOZGfit
         pgVw==
X-Gm-Message-State: AOAM5330r8iA6H9zLdylO6CRjNTsubLt6q9+3P/2UWo0KcwTdPCWizxn
        M+/x0pbQL0/i6mD7FiBYUirBMhfABRCtbAif6gQ=
X-Google-Smtp-Source: ABdhPJyHAbpI5VZ+WCYeQcIuPdX64cIeiZk0VZEGRdy1BKycJnmkGyJorCWba2P10ce/IdBwEtYcTz6BoKlhp+e0524=
X-Received: by 2002:a92:5eda:: with SMTP id f87mr23102667ilg.131.1605153731335;
 Wed, 11 Nov 2020 20:02:11 -0800 (PST)
MIME-Version: 1.0
References: <CAGaOi3Z5ezAiBB4-YxUa+so1s=PnVzVsfw9rAs3CGKExJHD-ow@mail.gmail.com>
In-Reply-To: <CAGaOi3Z5ezAiBB4-YxUa+so1s=PnVzVsfw9rAs3CGKExJHD-ow@mail.gmail.com>
From:   app l <lipc198702@gmail.com>
Date:   Thu, 12 Nov 2020 12:02:00 +0800
Message-ID: <CAGaOi3ZLiVUBaTX=humCVYp-tU1L61iY64HUCShfSeY38SZZsA@mail.gmail.com>
Subject: Re: Question: gadget: How to realize uvc and uac composite function?
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Through the debug, the problem has been resolved, it can be recognized
normally, and the windows driver can be loaded normally, thank you

On Tue, Nov 10, 2020 at 10:28 AM app l <lipc198702@gmail.com> wrote:
>
> Hi,
> Version: 4.9 and uac1 driver is V5.9. I tested it based on 4.9 with
> backported dwc3 driver frome v5.9.
> 1. According to configfs-usb-gadget-uvc, PC(Windows 10) can get ISO
> data normally;
> 2. According to configfs-usb-gadget-uac1, PC(Windows 10) can  install
> audio driver normally(AC Interface,/Captue Input terminal/Speaker);
> 3=E3=80=81uvc+uac1 composite device, PC(Windows 10) can get ISO data norm=
ally,
> but PC shows that the uac1 driver installation failed(AC
> Interface/Capture Inactive/Playback Inactive). AC Interface/Capture
> Inactive/Playback Inactive all show the device cannot start code 10,
> The settings of the I/O device are incorrect or the configuration
> parameters of the driver are incorrect. Through the USB analyzer to
> capture the packet, I found that the Index value seems to be wrong
> when PC host to get the descriptor. The acquisition is Playback
> Inactive and Capture Inactive, and the PC did not send the command
> packet about uac1. It is difficult to debug it.
> I suspect that some parts of the uac1 descriptor need to be modified,
> but I don=E2=80=99t know which one to modify.
> I sincerely hope that everyone can give some suggestions or related
> patches to help me. Thanks very much!
>
> Regards,
> pengcheng
