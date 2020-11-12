Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765662B0331
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgKLK44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 05:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgKLK4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:56:55 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4B2C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:56:53 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id t5so3614004qtp.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TGJZQaTm5BTG1XEJ4L/JYj5sReja1I+vS6/GWAWRDTw=;
        b=onsk+2Q6DpXnv1wkqywSaLWgoiNRnp+BH8Cud3m3ix4NLhApe9S8U01a0ZpgYRO2az
         14WSirBOauLhGkDfu/x+gvpbUPCsos7H5oe8f1AEaHpWpb2pv+mj7WZhX9MDESl4/2oA
         lRwvCYMFz22MDHUFqob8+flsq4xWINo88lNUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TGJZQaTm5BTG1XEJ4L/JYj5sReja1I+vS6/GWAWRDTw=;
        b=T+ag1dtOXEscwTLVFpgUfMBig3OL9MnpAakvHJw5rZnvT0Dr4aciQ1jcP+PMI4qaqc
         Xq8Ha1LIp9zlqweIeaand6x6/zNbjN6GR0YHUVBz9Hp7/mg5lR0lp44JxOQXTn0xPjW1
         mASq2m0TCTdJTHAxQdpzew5pgV6xCQaFJdf9OB9Swb97Rx5NzJ2I4xe07e7PlBtfIGmo
         exmYdyYe1iQYgmMrHhbuxFFESYekAr/i2hYjvC55ul1p6cGsvltnyw0E93116TIw7Ed8
         rNYjbJ3mEEorRifE+TxFRN/so1u8MsN6HxZCxtgNl7XTYnF/4FJcOklCTzzUzVL6DSqF
         De4Q==
X-Gm-Message-State: AOAM530kPXo9dzGF8NX5iFzY8BOv5ieCg3zajq1zJ0+0AvephuWhIGgP
        22o/3TOJA/crKWMQBFQB1q8irU9JnLnB8Orz4gnf7w==
X-Google-Smtp-Source: ABdhPJzMPkGmQ3VF7RW86gB4eHEfbhN9omVDSrbB2hl2Ge//B59MmV1xM6QkUMIa5UunJXXnMMZ9044YQmhTEMd1UxA=
X-Received: by 2002:ac8:7316:: with SMTP id x22mr28222013qto.386.1605178613034;
 Thu, 12 Nov 2020 02:56:53 -0800 (PST)
MIME-Version: 1.0
References: <20201109121731.1537580-1-daniel@0x0f.com> <20201109121731.1537580-3-daniel@0x0f.com>
 <20201111210602.GA1974594@bogus>
In-Reply-To: <20201111210602.GA1974594@bogus>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 12 Nov 2020 19:57:43 +0900
Message-ID: <CAFr9PXkH2ub7Vt7J8xJZLD3hoWPr7EG1a0jBVADdzdvzqqm-SQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: gpio: Binding for MStar MSC313 GPIO controller
To:     Rob Herring <robh@kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, 12 Nov 2020 at 06:06, Rob Herring <robh@kernel.org> wrote:
> > +  gpio-ranges-group-names:
> > +    $ref: /schemas/types.yaml#/definitions/string-array
>
> Not a standard property. Probably should be dropped, but why do you need
> this and what is it for?

It's unneeded. I thought it was a standard item from the other files I
looked at when putting together mine.
I'll delete it for the next version.

Is there anything else that looks off?

Thanks,

Daniel
