Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17ADC2785C1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgIYL0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgIYL0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:26:51 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AACC0613CE;
        Fri, 25 Sep 2020 04:26:51 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id ay8so2101897edb.8;
        Fri, 25 Sep 2020 04:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DaEiyCpA/iAmijBp9fbgLwzE+O9eX5S4Ozv2YkoK2I4=;
        b=G+4Kg6/gocoXGUoLsO/VRT8s6sDQArZ8eA/JQlK9y13t5BZUOX5WdfGGWRd+6Awqmt
         3rYqIhwANZV12yPloBy/JhPicz8+YIOBYYfVsyJdSwaguXQfP4hOi8MVKHTxNNeucCwe
         5hcIq3PyomzIM8INzRFlEuxhBoQ0b81daRNnhSbZeJGiJXVIpBtN3tp56z94lbfv0il3
         0EO9xrwNZz1hN7JmKMUXpNICCmLHJJbi40DEyLUY1V9/Gi07S4igN7PaQeKejwZ+acLh
         Xm2lmgZ0iSi29+H8GfAm8bmvP8usmJPU6od8JVk/5szVyqrpqOIIM6C6D40UXoCRvuwH
         kA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DaEiyCpA/iAmijBp9fbgLwzE+O9eX5S4Ozv2YkoK2I4=;
        b=Q3e9Q+rXD3ZrJS8YEOFmyyRIPpdr/MHEatE0ve2V5DEIZnPNb4o0WulHiHHu4J3cJz
         anInDIRmc5cikJn7Ld3UebEtrIZ5++ui1qQjgtjQ53YzpnwiRSZll5+JR0K3ukPOzjPR
         7zRcYpMAx7YaJ5ePVUTIriswSPjaRhsnrLBA1SH2mnIFwSkJYq5j2bdPvBgXMtKWeI6n
         z2V0oHCbapM8/sa/iBwe7cHZCmqQLvIu2YO4dvxEneaXWfRal+29qCsw+8COCukfQLoi
         w+xkDFzaYe7rgw+Re+vAMg8mHPjZX47fdpKCSF2dbybmKuh8wWYst741D8VpJ61bz7A1
         f05Q==
X-Gm-Message-State: AOAM533Wy5H79NXtaScbGEZY8L2veBr3nGyPyWm9jMQ+SynY6dS0qYpq
        2qdLEOJoonz6MgW8xz/COWQiMxp8pNfhMbV94Lg=
X-Google-Smtp-Source: ABdhPJxeAVbNfrPCu7zrhHMzDI4gm/MF1+4roWc++ikceWwHZjgE64uviY991arvc/Qz0YE266hXHEIqTqEb1kajqLI=
X-Received: by 2002:a05:6402:1495:: with SMTP id e21mr767338edv.146.1601033210101;
 Fri, 25 Sep 2020 04:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200925033017.1790973-1-art@khadas.com> <20200925033017.1790973-6-art@khadas.com>
 <CAFBinCAJ6svwiv9OM6EHz7468D9h+jW_ULiGrorgLetcODsAKQ@mail.gmail.com>
 <CAKaHn9+CWLJYN1Tt46VxBGNBEbVVJZWeL6ZJSf9w-5DmoxrvgQ@mail.gmail.com>
 <CAFBinCD0_QgKKcH+Kb2QbMWnx_csoXMEhSFYzmDscdTVB2TUJw@mail.gmail.com> <CAKaHn9K6O8u6Br84S63V0PDFBhiRbMdd4-bvC5FxFe6izj_Dvg@mail.gmail.com>
In-Reply-To: <CAKaHn9K6O8u6Br84S63V0PDFBhiRbMdd4-bvC5FxFe6izj_Dvg@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 25 Sep 2020 13:26:39 +0200
Message-ID: <CAFBinCAb91M5Zyn8yM1Ww4KKPANM2uqvJB11=QGjMJ2fdU836w@mail.gmail.com>
Subject: Re: [PATCH 5/8] arm64: dts: meson: remove reset-gpios from ethernet
 node for VIM2 meson-gxm-khadas-vim2
To:     Art Nikpal <email2tema@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        robh+dt@kernel.org, jbrunet@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artem,

(adding back all Cc recipients - please use "reply all" so they don't get lost)

On Fri, Sep 25, 2020 at 10:18 AM Art Nikpal <email2tema@gmail.com> wrote:
>
> this means that "something" is either set up incorrectly in the Linux
> kernel or that u-boot does some magic (and the same magic is then
> missing in the Linux kernel)
>
> maybe ;-)
>
> > I'll dig out my Khadas VIM2 to test this. what should I look out for
> (are there any error messages, dhcp not getting an IP address anymore,
> etc.)?
>
> just start your VIM2 board with ethernet
>
> 1) check connection its must works fine for example try ping your default gw
> 2) do `ifconfig eth0 down`
> 3) do `ifconfig eth0 up`
> 4) check your connection again it will be broken and u cant restore it im sure ;-) only reboot
# ping -4 -c2 google.com && ifconfig eth0 down && ifconfig eth0 up &&
sleep 5s && ping -4 -c2 google.com
PING google.com (172.217.22.78) 56(84) bytes of data.
64 bytes from fra15s17-in-f14.1e100.net (172.217.22.78): icmp_seq=1
ttl=114 time=22.4 ms
64 bytes from fra15s17-in-f78.1e100.net (172.217.22.78): icmp_seq=2
ttl=114 time=22.5 ms

--- google.com ping statistics ---
2 [  127.097495] meson8b-dwmac c9410000.ethernet eth0: Link is Down
packets transmitted, 2 received, 0% packet loss, time 1002ms
rtt min/avg/max/mdev = 22.375/22.415/22.455/0.040 ms
[  127.170167] meson8b-dwmac c9410000.ethernet eth0: PHY
[0.2009087f:00] driver [RTL8211F Gigabit Ethernet] (irq=38)
[  127.276459] meson8b-dwmac c9410000.ethernet eth0: No Safety
Features support found
[  127.278508] meson8b-dwmac c9410000.ethernet eth0: PTP not supported by HW
[  127.285230] meson8b-dwmac c9410000.ethernet eth0: configuring for
phy/rgmii link mode
[  130.425311] meson8b-dwmac c9410000.ethernet eth0: Link is Up -
1Gbps/Full - flow control rx/tx
PING google.com (172.217.22.78) 56(84) bytes of data.
64 bytes from fra15s17-in-f14.1e100.net (172.217.22.78): icmp_seq=1
ttl=114 time=22.4 ms
64 bytes from fra15s17-in-f78.1e100.net (172.217.22.78): icmp_seq=2
ttl=114 time=22.6 ms

--- google.com ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1002ms
rtt min/avg/max/mdev = 22.439/22.512/22.585/0.073 ms

note: the sleep 5s is needed to allow the link to come back up and to
get an IP address via DHCP
also if the output is not easy to read in your email client then I
have also uploaded it here: [0]

can you please show me the output of the debug logs in
rtl8211f_config_init() from drivers/net/phy/realtek.c (for example by
replacing dev_dbg with dev_err)?


Best regards,
Martin


[0] https://curlpaste.com/web/eaqun7
