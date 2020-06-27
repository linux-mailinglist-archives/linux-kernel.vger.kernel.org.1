Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A2520C14C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jun 2020 14:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgF0Msl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jun 2020 08:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgF0Msk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 08:48:40 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BC1C03E979
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 05:48:40 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id j202so5856813ybg.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 05:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+HfAsc3Fw0I2/Pkf86A5lqfA/70gYLaBPcWCq9aJpao=;
        b=AeRzz+WBhKO+5GtOCaz+ccjrHZUKiTXdnnfYWgLxCfdztvFYjHPD77187NcrFOFh5A
         Q7jh2fJcHOFk6mS4IQ4NulKW+vb72CRV4DQv3kPTr1C2QkIYs/gzhYa+jS41LaJrC9c/
         gDKcW9jp/Amq7jv94tzJB5lNCDRi2u0EfrhIRchUo7DQFbr06k1dRpvvp2ODoGEnrXrK
         7I60UP54+w0wjSNonkS9/XqERdAWY7hs1I6RefxXIdPHas4jp0XYxlA6P8gws88mq3AF
         OYJIRRRA0C7zNX/FXhHNhc64r0pkSWCtxlDycm23bPSF48C6iVzDOQX4FAiClnsPssOL
         XO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+HfAsc3Fw0I2/Pkf86A5lqfA/70gYLaBPcWCq9aJpao=;
        b=I3e7ZV0zZw8UJa2Thw8c/1uvkrFOoI/2sJ7uCTOv0O9psJFGm41VIl5bSuVefDoUll
         WIozyHF/f++8nHaPY3xqYmGlYhPUAwj9YXGgjRZ+qP7PodqZ/6A2dFoMUgDw0jNF8zLF
         5rirXz/2NBvRSaSDrPDnHfNaGdBQA99sbQSBPFjOI/PF8GmQEc105s/9VbYzkt7MzUVd
         fL3du4Gb19JapxMm3u2/vh7EWIN/ENVYkOF8N8JWxBavQ+5GPuABTovzoONCnYrE/V/P
         uOYX7dvABlB32deuScWbxLDMrKFxA+d2xcgpJeZZ4RQvKQxgGsJESVPtcG8Z6fHBawg/
         5upw==
X-Gm-Message-State: AOAM533hUaxpodhZQ7/bTL4X7neGZE5XNnX3C3zChsIKTglFJ9Qw3bkO
        /q387HKmraa2xOh0TuVCbVtSS/Esu7fpFpls37jtFg==
X-Google-Smtp-Source: ABdhPJzjf74IrntbQ4ZBa5tcfJ5vYcPJob6AkZpl9XawpxW9SaujUKcSkKn4BsHUIoQmUpZ8VWY0rIQ8OmtuQhYb8S8=
X-Received: by 2002:a25:fc26:: with SMTP id v38mr10924450ybd.314.1593262120092;
 Sat, 27 Jun 2020 05:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <1588394694-517-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1588394694-517-1-git-send-email-bmeng.cn@gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Sat, 27 Jun 2020 20:48:29 +0800
Message-ID: <CAEUhbmUj4iC1+4Y=93zpj+aCBqU1ySOHXvQgJHmxNx__UWduCQ@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: Drop CONFIG_MTD_M25P80 in 85xx-hw.config
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 2, 2020 at 12:45 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Drop CONFIG_MTD_M25P80 that was removed in
> commit b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
>
> ---
>
> Changes in v2:
> - correct the typo (5xx => 85xx) in the commit title
>
>  arch/powerpc/configs/85xx-hw.config | 1 -
>  1 file changed, 1 deletion(-)
>

It seems this patch isn't applied anywhere. Ping?
