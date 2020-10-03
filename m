Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E3A282672
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 21:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgJCTsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 15:48:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37498 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbgJCTsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 15:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601754519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hy5WpkO/Gu95w0OKNDzxdR7UAyBBtQNNsxFWZCduFU8=;
        b=EG/ero3Amp3ymnkxiFSshMsqyhG8cxjAy8CMdg8WLGEdqUkmwVrizRlq1Cr8KRGMGbA/jJ
        8XymOGJqrIyXGbnrk58YGutRWPB9UKA/jVQCbCy/Lpvq1LCEFhsVNo0hSK8r9qRvgHn2i3
        ombS/xBW1rGyi8rb1ZeXq8l92Xf7rq4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-Kz6BtJY3N3yABO9HBEwR8A-1; Sat, 03 Oct 2020 15:48:38 -0400
X-MC-Unique: Kz6BtJY3N3yABO9HBEwR8A-1
Received: by mail-oo1-f70.google.com with SMTP id f23so1368576oot.14
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 12:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hy5WpkO/Gu95w0OKNDzxdR7UAyBBtQNNsxFWZCduFU8=;
        b=n5UbjtjfRaOB28yCrLYjb97SReoSwxf7dDj+skXkcvyutXZQFBMTwMOlo2i/Ue21Sw
         sAkjDyhvUdmEmkmtJSPwktYWO8vf7NCXbhn/lpOZBp9bCZRzYSIGc3iPXIKEe+TorIK7
         /ONdhj4MJJnzkOKVWk7JwzG1TNHdjYpGqLW7H0SXlP/QWb8F1letL9aovsteNdbIq18p
         Dt2O681YFOQJh/5DRSy/uJjzlieHt5BsHYRiFIAI0b4rLx4y3hAYFtsn0jU9nM0DcBR7
         FmdW6NG+cr81OIsNlzuKqDafAuZA8ZS5FTPlk5M+SnL6B0e7QzLGV5B9ro0imm1M5bVW
         UKrg==
X-Gm-Message-State: AOAM533jbmbyEcWpkUX6VWsDVT/rAe0I99EVtfTKhl7fxgunE9+Ez11C
        TzpE7meLaPS2ykYsvILsc4hpOKnpA3GZwe6WTKKTSoAFhJAP8I3PjVr+Js3hpRhvehfF4dYUI6/
        M/6d1lS1+nLRUE3Tt8sz/YeTERPmMmkSdt7TW/z5A
X-Received: by 2002:a9d:3ca:: with SMTP id f68mr5704587otf.330.1601754516947;
        Sat, 03 Oct 2020 12:48:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2wq2Qm+3K0+4uyut/QnW4dmGFfGaay66ulKWiStR9/0e74r3/nykX7vJ+Cq6chVIYYIfwVu6O0sKr5ajDQWY=
X-Received: by 2002:a9d:3ca:: with SMTP id f68mr5704580otf.330.1601754516762;
 Sat, 03 Oct 2020 12:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201002174001.3012643-7-jarod@redhat.com> <20201002121317.474c95f0@hermes.local>
 <CAKfmpSc3-j2GtQtdskEb8BQvB6q_zJPcZc2GhG8t+M3yFxS4MQ@mail.gmail.com> <20201002.155718.1670574240166749204.davem@davemloft.net>
In-Reply-To: <20201002.155718.1670574240166749204.davem@davemloft.net>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Sat, 3 Oct 2020 15:48:26 -0400
Message-ID: <CAKfmpSd9NaBFhBsS=3zS5R5LeaVzguZjkwuvxSLYNT-Hwvj5Zw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 6/6] bonding: make Kconfig toggle to disable
 legacy interfaces
To:     David Miller <davem@davemloft.net>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Davis <tadavis@lbl.gov>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 6:57 PM David Miller <davem@davemloft.net> wrote:
>
> From: Jarod Wilson <jarod@redhat.com>
> Date: Fri, 2 Oct 2020 16:23:46 -0400
>
> > I'd had a bit of feedback that people would rather see both, and be
> > able to toggle off the old ones, rather than only having one or the
> > other, depending on the toggle, so I thought I'd give this a try. I
> > kind of liked the one or the other route, but I see the problems with
> > that too.
>
> Please keep everything for the entire deprecation period, unconditionally.

Okay, so 100% drop the Kconfig flag patch, but duplicate sysfs
interface names are acceptable, correct? Then what about the procfs
file having duplicate Slave and Port lines? Just leave them all as
Slave?

-- 
Jarod Wilson
jarod@redhat.com

