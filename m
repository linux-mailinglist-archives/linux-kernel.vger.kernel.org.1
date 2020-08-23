Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97A24F03F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 00:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgHWW2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 18:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgHWW2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 18:28:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33AFC061575
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:28:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d16so6841320wrq.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OCbyT8Wrt7DW9zhQxNDDF4QWFdP2cM1l1TV2mZi9goY=;
        b=QE6NuQ7zRXs7929353ltLpfgS+0DmhB/SOZWK1nX09cLl5mSRc08gunw0mSIFBIesi
         tqP5F//nFgo04iLXNaZeQcMgHiNC8U6K8USa4hUXsO+3j9h+wTPIE/PZ4HAV1c72a3pE
         1toDiSt5vqJOaBMD1pVGD4WPUdgdwOhHwD5VByKN7e97sn6ZryxXerJm7hkWwrupKAM5
         E/haE66gk+VyHis6tCQx07hpKRw+GSRS4F7wEfgaGQ5CP4fHSxlVS29xHD8LUj1Gembl
         F45+LBAJRagg36xhTnYsYrhrc8HFZeMSilx82bQFx2Pamf0Kgm2jYHX+mEgi9Xsy3Rif
         lKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCbyT8Wrt7DW9zhQxNDDF4QWFdP2cM1l1TV2mZi9goY=;
        b=iZigREAi88e72/NrYyptIPdluQFx/V2XrSU+os/oBVsMXCRXUTdrDc++GQrmeJzB3B
         Dqg0y0Z/+aTecOPcucA5bcPWWOgPvok4CUwwZiR5FpjmDWdw5IOAlRPuhzNwdWX2GHR8
         RD3KuOPieBpq/7hGi3iO07FSl2fN+nm5e13gHYSfZNicW44cRFdvYa4KOJgu0XDjoxct
         kMYH7SkSiBRP7a1sL/TXkq/BMzEKQEHjhIzEdeiXLJrYRVSIE5AXpMnTM7yarngxZmV9
         ZovC4UJn8V8TJ2GmqL4OSVWw54EvRarxpSnjEfM3iFW9fPP5eWuLsXroyqiLUuCiUgrJ
         0xwA==
X-Gm-Message-State: AOAM533txq8SUrufS3aYFyXgRsKZpxMB3hTef7w1G94vxJyB93FSIjd6
        +XHIujyb4YMCnsl97jr9KTk2BKOGx1HALgKcnFI3tw==
X-Google-Smtp-Source: ABdhPJwkCWcXz34HWBS5IuQWjF/zrTMiC/SPES/zSvwvj755M1Z4IkSgYyBx/Mq1s39ErgUK6o6XcySqdW/xiYvVyp8=
X-Received: by 2002:a5d:660d:: with SMTP id n13mr3054833wru.52.1598221714806;
 Sun, 23 Aug 2020 15:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAGbU3_nRMbe8Syo3OHw6B4LXUheGiXXcLcaEQe0EAFTAB7xgng@mail.gmail.com>
 <CAGbU3_=ZywUOP1CKNQ6=P99SgX28_0iXSs81yP=vGFKv7JyMcQ@mail.gmail.com>
 <CAGbU3_krnjbeKnm6Zyn-tqYCHVZFBkB+oCP-UF_kVOGz=zkKFQ@mail.gmail.com> <20200822.140141.880909883327091452.davem@davemloft.net>
In-Reply-To: <20200822.140141.880909883327091452.davem@davemloft.net>
From:   Pascal Bouchareine <kalou@tfz.net>
Date:   Sun, 23 Aug 2020 15:28:23 -0700
Message-ID: <CAGbU3_m_2_6iq-ZCMJ0i7E=4nFi6o=akd9_QpeRSa26=U67yog@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net: socket: implement SO_DESCRIPTION
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 2:01 PM David Miller <davem@davemloft.net> wrote:
> > About the pid part -
> > On top of multiple pids to scan for a given socket, there's also the
> > security provided by /proc - I'm not sure what inet_diag does for that
> > So maybe users calling it will need to scan /proc for a long time anyway...
> >
> > Or is that doable?
>
> I'd like to kindly ask that you do more research into how this kind of
> information is advertised to the user using modern interfaces, and what
> kinds of permissions and checks are done for those.

If we wanted to get rid of having to scan /proc from userland when
using sock_diag to identify associated processes,
I suppose scanning for pids would be the most annoying part?

I understand sock_diag uses CAP_NET_ADMIN for some sensitive bits.

I thought it would require an additional bit of logic to let an
unprivileged user access its own socket "sensitive" data.

Your message makes me think I need to read a lot more about it, so
I'll try that - but more importantly
as you mention APIs and modern interfaces, I think eBPF is going to be
of great help to try and hack
around this data without disturbing existing APIs.

Thanks for taking the time to look into it
