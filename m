Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852962DDF48
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 08:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbgLRHzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 02:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732322AbgLRHzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 02:55:36 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879DDC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 23:54:56 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ga15so1878697ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 23:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlSOutxcnfCnpQdRS/INoC9PGjfzxT8xh0q9X7xLImU=;
        b=WESp/LVuEddoDp031yghvRr5ezOYqVnEnWkYtSkedOiry0aUZ/QkWuUaEx2y+pUdaP
         da3AKB64dMb5TCAiKdP1jMH8W7ilcDj+6m8XS1rgN/keiHoUCosMXfE154Puuz1zVdk7
         aYczcX9Ihc/Me44MMKXhAVMqNybhh3ppZFIl30jBs7HCh7aaf183g0X+NaXJe6lHtMsj
         uOom9/e/pLb64DDNqOd4bjz+aqNkx9+aHlD/jBurn8bcHoeS3lygOOUsC9ouRhuq4DWt
         PpaCIiwlOnGxAjWU05Q12P8PZoS4aase0lajlD3ErEAmsvnCol/WowZOjThRA4RTX0Pd
         OgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlSOutxcnfCnpQdRS/INoC9PGjfzxT8xh0q9X7xLImU=;
        b=XPf1MpX/2R4yFnEc6FynMAIzDbTBPSEpZzse7afr7/yorAQgrVIZ0o7hMPCVbR7+yY
         8eK8rY+739TOCXBGngYYXxQpP04hjvLTIw8toH0Z328tkcwRLwDHbE5SI9sOaH8h8zcr
         v0IoD4E390oZ2jEjdwh3M992uMUtqJZLgxbpeirkyVjoo+51h5ofAFVRuZlQV6rI1jXo
         lkE/SWuSQlqSqtpHk/Nea41tpa20/SfkGMFzy9CoVkepsia3+Kh8GDOXev0q1lU7Tawf
         +3d9/FOoTJEekh3hM68VgBzjSdzihuXyyJEKGgrK85kd6jRti0TDGcvkMP9j4YzJ3rcz
         40ww==
X-Gm-Message-State: AOAM533eV7YMqVGJONpKOrTrvfuQ4xCRhGwKj8qY0alpdkdb51QZ9jzO
        EN/N6gmUfSnYmF9ndBkU0mT8AWxpYsIv0dVLa2EhSw==
X-Google-Smtp-Source: ABdhPJx95FmF+WWZ0ANmUoY+SFO6NW+6z+DkqqwA9AtuCoduSQA+YnBINs8WXjsr9XhKY5E4YXU+gVJwpZjl0pjvMPw=
X-Received: by 2002:a17:906:b745:: with SMTP id fx5mr2740918ejb.103.1608278093688;
 Thu, 17 Dec 2020 23:54:53 -0800 (PST)
MIME-Version: 1.0
References: <1608219249-6297-1-git-send-email-loic.poulain@linaro.org> <20201217085847.413f2d53@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201217085847.413f2d53@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Fri, 18 Dec 2020 09:01:30 +0100
Message-ID: <CAMZdPi8f3=1Z2iMg03fBNe5bQBz+2VXHZLmf--z-AaPffanirw@mail.gmail.com>
Subject: Re: [PATCH v2] net: mhi: Add raw IP mode support
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

On Thu, 17 Dec 2020 at 17:58, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 17 Dec 2020 16:34:09 +0100 Loic Poulain wrote:
> > MHI net is protocol agnostic, the payload protocol depends on the modem
> > configuration, which can be either RMNET (IP muxing and aggregation) or
> > raw IP. This patch adds support for incomming IPv4/IPv6 packets, that
> > was previously unconditionnaly reported as RMNET packets.
>
> Now it sounds a lot more like an extension than a fix. Is the interface
> usable without this change? If it is we should merge this into net-next
> after the merge window.

Yes, without this change, interface is usable when modem is configured
with RMNET protocol, it's an extension to raw ip support.

>
> Either way you need to cc netdev for this patch to get into patchwork.

I'll resubmit after the merge window.

Thanks,
Loic
