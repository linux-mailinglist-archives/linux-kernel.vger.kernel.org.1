Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41272EB3C3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 20:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbhAET4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 14:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbhAET4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:56:19 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A78C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 11:55:39 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id o17so1308650lfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 11:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kz5X2TbTXdhqWI8ZjPb3eUKzSaXM2xhdAJ6U7U2oZ8E=;
        b=gY98uSKZB8UX8f993c1PbBeWpeexxNts8pg3YC0F8gFIcPB+RgQO6ef4p3AnawjLmQ
         MHpykmXTq4KwTjdJWHJDiv5EC2yzs/3mwiHJGu+LX9M++3xemFmOvQ7wtnxOPRk9ScT6
         UMkbxdsQKg/jC5JYFoV4/37kF7rlnXWB+NS6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kz5X2TbTXdhqWI8ZjPb3eUKzSaXM2xhdAJ6U7U2oZ8E=;
        b=VD8ZU5KZPzmNUepZ4AJB+eybnyI/KblkrZLeyvxwSqmRvvOBlswQBh3Va5QvGZaFDg
         LBaeiaogILzSp7col997sMRNW/hVl0skqenCl92YW1tD9q+fkxyFu6AxE6Nhl35jfuKF
         KJdWGEdYI43vh2iEbQv4i75vIECO1GAU6pp08uHxfzAJE2f5neQ6TdTPhGJW1PBSgvZO
         LXmdEJmy2TyW0XSWYnGvMXuQUA471chnGQGiXzUiA2Gy5Lrp+fjG3mUYH1gozen+sczH
         h7uNfHbcl57I26pPjw1S37Su6vLR1NBf4HAe44CpU3woCgDqzeUU7FS92qwZnB04bkp6
         +b7Q==
X-Gm-Message-State: AOAM532m9lGRaojB7IHjPXPLY4vB6t6Y6AT6exlw2On13rM932RryrX7
        DNhcykSXtQat9dokPRGGa0Un69avAEScMQ==
X-Google-Smtp-Source: ABdhPJxaGmBFelHXlmskI3jGO5yCp7CcGX4EJIVSv3z+v+YgfDGIo/t0lfAxZMUx3xYq1nAb4wz0ew==
X-Received: by 2002:a2e:8159:: with SMTP id t25mr545396ljg.379.1609876537344;
        Tue, 05 Jan 2021 11:55:37 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id g136sm14224lfd.272.2021.01.05.11.55.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 11:55:36 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id b26so1228982lff.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 11:55:36 -0800 (PST)
X-Received: by 2002:ac2:4987:: with SMTP id f7mr364877lfl.41.1609876535969;
 Tue, 05 Jan 2021 11:55:35 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whS+rzNMSsU6vRoLMzrm0JPN-OVg+BxhybMet3NpqpR-Q@mail.gmail.com>
 <20210105184653.GA88051@roeck-us.net>
In-Reply-To: <20210105184653.GA88051@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Jan 2021 11:55:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=why7Sc=bypL-rbXevtoe8GjSv2ifSH1pVZn-ziAGKR+_A@mail.gmail.com>
Message-ID: <CAHk-=why7Sc=bypL-rbXevtoe8GjSv2ifSH1pVZn-ziAGKR+_A@mail.gmail.com>
Subject: Re: Linux 5.11-rc2
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 10:46 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Problems are as already reported against v5.11-rc1.

Yes. Thanks for keeping on top of this, I'm expecting to get the fixes
as people get back from vacations.

           Linus
