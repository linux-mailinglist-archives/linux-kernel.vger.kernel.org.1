Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8E12CE07A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgLCVTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 16:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgLCVTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:19:19 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D33C061A51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 13:18:33 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id d20so4789430lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 13:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DJRKnqjCgWHhm3DXxiGPglLb7n4zSVyCYpnqLdcdiZo=;
        b=TBvZ8cT+n+pese6T9ygSu73P9cc8jXepQ+bP4M1qPKZTgVR/VxJCes/IPiqB3zVaRZ
         dm9AAoxOgzmzlj6bvdGb4sfWZ+FhCyhNrL80+Spt99mgn9W4suTyGjHaCg8x4l/sbZlQ
         zVFKModYzVc0g2ZULXQBME729MQtdKXVNqm4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DJRKnqjCgWHhm3DXxiGPglLb7n4zSVyCYpnqLdcdiZo=;
        b=sgmyTVAkJ+1BTiwIsE9nO6mXNrp7HAKK8qHcthGka8uH7DKBjJs6EpNs95+qZKwY8c
         5Ap1gAUkgbQcfw83HWmFyfZVEC7yyePKC/8MBnqD9O5ThtSTRFWFXrwumT4Ud4JZmuEA
         cfp4u6Q4UZezbkSQa8E7LZuILxAshB3qEJEb6nOwxSOq6GvgQXxOe7ae+bLQzbxbcKn/
         aLDGhrHbWhFzQSwU4eoTG8o6vPiBnYrKUuW4YJYWtXVsbNs35kkYv/px1NAdU2j9Skcl
         GVbZOjbHXNOXBDpB0qLXjiGjE8UeFuoVE1QvGId8rdojrRfjwpa/8m/2czochQr/d4kI
         ZD0A==
X-Gm-Message-State: AOAM532efPO17pzL1I166tGBS2x/NDiLMPvsok4RZk3WmaIJn0kdxcMA
        e9/lcNDUMI5SSCtfS2FvH//8OzTUMgBrmQ==
X-Google-Smtp-Source: ABdhPJzq6C5lxyAs1atRdNkxAMqKDxQ9O1TFfO0bVYEfUf84OmlZPVroLL7yzyX3rPLnjs9umui0uA==
X-Received: by 2002:ac2:5311:: with SMTP id c17mr2127303lfh.22.1607030311324;
        Thu, 03 Dec 2020 13:18:31 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id z16sm829745ljc.27.2020.12.03.13.18.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 13:18:30 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id s30so4828238lfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 13:18:30 -0800 (PST)
X-Received: by 2002:a19:ed0f:: with SMTP id y15mr1977548lfy.352.1607030309965;
 Thu, 03 Dec 2020 13:18:29 -0800 (PST)
MIME-Version: 1.0
References: <20201203204459.3963776-1-kuba@kernel.org>
In-Reply-To: <20201203204459.3963776-1-kuba@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Dec 2020 13:18:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgBDP8WwpO-yyv0fvdc0w9qoQwugywvwsARp4HMfUkD1g@mail.gmail.com>
Message-ID: <CAHk-=wgBDP8WwpO-yyv0fvdc0w9qoQwugywvwsARp4HMfUkD1g@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for 5.10-rc7
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 12:45 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Networking fixes for 5.10-rc7, including fixes from bpf, netfilter,
> wireless drivers, wireless mesh and can.

Thanks, pulled.

And btw - maybe I've already talked about this, but since next week is
(hopefully) going to be the last week of rc release: since the
networking pulls tend to be some of the bigger ones, one thing I've
asked David to do in the past is to (a) not send a big networking pull
request right before the final release and (b) let me know whether
there is anything worrisome going on in networking.

So if you send it on a Thursday (like this one), then that's all good
- it's the "Oh, it's Sunday noon, I was planning on a final release in
the afternoon, and I have a big networking fix pull request in my
mailbox" that I'd prefer to not see.

A heads up on the "Uhhuh - we have something bad going in the
networking tree" kind of situation you can obviously send at any time.
If there are known issues, I'll just make an rc8 - I prefer not to
_have_ to, of course, but I'd always much rather be safe than release
the final kernel just because I didn't know of some pending issue.

(And the reverse - just a note saying "everything looks fine, none of
this is scary and there's nothing pending that looks at all worrisome
either" - for the last rc pull is obviously also always appreciated,
but generally I'll assume that unless something else is said, we're in
good shape).

            Linus
