Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662891AB4FA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 02:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405461AbgDPAy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 20:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405346AbgDPAyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 20:54:45 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3059C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 17:54:43 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id f8so4222195lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 17:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hzMDorCv1GZID9zsmGcg6OddhqYx722MVsuJ8PCoquU=;
        b=PQbQU4mx+Y47Kp0VmJmY4pdmkyIFeOBpm/PuEBSauBtddR5AErvLkCUxYdB5QBq+Bl
         hkSP5lJlqOjR6sKAAc+32Cg2e5kqRXpCMz9orUD/QAFTm2fIM2IpvXHQkVIn6FAEqQOR
         he4mBko7bQTN6Ponzq1pQyRnUmWxWkRdsyIqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hzMDorCv1GZID9zsmGcg6OddhqYx722MVsuJ8PCoquU=;
        b=FnGuAFPkIhAaEWA9yy+Ulmb//zbh4feswxMIzd9jKybfOgFjzPdHDuW7jYp7EWuQOt
         SAH3gPiKehtRhMAa/+9CVkBhACW91rZxMhPuULawSc0yDeYLau+UmIKfOIFtoo00t/7t
         aezAw6crliU5v9JSxDTtphBxZsArl4ch8186rjZL2HcjtOW7GEnNXAQeIwuR6OX2uXFu
         0mcyoOx8X4jRM5jjMCDlcesX0TsISy4KztcYwRL6OTYIxxhxZ4tSqkUz3gQGAR/+d2Rn
         IoM/YbdzzLyvaD5e7fSuu31TbP9GUnBUFH/ZeXPeNrHtSCG9gx0B+uWyJOb8/FQ69l5L
         0pfg==
X-Gm-Message-State: AGi0PuZ1YgpweFs8B6iO/vKKUdv76XNLjS2A+s4HRzfMTjwSG+O4VXch
        puq2moOiHEQBbxQOQ4vHLTb2/WlTQK4=
X-Google-Smtp-Source: APiQypIVeKfqWc2WIvRqxp0zccQEFdIAKL6Yrzo7l52ARNAfIgLaV1h1l7d/aEkPpX6OZznbfP0hRA==
X-Received: by 2002:a19:5e46:: with SMTP id z6mr4211089lfi.74.1586998481797;
        Wed, 15 Apr 2020 17:54:41 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id z17sm8266703ljc.8.2020.04.15.17.54.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 17:54:41 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id h25so5917855lja.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 17:54:41 -0700 (PDT)
X-Received: by 2002:a2e:870f:: with SMTP id m15mr4867889lji.16.1586998009252;
 Wed, 15 Apr 2020 17:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200414123606-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200414123606-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Apr 2020 17:46:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgVQcD=JJVmowEorHHQSVmSw+vG+Ddc4FATZoTp9mfUmw@mail.gmail.com>
Message-ID: <CAHk-=wgVQcD=JJVmowEorHHQSVmSw+vG+Ddc4FATZoTp9mfUmw@mail.gmail.com>
Subject: Re: [GIT PULL] vhost: cleanups and fixes
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, ashutosh.dixit@intel.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        eli@mellanox.com, eperezma@redhat.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>, hulkci@huawei.com,
        "Cc: stable@vger.kernel.org, david@redhat.com, dverkamp@chromium.org,
        hch@lst.de, jasowang@redhat.com, liang.z.li@intel.com, mst@redhat.com,
        tiny.windzz@gmail.com," <jasowang@redhat.com>,
        matej.genci@nutanix.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        yanaijie@huawei.com, YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 9:36 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> virtio: fixes, cleanups

Looking at this, about 75% of it looks like it should have come in
during the merge window, not now.

              Linus
