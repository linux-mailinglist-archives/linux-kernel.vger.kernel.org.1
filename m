Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2319B302D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbhAYV1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731932AbhAYVVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:21:45 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58B1C061573;
        Mon, 25 Jan 2021 13:21:04 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id r32so14740443ybd.5;
        Mon, 25 Jan 2021 13:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3lCPZHOlWCqOFxwlNBZvwznnjkRC7QjnUuvoRMU1js=;
        b=AWfk7f2W5VMVwnBdqUIg2d7rqamzb4Yv1IDg4ZdKjHwmcoU0cfFgonTlu8aYVrIjdl
         2zHwkZP1rUF6NmjZHL37d/JSECgfSFS+jLu35oNLOSK90efm7k0BDRHE59X89vFzv6xa
         nIBXOs4vzGfCbXF4yHBxy893bj75YsgAHCjcCOUwiH+YWLsS18THsVR4Xi4jr/S9rCs7
         Q0OKmKNYBilicr18C8VdebXxch0K2pWmCat2/BxWDxjr81pLfoI6XCgSpv06Goq3MOlN
         UDXZ8a1Q0GHpWPR7GK+P46L8gzxJpf9LReDeDyaR1gxu0x1MsYtM7yMdB+K40dfAHE+F
         7tHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3lCPZHOlWCqOFxwlNBZvwznnjkRC7QjnUuvoRMU1js=;
        b=nx5b22W5F5Upi8Fp9em7JNK5W5sEA0T2lYDlgbmbAcOFpqMo+IlC7sjaimu1Isw5Xz
         fZkUWn58nJ7VEyHXnWdcSmrIjDq2QdPxzjFflhsN/5ZKjTtF8fmhgmgCYmaSPwG47ON3
         R/Ufphc9WLzxLHaLefNfeQPybf1ebE5zYobaElPaHsk5Alq8YrJ0DMRy3T3hRnjG5bGD
         /cPdNLpgRLARbB+bW1CbxiS5hxie3tBdBwlQpUF87B3YETrKJfEptXxJr3ik5hpTfmdP
         e6pneIyaa7Eslw2VHY9t+Jho4fOQL9YxcVYkbQqZiYAkKUCSifzZjkNVyxqV3oAfEXWe
         rFgw==
X-Gm-Message-State: AOAM532/zaHWGhBmwiQYYPVHDaD/N8tkZ6XJqsUsmkOuIDJ8YwaZZTCv
        BpMxFE//SnE73PPeBmMfYHmevKESglhILNxHHIU=
X-Google-Smtp-Source: ABdhPJz/qrVrI1+It/goUqbBAtWieAunYcdLPQ/h/BJBfBU3NKOQ6Dgn3qZyis7KHACFTh0bSoVnaAJa7SdLQeWR+Nk=
X-Received: by 2002:a25:d84d:: with SMTP id p74mr3490418ybg.135.1611609664337;
 Mon, 25 Jan 2021 13:21:04 -0800 (PST)
MIME-Version: 1.0
References: <20210118123538.564597-1-geert@linux-m68k.org> <20210118123538.564597-4-geert@linux-m68k.org>
In-Reply-To: <20210118123538.564597-4-geert@linux-m68k.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 25 Jan 2021 22:20:53 +0100
Message-ID: <CANiq72=UPoJh4oaoev2a4+iYO1T0YwtCRPXjZ=gatHyAi_OC=g@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: auxdisplay: ht16k33: Convert to json-schema
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 1:35 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Convert the Holtek HT16K33 LED controller with keyscan Device Tree
> binding documentation to json-schema.

Applied to -next, thanks!

Cheers,
Miguel
