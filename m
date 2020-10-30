Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB3C2A02B9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgJ3KWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgJ3KWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:22:22 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 870BF20719
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 10:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604053341;
        bh=QaPlm2yPC/zGow/8UqnUJUgg/ASms6xiu1xXrafKBmg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wipxcyVEGaxq8MVcw9E/LiiemNBX+xPZQ5xsk0oXiUMowIuH1CEBBUJVZQvdJsftk
         Vb8XEl6Jog/Z7I8CAtuSbMQ/Kf9L/Zu0SRUNlTMw5dsSgWushL6BxxvFbgjJhE+0dY
         39YBF2NjrdYrXnz5UCW1wCPdD3tOinn1rHuD77JU=
Received: by mail-qv1-f52.google.com with SMTP id t20so2516952qvv.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:22:21 -0700 (PDT)
X-Gm-Message-State: AOAM533M/p65MucoiuvzIeZeCGH+SVo6PXyUdtZv4xNzUypAxD2j73EC
        xdDDfYLYwJa19wSqd9v9QJQRgJV/d+3dcZu8Tmk=
X-Google-Smtp-Source: ABdhPJyeMrXwgn5YEt4E78QS/eOYS7oKwvspZ7I8dqbF6D9CKkAro+aMi2W52X+lwqBOOwcgymN2lfzqb/vMlJi26OM=
X-Received: by 2002:a0c:f447:: with SMTP id h7mr8023532qvm.7.1604053340646;
 Fri, 30 Oct 2020 03:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201026155801.16053-1-harshalchau04@gmail.com>
In-Reply-To: <20201026155801.16053-1-harshalchau04@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 30 Oct 2020 11:22:04 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1bv4SjJjx0pEQPPzwO_2aEKQ-QBzGVuK8UmnZ_Uk62qA@mail.gmail.com>
Message-ID: <CAK8P3a1bv4SjJjx0pEQPPzwO_2aEKQ-QBzGVuK8UmnZ_Uk62qA@mail.gmail.com>
Subject: Re: [PATCH] misc: xilinx_sdfec: add compat_ptr_ioctl()
To:     Harshal Chaudhari <harshalchau04@gmail.com>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 4:58 PM Harshal Chaudhari
<harshalchau04@gmail.com> wrote:
>
> Driver has a trivial helper function to convert
> the pointer argument and then call the native ioctl handler.
> But now we have a generic implementation for that, so we can use it.
>
> Signed-off-by: Harshal Chaudhari <harshalchau04@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
