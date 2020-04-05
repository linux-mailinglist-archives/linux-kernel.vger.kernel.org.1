Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8716919ECE9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 19:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgDERcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 13:32:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44599 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgDERcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 13:32:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so12135979lji.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zcbh6sH9SJBGE+Cjk3XFguwEqI2IKXqqQBtRFq6gvFQ=;
        b=R07dbyu7Y0eMKVM4FedC3n/xof3lreuns2KIRBmYuFzNApajuKhjO7x1wg1aWKkMhh
         dwTz+7LXu6F7lM4s5hAWcEoHMHg14h+cQpmTR9fdFNXDCp6e2xdLcSoC3KXYyqK/QeGu
         RsK9JhsA+jl8afkEI+uxGrG60T2A4hCuJEIG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zcbh6sH9SJBGE+Cjk3XFguwEqI2IKXqqQBtRFq6gvFQ=;
        b=L7b52FeG6AYIE82axxLYa0C6QO24u7FRp096yNiQ3J+SpqLZhJ+X20GyP0dAMEqmeQ
         7b/KVlhMWzvz8nwMGsUVpr0hqpq4WJQMzet/NvMnPR5gV6b7AxRghW8L+ojczPW7LOVK
         2RRe/d+Te4nxLX8nLw4CW6fnwFL92i+dapUlOMnh9VCNXZgZmHSXcMvmiQo5lj+6mF33
         oFMTDYGWvOjOOD8EPzP02qfc0wgmZTxksmREYlCS5NjWsXX9A6oR9fiTjqNBeUUQl3Oo
         GVrOM5uOEaJ9ruy82Gp6t//RAkOe+3Fn7UbC8DHZfVyWHeDS/qrypCoPHCdiFxh0+4Kv
         CJLw==
X-Gm-Message-State: AGi0PubW3PfuAEu2ROi0wPuUtVf2gK+sMP4Whhp5TNhPeV/araNawv8s
        CdraCAwGjWMxwULkhFE1VTrdZ9l5Tr0=
X-Google-Smtp-Source: APiQypJBnb8Gyf1epJhm/rqg+ka8iUeFbuZmfNsBV9karK9nbSK4GNiYaSX7PTfYupmNlIeBb7Zv/g==
X-Received: by 2002:a2e:7a18:: with SMTP id v24mr10196151ljc.34.1586107919584;
        Sun, 05 Apr 2020 10:31:59 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id e2sm8624020ljl.83.2020.04.05.10.31.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 10:31:58 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id r17so6307233lff.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 10:31:57 -0700 (PDT)
X-Received: by 2002:a05:6512:14a:: with SMTP id m10mr6564163lfo.152.1586107917356;
 Sun, 05 Apr 2020 10:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <1437197.1585570598@warthog.procyon.org.uk> <CAHk-=wgWnZCvTFDfiYAy=uMUf2F1Yy1r9ur5ARcmtqLjX8Tz4Q@mail.gmail.com>
 <78ff6e5d-9643-8798-09cb-65b1415140be@redhat.com> <3567369.1586077430@warthog.procyon.org.uk>
In-Reply-To: <3567369.1586077430@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Apr 2020 10:31:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg-6906+D68VHWv_SCvWUSG8R9w=js7kExmTum90Evu4g@mail.gmail.com>
Message-ID: <CAHk-=wg-6906+D68VHWv_SCvWUSG8R9w=js7kExmTum90Evu4g@mail.gmail.com>
Subject: Re: [GIT PULL] keys: Fix key->sem vs mmap_sem issue when reading key
To:     David Howells <dhowells@redhat.com>
Cc:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 5, 2020 at 2:04 AM David Howells <dhowells@redhat.com> wrote:
>
> Should this be moved into core code, rather than being squirrelled away in
> security/keys/?

Yes. I do think that that __kvzfree() function makes sense in general
(the same way that kzfree does).

I just happen to despise the name, and think that the implementation
isn't great.

It also probably makes no sense to make it an inline function. It's
not like that function is done for performance reasons, and it might
only get worse if we then end up making it cause barriers or something
for CPU data leakage issues or whatever.

           Linus
