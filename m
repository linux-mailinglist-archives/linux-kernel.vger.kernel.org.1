Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F031EE745
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 17:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgFDPEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 11:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbgFDPEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:04:21 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2EDC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 08:04:20 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id 9so6330397ilg.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LngI92jGD0QZdOy6kZ5Tmr8Ff0OC1yZ/CGxWbpFolT8=;
        b=YS3aEKbVTKZDkSKeh0CX/xm9WTtmNACYiPRBDIeMX8MelYg3aX/45//1Qy2UGnptab
         HlDNcZDnEbu32YZJJzWL5dHsFExuLJ6QQXKHK/5CtyP7ni3GXKgW3rpT1OnZ7TUGRL5h
         Xe9aS9spm60GdmUKA8LQUdUQ8xYTDsLj3POVE73X/gaDiKwayQDq99kONQCIiGZiG7Wa
         1T0yp8LKAw1SVLuUYzn/kdUKksA4cOWp2yumBT9I7G6gtZ0h+sN5IPXuUy1c6iAFlDK4
         n/po9Icft2JhR0xk4cRTX9IL/GiBq/GEhDSQfMtNwdpoi5nsxMRVO/qn4QQcKqvDs9Vi
         HJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LngI92jGD0QZdOy6kZ5Tmr8Ff0OC1yZ/CGxWbpFolT8=;
        b=S/EkFrCTRiRcDZuxwTZIW42dloYsSn9W8AtjLlov4JY/0XA/Vx6fA+2nE7ieDVOs0u
         lMcbpr/fT7YBo67raXsMcpaiFx8hqj6xN5oE8tQTI9TmaeQ/8msODPzvkbj8i8kCB6+8
         Q1g1n60nQZlMsZhFMCxpTMei4sRLQHg2c6egknoi9VCwdIM6llElWytwlblA9MOYX9su
         ZG9uHxirq3lQFDJdnrotkhtw3upsrDY/wvAD9ncbYkmh1KkBkHe/dnql8kIgPs8sPMDI
         vKqwJuVeG2sWZx0QCnszMkQwEsAHAx3K56tusf3iii/9bve7b1Uf4fMTLsb/kbTMJ6Z3
         yRIA==
X-Gm-Message-State: AOAM532xEKuTWw8IAjVVWrxlW6uCdT22gXOMeu5BJoYl1VbTlJOhD4JQ
        YTgAefyPYa4vX3rZoXA1AW4fuq+HhQJ3pCkmwNjANFex
X-Google-Smtp-Source: ABdhPJxE7Q4CFY/nkL5GSgsZYUCp7qF3I5XISpdtC4b0hk26y/JG0p0u7xwfc0+jU6YiyLx+h6E7Hh12eKUHWQBcnsA=
X-Received: by 2002:a92:db0b:: with SMTP id b11mr4267453iln.90.1591283059306;
 Thu, 04 Jun 2020 08:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAOkhzLUrNYk6JKTbTQuFkfuGKxGvW9XVq6+p9igsBgX1-e9Cxg@mail.gmail.com>
 <CAKb7Uvg0W_1qUjf3G4JrCb2oJgkwz4G5T6PwkyeL-rZEp4UnTw@mail.gmail.com>
In-Reply-To: <CAKb7Uvg0W_1qUjf3G4JrCb2oJgkwz4G5T6PwkyeL-rZEp4UnTw@mail.gmail.com>
From:   Zeno Davatz <zdavatz@gmail.com>
Date:   Thu, 4 Jun 2020 17:04:08 +0200
Message-ID: <CAOkhzLXifEA2NvtDPFNsvH3bSDiH7ZLk0iRr2AkDDa6fO=fVfQ@mail.gmail.com>
Subject: Re: [Nouveau] NVIDIA GP107 (137000a1) - acr: failed to load firmware
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Ilia

Thank you for your reply.

On Thu, Jun 4, 2020 at 4:36 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
> Starting with kernel 5.6, loading nouveau without firmware (for GPUs
> where it is required, such as yours) got broken.
>
> You are loading nouveau without firmware, so it fails.
>
> The firmware needs to be available to the kernel at the time of nouveau loading.

How can I tell the kernel to load the firmware?

Best
Zeno
