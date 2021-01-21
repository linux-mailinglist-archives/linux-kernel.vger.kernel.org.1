Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F942FE20D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbhAUFx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbhAUDjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 22:39:44 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1ACC061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 19:38:58 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id u25so602679lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 19:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TEEhF+tsXrnqa5+Da17KxO7jVVBh4HlCwHV9GnjG9iQ=;
        b=S/izy/CulrJix4ZCImmuFX54YmVDejrNeSW+PJYGx4dzqkIZ24kf/kubuyTcDwgSm3
         0nGpPVRsii4BdZkalm+Ncclf5Rwiye3I1U/rMJn/5JrKsO1tREjhteFicWuzQIM82gan
         WKCLMAYXuHkzl2M0yNpFU9E11Dt/HR6pDbEYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TEEhF+tsXrnqa5+Da17KxO7jVVBh4HlCwHV9GnjG9iQ=;
        b=U1zG3yg635FFC1PuOhedfJ4DpGvZQGWDujn/YmqSbETzSoVxYrHNq+OFxiuQYfkcQT
         fpJAa1Sea1G0q4HiqiSf+DVna8aMPQla7ch84o55zJLbjmY03Ns2OA4ofiM7437DpqVt
         EIn0DUc3ByuwEim8u6LkgyaYptWYV9yEgRl1FTy5l7jmNvm8YpdoIfUZLZwWC4fj7Ypw
         cn1KkTFbLA7NuwRH5S2sLiqUmaJ0T6sxh6NVUdh6qyEZn8ukmwurdcvDcXT429W9lfPk
         KR3oqkAgapeWWfLUIcItwsD5frxR8MjITjCQEXLfjjuKIYDonMGUT5cYt+HPpGRDgsPy
         prFQ==
X-Gm-Message-State: AOAM532RW7i7mQBhf+m3nlEZAWfN9Q6oiDV8a5OJiq15FdYkSsD4HJcE
        h+DnzCuc8WLw7ZdETzp+yWsMA/wOCZ8KJA==
X-Google-Smtp-Source: ABdhPJwmAFqKl4mqaK5hcVj2YWxc5wKKPIwPNjw/oNt1ty+11MqfjQSAQxEdVCeuft0bztSWid9Z0Q==
X-Received: by 2002:a19:3f12:: with SMTP id m18mr5159357lfa.519.1611200336673;
        Wed, 20 Jan 2021 19:38:56 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id v7sm383900lfg.9.2021.01.20.19.38.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 19:38:55 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id n8so927021ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 19:38:55 -0800 (PST)
X-Received: by 2002:a2e:808e:: with SMTP id i14mr4497915ljg.411.1611200334792;
 Wed, 20 Jan 2021 19:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20210118193457.GA736435@zeniv-ca> <CAHk-=wh6HLz_qMam_J=W3X4caBqAGN8P+8c_y+sGFvBaD70K8w@mail.gmail.com>
 <20210118195400.GC736435@zeniv-ca> <20210120162608.GB740243@zeniv-ca>
 <20210120191116.GC740243@zeniv-ca> <CAHk-=wjtTC_jNL+K1Ey_wY_KpTYZOR5XwhkZ+Eu7vviVi5itDQ@mail.gmail.com>
 <20210120231439.GE740243@zeniv-ca> <CAHk-=widQ+oLHbm=wSrewpLgXJg_FWCZV3BERmaEAx+ZCMfmZg@mail.gmail.com>
 <20210121003835.GF740243@zeniv-ca> <CAHk-=whWGwcZXpqDFv-j2fcChtT1jE0ZMFCmQHp3BrSkp+XZ6A@mail.gmail.com>
 <20210121014528.GG740243@zeniv-ca>
In-Reply-To: <20210121014528.GG740243@zeniv-ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jan 2021 19:38:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=whqZbEPt2WC6WRWrMNPqaTsx99dp74vB6FQfM4aO6biQQ@mail.gmail.com>
Message-ID: <CAHk-=whqZbEPt2WC6WRWrMNPqaTsx99dp74vB6FQfM4aO6biQQ@mail.gmail.com>
Subject: Re: Splicing to/from a tty
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 5:45 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> splice() triggers an error for seekable destination with O_APPEND and
> with NULL off_out.

Ok, that's just broken.

> Same for splice() to socket with
>         fcntl(sock_fd, F_SETFL, O_APPEND);
> done first.

Same.

As long as you don't pass a position pointer, I think both should just work.

Not that I imagine it matters for a lot of people..

              Linus

           Linus
