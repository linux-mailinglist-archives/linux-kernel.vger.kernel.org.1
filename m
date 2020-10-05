Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6B6283C4D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgJEQTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbgJEQTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:19:30 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E618C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 09:19:29 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 33so10000651edq.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 09:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQ6Es/xFLdPSzg2OGJum/VZUjZ6RGFtSfKRD6VKBbPA=;
        b=OqX+NWMPXADOMZdtu9ru/FhG7Ts+W/pk4fSJxPmwmUSCLNUr08m26yVPEKP25MiK5L
         Zmt+lH7KRBvILnryPTFJYg34OVHIbfrEHrYH7+8jXP5RwXYivZo/8Crp/rW8QwxPoUHv
         qQSmNfvczFY3cGlot6Pc7i1AONsavVh1I7wE5hzy2T3kKHJW0lDWi4RIfY7I1UHzxkHG
         vjlIu5KdgYTGwbCic/qmPjcelqfMYplF9of5HyCm+cnhl3Kp68GNMrK/pfm+rRZTFf6N
         2X0wElHqaKqUObvM98UAseZIvcATJRMsaHhL8Drv/sss6oVlWQADKT3iK9j2NtAgm8vr
         Jrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQ6Es/xFLdPSzg2OGJum/VZUjZ6RGFtSfKRD6VKBbPA=;
        b=fT1KQ9hqw845GQIjjl3JaukKTaY9QjTJ+jgbdehJJ9E2VN0m7gltbFMuyLzBJ9AKGF
         Nu7nZ3YBV93WihGpn5AkSvEEVhCaMgr3kKZGH8mCTUfoBKfZbEQq7H5KxIujcre73eGO
         i85R3CJPZcAjLYoQdQCM17K/SmCot6h9V9Y90knJVgmV1heNbLYnE58OREx2EdX+HUMG
         tQOHgQt5m9o4dKZ6CRaSgMZcpwyAZIliye/E0b+rL4oGJNLS7QMdUgWX6cWXTYt5w5zI
         fUnlo2FF+DlrxlPvydWr3XE96QXRXX6gU75z91LDEcw4bZSZn7wcXeXOEH/tGPEPgZYW
         sI/w==
X-Gm-Message-State: AOAM531O+WmYvi5300JW94oz2ergSdh0bePP3SGLEcrPVJEfqbZdfFgi
        xipsDiE7Ur/LHGQrsKuSLP4rHUjLJhVIpdCFY8jnK5o9DGo=
X-Google-Smtp-Source: ABdhPJyyb0MgBxR6SjwM/a7GkpSgGlmXWAy5Y7nXmfye8eEdiU+mSxfHcT6n99s3f26yKRP4CA5PB7sHz4ijhjGORA4=
X-Received: by 2002:a50:d987:: with SMTP id w7mr402692edj.113.1601914768199;
 Mon, 05 Oct 2020 09:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201005151518.67527-1-steve.wahl@hpe.com>
In-Reply-To: <20201005151518.67527-1-steve.wahl@hpe.com>
From:   Robin Holt <robinmholt@gmail.com>
Date:   Mon, 5 Oct 2020 11:19:16 -0500
Message-ID: <CAPp3RGrY+AtPpOUUPtK-xwWrpxknCL1=SQ+++_X3SupZ73i7_A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Some SGI-related cleanup
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Russ Anderson <rja@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Acked-By: Robin Holt <robinmholt@gmail.com>
