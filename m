Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70F72A2DCC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 16:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgKBPM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 10:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgKBPM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 10:12:58 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6291BC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 07:12:58 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id f15so4015561uaq.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 07:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H13SWQzOM1d2Hdbjj3kPC0w/mhhsSutq0E6TAXTvczY=;
        b=FT262CiGNq0R+2zZyymvsAocIiZEYrFLJeHq4bupLB3fpY4zNRscqvcg4uGb29ckLO
         nh3qEs9Kn3lLFleGbKmItERnCNmDIGbaJb22Asz3Kq5OeDJfSLsENMP3/3z+OqSFdGl6
         X9hIAPzGfbqB/Szogfs8DY+L1iRHGepHaZXp3g0E1ItGC40WkMXbv7E/JPIXitMkA4Db
         QKlhx8QgkSSAkZpdXViJz+QFd0ddezj5WxxXhYinPBNlhcH6dYrrgp0+QFeshI+ZnDwi
         fDd43mDTn0hq8dPD/g9uBGYuIdLIuttzo2UTDpRCE3t+TYrDHznpWU7UENVUDOKyOzCV
         667A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H13SWQzOM1d2Hdbjj3kPC0w/mhhsSutq0E6TAXTvczY=;
        b=Z7UmqZFJ2TEiAg2Fv6dZupMzl3clExd9fpvM8RN+y2T1upaglnhds3lJRbn7I7NBa6
         Fo3qDsFc6NPQD6wYY8YRc6dlNt54eCnvP4CIrBRnh8+XlaNm96xcuc+RRZi+eQN+BRtT
         8DX+xeeNalqAD8rX6xmaEkIfg7aaftwqEIsfuDUfcpVsUQpAn3Ca1wCg2QLy4hPamKza
         mEI3gdAFtRa/683QPXVotSbYoEDoiXKshFfdBgzTBXZ/f3QSFv9k6brq2cS9w0d5YQTM
         zGWovRLLu91vf26JfVGO90iP5h+oLrwyep5BAAYg/1AIv9VXgjsECv7Vrue+dyXkvMzm
         0G+A==
X-Gm-Message-State: AOAM533LBAPjG11zUqu67EE3Z7LPO9ctxlhVkxvLjWo5bBDPCgz0mtCZ
        uToo9pBu7E9z6dM3IXXVR9pbCHOKCi4=
X-Google-Smtp-Source: ABdhPJwvOFaceViFggC8/5TmssHFO+L5wR742GacpnXhZdOxXGg0rzWEfmlewozPDcbCXtFfcb6uBg==
X-Received: by 2002:ab0:758c:: with SMTP id q12mr2961898uap.75.1604329976834;
        Mon, 02 Nov 2020 07:12:56 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id t71sm1841702vkb.7.2020.11.02.07.12.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 07:12:53 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id k12so4017658uad.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 07:12:52 -0800 (PST)
X-Received: by 2002:ab0:6156:: with SMTP id w22mr7966149uan.122.1604329971985;
 Mon, 02 Nov 2020 07:12:51 -0800 (PST)
MIME-Version: 1.0
References: <qXMvIwNa4HX1gIpQwq4bUiGIpTyB4QDWx9DDZHnNg@cp4-web-038.plabs.ch>
In-Reply-To: <qXMvIwNa4HX1gIpQwq4bUiGIpTyB4QDWx9DDZHnNg@cp4-web-038.plabs.ch>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 2 Nov 2020 10:12:15 -0500
X-Gmail-Original-Message-ID: <CA+FuTScT=aXKVEeGYLQeYVgoJXJjtTN2DxTgiCof-Kfsc_nZ2g@mail.gmail.com>
Message-ID: <CA+FuTScT=aXKVEeGYLQeYVgoJXJjtTN2DxTgiCof-Kfsc_nZ2g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/2] net: add GSO UDP L4 and GSO fraglists to
 the list of software-backed types
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Antoine Tenart <atenart@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 1, 2020 at 8:17 AM Alexander Lobakin <alobakin@pm.me> wrote:
>
> Commit e20cf8d3f1f7 ("udp: implement GRO for plain UDP sockets.") and
> commit 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.") made UDP L4
> and fraglisted GRO/GSO fully supported by the software fallback mode.
> We can safely add them to NETIF_F_GSO_SOFTWARE to allow logical/virtual
> netdevs to forward these types of skbs up to the real drivers.
>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Acked-by: Willem de Bruijn <willemb@google.com>
