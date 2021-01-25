Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E19302D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbhAYVWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732581AbhAYVUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:20:41 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913B7C061573;
        Mon, 25 Jan 2021 13:20:01 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id p185so14702309ybg.8;
        Mon, 25 Jan 2021 13:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KWlxx7vqFuniWpQig1xl3Gehi+dZ8JGsbOBFONRJmFo=;
        b=LsGTyNGxNSwp77mqMG4AIQUzQpC2B2TfjIlKnEXXIRk6udbVE5Mbp0bK1NNmsz79z3
         Q+5+ZR38uXO/JO+ho8ldOnz7c9X/BLWXY2vG2KsJ8/LzdwJRqtEFwZMdaB8owOqUWzIF
         NVYoFCjOFOkNFLxEO6XrP1Bfk2TaiTPigr4kPbZmDxq4hLgMBdkcG21IVqFOhJxTKs0s
         h9BlipmOObV0Hn5PWyphnjbU5qhe3/pz1zID5b2mXJl8fNBAX6cUTZTQZKGyckJa+2z4
         aov77yYBH8ktJm4PnuH8juhA7DJN28WiBewfI+qcy2C6pUwOkodg2zmWQIf8nCwpa5IT
         R0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWlxx7vqFuniWpQig1xl3Gehi+dZ8JGsbOBFONRJmFo=;
        b=GuqLNMHmPh0SWC2lJvtVXgsbMm5FBmeYYSRxpGwaM5VUr/vmu8k9mbeCXQv/S5AmlH
         2mSE5EBvR0uRhQYWEvYwcuxAynj/O/RJJQauyBsDWsf5TYmL9jY7rZoxmPZaRCKupflT
         JxehkRtFP7ToXDqYUh/z0BozRxQjG9CLz5VZeGxMoCqQWF66s5farWqYLn3FQcm6ZcYg
         EkThfUi6tNOwCX3G6N69i8DVG9+IfFQx6VLNnhSpXtFc6iODPtGzziCBD/LoVguBxM8q
         Kz+UvMwLSp/v5pb7fKMP7LEmZa2hAfyG1byLNC2TZ+BT/nP5drOnOcA2B09+DOalFJOW
         x1Gg==
X-Gm-Message-State: AOAM530TmUc1dxUDiBwdwFT4O4ZbdHee9xtJDGobnPM1/ODOQmxhdnWF
        cmdNaK+LEttVhiCjMieYX55pY1nSmG1WBqSMNiaqXGRmSP8=
X-Google-Smtp-Source: ABdhPJyoER2A5eMTfzOUXSXObZe7vKWVhfRtlkjHUcx10bpgG6SEJFFx/ElYdZpTjHczMsnzEKdkV2qDAZwv8N/BUV4=
X-Received: by 2002:a25:af8c:: with SMTP id g12mr3761991ybh.33.1611609600857;
 Mon, 25 Jan 2021 13:20:00 -0800 (PST)
MIME-Version: 1.0
References: <20210118123538.564597-1-geert@linux-m68k.org> <20210118123538.564597-2-geert@linux-m68k.org>
In-Reply-To: <20210118123538.564597-2-geert@linux-m68k.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 25 Jan 2021 22:19:50 +0100
Message-ID: <CANiq72mD0kGSb+Sgfz1knpho0Fk442ifjzyhW-ULnBLOHY1bKQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: auxdisplay: ht16k33: Keyscan function
 should be optional
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Kaplan <M.KAPLAN@evva.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 1:35 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> From: Robin van der Gracht <robin@protonic.nl>
>
> Keyscan should be optional to support simple LED matrix displays (output
> only).

Applied to -next, thanks!

Cheers,
Miguel
