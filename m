Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F6C28441F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 04:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgJFCox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 22:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgJFCow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 22:44:52 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90525C0613CE;
        Mon,  5 Oct 2020 19:44:52 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p11so490312pld.5;
        Mon, 05 Oct 2020 19:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=c/r3PEj0YRai5C3VqjNaYuwwDYS1p6JUQvyN0lvoAyM=;
        b=gZKPVgcb9eSWsRLOQDMDuEXhOqUdFypNE0jzBHtA4crYiiIlkgr3O7vxr/i6mlssBg
         +hkHeLWWlyBaKfQhyNbu/aGLbkPCOJzfcHHVa8ein8Qs5VUK7iG5UOEbzqPNifN7tIKQ
         Ex1AWgNGUtM/NkR19tiiBCtcTt821D3uZMQZoG02lCXH0BebKwUuNzGfKSx0JXRc+w97
         ZRG/tQ2JuJEgE8P+PaEMmptZAOpPf8ucw0As5q6K+dkTCqIOT8/Qzzk6bCfl46wtbQ4a
         8BGa75rHZG88KLuAXsBNX5UrQf6M2WNt7xcGng9gSJKqDp6dUugssXT6zsE03krYdrPu
         8jfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=c/r3PEj0YRai5C3VqjNaYuwwDYS1p6JUQvyN0lvoAyM=;
        b=j62kUjKgd8QflG/DqI8ih6JmNWqUy6vl9YstG1nTcMjEVhSFYRhE85IIQFHE8q9xNW
         V+042FssuPCLMvRxBk/UhT+w1XhUrGApwmkON7JXBoHdR9tW26+uEAg6B1oxEEuHZPEL
         L/fmDmfRS+HOUfOqKNVRtAnhXyOBMZBRkF8zYWGQi2WR/V+CNgi/mxfydjCs4ZpcMk/w
         +am76PymlJ0zkn0Gv6j+JJFnkfedVZdVZ99qEXVBFuyHnUbQgmtuf9W00GWvYykTu1VW
         kZ3KOP0JyADiXcriMQkWAdqrb06tlRqmf00pm5OOrI0WE1MFM989d/NB2E7+82xERYwh
         8W7A==
X-Gm-Message-State: AOAM5321wSOKexSahHmkgfdBR37BWgfM+0l2E2uZf3jfi6VsnCk73vDL
        xM6CRGZG5MDYHUilrPRgGDnpvck55KGQ6Nsdw3Q=
X-Google-Smtp-Source: ABdhPJy2nooYLBrQ5KLb9QiAVlVBANGc294nAeAdlos0bGJi0zn5KhComJuVTd3U0wSPeZ8/kFZkXg==
X-Received: by 2002:a17:90a:588b:: with SMTP id j11mr2164529pji.45.1601952291222;
        Mon, 05 Oct 2020 19:44:51 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.207.135])
        by smtp.gmail.com with ESMTPSA id gi20sm940810pjb.28.2020.10.05.19.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 19:44:50 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Subject: Re: [PATCH v3] bluetooth: hci_h5: fix memory leak in h5_close
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201001194329.9328-1-anant.thazhemadam@gmail.com>
 <20201004051708.21985-1-anant.thazhemadam@gmail.com>
 <407eed16-ba46-0ba6-544f-d5e820a1ced7@redhat.com>
Message-ID: <93ed51be-97b9-c5b4-8448-d06528a1d1af@gmail.com>
Date:   Tue, 6 Oct 2020 08:14:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <407eed16-ba46-0ba6-544f-d5e820a1ced7@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-10-2020 14:48, Hans de Goede wrote:
> To fully fix the memleak you also need to add a kfree_skb(h5->rx_skb);
> call to the end of h5_serdev_remove(), because in the hu->serdev case
> that is where the h5 struct will be free-ed (it is free-ed after that
> function exits).

Hi Hans,

I'm not entirely convinced that it might be entirely the best idea to do
that.

* The bug detected by syzbot only provides us with reproducer and
information about this bug (which gets triggered when !hu->serdev).
Even if like you said, there might be a memory leak unattended to when
hu->serdev exists, then this might not necessarily be the right place to fix
it.

* From what I can see, all the drivers that have modified to provide serdev
support have different close() mechanisms.
However, one thing they do have in common (in this context) is that their
respective serdev_remove() function simply calls hci_uart_unregister_device()
to unregister the device.
It is primarily for this reason that I feel adding a kfree_skb() call at the end
of h5_serdev_remove() might not exactly be the best way we could solve this
(and since this hasn't been picked up by syzbot yet, there's no way to know if
this just fixes things or ends up causing unforeseen complications).

Alternatively, wouldn't freeing h5->rx_skb and assigning it to NULL, for both
hu->serdev and !hu->serdev cases within h5_close() itself be a better
approach? I've also taken the liberty of testing a patch that does this, and it
seems to work correctly too. :)

But then again, I'm not exactly an authority on how this works.

Thanks,
Anant
