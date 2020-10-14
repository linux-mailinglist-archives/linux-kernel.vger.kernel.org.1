Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D765928DDE9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgJNJqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbgJNJqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:46:06 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C78C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 02:46:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h7so3007353wre.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 02:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O64oufbI1HdC5TSRm3/CRUrel2ecCtGIg/wv/WX/Y94=;
        b=IEuvdFIVnhaCDXlW9sS0sQ5aBGeO4OUOgJSLNCHbXWfA+Vk7m7OUJ8Ido0AUez4Rox
         jT/SyNTxjbS6xPx6q7OJBMQrcvbkErMzdqEAlA/CEO7/I4FdJCzEHywKtR8cXYPFnbe/
         NJQ6XAzUN0JrudUFVC3Vlkt/QUp4RwbJ0RFZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O64oufbI1HdC5TSRm3/CRUrel2ecCtGIg/wv/WX/Y94=;
        b=f5dTpuI0YtgROX1HMgtEWTSMI4RPzbVcV7G3pKNXfWkWZdGsaCD8DZZcYHnxU4vrUI
         BLQ6/pNEhvHHT6SOonWtDRaeT8aEQXHErIYyN/ZBtHgs898no9Yt29wDgyjpf/Np2a5Q
         nkbcXTHy9BWHah3zkYQOhd7pCK6W47G3KXfqpVbeziFazycGP65rcyvTNmS2IgmT3gOM
         yhE1Ety6UtwTjSjD/kSLUIt7DVnkRVLToWQCTzhN/Wsy9dXCX6V43Wf2mNYYlesIWLmG
         c9JAueeMecsfiLiPAl/+D1aZfzzs/FhbFenZohpY5Puy2zj5t9R64xnPRmREN0R9AvOR
         ws7Q==
X-Gm-Message-State: AOAM530MBpxRjgp+TrxR0E8A2Xt8eeGmBq/3fw0hHt0PGigpDyjn6J+C
        AM2QDOdwebUgrDiL0utDTyjbdtEnP6dhOYs0z76R0w==
X-Google-Smtp-Source: ABdhPJycDl8gZ1dz3QYyWHfbKW5ZhLpbrJPquHLktOSpMgRvhIbNukpryKchkU8uMNrbAOFO9RtLvupjWUe6PgNe0SI=
X-Received: by 2002:adf:fe09:: with SMTP id n9mr4648496wrr.144.1602668763527;
 Wed, 14 Oct 2020 02:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201011024831.3868571-1-daniel@0x0f.com> <20201011024831.3868571-3-daniel@0x0f.com>
 <20201012161156.GA1635284@bogus>
In-Reply-To: <20201012161156.GA1635284@bogus>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 14 Oct 2020 18:45:52 +0900
Message-ID: <CAFr9PXnK8wsTURRy77jMwsAS9vkjo6ibTVJch0BEUgvT4ALEhw@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: gpio: Add a binding header for the
 MSC313 GPIO driver
To:     Rob Herring <robh@kernel.org>
Cc:     linux-gpio@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, 13 Oct 2020 at 01:11, Rob Herring <robh@kernel.org> wrote:
<snip>
> >  MAINTAINERS                            |  1 +
> >  include/dt-bindings/gpio/msc313-gpio.h | 95 ++++++++++++++++++++++++++
> >  2 files changed, 96 insertions(+)
> >  create mode 100644 include/dt-bindings/gpio/msc313-gpio.h
>
> This should be part of the previous patch to avoid the error.

Would reordering the patches to make this header before the yaml file
be acceptable?
The commit message might be pretty big with them squashed into one.

<snip>
> > @@ -0,0 +1,95 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
>
> Don't use DT on non-GPL systems?

Good point. I didn't really think about the header also being used for
something like FreeBSD.
I'll fix that.

Cheers,

Daniel
