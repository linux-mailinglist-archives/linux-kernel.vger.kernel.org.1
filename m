Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2676326C8D7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgIPS62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:58:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbgIPRwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:52:02 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80E522224E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 13:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600264433;
        bh=jOr1ILBrH0hsIe4Uxj0HglLHNtHLCgPAOSI7lD6Bk0A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p9VWVOxqy0ZOpY6zV+lgUxPY3vw6KIsl7EKpGzi/f5TJiOJuxEkiQ/G4gh/h5EzHS
         RF68RygSMJzp1/h8NeBPg+O7beXq7pBMA/m7hUDQMMXJocOkwnecFGmmYzMf7uZb0o
         AGOuxHWQwZXx2lQ+zyA8jN8N/CcUyUTP+mpFQPzA=
Received: by mail-wm1-f47.google.com with SMTP id e11so2301754wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 06:53:53 -0700 (PDT)
X-Gm-Message-State: AOAM533oRFOTibChtUIkOQP3sYTMluty0BKpQ+xEGJ4fbDgSO0bhPVU8
        5xki6I6MW7OarqX+B6Dr6PrxT9jOtdaLBXKJZfhsyA==
X-Google-Smtp-Source: ABdhPJwsFxAlLKwvcgub1p7xhg7wLnttUhWDVhNNq6UFPkr9RccoakwAwNYCTooMbhwj5JmFeJr/NfK4O+SpA8c8x0E=
X-Received: by 2002:a05:600c:4104:: with SMTP id j4mr4760326wmi.36.1600264432116;
 Wed, 16 Sep 2020 06:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200916043652.96640-1-ebiggers@kernel.org>
In-Reply-To: <20200916043652.96640-1-ebiggers@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 16 Sep 2020 06:53:41 -0700
X-Gmail-Original-Message-ID: <CALCETrU-D=b-oGE3+zjoYFP5dBU7ur41dqwkz1BifOzN2=jV7g@mail.gmail.com>
Message-ID: <CALCETrU-D=b-oGE3+zjoYFP5dBU7ur41dqwkz1BifOzN2=jV7g@mail.gmail.com>
Subject: Re: [PATCH] random: remove dead code left over from blocking pool
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 9:38 PM Eric Biggers <ebiggers@kernel.org> wrote:>
> From: Eric Biggers <ebiggers@google.com>
>
> Remove some dead code that was left over following commit 90ea1c6436d2
> ("random: remove the blocking pool").
>

Looks good to me.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
