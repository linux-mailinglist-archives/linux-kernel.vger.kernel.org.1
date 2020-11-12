Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1153A2B0AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgKLQzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgKLQzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:55:47 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B50EC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:55:47 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id r9so6732495ioo.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ETpWFBd82lx8Kdft4QwKqVKvGr2uK2uAQvv2db2HDz0=;
        b=PCzdlWx9Cp/V9lnWUueHF2VcaCBxb4Ct7aclc20F9rWV1nUkGfprcITXoX35X4qdcd
         U0eh4fzg975MiiUzGan5DjCKHuvngjy48ZN216PpQ4gfBAIBq/0xOuMzlsJVo7G6HjYK
         XKpYlX+gU92JQa0HvUNdrw2IF1As1Muz/AI2pHdl6+Ka9xArHVhhDZ5f4fPVv21ReXNx
         wHd4sNwSdmjIZBPpsNpBviNyZo6m/ZkuGI3inzIpwthAAxQnho12v+ODja3B8NaYgike
         r6/GlEwEvx22TRqBqyEXmIb2N63CY9RQaOhnN16pc2NvDlfBD/8uqYfHIelkkC7lGB1G
         MgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ETpWFBd82lx8Kdft4QwKqVKvGr2uK2uAQvv2db2HDz0=;
        b=XnnL37oPbPNTg3EC9xz4Jm16jdly6+b6KgXKNTBUfSP9UIpqqOEyC/LEmvteiemK0e
         tZi9Iy69GAPC1qstd9DKTYOyRCEBIlIU/YaUxfnaktRoHu4uzIwDLzubkmCGYdxNqCnR
         QVE9QyA+/Qac1YJYJrW2RLWsVkBVDankb4ZMvkWl7Y7Fse75FSE2APQDvuIjXoOeynyB
         XfKwba73WXdbYLc+eIfSOAQnEW1ZKSCXJk8WXMqwicKlV0SmpHHKctTogMlTyT20gAeN
         mK0ffv5HCOM7tgyF3eAcG3RLO/PaNnzFucivGxcF3DxWbbtfeNKVwPBy1k/vzu4s2/Ek
         NHkA==
X-Gm-Message-State: AOAM530AqDOYppWyJz2ezlJiRztEpCpwy0oB06wI++A3XiZN7FKAqaJX
        sc86pzbrKuimQJJ/THUtnGEhbj/rzmIZprJi9APY+XysEIs=
X-Google-Smtp-Source: ABdhPJyBEEXMy1YHyTULn3cw+/7ICqSCwPnUns2lDfzQCwq43S928+OMpwpdYpLsJ0+ylUM9bhI+10m9Fpy7H/Wm/rc=
X-Received: by 2002:a6b:8e82:: with SMTP id q124mr611iod.164.1605200146254;
 Thu, 12 Nov 2020 08:55:46 -0800 (PST)
MIME-Version: 1.0
References: <175b3433a4c.aea7c06513321.4158329434310691736@shytyi.net>
 <202011110944.7zNVZmvB-lkp@intel.com> <175bd218cf4.103c639bc117278.4209371191555514829@shytyi.net>
In-Reply-To: <175bd218cf4.103c639bc117278.4209371191555514829@shytyi.net>
From:   Hideaki Yoshifuji <hideaki.yoshifuji@miraclelinux.com>
Date:   Fri, 13 Nov 2020 01:55:08 +0900
Message-ID: <CAPA1RqDgKfcDqSOM+1TV=EesU1rynt6Z=EqbTur1Q6Xt=YvxpQ@mail.gmail.com>
Subject: Re: [PATCH net-next V3] net: Variable SLAAC: SLAAC with prefixes of
 arbitrary length in PIO
To:     Dmytro Shytyi <dmytro@shytyi.net>
Cc:     kuba <kuba@kernel.org>, kuznet <kuznet@ms2.inr.ac.ru>,
        yoshfuji <yoshfuji@linux-ipv6.org>,
        liuhangbin <liuhangbin@gmail.com>, davem <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hideaki Yoshifuji <hideaki.yoshifuji@miraclelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2020=E5=B9=B411=E6=9C=8813=E6=97=A5(=E9=87=91) 0:46 Dmytro Shytyi <dmytro@s=
hytyi.net>:
>
> Variable SLAAC: SLAAC with prefixes of arbitrary length in PIO (randomly
> generated hostID or stable privacy + privacy extensions).
> The main problem is that SLAAC RA or PD allocates a /64 by the Wireless
> carrier 4G, 5G to a mobile hotspot, however segmentation of the /64 via
> SLAAC is required so that downstream interfaces can be further subnetted.
> Example: uCPE device (4G + WI-FI enabled) receives /64 via Wireless, and
> assigns /72 to VNF-Firewall, /72 to WIFI, /72 to VNF-Router, /72 to
> Load-Balancer and /72 to wired connected devices.
> IETF document that defines problem statement:
> draft-mishra-v6ops-variable-slaac-problem-stmt
> IETF document that specifies variable slaac:
> draft-mishra-6man-variable-slaac
>
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> Reported-by: kernel test robot <lkp@intel.com>
> ---

> -       write_lock_bh(&idev->lock);
> +       int ret;
> +#if defined(CONFIG_ARCH_SUPPORTS_INT128)
> +       __int128 host_id;
> +       __int128 net_prfx;
:

No, this does not help anything.
Please do not rely on __int128.

--yoshfuji
