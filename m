Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30933287CF9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 22:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgJHUU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 16:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbgJHUU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 16:20:59 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CAAC0613D2;
        Thu,  8 Oct 2020 13:20:59 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id m17so7791554ioo.1;
        Thu, 08 Oct 2020 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CB6W9WzO7W1bZwpkRkybp5FcJ0TGq96Jgxj94UreKCM=;
        b=tdsRl6KXos7ZO36a7xzlcrsj80EGfWjJaGhhsY3foy0dQRb1vcQm0fLLB61F2OE29G
         ZSUSoNDGCoqWig0uxhQmTtBoqaqhtKZhgIEPaQz95yGeVFT/kOFHnN5EWe69Tl8AgfxU
         DLaw7r3h8YEaZwE0fDqsgKYL1Olm/5RPVGyOgioqkjcYgemgtWhxU0mtMMX9xr0MgTd6
         B0QxypLvyQVpT+ar0TT8G++ZZ2uUNI0CTaVMJ1U+kRSSe/JDPvI9VRXK1nDLv0yqXnbQ
         u8305h2Ua8TGMgaGax2QX3tGPd585mwz71ivAL7BLxSNuyFoqzSEnce9W+0KBg4Bxz7p
         A6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CB6W9WzO7W1bZwpkRkybp5FcJ0TGq96Jgxj94UreKCM=;
        b=i5uLri2Hzwn3gjkTZkqSmjr0X8EDXyOjh5qdfVeKsgO6gZHBHi5qhxnOAzGowH1bqb
         ALSJMDUa4UPvF9FnhytmpEstMSNA8eqUG1AvKbdcXXRP8g1Kdfl3692WM7vDQ3gujTqo
         BPSGYvqhP/CfFOXRJK1L65wyBZrh8+hlZ8Vwqifujr5g1fGQrjv4VI0L4Yr+eZqaJhjf
         95ncCLUfQcoJacaHrWhFWeRh+rjh1CgHXSQz3UVi//VP7pqCRyL7IgrZaePbmnu2Ca8S
         SXGhrZh745a6ffqCtP9NXhfPTcu4uM/2Otchnnr4L07ZyLMNxUE8Oq1lMymoH0twteBR
         ncsA==
X-Gm-Message-State: AOAM5321lTEvBjmfXqENAXT6PlsJkUlg0Zd/IhV15zXw49uKWchPfH14
        MSHST4KuKD7kFLrRRZhoy5r449oWMUnVEDB/RHU=
X-Google-Smtp-Source: ABdhPJw/MzJ8hHIL1wI1ZtwXSGDbIpwzG2ersyQHW/4pjitnRNz7OIW63QNnm7qihfj/d/D0NshhLX3TqGXYYOl84+s=
X-Received: by 2002:a05:6602:18f:: with SMTP id m15mr7125778ioo.48.1602188458584;
 Thu, 08 Oct 2020 13:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601655904.git.npcomplete13@gmail.com> <cd64e0ccae3e5785c80ad4d73af533a40fc15876.1601655904.git.npcomplete13@gmail.com>
 <20201007210327.GE112961@lunn.ch> <20201007220718.GB1972@ubuntu>
 <20201008003241.GG112961@lunn.ch> <9c6e4da5-033e-6b30-4525-9f3a7b4ba01f@gmail.com>
In-Reply-To: <9c6e4da5-033e-6b30-4525-9f3a7b4ba01f@gmail.com>
From:   Vivek Unune <npcomplete13@gmail.com>
Date:   Thu, 8 Oct 2020 16:20:47 -0400
Message-ID: <CAChtp75Yo2crLwUCWWNgya-JmDiXvOt+JRwWojQQNazgDaphLw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: BCM5301X: Linksys EA9500 add port 5 and
 port 7
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Florian, I'll do that!

On Thu, Oct 8, 2020 at 10:58 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 10/7/2020 5:32 PM, Andrew Lunn wrote:
> >> This router is currently not enabled in Openwrt
> >
> > You have to be careful here. Not everything runs OpenWRT. You cannot
> > break backwards compatibility in mainline, simple as that. You need to
> > ensure that mainline does not see a change in the CPU port.
>
> I don't think this is breaking anything, in premise all 3 CPU interfaces
> are completely interchangeable, with the notable fact that port 8
> happens to have the flow accelerator block available for re-circulation
> of packets if we wanted to support a NATP offload at some point in the
> future.
>
> Vivek, maybe you can add ports 5 and 7 in the Device Tree and mark them
> as disabled for now.
> --
> Florian
