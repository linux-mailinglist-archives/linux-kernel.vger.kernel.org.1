Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF28283A1A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgJEPbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgJEPbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:31:11 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66188C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 08:31:11 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id k18so6997205ybh.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 08:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cw/49/7CWUsOFG1FzK/oEJGQl+O+DSFujk6JuVIfKE4=;
        b=og19PhzZxJuW0zF4WRck2Gpk0AAN/IODDl246MCCVVBPnub9QbgLVfNZnSWuuNpBpv
         5Z/azngmp7sDPs2gzl/ONHAb5VWqAh8bGsPEHl/ylyi69Njp0GARV4zXe2N7X2bLF9X8
         ZoGt4352McXSgTbGidmXYYlJn5MLVzUHb/9c7X3nTvU45W3X85zlexnHJN+NwN6zgjBz
         nn4AQJOYODIxS2agSlUZlhrp8XjCdEj31xDyeGfKG9R1hthrtAtgUS7Ddw/EEMcVRyZV
         WFgSWn5+YaxWtYPxt6NvKBAgRzIYv9aix1MhfAJrvDPGtWZg+jtlcPDII8RZshoCPVLy
         u69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cw/49/7CWUsOFG1FzK/oEJGQl+O+DSFujk6JuVIfKE4=;
        b=SEiry+BkTNnkdTLf7F3qx/mhItkHc7Sa2k2CpIO68aK2F69XtYmn3BCp/tni4pQMyH
         +ajiozoktcrjWIt2iz65LKNR+rBajid8Ss7wRF0v2a499N7XtyKs3apJ+XH0fffqtkK1
         taJGMxt4OV+o6AW7vwlsMJ5IJOnAc11bifXUE9qiV2sNld6LHui0PILYdAh6edTU9k4n
         DKcmLFiiup28wn1sCDKGjQmqmEl5z/f5jyG2iDxHTW/FZCjHnfBOfY2Ufua0nfsRhWL9
         gni2/u7Qy2KsTaqEKeKj5lcsqJ8hTN7QmARdMoZmtypzEVEO1SEjfEuzp8mFealLaAJy
         NX7g==
X-Gm-Message-State: AOAM532jvgICYrbDi0Z0x4rHB9jyQOJe+qFqIM9bkoZzjOKRm8mteIGE
        8/8TvrsWL3Fl/wwp/CScw641B7MbABKVAsujpp5dasXW
X-Google-Smtp-Source: ABdhPJxaXC7Q5nLJnXnh/wxbxVipXLxH/HpDU/tIp4gz0Jldi6IkMo7naiPU6Jk1jMMSDjpHvvER3F5d/7GCw14Etf8=
X-Received: by 2002:a25:3747:: with SMTP id e68mr721053yba.93.1601911870648;
 Mon, 05 Oct 2020 08:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201005122732.3429347-1-poeschel@lemonage.de>
In-Reply-To: <20201005122732.3429347-1-poeschel@lemonage.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 5 Oct 2020 17:30:59 +0200
Message-ID: <CANiq72mH93Yes8dShcFffEqS_O3NtuDOa8HyS20zKvLoiPn1hg@mail.gmail.com>
Subject: Re: [PATCH v4 00/32] Make charlcd device independent
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars,

On Mon, Oct 5, 2020 at 2:27 PM <poeschel@lemonage.de> wrote:
>
> This tries to make charlcd device independent.

Thanks a lot for the work!

I see you have written the differences between versions in each patch,
but given there are 32 patches, it'd be nice to comment which ones have
changed so that folks that already did a review can take a look at
those.

Cheers,
Miguel
