Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3544423EEE7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 16:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgHGORh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 10:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgHGORh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 10:17:37 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE741C061756;
        Fri,  7 Aug 2020 07:17:36 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id k12so1718747otr.1;
        Fri, 07 Aug 2020 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=82inPIW1Oh/CO4EvqfOvn88LliTF9Oaje984rAfu0Tw=;
        b=liA8SLAbCxzV6pQOj2xavJ56O2yEHv+7sLicIkvBLcjky9vWltuYzW70CmJOxqRv8W
         4dzPaAbPD6RrPTr2Xmbnphv3SP55mX3U6utksiMnyihDeCIOQ01roYZp9hAigisZb0iE
         Pk6xV803J45OOkb4rEVEqqLV03en5NRMknou0H9Q4i/r5KBFM+riEkwnuJMT/pMomtgB
         8e8Q94J52MtYAzP0EKhoiJljkkv1Zef7mjWMJFJR3dHB4OZ+ss1by6fZyzHmnKIZDqd3
         g2t9fDNCt7Kv97xwstxcfmO2U9FIn+lf9sVN56l1CHjgIzGd6iBV77r2pzeGf+0WeCMM
         46Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=82inPIW1Oh/CO4EvqfOvn88LliTF9Oaje984rAfu0Tw=;
        b=cTV5n+OlZm54TwEP4tXDa9VzgBiesKG3B+Z2u02HMFfcIrfNb46Bt2CapwhI5njQRJ
         KmQzVvPei+Jj3gRYiN1oNkMTnRonLavkaqYmlctK3khISwp58eGYHi5aKOBK6/uDq4LY
         vjul7A9KAzl5CLq929Zqu1T1M66uLQmENjkV+RJ2mI7es8JUXcbK7OwoZHNiDhiKPPfH
         xhj3jYpvxRtN40QgGNo/IusgIbeq0nDz7b18iCP6GWAmgDs0p3tbI9//5r5z+HfllEvh
         2liDewnINHojiFORDaqQsr68yN9dQpXO/uOax99V7i65y2RJseAAw7dug9PZkEBhE8NL
         1ktA==
X-Gm-Message-State: AOAM533GJ0z9c7hANBoSO4NdsqoTFS4hOyddKeEYMtMSy38nx5KhPXJj
        n7rsbv+m6qhmPMaa8U7O+zAQw+MRBP3r3mu/Tw6ZiKTc
X-Google-Smtp-Source: ABdhPJzJoOY9utr4XlHtbQHhXPgnAlU2YHBvgtTpoRtyfLOBiOOCaLlool2rso3y1DF/hLM984tvlDxJam2Q3egEPZ8=
X-Received: by 2002:a9d:6a54:: with SMTP id h20mr12303058otn.116.1596809855593;
 Fri, 07 Aug 2020 07:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAGngYiVa9v9jGPNu4W+KHUnvemKU-BVE89-XNLcWOmoZjAPMTg@mail.gmail.com>
 <24f1687c-043a-a15e-0be4-8392e7b5c96b@metux.net>
In-Reply-To: <24f1687c-043a-a15e-0be4-8392e7b5c96b@metux.net>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 7 Aug 2020 10:17:23 -0400
Message-ID: <CAGngYiVokqYkEiQTcqAMnvif3qEWkPOb1cAk+4rvwgxBKZ5Ukw@mail.gmail.com>
Subject: Re: [Q] devicetree overlays
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Enrico,

On Fri, Aug 7, 2020 at 7:27 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> In both cases it would be nice to have the actual device configuration
> written as a DT snippet, which just needs to be loaded.
>

I believe you're asking: "how do I associate device tree nodes to
devices on a dynamically discoverable bus such as USB or PCI" right ?

I believe that already exists. You can describe the _expected_ pci or
usb topology in the
devicetree. If a device gets detected in a spot on the bus described
in the tree, that
snippet will be automatically associated with this device.

How to for usb:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/usb/usb-device.txt?h=v5.8

How to for pci:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/pci.txt?h=v5.8

For example, associate a mac address to an ethernet controller
on a pcie bus via the devicetree.
"reg" (which describes pcie topology/address) still needs filling in.

&pcie {
        host@0 {
                #address-cells = <3>;
                #size-cells = <2>;
                reg = <0 0 0 0 0>;
                bcm5778: bcm5778@0 {
                        reg = <0 0 0 0 0>;
                        mac-address = [CA 11 AB 1E 10 01];
                };
        };
};
